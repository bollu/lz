//===- HaskToLLVM.cpp - Hask dialect conversion ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Pointer/PointerDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include <mlir/Parser.h>
#include <sstream>

// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"

// pattern matching
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"

// dilect lowering
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/SCFToStandard/SCFToStandard.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

// https://github.com/llvm/llvm-project/blob/a048e2fa1d0285a3582bd224d5652dbf1dc91cb4/mlir/examples/toy/Ch6/mlir/LowerToLLVM.cpp
// https://github.com/llvm/llvm-project/blob/706d992cedaf2ca3190e4445015da62faf2db544/mlir/lib/Conversion/StandardToLLVM/StandardToLLVM.cpp

namespace mlir {
namespace standalone {

FunctionType convertFunctionType(FunctionType fnty, TypeConverter &tc,
                                 OpBuilder &builder) {
  SmallVector<Type, 4> argtys;
  for (Type t : fnty.getInputs()) {
    argtys.push_back(tc.convertType(t));
  }

  SmallVector<Type, 4> rettys;
  for (Type t : fnty.getResults()) {
    rettys.push_back(tc.convertType(t));
  }
  return builder.getFunctionType(argtys, rettys);
};

// class HaskToLLVMTypeConverter : public mlir::LLVMTypeConverter {
class HaskToLLVMTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  HaskToLLVMTypeConverter(MLIRContext *ctx) {
    // Convert ThunkType to I8PtrTy.
    // addConversion([](ThunkType type) -> Type {
    //   return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    // });

    addConversion([](Type type) { return type; });

    // lz.value -> ptr.void
    addConversion([](ValueType type) -> Type {
      return ptr::VoidPtrType::get(type.getContext());
    });

    // lz.thunk -> ptr.void
    addConversion([](ThunkType type) -> Type {
      return ptr::VoidPtrType::get(type.getContext());
    });

    // int->!ptr.void
    /*
    addConversion([](IntegerType type) -> Type {
      return ptr::VoidPtrType::get(type.getContext());
    });
    */

    // !ptr.void -> !int
    /*
    addConversion([](ptr::VoidPtrType type) -> Type {
      return IntegerType::get(64, type.getContext());
    });
    */

    // int -> !ptr.void
    /*
    addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                                 ValueRange vals,
                                 Location loc) -> Optional<Value> {
      if (vals.size() != 1 || !vals[0].getType().isa<IntegerType>()) {
        return {};
      }

      ptr::PtrIntToPtrOp op = rewriter.create<ptr::PtrIntToPtrOp>(loc, vals[0]);
      llvm::SmallPtrSet<Operation *, 1> exceptions;
      exceptions.insert(op);

      // vvv HACK/MLIRBUG: isn't this a hack? why do I need this?
      // vals[0].replaceAllUsesExcept(op.getResult(), exceptions);
      return op.getResult();
    });
    */

    // !ptr.void -> int
    /*
    addSourceMaterialization([&](OpBuilder &rewriter, IntegerType resultty,
                                 ValueRange vals,
                                 Location loc) -> Optional<Value> {
      if (vals.size() != 1 || !vals[0].getType().isa<ptr::VoidPtrType>()) {
        return {};
      }

      ptr::PtrPtrToIntOp op =
          rewriter.create<ptr::PtrPtrToIntOp>(loc, vals[0], resultty);

      llvm::errs() << "op: ";
      op.dump();
      llvm::errs() << "\n";
      getchar();
      return op.getResult();
    });
    */
  };

  // convert a thing to a void pointer.
  Value toVoidPointer(OpBuilder &builder, Value src) {
    if (src.getType().isa<ptr::VoidPtrType>()) {
      return src;
    }
    if (src.getType().isa<IntegerType>()) {
      ptr::PtrIntToPtrOp op =
          builder.create<ptr::PtrIntToPtrOp>(builder.getUnknownLoc(), src);
      return op;
    }

    if (src.getType().isa<FunctionType>()) {
      return builder.create<ptr::PtrFnPtrToVoidPtrOp>(builder.getUnknownLoc(),
                                                      src);
    }

    assert(false && "unknown type to convert to void pointer");
  };

  // convert to `retty` from a void pointer.
  Value fromVoidPointer(OpBuilder &builder, Value src, Type retty) {
    if (retty.isa<ptr::VoidPtrType>()) {
      return src;
    }
    if (IntegerType it = retty.dyn_cast<IntegerType>()) {
      ptr::PtrPtrToIntOp op =
          builder.create<ptr::PtrPtrToIntOp>(builder.getUnknownLoc(), src, it);
      return op;
    }

    assert(false && "unknown type to convert from void pointer");
  };
};

class ConstantOpLowering : public ConversionPattern {
public:
  explicit ConstantOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ConstantOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto constant = cast<ConstantOp>(rator);
    FuncOp owner = constant.getParentOfType<FuncOp>();

    FunctionType fnty = constant.getResult().getType().dyn_cast<FunctionType>();
    assert(fnty);

    FunctionType outty = convertFunctionType(fnty, *typeConverter, rewriter);

    llvm::errs() << "\n===old op:===\n";
    constant.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\nnew type: |" << outty << "|\n";
    getchar();
    assert(fnty && "was asked to lower a constant op that's not a reference to "
                   "a function?!");

    // create new function ref with new types
    rewriter.replaceOpWithNewOp<ConstantOp>(constant, outty,
                                            constant.getValue());

    llvm::errs() << "\n===\nmodule after rewrite:\n";
    owner.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    getchar();

    return success();
  }
};
// https://github.com/spcl/open-earth-compiler/blob/master/lib/Conversion/StencilToStandard/ConvertStencilToStandard.cpp#L45
class FuncOpLowering : public ConversionPattern {
public:
  explicit FuncOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(FuncOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = operation->getLoc();
    auto funcOp = cast<FuncOp>(operation);

    TypeConverter::SignatureConversion inputs(funcOp.getNumArguments());
    for (auto &en : llvm::enumerate(funcOp.getType().getInputs()))
      inputs.addInputs(en.index(), typeConverter->convertType(en.value()));

    TypeConverter::SignatureConversion results(funcOp.getNumResults());
    for (auto &en : llvm::enumerate(funcOp.getType().getResults()))
      results.addInputs(en.index(), typeConverter->convertType(en.value()));

    auto funcType =
        FunctionType::get(inputs.getConvertedTypes(),
                          results.getConvertedTypes(), funcOp.getContext());

    auto newFuncOp = rewriter.create<FuncOp>(loc, funcOp.getName(), funcType);
    // vvvv SHOOT ME PLEASE.
    // The problem is that I can't copy *all* attributes, because Type
    // is also an attribute x(.

    if (Attribute visibility = funcOp.getAttr("sym_visibility")) {
      newFuncOp.setAttr("sym_visibility", visibility);
    }
    // newFuncOp.setAttrs(funcOp.getAttrs());
    rewriter.inlineRegionBefore(funcOp.getBody(), newFuncOp.getBody(),
                                newFuncOp.end());

    if (failed(rewriter.convertRegionTypes(&newFuncOp.getBody(), *typeConverter,
                                           &inputs))) {
      assert(false && "unable to convert the function's region");
      return failure();
    }
    rewriter.eraseOp(funcOp);

    llvm::errs() << "\n===\nconverting function:\n";
    funcOp.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n===new function:===\n";
    newFuncOp.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n===\n";
    getchar();

    return success();
  }
};

class ReturnOpLowering : public ConversionPattern {
public:
  explicit ReturnOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ReturnOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = operation->getLoc();
    rewriter.create<ReturnOp>(loc, operands);
    rewriter.eraseOp(operation);
    return success();
  }
};

bool isI8Ptr(Type ty) {
  auto ptr = ty.dyn_cast<LLVM::LLVMPointerType>();
  if (!ptr) {
    return false;
  }
  auto elem = ptr.getElementType().dyn_cast<LLVM::LLVMIntegerType>();
  if (!elem) {
    return false;
  }
  return elem.getBitWidth() == 8;
}

// static Value getOrCreateGlobalString(Location loc, OpBuilder &builder,
//                                      StringRef name, StringRef value,
//                                      ModuleOp module) {
//   // Create the global at the entry of the module.
//   LLVM::GlobalOp global;
//   if (!(global = module.lookupSymbol<LLVM::GlobalOp>(name))) {
//     OpBuilder::InsertionGuard insertGuard(builder);
//     builder.setInsertionPointToStart(module.getBody());
//     auto type = LLVM::LLVMType::getArrayTy(
//         LLVM::LLVMType::getInt8Ty(builder.getContext()), value.size());
//     global = builder.create<LLVM::GlobalOp>(loc, type,true,
//                                             LLVM::Linkage::Internal, name,
//                                             builder.getStringAttr(value));
//   }
//
//   // Get the pointer to the first character in the global string.
//   Value globalPtr = builder.create<LLVM::AddressOfOp>(loc, global);
//   Value cst0 = builder.create<LLVM::ConstantOp>(
//       loc, LLVM::LLVMType::getInt64Ty(builder.getContext()),
//       builder.getIntegerAttr(builder.getIndexType(), 0));
//   return builder.create<LLVM::GEPOp>(
//       loc, LLVM::LLVMType::getInt8PtrTy(builder.getContext()), globalPtr,
//       ArrayRef<Value>({cst0, cst0}));
// }
//
struct ForceOpConversionPattern : public mlir::ConversionPattern {
  explicit ForceOpConversionPattern(HaskToLLVMTypeConverter &tc,
                                    MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, tc, context), tc(tc) {
  }

  HaskToLLVMTypeConverter &tc;

  // !ptr.void -> !ptr.void
  static FuncOp getOrInsertEvalClosure(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "evalClosure";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ptr::VoidPtrType::get(context);
    Type retty = ptr::VoidPtrType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ForceOp force = mlir::dyn_cast<ForceOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp evalClosure = getOrInsertEvalClosure(rewriter, mod);
    rewriter.setInsertionPointAfter(op);

    // vvv HACK: I ought not need this!
    //    SmallVector<Value, 4> args(rands.begin(), rands.end());
    CallOp call = rewriter.create<CallOp>(op->getLoc(), evalClosure, rands);

    rewriter.setInsertionPointAfter(call);
    Value out = tc.fromVoidPointer(rewriter, call.getResult(0),
                                   tc.convertType(force.getResult().getType()));
    rewriter.replaceOp(force, out);
    return success();
  }
};

// legalize a region that has been inlined into an scf.if by converting
// all lz.return() s into scf.yield() s
void convertReturnsToYields(mlir::Region *r, mlir::PatternRewriter &rewriter) {
  for (Block &b : r->getBlocks()) {
    if (b.empty()) {
      continue;
    }
    HaskReturnOp ret = mlir::dyn_cast<HaskReturnOp>(b.back());
    if (!ret) {
      continue;
    }
    rewriter.setInsertionPointAfter(ret);
    rewriter.replaceOpWithNewOp<mlir::scf::YieldOp>(ret.getOperation(),
                                                    ret.getOperand());
  }
}

struct CaseOpConversionPattern : public mlir::ConversionPattern {
  explicit CaseOpConversionPattern(mlir::TypeConverter &tc,
                                   MLIRContext *context)
      : ConversionPattern(CaseOp::getOperationName(), 1, tc, context) {}

  // isConstructorTagEq(TAG : !ptr.char, constructor: !ptr.void) -> i1
  static FuncOp getOrInsertIsConstructorTagEq(PatternRewriter &rewriter,
                                              ModuleOp module) {
    MLIRContext *context = rewriter.getContext();
    const std::string name = "isConstructorTagEq";
    if (mlir::FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    // constructor, string constructor name
    SmallVector<Type, 4> argtys{ptr::CharPtrType::get(context),
                                ptr::VoidPtrType::get(context)};
    Type retty = ptr::VoidPtrType::get(context);
    auto llvmFnType = rewriter.getFunctionType(argtys, retty);
    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    FuncOp fn = rewriter.create<FuncOp>(module.getLoc(), name, llvmFnType);
    fn.setPrivate();
    return fn;
  }

  // extractConstructorArgN(constructor: !ptr.void, arg_ix: int) -> !ptr.void
  static FuncOp getOrInsertExtractConstructorArg(PatternRewriter &rewriter,
                                                 ModuleOp module) {
    MLIRContext *context = rewriter.getContext();

    const std::string name = "extractConstructorArg";
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<Type, 4> argsTy{ptr::VoidPtrType::get(context),
                                rewriter.getI64Type()};
    Type retty = ptr::VoidPtrType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argsTy, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    FuncOp fn = rewriter.create<FuncOp>(module.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  // return the order in which we should generate case alts.
  static std::vector<int> getAltGenerationOrder(CaseOp caseop) {
    std::vector<int> ixs;
    llvm::Optional<int> defaultix = caseop.getDefaultAltIndex();
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      if (defaultix && *defaultix == i) {
        continue;
      }
      ixs.push_back(i);
    }
    if (defaultix) {
      ixs.push_back(*defaultix);
    }
    return ixs;
  }

  // make a call to extractConstructorArg(...)
  static Value
  mkCallExtractConstructorArg(Value constructor, int argix, ModuleOp mod,
                              ConversionPatternRewriter &rewriter) {
    FuncOp fn = getOrInsertExtractConstructorArg(rewriter, mod);
    Value argixv = rewriter.create<ConstantIntOp>(rewriter.getUnknownLoc(),
                                                  argix, rewriter.getI64Type());
    // Value argixv = rewriter.create<LLVM::ConstantOp>(
    //     rewriter.getUnknownLoc(),
    //     LLVM::LLVMType::getInt64Ty(rewriter.getContext()),
    //     rewriter.getI64IntegerAttr(argix));
    SmallVector<Value, 2> args = {constructor, argixv};
    CallOp call = rewriter.create<CallOp>(rewriter.getUnknownLoc(), fn, args);
    return call.getResult(0);
  }

  // fill the region `out` with the ith RHS of the caseop.
  void genCaseAltRHS(Region *out, CaseOp caseop, int i,
                     ConversionPatternRewriter &rewriter) const {
    ModuleOp mod = caseop.getParentOfType<ModuleOp>();
    assert(out->args_empty());
    assert(out->getBlocks().size() == 1);
    llvm::SmallVector<Value, 4> rhsVals;

    rewriter.setInsertionPointToEnd(&out->front());
    for (int argix = 0; argix < (int)caseop.getAltRHS(i).getNumArguments();
         ++argix) {
      rhsVals.push_back(mkCallExtractConstructorArg(caseop.getScrutinee(),
                                                    argix, mod, rewriter));
    }

    // rewriter.cloneRegionBefore(caseop.getAltRHS(i), *out, out->end(),
    // mapper);
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), *out, out->end());
    convertReturnsToYields(out, rewriter);
    rewriter.mergeBlocks(out->getBlocks().front().getNextNode(),
                         &out->getBlocks().front(), rhsVals);
  }

  // generate the order[i]th case alt of caseop, We need this `order` thing to
  // make sure we generate the default case last. I guess we don't need it if we
  // are sure that people always write the default case last? whatever.
  scf::IfOp genCaseAlt(mlir::standalone::CaseOp caseop, Value scrutinee, int i,
                       const std::vector<int> &order,
                       ConversionPatternRewriter &rewriter) const {
    ModuleOp mod = caseop.getParentOfType<ModuleOp>();

    // isConsTagEq(scrutinee, lhs-tag)
    FuncOp fn = getOrInsertIsConstructorTagEq(rewriter, mod);
    // Value lhs = getOrCreateGlobalString(
    //     caseop.getLoc(), rewriter, caseop.getAltLHS(order[i]).getValue(),
    //     caseop.getAltLHS(order[i]).getValue(), mod);

    Value lhs = rewriter.create<ptr::PtrStringOp>(
        caseop.getLoc(), caseop.getAltLHS(order[i]).getValue());
    SmallVector<Value, 4> params{scrutinee, lhs};

    // check if equal
    const bool hasNext = (i + 1 < (int)order.size());
    if (hasNext) {
      CallOp isEq = rewriter.create<CallOp>(caseop.getLoc(), fn, params);

      scf::IfOp ite = rewriter.create<mlir::scf::IfOp>(
          /*return types=*/caseop.getLoc(), caseop.getResult().getType(),
          /*cond=*/isEq.getResult(0),
          /* createelse=*/true);

      genCaseAltRHS(&ite.thenRegion(), caseop, order[i], rewriter);

      rewriter.setInsertionPointToEnd(&ite.elseRegion().front());
      scf::IfOp caseladder =
          genCaseAlt(caseop, scrutinee, i + 1, order, rewriter);

      rewriter.setInsertionPointAfter(caseladder);
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    caseladder.getResults());
      return ite;

    } else { // default or final else
      // generate dummy if condition

      Value True = rewriter.create<ConstantOp>(
          rewriter.getUnknownLoc(),
          rewriter.getIntegerAttr(rewriter.getI1Type(), 1));
      scf::IfOp ite =
          rewriter.create<mlir::scf::IfOp>(caseop.getLoc(),
                                           /*return types=*/
                                           caseop.getResult().getType(),
                                           /*cond=*/True,
                                           /* createelse=*/true);

      genCaseAltRHS(&ite.thenRegion(), caseop, order[i], rewriter);

      rewriter.setInsertionPointToEnd(&ite.elseRegion().front());
      // TODO: unreachable is defined to be ZeroResult, but it's really
      // VariadicResult?
      auto undef = rewriter.create<HaskUndefOp>(rewriter.getUnknownLoc(),
                                                caseop.getResult().getType());
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    undef.getResult());
      rewriter.setInsertionPointAfter(ite);
      return ite;
    }
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto caseop = cast<CaseOp>(op);

    assert(rands.size() == 1);

    rewriter.setInsertionPointAfter(op);
    const std::vector<int> order = getAltGenerationOrder(caseop);
    scf::IfOp caseladder = genCaseAlt(caseop, rands[0], 0, order, rewriter);
    llvm::errs() << "vvvvvvcase op (before)vvvvvv\n";
    caseop.dump();
    llvm::errs() << "======case op (after)======\n";
    caseladder.print(llvm::errs(),
                     mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^caseop[before/after]^^^^^^^^^\n";
    getchar();

    // caseop.getResult().replaceAllUsesWith(caseladder.getResult(0));
    // rewriter.eraseOp(caseop);
    rewriter.replaceOp(caseop, caseladder.getResults());

    llvm::errs() << "\nvvvvvvcase op module [after inline]vvvvvv\n";
    caseladder.getParentOfType<ModuleOp>().print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n";
    getchar();

    return success();
  }
}; // namespace standalone

class HaskConstructOpConversionPattern : public ConversionPattern {
private:
  HaskToLLVMTypeConverter &tc;

public:
  explicit HaskConstructOpConversionPattern(HaskToLLVMTypeConverter &tc,
                                            MLIRContext *context)
      : ConversionPattern(HaskConstructOp::getOperationName(), 1, tc, context),
        tc(tc) {}

  // mkConstructor: !ptr.char x [!ptr.void^n] -> !ptr.void
  static FuncOp getOrInsertMkConstructor(PatternRewriter &rewriter,
                                         ModuleOp module, int n) {
    const std::string name = "mkConstructor" + std::to_string(n);
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<mlir::Type, 4> argTys;
    argTys.push_back(ptr::CharPtrType::get(rewriter.getContext()));
    for (int i = 0; i < n; ++i) {
      argTys.push_back(ptr::VoidPtrType::get(rewriter.getContext()));
    }
    mlir::Type retty = ptr::VoidPtrType::get(rewriter.getContext());

    auto fntype = rewriter.getFunctionType(argTys, retty);
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());

    FuncOp fndecl =
        rewriter.create<FuncOp>(rewriter.getUnknownLoc(), name, fntype);

    fndecl.setPrivate();
    return fndecl;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskConstructOp cons = cast<HaskConstructOp>(op);
    // ModuleOp mod = cons.getParentOfType<ModuleOp>();

    FuncOp fn = getOrInsertMkConstructor(
        rewriter, op->getParentOfType<ModuleOp>(), cons.getNumOperands());

    Value name = rewriter.create<ptr::PtrStringOp>(
        cons.getLoc(), cons.getDataConstructorName());
    SmallVector<Value, 4> args = {name};

    rewriter.setInsertionPointAfter(cons);

    for (int i = 0; i < (int)operands.size(); ++i) {
      args.insert(args.end(), tc.toVoidPointer(rewriter, operands[i]));
    }

    CallOp call = rewriter.create<CallOp>(cons.getLoc(), fn, args);
    rewriter.replaceOp(cons, call.getResult(0));
    return success();
  }
};

/*
class I64ToI8PtrConversionPattern : public ConversionPattern {
public:
  explicit I64ToI8PtrConversionPattern(TypeConverter &tc)
      : ConversionPattern(1, tc, MatchAnyOpTypeTag()) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    bool changed = false;
    for (int i = 0; i < (int)op->getNumResults(); ++i) {
      LLVM::LLVMIntegerType opResultTy =
          op->getResult(i).getType().dyn_cast<mlir::LLVM::LLVMIntegerType>();
      if (!opResultTy) {
        continue;
      }

      // TODO: how do I check that the use site wants an I64Ptr?
      return failure();
    }

    return changed ? success() : failure();
  }
};
*/

// Keep the old version of the class around because it has details about
// function pointers.
// vvvvvvvv
// class ApOpConversionPattern : public ConversionPattern {
// public:
//   explicit ApOpConversionPattern(TypeConverter &tc, MLIRContext *context)
//       : ConversionPattern(ApOp::getOperationName(), 1, tc, context) {}
//   // !ptr.void x
//   static CallOp getOrInsertMkClosure(PatternRewriter &rewriter, ModuleOp
//   module,
//                                      int n) {

//     const std::string name = "mkClosure_capture0_args" + std::to_string(n);
//     if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
//       return fn;
//     }

//     auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
//     llvm::SmallVector<LLVM::LLVMType, 4> argTys(n + 1, I8PtrTy);
//     auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
//                                                     /*isVarArg=*/false);

//     // Insert the printf function into the body of the parent module.
//     PatternRewriter::InsertionGuard insertGuard(rewriter);
//     rewriter.setInsertionPointToStart(module.getBody());
//     rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
//     return SymbolRefAttr::get(name, rewriter.getContext());
//   }

//   LogicalResult
//   matchAndRewrite(Operation *op, ArrayRef<Value> operands,
//                   ConversionPatternRewriter &rewriter) const override {
//     using namespace mlir::LLVM;
//     ApOp ap = cast<ApOp>(op);
//     ModuleOp module = ap.getParentOfType<ModuleOp>();

//     llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
//     // LLVMType kparamty =
//     //     haskToLLVMType(rewriter.getContext(), ap.getResult().getType());

//     rewriter.setInsertionPointAfter(ap);
//     SmallVector<Value, 4> llvmFnArgs;
//     // llvmFnArgs.push_back(transmuteToVoidPtr(ap.getFn(), rewriter,
//     // ap.getLoc()));

//     auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());

//     // convert function pointer into void* before pushing back
//     llvmFnArgs.push_back(typeConverter->materializeTargetConversion(
//         rewriter, ap.getLoc(), I8PtrTy, ap.getFn()));
//     // llvmFnArgs.push_back(( ap.getFn());

//     for (int i = 0; i < ap.getNumFnArguments(); ++i) {
//       // llvmFnArgs.push_back(
//       //     transmuteToVoidPtr(ap.getFnArgument(i), rewriter,
//       ap.getLoc())); llvmFnArgs.push_back(ap.getFnArgument(i));
//     }

//     FlatSymbolRefAttr mkclosure =
//         getOrInsertMkClosure(rewriter, module, ap.getNumFnArguments());
//     rewriter.replaceOpWithNewOp<LLVM::CallOp>(
//         op, LLVMType::getInt8PtrTy(rewriter.getContext()), mkclosure,
//         llvmFnArgs);
//     return success();
//   }
// };

class ApOpConversionPattern : public ConversionPattern {
private:
  HaskToLLVMTypeConverter &tc;

public:
  explicit ApOpConversionPattern(HaskToLLVMTypeConverter &tc,
                                 MLIRContext *context)
      : ConversionPattern(ApOp::getOperationName(), 1, tc, context), tc(tc) {}
  // !ptr.void x [!ptr.void*n] -> !ptr.void
  // fnptr x args -> closure
  static FuncOp getOrInsertMkClosure(PatternRewriter &rewriter, ModuleOp module,
                                     int n) {
    const std::string name = "mkClosure_capture0_args" + std::to_string(n);
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *ctx = rewriter.getContext();

    // auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    // llvm::SmallVector<LLVM::LLVMType, 4> argTys(n + 1, I8PtrTy);
    // auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
    // /*isVarArg=*/false);

    SmallVector<Type, 4> argTys;
    for (int i = 0; i < n + 1; ++i) {
      argTys.push_back(ptr::VoidPtrType::get(ctx));
    }
    Type retty = ptr::VoidPtrType::get(ctx);
    FunctionType fnty = rewriter.getFunctionType(argTys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApOp ap = cast<ApOp>(op);
    ModuleOp module = ap.getParentOfType<ModuleOp>();

    rewriter.setInsertionPointAfter(ap);
    SmallVector<Value, 4> args;

    // function.
    args.push_back(tc.toVoidPointer(rewriter, rands[0]));

    // function arguments
    for (int i = 1; i < (int)rands.size(); ++i) {
      args.push_back(rands[i]);
    }

    FuncOp mkclosure =
        getOrInsertMkClosure(rewriter, module, ap.getNumFnArguments());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, mkclosure, args);
    return success();
  }
};

class ApEagerOpConversionPattern : public ConversionPattern {
public:
  explicit ApEagerOpConversionPattern(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ApEagerOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApEagerOp ap = cast<ApEagerOp>(op);
    rewriter.setInsertionPointAfter(ap);
    rewriter.replaceOpWithNewOp<mlir::CallOp>(
        ap, ap.getFnName(), ap.getResult().getType(), ap.getFnArguments());
    return success();
  }
};

struct HaskReturnOpConversionPattern : public mlir::ConversionPattern {
  explicit HaskReturnOpConversionPattern(TypeConverter &tc,
                                         MLIRContext *context)
      : ConversionPattern(HaskReturnOp::getOperationName(), 1, tc, context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    HaskReturnOp ret = cast<HaskReturnOp>(op);
    rewriter.setInsertionPointAfter(ret);
    rewriter.replaceOpWithNewOp<mlir::scf::YieldOp>(ret, ret.getOperand());
    return success();
  }
};

namespace {
struct LowerHaskToLLVMPass : public Pass {
  LowerHaskToLLVMPass() : Pass(mlir::TypeID::get<LowerHaskToLLVMPass>()){};
  StringRef getName() const override { return "LowerHaskToLLVM"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerHaskToLLVMPass>(
        *static_cast<const LowerHaskToLLVMPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    // LLVMConversionTarget target(getContext());
    ConversionTarget target(getContext());
    target.addIllegalDialect<HaskDialect>();
    // target.addLegalDialect<HaskDialect>();
    // target.addIllegalOp<HaskConstructOp>();

    target.addLegalOp<HaskUndefOp>();

    target.addLegalDialect<StandardOpsDialect>();
    // target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalDialect<scf::SCFDialect>();
    target.addLegalDialect<ptr::PtrDialect>();

    target.addLegalOp<ModuleOp, ModuleTerminatorOp>();

    target.addDynamicallyLegalOp<ConstantOp>([](ConstantOp op) {
      llvm::errs() << "\n\nchecking if legal:|";
      op.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());

      auto funcType = op.getType().dyn_cast<FunctionType>();
      if (!funcType) {
        llvm::errs() << "| true;\n";
        getchar();
        return true;
      }

      for (auto &arg : llvm::enumerate(funcType.getInputs())) {
        if (arg.value().isa<HaskType>()) {
          llvm::errs() << "| false;\n";
          getchar();

          return false;
        }
      }
      for (auto &arg : llvm::enumerate(funcType.getResults())) {
        if (arg.value().isa<HaskType>()) {
          llvm::errs() << "| false;\n";
          getchar();

          return false;
        }
      }
      llvm::errs() << "| true;\n";
      getchar();
      return true;
    });

    target.addDynamicallyLegalOp<FuncOp>([](FuncOp funcOp) {
      auto funcType = funcOp.getType();
      for (auto &arg : llvm::enumerate(funcType.getInputs())) {
        if (arg.value().isa<HaskType>())
          return false;
      }
      for (auto &arg : llvm::enumerate(funcType.getResults())) {
        if (arg.value().isa<HaskType>())
          return false;
      }
      return true;
    });

    target.addDynamicallyLegalOp<ReturnOp>([](ReturnOp ret) {
      for (Value arg : ret.getOperands()) {
        if (arg.getType().isa<HaskType>())
          return false;
      }
      return true;
    });

    HaskToLLVMTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;

    // OK why is it not able to legalize func? x(
    populateAffineToStdConversionPatterns(patterns, &getContext());
    populateLoopToStdConversionPatterns(patterns, &getContext());
    // populateStdToLLVMConversionPatterns(typeConverter, patterns);

    patterns.insert<ForceOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<CaseOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<HaskConstructOpConversionPattern>(typeConverter,
                                                      &getContext());
    patterns.insert<ConstantOpLowering>(typeConverter, &getContext());
    patterns.insert<FuncOpLowering>(typeConverter, &getContext());
    patterns.insert<ReturnOpLowering>(typeConverter, &getContext());

    patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<ApEagerOpConversionPattern>(typeConverter,
    // &getContext());
    // patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
    //                                                &getContext());
    ::llvm::DebugFlag = true;

    // applyPartialConversion | applyFullConversion

    if (failed(mlir::applyPartialConversion(getOperation(), target,
                                            std::move(patterns)))) {
      llvm::errs() << "===Hask -> LLVM lowering failed at Conversion===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };

    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Hask -> LLVM lowering failed at Verification===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    }

    ::llvm::DebugFlag = false;
  };
};
} // end anonymous namespace.

std::unique_ptr<mlir::Pass> createLowerHaskToLLVMPass() {
  return std::make_unique<LowerHaskToLLVMPass>();
}

void registerLowerHaskToLLVMPass() {
  ::mlir::registerPass("lz-lower-to-llvm", "Perform lowering to LLVM",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLowerHaskToLLVMPass();
                       });
}

} // namespace standalone
} // namespace mlir
