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
#include "mlir/IR/Types.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include <mlir/Parser.h>
#include <sstream>

// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/BuiltinTypes.h"

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

namespace {

// i64 -> !ptr.void

/*
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
 */

// class HaskTypeConverter : public mlir::LLVMTypeConverter {
class HaskTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  HaskTypeConverter(MLIRContext *ctx) {
    // Convert ThunkType to I8PtrTy.
    // addConversion([](ThunkType type) -> Type {
    //   return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    // });

    addConversion([](Type type) { return type; });

    // lz.value -> ptr.void
    // addConversion([](ValueType type) -> Type {
    //   return ptr::VoidPtrType::get(type.getContext());
    // });

    // // lz.thunk -> ptr.void
    // addConversion([](ThunkType type) -> Type {
    //   return ptr::VoidPtrType::get(type.getContext());
    // });

    addConversion([&](FunctionType fnty) -> Type {
      SmallVector<Type, 4> argtys;
      for (Type t : fnty.getInputs()) {
        argtys.push_back(this->convertType(t));
      }

      SmallVector<Type, 4> rettys;
      for (Type t : fnty.getResults()) {
        rettys.push_back(this->convertType(t));
      }

      return mlir::FunctionType::get(fnty.getContext(), argtys, rettys);
    });

    addConversion([&](mlir::MemRefType memref) -> Type {
      return mlir::MemRefType::get(memref.getShape(),
                                   this->convertType(memref.getElementType()),
                                   memref.getAffineMaps());
    });

    // lz.value -> !ptr.void
    /*
    addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                                 ValueRange vals,
                                 Location loc) -> Optional<Value> {
      llvm::errs() << "materializing * -> !ptr.void: |" << vals[0] << "|\n";
      if (vals.size() != 1) {
        return {};
      }
      if (!vals[0].getType().isa<ValueType>()) {
        return {};
      }
      return {rewriter.create<ptr::HaskValueToPtrOp>(loc, vals[0])};
    });
    */

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

      ptr::IntToPtrOp op = rewriter.create<ptr::IntToPtrOp>(loc, vals[0]);
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

      ptr::PtrToIntOp op =
          rewriter.create<ptr::PtrToIntOp>(loc, vals[0], resultty);

      llvm::errs() << "op: ";
      op.dump();
      llvm::errs() << "\n";
      return op.getResult();
    });
    */
  };

  // convert a thing to a void pointer.
  // Value toVoidPointer(OpBuilder &builder, Value src) {
  //   if (src.getType().isa<ptr::VoidPtrType>()) {
  //     return src;
  //   }
  //   if (src.getType().isa<IntegerType>()) {
  //     ptr::IntToPtrOp op =
  //         builder.create<ptr::IntToPtrOp>(builder.getUnknownLoc(), src);
  //     return op;
  //   }
  //   if (src.getType().isa<FunctionType>()) {
  //     return builder.create<ptr::FnToVoidPtrOp>(builder.getUnknownLoc(), src);
  //   }
  //   if (src.getType().isa<MemRefType>()) {
  //     ptr::MemrefToVoidPtrOp op =
  //         builder.create<ptr::MemrefToVoidPtrOp>(builder.getUnknownLoc(), src);
  //     return op;
  //   }
  //   if (src.getType().isa<FloatType>()) {
  //     ptr::DoubleToPtrOp op =
  //         builder.create<ptr::DoubleToPtrOp>(builder.getUnknownLoc(), src);
  //     return op;
  //   }
  //   llvm::errs() << "ERROR: unknown type: |" << src.getType() << "|\n";
  //   assert(false && "unknown type to convert to void pointer");
  // };

  // // convert to `retty` from a void pointer.
  // Value fromVoidPointer(OpBuilder &builder, Value src, Type retty) {
  //   if (retty.isa<ptr::VoidPtrType>()) {
  //     return src;
  //   }
  //   if (IntegerType it = retty.dyn_cast<IntegerType>()) {
  //     ptr::PtrToIntOp op =
  //         builder.create<ptr::PtrToIntOp>(builder.getUnknownLoc(), src, it);
  //     return op;
  //   }
  //   if (MemRefType mr = retty.dyn_cast<MemRefType>()) {
  //     ptr::PtrToMemrefOp op =
  //         builder.create<ptr::PtrToMemrefOp>(builder.getUnknownLoc(), src, mr);
  //     return op;
  //   }
  //   if (ValueType val = retty.dyn_cast<ValueType>()) {
  //     return src;
  //     //    ptr::PtrToHaskValueOp op =
  //     //      builder.create<ptr::PtrToHaskValueOp>(builder.getUnknownLoc(),
  //     //      src);
  //     //  return op;
  //   }
  //   if (FloatType ft = retty.dyn_cast<FloatType>()) {
  //     return builder.create<ptr::PtrToFloatOp>(builder.getUnknownLoc(), src,
  //                                              ft);
  //   }

  //   llvm::errs() << "ERROR: unknown type: |" << retty << "|\n";
  //   assert(false && "unknown type to convert from void pointer");
  // };
};

class ConstantOpLowering : public ConversionPattern {
public:
  explicit ConstantOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ConstantOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto constant = cast<ConstantOp>(rator);
    FunctionType fnty = constant.getResult().getType().dyn_cast<FunctionType>();
    assert(fnty && "expected function");

    FunctionType outty =
        typeConverter->convertType(fnty).dyn_cast<FunctionType>();
    assert(outty &&
           "was asked to lower a constant op that's not a reference to "
           "a function?!");

    // Anything whose legality is checked with `isDynamicallyLegal` needs to be
    // `rewrite.erase`d and then `rewriter.create`d. It seems like you can't
    // use `rewriter.replaceOpWithNewOp` for such operations.
    // vvvvv
    // create new function ref with new types
    // rewriter.replaceOpWithNewOp<ConstantOp>(constant, outty,
    //                                         constant.getValue());

    ConstantOp newconst = rewriter.create<ConstantOp>(constant.getLoc(), outty,
                                                      constant.getValue());
    constant.getResult().replaceAllUsesWith(newconst.getResult());
    rewriter.eraseOp(constant);

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
        FunctionType::get(funcOp.getContext(), inputs.getConvertedTypes(),
                          results.getConvertedTypes());

    auto newFuncOp = rewriter.create<FuncOp>(loc, funcOp.getName(), funcType);
    // vvvv SHOOT ME PLEASE.
    // The problem is that I can't copy *all* attributes, because Type
    // is also an attribute x(.

    if (Attribute visibility = funcOp->getAttr("sym_visibility")) {
      newFuncOp->setAttr("sym_visibility", visibility);
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

class ScfYieldOpLowering : public ConversionPattern {
public:
  explicit ScfYieldOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(scf::YieldOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    assert(false);
    rewriter.replaceOpWithNewOp<scf::YieldOp>(op, rands);
    assert(false);
    return success();
  }
};

class AffineYieldOpLowering : public ConversionPattern {
public:
  explicit AffineYieldOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(AffineYieldOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<AffineYieldOp>(op, rands);
    return success();
  }
};

// I don't understand why I need this.
class CallOpLowering : public ConversionPattern {
public:
  explicit CallOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(CallOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto call = cast<CallOp>(operation);
    SmallVector<Type, 4> resultTypes;
    if (failed(
            typeConverter->convertTypes(call.getResultTypes(), resultTypes))) {
      return failure();
    }

    rewriter.replaceOpWithNewOp<CallOp>(operation, call.getCallee(),
                                        resultTypes, operands);
    return success();
  }
};

// I don't understand why I need this.
class CallIndirectOpLowering : public ConversionPattern {
public:
  explicit CallIndirectOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(CallIndirectOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    //    auto call = cast<CallIndirectOp>(op);
    //    typeConverter->convertTypes(call.getResultTypes(), resultTypes);
    rewriter.replaceOpWithNewOp<CallIndirectOp>(op, rands[0],
                                                rands.drop_front(1));
    llvm::errs() << "=====call indirect parent fn=====\n";
    op->getParentOfType<FuncOp>().print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n=====\n";
    return success();
  }
};

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
  explicit ForceOpConversionPattern(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, tc, context), tc(tc) {
  }

  HaskTypeConverter &tc;

  // !ptr.void -> !ptr.void
  static FuncOp getOrInsertEvalClosure(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "evalClosure";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
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
    FuncOp parent = op->getParentOfType<FuncOp>();
    // ForceOp force = mlir::cast<ForceOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp evalClosure = getOrInsertEvalClosure(rewriter, mod);
    rewriter.setInsertionPointAfter(op);

    // vvv HACK: I ought not need this!
    //    SmallVector<Value, 4> args(rands.begin(), rands.end());
    rewriter.setInsertionPointAfter(op);
    // Value toForce = tc.toVoidPointer(rewriter, rands[0]);
    Value toForce = rands[0];
    CallOp call = rewriter.create<CallOp>(op->getLoc(), evalClosure, toForce);
    rewriter.setInsertionPointAfter(call);
    // Value out = tc.fromVoidPointer(rewriter, call.getResult(0),
    //                                force.getResult().getType());
    Value out = call.getResult(0);
    rewriter.replaceOp(op, out);
    llvm::errs() << "vvvv--after-force---vvv\n";
    parent.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "^^^^^^^\n";
    return success();
  }
};

// legalize a region that has been inlined into an scf.if by converting
// all lz.return() s into scf.yield() s
/*
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
*/

struct CaseOpConversionPattern : public mlir::ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit CaseOpConversionPattern(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(CaseOp::getOperationName(), 1, tc, context), tc(tc) {}

  // isConstructorTagEq(scrutinee: !ptr.void, TAG : !ptr.char) -> i1
  static FuncOp getOrInsertIsConstructorTagEq(PatternRewriter &rewriter,
                                              ModuleOp module) {
    MLIRContext *context = rewriter.getContext();
    const std::string name = "isConstructorTagEq";
    if (mlir::FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    // constructor, string constructor name
    SmallVector<Type, 4> argtys{ValueType::get(context),
                                ValueType::get(context)};
    Type retty = rewriter.getI1Type();
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

    SmallVector<Type, 4> argsTy{ValueType::get(context),
                                rewriter.getI32Type()};
    Type retty = ValueType::get(context);
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
                                                  argix, rewriter.getI32Type());
    // Value argixv = rewriter.create<LLVM::ConstantOp>(
    //     rewriter.getUnknownLoc(),
    //     LLVM::LLVMType::getInt64Ty(rewriter.getContext()),
    //     rewriter.getI64IntegerAttr(argix));
    SmallVector<Value, 2> args = {constructor, argixv};
    CallOp call = rewriter.create<CallOp>(rewriter.getUnknownLoc(), fn, args);
    return call.getResult(0);
  }

  // fill the region `out` with the ith RHS of the caseop.
  void genCaseAltRHS(Region *out, CaseOp caseop, Value scrutinee, int i,
                     ConversionPatternRewriter &rewriter) const {
    ModuleOp mod = caseop->getParentOfType<ModuleOp>();
    assert(out->args_empty());
    assert(out->getBlocks().size() == 1);
    llvm::SmallVector<Value, 4> rhsVals;

    for (int argix = 0; argix < (int)caseop.getAltRHS(i).getNumArguments();
         ++argix) {
      Value arg = mkCallExtractConstructorArg(scrutinee, argix, mod, rewriter);
      // Type ty = tc.convertType(caseop.getAltRHS(i).getArgument(argix).getType());
      rewriter.setInsertionPointToEnd(&out->front());
      // arg = tc.fromVoidPointer(rewriter, arg, ty);
      rhsVals.push_back(arg);
    }

    Block *caseEntryBB = &caseop.getAltRHS(i).front();
    assert(caseEntryBB);
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), *out, out->end());
    rewriter.mergeBlocks(caseEntryBB, &out->getBlocks().front(), rhsVals);
  }

  // generate the order[i]th case alt of caseop, We need this `order` thing to
  // make sure we generate the default case last. I guess we don't need it if we
  // are sure that people always write the default case last? whatever.
  scf::IfOp genCaseAlt(mlir::standalone::CaseOp caseop, Value scrutinee, int i,
                       const std::vector<int> &order,
                       ConversionPatternRewriter &rewriter) const {
    ModuleOp mod = caseop->getParentOfType<ModuleOp>();

    // check if equal
    const bool hasNext = (i + 1 < (int)order.size());

    Value condition = [&]() {
      if (hasNext) {
        // isConsTagEq(scrutinee, lhs-tag)
        FuncOp fn = getOrInsertIsConstructorTagEq(rewriter, mod);
        Value lhs = rewriter.create<ptr::PtrStringOp>(
            caseop.getLoc(), caseop.getAltLHS(order[i]).getValue());
        SmallVector<Value, 4> params{scrutinee, lhs};
        CallOp isEq = rewriter.create<CallOp>(caseop.getLoc(), fn, params);
        return isEq.getResult(0);
      } else {
        Value True = rewriter.create<ConstantOp>(
            rewriter.getUnknownLoc(),
            rewriter.getIntegerAttr(rewriter.getI1Type(), 1));
        return True;
      }
    }();

    scf::IfOp ite = rewriter.create<mlir::scf::IfOp>(
        caseop.getLoc(),
        /*return types=*/
        typeConverter->convertType(caseop.getResult().getType()),
        /*cond=*/condition,
        /* createelse=*/true);
    rewriter.startRootUpdate(ite);

    // THEN
    rewriter.setInsertionPointToStart(&ite.thenRegion().front());
    genCaseAltRHS(&ite.thenRegion(), caseop, scrutinee, order[i], rewriter);

    // ELSE
    rewriter.setInsertionPointToStart(&ite.elseRegion().front());
    if (hasNext) {
      scf::IfOp caseladder =
          genCaseAlt(caseop, scrutinee, i + 1, order, rewriter);

      rewriter.setInsertionPointAfter(caseladder);
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    caseladder.getResults());

    } else {
      auto undef = rewriter.create<ptr::PtrUndefOp>(
          rewriter.getUnknownLoc(),
          typeConverter->convertType(caseop.getResult().getType()));
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    undef.getResult());
    }
    rewriter.finalizeRootUpdate(ite);
    return ite;
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

    // caseop.getResult().replaceAllUsesWith(caseladder.getResult(0));
    // rewriter.eraseOp(caseop);
    rewriter.replaceOp(caseop, caseladder.getResults());

    llvm::errs() << "\nvvvvvvcase op module [after inline]vvvvvv\n";
    caseladder->getParentOfType<ModuleOp>().print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n";

    return success();
  }
}; // end caseop




struct CaseIntOpConversionPattern : public mlir::ConversionPattern {
public:
  explicit CaseIntOpConversionPattern(HaskTypeConverter &tc,
                                      MLIRContext *context)
      : ConversionPattern(CaseIntOp::getOperationName(), 1, tc, context) {}

  // return the order in which we should generate case alts.
  static std::vector<int> getAltGenerationOrder(CaseIntOp caseop) {
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

  // fill the region `out` with the ith RHS of the caseop.
  void genCaseAltRHS(Region *out, CaseIntOp caseop, Value scrutinee, int i,
                     ConversionPatternRewriter &rewriter) const {
    assert(out->args_empty());
    assert(out->getBlocks().size() == 1);
    llvm::SmallVector<Value, 4> rhsVals;

    assert(caseop.getAltRHS(i).getNumArguments() <= 1);

    if (caseop.getAltRHS(i).getNumArguments() == 1) {
      // Type ty = tc.convertType(caseop.getAltRHS(i).getArgument(0).getType());
      rewriter.setInsertionPointToEnd(&out->front());
      // Value arg = tc.fromVoidPointer(rewriter, scrutinee, ty);
      rhsVals.push_back(scrutinee);
    };
    Block *caseEntryBB = &caseop.getAltRHS(i).front();
    assert(caseEntryBB);
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), *out, out->end());
    rewriter.mergeBlocks(caseEntryBB, &out->getBlocks().front(), rhsVals);
  }

  // generate the order[i]th case alt of caseop, We need this `order` thing to
  // make sure we generate the default case last. I guess we don't need it if we
  // are sure that people always write the default case last? whatever.
  scf::IfOp genCaseAlt(mlir::standalone::CaseIntOp caseop, Value scrutinee,
                       int i, const std::vector<int> &order,
                       ConversionPatternRewriter &rewriter) const {

    // check if equal
    const bool hasNext = (i + 1 < (int)order.size());

    Value condition = [&]() {
      if (hasNext) {
        IntegerType ity = scrutinee.getType().cast<IntegerType>();
        int64_t lhsint = caseop.getAltLHS(order[i])->getInt();
        Value lhsConst =
            rewriter.create<ConstantIntOp>(caseop.getLoc(), lhsint, ity);

        CmpIOp isEq = rewriter.create<CmpIOp>(
            caseop.getLoc(), CmpIPredicate::eq, scrutinee, lhsConst);
        return isEq.getResult();
      } else {
        Value True = rewriter.create<ConstantOp>(
            rewriter.getUnknownLoc(),
            rewriter.getIntegerAttr(rewriter.getI1Type(), 1));
        return True;
      }
    }();

    scf::IfOp ite = rewriter.create<mlir::scf::IfOp>(
        caseop.getLoc(),
        /*return types=*/
        typeConverter->convertType(caseop.getResult().getType()),
        /*cond=*/condition,
        /* createelse=*/true);
    rewriter.startRootUpdate(ite);

    // THEN
    rewriter.setInsertionPointToStart(&ite.thenRegion().front());
    genCaseAltRHS(&ite.thenRegion(), caseop, scrutinee, order[i], rewriter);

    // ELSE
    rewriter.setInsertionPointToStart(&ite.elseRegion().front());
    if (hasNext) {
      scf::IfOp caseladder =
          genCaseAlt(caseop, scrutinee, i + 1, order, rewriter);

      rewriter.setInsertionPointAfter(caseladder);
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    caseladder.getResults());

    } else {
      auto undef = rewriter.create<ptr::PtrUndefOp>(
          rewriter.getUnknownLoc(),
          typeConverter->convertType(caseop.getResult().getType()));
      rewriter.create<scf::YieldOp>(rewriter.getUnknownLoc(),
                                    undef.getResult());
    }
    rewriter.finalizeRootUpdate(ite);
    return ite;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    CaseIntOp caseop = cast<CaseIntOp>(op);

    assert(rands.size() == 1);

    rewriter.setInsertionPointAfter(op);
    const std::vector<int> order = getAltGenerationOrder(caseop);
    scf::IfOp caseladder = genCaseAlt(caseop, rands[0], 0, order, rewriter);
    llvm::errs() << "vvvvvvcase int op (before)vvvvvv\n";
    caseop.dump();
    llvm::errs() << "======case int op (after)======\n";
    caseladder.print(llvm::errs(),
                     mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^caseIntop[before/after]^^^^^^^^^\n";

    // caseop.getResult().replaceAllUsesWith(caseladder.getResult(0));
    // rewriter.eraseOp(caseop);
    rewriter.replaceOp(caseop, caseladder.getResults());

    llvm::errs() << "\nvvvvvvcase op module [after inline]vvvvvv\n";
    caseladder->getParentOfType<ModuleOp>().print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n";

    return success();
  }
}; // CaseIntOp end



class HaskConstructOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit HaskConstructOpLowering(HaskTypeConverter &tc, MLIRContext *context)
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
    // argTys.push_back(ptr::CharPtrType::get(rewriter.getContext()));
    argTys.push_back(ValueType::get(rewriter.getContext()));
    for (int i = 0; i < n; ++i) {
      argTys.push_back(ValueType::get(rewriter.getContext()));
    }
    mlir::Type retty = ValueType::get(rewriter.getContext());

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
      // args.insert(args.end(), tc.toVoidPointer(rewriter, operands[i]));
      args.insert(args.end(), operands[i]);
    }

    // CallOp call = rewriter.create<CallOp>(cons.getLoc(), fn, args);
    // rewriter.replaceOp(cons, call.getResult(0));
    rewriter.replaceOpWithNewOp<CallOp>(cons, fn, args);
    return success();
  }
};

class ThunkifyOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit ThunkifyOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ThunkifyOp::getOperationName(), 1, tc, context),
        tc(tc) {}
  // !ptr.void -> !ptr.void
  static FuncOp getOrInsertMkClosureThunkify(PatternRewriter &rewriter,
                                             ModuleOp m) {
    const std::string name = "mkClosure_thunkify";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    // Value param = tc.toVoidPointer(rewriter, rands[0]);
    Value param = rands[0];
    FuncOp mkClosure = getOrInsertMkClosureThunkify(rewriter, mod);
    rewriter.replaceOpWithNewOp<CallOp>(rator, mkClosure, param);
    return success();
  }
};

class ApOpConversionPattern : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit ApOpConversionPattern(HaskTypeConverter &tc, MLIRContext *context)
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
      argTys.push_back(ValueType::get(ctx));
    }
    Type retty = ValueType::get(ctx);
    FunctionType fnty = rewriter.getFunctionType(argTys, retty);

    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    FuncOp fn = rewriter.create<FuncOp>(module.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApOp ap = cast<ApOp>(op);
    ModuleOp module = ap->getParentOfType<ModuleOp>();

    rewriter.setInsertionPointAfter(ap);
    SmallVector<Value, 4> args;

    // function.
    // args.push_back(tc.toVoidPointer(rewriter, rands[0]));
    args.push_back(rands[0]);

    // function arguments
    for (int i = 1; i < (int)rands.size(); ++i) {
      // args.push_back(tc.toVoidPointer(rewriter, rands[i]));
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

    Value fn = operands[0];
    SmallVector<Value, 4> args;
    for (int i = 1; i < (int)operands.size(); ++i) {
      args.push_back(operands[i]);
    }

    rewriter.replaceOpWithNewOp<mlir::CallIndirectOp>(ap, fn, args);
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
    rewriter.replaceOpWithNewOp<mlir::scf::YieldOp>(ret, operands);
    return success();
  }
};

struct AllocOpLowering : public mlir::ConversionPattern {
  explicit AllocOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::AllocOp::getOperationName(), 1, tc, context) {
  }
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    memref::AllocaOp alloc = cast<memref::AllocaOp>(op);
    rewriter.setInsertionPointAfter(alloc);
    assert(false && "I don't know what this is supposed to be");
    MemRefType memrefty =
        typeConverter->convertType(alloc.getType()).cast<MemRefType>();

    llvm::errs() << "===\n";
    llvm::errs() << "dynamicSizes.size(): " << alloc.getDynamicSizes().size()
                 << "\n";
    llvm::errs() << "getOperands.size(): " << alloc.getOperands().size()
                 << "\n";
    llvm::errs() << "rands.size(): " << rands.size() << "\n";
    llvm::errs() << "===\n";
    rewriter.replaceOpWithNewOp<memref::AllocaOp>(alloc, memrefty, rands);
    return success();
  }
};

struct StoreOpLowering : public mlir::ConversionPattern {
  explicit StoreOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::StoreOp::getOperationName(), 1, tc, context) {
  }
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    memref::StoreOp store = cast<memref::StoreOp>(op);
    rewriter.setInsertionPointAfter(store);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 3 &&
           "store needs memref, value to store, and store indeces");
    rewriter.replaceOpWithNewOp<memref::StoreOp>(store, rands[0], rands[1],
                                                 rands.drop_front(2));
    return success();
  }
};

struct LoadOpLowering : public mlir::ConversionPattern {
  explicit LoadOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::LoadOp::getOperationName(), 1, tc, context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    // assert(false);
    using namespace mlir::LLVM;
    memref::LoadOp load = cast<memref::LoadOp>(op);
    rewriter.setInsertionPointAfter(load);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 2 && "oad needs memref and store indeces");
    rewriter.replaceOpWithNewOp<memref::LoadOp>(op, rands[0],
                                                rands.drop_front(1));
    return success();
  }
};

struct AffineLoadOpLowering : public mlir::ConversionPattern {
  explicit AffineLoadOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineLoadOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    // assert(false);
    using namespace mlir::LLVM;
    mlir::AffineLoadOp load = cast<mlir::AffineLoadOp>(op);
    rewriter.setInsertionPointAfter(load);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 2 && "oad needs memref and store indeces");
    rewriter.replaceOpWithNewOp<mlir::AffineLoadOp>(op, load.getAffineMap(),
                                                    rands);
    return success();
  }
};

struct AffineStoreOpLowering : public mlir::ConversionPattern {
  explicit AffineStoreOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineStoreOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    mlir::AffineStoreOp store = cast<mlir::AffineStoreOp>(op);
    rewriter.setInsertionPointAfter(store);
    assert(rands.size() >= 3 &&
           "affine store needs memref, value to store, and store indeces");
    rewriter.replaceOpWithNewOp<mlir::AffineStoreOp>(store, rands[0], rands[1],
                                                     rands.drop_front(2));
    return success();
  }
};

struct AffineForOpLowering : public mlir::ConversionPattern {
  explicit AffineForOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineForOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {

    llvm::errs() << "===FOR==\n";
    op->print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^FOR^^^\n";
    mlir::AffineForOp for_ = cast<mlir::AffineForOp>(op);
    Location loc = for_.getLoc();

    AffineMap lbMap = for_.getLowerBoundMap();
    AffineMap ubMap = for_.getUpperBoundMap();
    int step = for_.getStep();
    // Value step = rewriter.create<ConstantIndexOp>(loc, op.getStep());
    ValueRange lbOperands = for_.getLowerBoundOperands();
    ValueRange ubOperands = for_.getUpperBoundOperands();

    AffineForOp newForOp =
        rewriter.create<AffineForOp>(loc, lbOperands, lbMap, ubOperands, ubMap,
                                     step, for_.getIterOperands());
    // https://github.com/llvm/llvm-project/blob/ed23229a64aed5b9d6120d57138d475291ca3667/mlir/lib/Conversion/AffineToStandard/AffineToStandard.cpp#L360
    // WTF: why is this in the source code? o_O |
    // rewriter.eraseBlock(scfForOp.getBody())
    rewriter.eraseBlock(newForOp.getBody());

    rewriter.inlineRegionBefore(for_.region(), newForOp.region(),
                                newForOp.region().end());

    for (int i = 0; i < (int)newForOp->getNumOperands(); ++i) {
      Type t = newForOp.getOperand(i).getType();
      Type tnew = typeConverter->convertType(t);
      newForOp.getOperand(i).setType(tnew);
    }

    for (int i = 0; i < (int)newForOp.region().getNumArguments(); ++i) {
      Type t = newForOp.region().getArgument(i).getType();
      Type tnew = typeConverter->convertType(t);
      newForOp.region().getArgument(i).setType(tnew);
    }

    for (int i = 0; i < (int)newForOp->getNumResults(); ++i) {
      newForOp.getResult(i).setType(
          typeConverter->convertType(newForOp.getResult(i).getType()));
    }

    llvm::errs() << "===NEW FOR OP===\n";
    newForOp.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());

    llvm::errs() << "\n^^^^NEW FOR OP^^^^\n";

    rewriter.replaceOp(op, newForOp.results());
    return success();
  }
};

bool isTypeLegal(Type t) {
  if (t.isa<HaskType>()) {
    return false;
  }
  if (auto fnty = t.dyn_cast<FunctionType>()) {

    for (Type t : fnty.getInputs()) {
      if (!isTypeLegal(t)) {
        return false;
      }
    }

    for (Type t : fnty.getResults()) {
      if (!isTypeLegal(t)) {
        return false;
      }
    }
  }

  if (auto memrefty = t.dyn_cast<MemRefType>()) {
    if (!isTypeLegal(memrefty.getElementType())) {
      return false;
    }
  }
  return true;
}

// I don't know why, but OpConversionPattern just dies.
// class ErasedValueOpLowering : public OpConversionPattern<ErasedValueOp> {
struct ErasedValueOpLowering : public mlir::ConversionPattern {
public:
  static FuncOp getOrCreateLeanBox(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_box";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = rewriter.getI32Type();
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit ErasedValueOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ErasedValueOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp leanbox = getOrCreateLeanBox(rewriter, mod);
    Value c0 = rewriter.create<ConstantIntOp>(rewriter.getUnknownLoc(), 0,
                                              rewriter.getI32Type());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, leanbox, c0);
    return success();
  }
};

// I don't know why, but OpConversionPattern just dies.
// class ErasedValueOpLowering : public OpConversionPattern<ErasedValueOp> {
struct TagGetOpLowering : public mlir::ConversionPattern {
public:
  explicit TagGetOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(TagGetOp::getOperationName(), 1, tc, context) {}

  static FuncOp getOrCreateLeanTag(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_obj_tag";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = rewriter.getI32Type();
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
    TagGetOp tagget = cast<TagGetOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp f = getOrCreateLeanTag(rewriter, mod);
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, tagget.getOperand());
    return success();
  }
};

struct PapExtendOpLowering : public mlir::ConversionPattern {
public:
  // TODO: need variadic arguments?
  static FuncOp getOrCreateLeanApply(int nargs, PatternRewriter &rewriter,
                                     ModuleOp m) {
    const std::string name = "lean_apply_" + std::to_string(nargs);
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *context = rewriter.getContext();
    SmallVector<Type, 4> argtys;

    argtys.push_back(ValueType::get(context)); // argument.
    for (int i = 0; i < nargs; ++i) {
      argtys.push_back(ValueType::get(context));
    }

    Type retty = rewriter.getI32Type();
    FunctionType fnty = rewriter.getFunctionType(argtys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit PapExtendOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PapExtendOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PapExtendOp papext = cast<PapExtendOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    // def emitApp (z : VarId) (f : VarId) (ys : Array Arg) : M Unit :=
    // if ys.size > closureMaxArgs then do
    //  emit "{ lean_object* _aargs[] = {"; emitArgs ys; emitLn "};";
    // emitLhs z; emit "lean_apply_m("; emit f; emit ", "; emit ys.size; emitLn
    // ", _aargs); }" else do
    //   emitLhs z; emit "lean_apply_"; emit ys.size; emit "("; emit f; emit ",
    //   "; emitArgs ys; emitLn ");"
    // TODO: generate lean_apply_m;
    FuncOp f = getOrCreateLeanApply(papext.getNumFnArguments(), rewriter, mod);
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, papext->getOperands());
    return success();
  }
};

struct LowerHaskPass : public Pass {
  LowerHaskPass() : Pass(mlir::TypeID::get<LowerHaskPass>()){};
  StringRef getName() const override { return "LowerHaskToLLVM"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerHaskPass>(
        *static_cast<const LowerHaskPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    assert(false && "please only use --lean-lower. Don't waste an hour of your life debugging this.");
    // LLVMConversionTarget target(getContext());
    ConversionTarget target(getContext());
    target.addIllegalDialect<HaskDialect>();
    // target.addLegalDialect<HaskDialect>();
    // target.addIllegalOp<HaskCaseIntRetOp>();
    // target.addIllegalOp<HaskConstructOp>();

    target.addLegalDialect<StandardOpsDialect>();
    target.addLegalDialect<AffineDialect>();

    // target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalDialect<scf::SCFDialect>();
    target.addLegalDialect<ptr::PtrDialect>();

    target.addLegalOp<ModuleOp, ModuleTerminatorOp>();

    target.addDynamicallyLegalOp<ConstantOp>(
        [](ConstantOp op) { return isTypeLegal(op.getType()); });

    // This is wrong. We need to recursively check if function type
    // is legal.
    target.addDynamicallyLegalOp<FuncOp>(
        [](FuncOp funcOp) { return isTypeLegal(funcOp.getType()); });

    target.addDynamicallyLegalOp<ReturnOp>([](ReturnOp ret) {
      for (Value arg : ret.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }
      return true;
    });

    target.addDynamicallyLegalOp<CallOp>([](CallOp call) {
      for (Value arg : call.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }

      for (Type t : call.getResultTypes()) {
        if (!isTypeLegal(t)) {
          return false;
        }
      }
      return true;
    });

    /*
  target.addDynamicallyLegalOp<CallIndirectOp>([](CallIndirectOp call) {

    llvm::errs() << "===Checking callIndirectOp===\n";
    for (Value arg : call.getOperands()) {
      llvm::errs() << " - " << arg.getType() << "\n";
      if (!isTypeLegal(arg.getType())) {
        return false;

      }
    }

    for (Type t : call.getResultTypes()) {
      llvm::errs() << " - " << t << "\n";

      if (!isTypeLegal(t)) {
        return false;
      }
    }
    llvm::errs() << "\n===\n";
    return true;
  });
     */

    target.addDynamicallyLegalOp<memref::AllocOp>(
        [](memref::AllocOp op) { return isTypeLegal(op.getType()); });

    target.addDynamicallyLegalOp<memref::StoreOp>([](memref::StoreOp store) {
      return isTypeLegal(store.getMemRefType()) &&
             isTypeLegal(store.getValueToStore().getType());
    });

    target.addDynamicallyLegalOp<memref::LoadOp>([](memref::LoadOp load) {
      return isTypeLegal(load.getMemRefType()) &&
             isTypeLegal(load.getResult().getType());
    });

    target.addDynamicallyLegalOp<AffineLoadOp>([](mlir::AffineLoadOp load) {
      return isTypeLegal(load.getMemRefType()) &&
             isTypeLegal(load.getResult().getType());
    });

    target.addDynamicallyLegalOp<AffineStoreOp>([](mlir::AffineStoreOp op) {
      for (Value arg : op.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }

      return true;
    });

    target.addDynamicallyLegalOp<AffineForOp>([](mlir::AffineForOp op) {
      for (Value arg : op.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }

      for (Type t : op.getResultTypes()) {
        if (!isTypeLegal(t)) {
          return false;
        }
      }
      return true;
    });

    target.addDynamicallyLegalOp<mlir::scf::YieldOp>([](scf::YieldOp yield) {
      for (Type t : yield.getOperandTypes()) {
        if (!isTypeLegal(t)) {
          llvm::errs() << "ILLEGAL scfOperandType: |" << t << "|\n";
          return false;
        }
      }
      return true;
    });

    target.addDynamicallyLegalOp<mlir::AffineYieldOp>([](AffineYieldOp yield) {
      for (Type t : yield.getOperandTypes()) {
        if (!isTypeLegal(t)) {
          return false;
        }
      }
      return true;
    });

    HaskTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns(&getContext());

    // OK why is it not able to legalize func? x(
    // populateAffineToStdConversionPatterns(patterns, &getContext());
    // populateLoopToStdConversionPatterns(patterns, &getContext());
    // populateStdToLLVMConversionPatterns(typeConverter, patterns);

    patterns.insert<ForceOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<CaseOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<CaseIntOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<CanonicalizeCaseIntRetPattern>(typeConverter, &getContext());

    patterns.insert<HaskConstructOpLowering>(typeConverter, &getContext());
    patterns.insert<ThunkifyOpLowering>(typeConverter, &getContext());
    patterns.insert<ErasedValueOpLowering>(typeConverter, &getContext());
    patterns.insert<TagGetOpLowering>(typeConverter, &getContext());
    patterns.insert<PapExtendOpLowering>(typeConverter, &getContext());

    patterns.insert<ConstantOpLowering>(typeConverter, &getContext());
    patterns.insert<FuncOpLowering>(typeConverter, &getContext());
    patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
    patterns.insert<CallOpLowering>(typeConverter, &getContext());
    //    patterns.insert<CallIndirectOpLowering>(typeConverter, &getContext());
    patterns.insert<ScfYieldOpLowering>(typeConverter, &getContext());

    patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<ApEagerOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
                                                   &getContext());

    // Memref ops? is this really how I'm supposed to do this?
    patterns.insert<AllocOpLowering>(typeConverter, &getContext());
    patterns.insert<StoreOpLowering>(typeConverter, &getContext());
    patterns.insert<LoadOpLowering>(typeConverter, &getContext());
    patterns.insert<AffineLoadOpLowering>(typeConverter, &getContext());
    patterns.insert<AffineStoreOpLowering>(typeConverter, &getContext());
    patterns.insert<AffineYieldOpLowering>(typeConverter, &getContext());

    patterns.insert<AffineForOpLowering>(typeConverter, &getContext());

    ::llvm::DebugFlag = true;

    // applyPartialConversion | applyFullConversion

    if (failed(mlir::applyPartialConversion(getOperation(), target,
                                            std::move(patterns)))) {
      llvm::errs() << "===Hask lowering failed at Conversion===\n";
      getOperation()->print(llvm::errs(),
                            mlir::OpPrintingFlags().printGenericOpForm());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };

    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Hask lowering failed at Verification===\n";
      getOperation()->print(llvm::errs());

      llvm::errs() << "\n===\n";
      signalPassFailure();
    }

    ::llvm::DebugFlag = false;
  };
};
} // end anonymous namespace.

std::unique_ptr<mlir::Pass> createLowerHaskPass() {
  return std::make_unique<LowerHaskPass>();
}

void registerLowerHaskPass() {
  ::mlir::registerPass(
      "lz-lower", "Perform lowering to std+scf+ptr",
      []() -> std::unique_ptr<::mlir::Pass> { return createLowerHaskPass(); });
}

} // namespace standalone
} // namespace mlir
