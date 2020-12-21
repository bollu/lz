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
static Value getOrCreateGlobalString(Location loc, OpBuilder &builder,
                                     StringRef name, StringRef value,
                                     ModuleOp module) {
  // Create the global at the entry of the module.
  LLVM::GlobalOp global;
  if (!(global = module.lookupSymbol<LLVM::GlobalOp>(name))) {
    OpBuilder::InsertionGuard insertGuard(builder);
    builder.setInsertionPointToStart(module.getBody());
    auto type = LLVM::LLVMType::getArrayTy(
        LLVM::LLVMType::getInt8Ty(builder.getContext()), value.size());
    global = builder.create<LLVM::GlobalOp>(loc, type, /*isConstant=*/true,
                                            LLVM::Linkage::Internal, name,
                                            builder.getStringAttr(value));
  }

  // Get the pointer to the first character in the global string.
  Value globalPtr = builder.create<LLVM::AddressOfOp>(loc, global);
  Value cst0 = builder.create<LLVM::ConstantOp>(
      loc, LLVM::LLVMType::getInt64Ty(builder.getContext()),
      builder.getIntegerAttr(builder.getIndexType(), 0));
  return builder.create<LLVM::GEPOp>(
      loc, LLVM::LLVMType::getInt8PtrTy(builder.getContext()), globalPtr,
      ArrayRef<Value>({cst0, cst0}));
}

struct ForceOpConversionPattern : public mlir::ConversionPattern {
  explicit ForceOpConversionPattern(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, tc, context) {}

  // void* -> void*
  static FlatSymbolRefAttr getOrInsertEvalClosure(PatternRewriter &rewriter,
                                                  ModuleOp m) {
    const std::string name = "evalClosure";
    if (m.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
      return SymbolRefAttr::get(name, rewriter.getContext());
    }

    auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    auto I8PtrToI8PtrTy = LLVM::LLVMType::getFunctionTy(I8PtrTy, I8PtrTy,
                                                        /*isVarArg=*/false);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    rewriter.create<LLVM::LLVMFuncOp>(m.getLoc(), name, I8PtrToI8PtrTy);
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ForceOp f = cast<ForceOp>(op);
    rewriter.setInsertionPointAfter(f);

    LLVM::CallOp force = rewriter.create<LLVM::CallOp>(
        op->getLoc(), LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()),
        getOrInsertEvalClosure(rewriter, f.getParentOfType<ModuleOp>()),
        f.getScrutinee());

    // materialize a conversion from i8* -> i64 if necessary
    Type outty = typeConverter->convertType(f.getResult().getType());
    Value out = typeConverter->materializeTargetConversion(
        rewriter, f.getLoc(), outty, force.getResult(0));
    rewriter.replaceOp(f, out);
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

  // isConstructorTagEq(TAG : char *, constructor: void * -> bool)
  static FlatSymbolRefAttr
  getOrInsertIsConstructorTagEq(PatternRewriter &rewriter, ModuleOp module) {
    const std::string name = "isConstructorTagEq";
    if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
      return SymbolRefAttr::get(name, rewriter.getContext());
    }

    auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    auto llvmI1Ty = LLVM::LLVMType::getInt1Ty(rewriter.getContext());

    // constructor, string constructor name
    SmallVector<mlir::LLVM::LLVMType, 4> argsTy{llvmI8PtrTy, llvmI8PtrTy};
    auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI1Ty, argsTy,
                                                    /*isVarArg=*/false);

    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  // extractConstructorArgN(constructor: void *, arg_ix: int) -> void*)
  static FlatSymbolRefAttr
  getOrInsertExtractConstructorArg(PatternRewriter &rewriter, ModuleOp module) {
    const std::string name = "extractConstructorArg";
    if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
      return SymbolRefAttr::get(name, rewriter.getContext());
    }

    auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    auto llvmI64Ty = LLVM::LLVMType::getInt64Ty(rewriter.getContext());

    // string constructor name, <n> arguments.
    SmallVector<mlir::LLVM::LLVMType, 4> argsTy{llvmI8PtrTy, llvmI64Ty};
    auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI8PtrTy, argsTy,
                                                    /*isVarArg=*/false);

    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
    return SymbolRefAttr::get(name, rewriter.getContext());
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
    FlatSymbolRefAttr fn = getOrInsertExtractConstructorArg(rewriter, mod);
    Value argixv = rewriter.create<LLVM::ConstantOp>(
        rewriter.getUnknownLoc(),
        LLVM::LLVMType::getInt64Ty(rewriter.getContext()),
        rewriter.getI64IntegerAttr(argix));
    SmallVector<Value, 2> args = {constructor, argixv};
    LLVM::CallOp call = rewriter.create<LLVM::CallOp>(
        rewriter.getUnknownLoc(),
        LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), fn, args);
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
  scf::IfOp genCaseAlt(mlir::standalone::CaseOp caseop, int i,
                       const std::vector<int> &order,
                       ConversionPatternRewriter &rewriter) const {
    ModuleOp mod = caseop.getParentOfType<ModuleOp>();

    // isConsTagEq(scrutinee, lhs-tag)
    FlatSymbolRefAttr fn = getOrInsertIsConstructorTagEq(rewriter, mod);
    Value lhs = getOrCreateGlobalString(
        caseop.getLoc(), rewriter, caseop.getAltLHS(order[i]).getValue(),
        caseop.getAltLHS(order[i]).getValue(), mod);

    SmallVector<Value, 4> params{caseop.getScrutinee(), lhs};

    // check if equal
    const bool hasNext = (i + 1 < (int)order.size());
    if (hasNext) {
      LLVM::CallOp isEq = rewriter.create<LLVM::CallOp>(
          caseop.getLoc(), LLVM::LLVMType::getInt1Ty(rewriter.getContext()), fn,
          params);

      scf::IfOp ite = rewriter.create<mlir::scf::IfOp>(
          /*return types=*/caseop.getLoc(), caseop.getResult().getType(),
          /*cond=*/isEq.getResult(0),
          /* createelse=*/true);

      genCaseAltRHS(&ite.thenRegion(), caseop, order[i], rewriter);

      rewriter.setInsertionPointToEnd(&ite.elseRegion().front());
      scf::IfOp caseladder = genCaseAlt(caseop, i + 1, order, rewriter);

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

    rewriter.setInsertionPointAfter(op);
    const std::vector<int> order = getAltGenerationOrder(caseop);
    scf::IfOp caseladder = genCaseAlt(caseop, 0, order, rewriter);
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
public:
  explicit HaskConstructOpConversionPattern(TypeConverter &tc,
                                            MLIRContext *context)
      : ConversionPattern(HaskConstructOp::getOperationName(), 1, tc, context) {
  }

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
    for (int i = 0; i < cons.getNumOperands(); ++i) {
      args.push_back(cons.getOperand(i));
    }

    rewriter.setInsertionPointAfter(cons);
    rewriter.replaceOpWithNewOp<CallOp>(cons, fn, args);
    llvm::errs() << "\n====\n";
    fn.getParentOp()->dump();
    getchar();
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

    // lz.value -> ptr.void
    addConversion([](ValueType type) -> Type {
      return ptr::VoidPtrType::get(type.getContext());
    });

    // int -> !ptr.void
    addConversion([](IntegerType type) -> Type {
      return ptr::VoidPtrType::get(type.getContext());
    });

    // int -> !ptr.void
    addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                                 ValueRange vals,
                                 Location loc) -> mlir::Optional<Value> {
      if (vals.size() != 1 || !vals[0].getType().isa<IntegerType>()) {
        return {};
      }

      ptr::PtrIntToPtrOp op = rewriter.create<ptr::PtrIntToPtrOp>(loc, vals[0]);
      llvm::SmallPtrSet<Operation *, 1> exceptions;
      exceptions.insert(op);

      // vvv isn't this a hack? why do I need this?
      // vals[0].replaceAllUsesExcept(op.getResult(), exceptions);
      return op.getResult();
    });

    // !lz.value -> !ptr.void
    addTargetMaterialization([&](OpBuilder &rewriter, ptr::VoidPtrType resultty,
                                 ValueRange vals,
                                 Location loc) -> mlir::Optional<Value> {
      if (vals.size() != 1 || !vals[0].getType().isa<ValueType>()) {
        return {};
      }

      return {rewriter.create<standalone::HaskValueToPtrOp>(loc, vals[0])};
      // return rewriter.create<
    });

    // convert LLVM::I64Type to LLVM::I8PtrTy

    // addConversion([](LLVM::LLVMIntegerType type) -> llvm::Optional<Type> {
    //   return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    // });

    // i8* -> i64
    /*
    addConversion([](LLVM::LLVMPointerType type) -> llvm::Optional<Type> {
      LLVM::LLVMIntegerType intty =
          type.getElementType().dyn_cast<LLVM::LLVMIntegerType>();
      if (!intty) {
        return {};
      }
      if (intty.getBitWidth() != 8) {
        return {};
      }

      return {LLVM::LLVMType::getInt64Ty(type.getContext())};
    });
    */

    /*
    addConversion([](mlir::IntegerType type) -> Type {
      return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    });
    */

    // TODO: We really want to know the ADT that this represents so we can
    // figure out storage requirements. For now, hack it, say `void*`.
    /*
    addConversion([](ValueType type) -> Type {
      return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    });
    */

    // i8* -> i64
    /* TODO: how to use the function like this?
    auto i8ptrtoi64 = [](OpBuilder &rewriter,
                         mlir::LLVM::LLVMIntegerType resultty, ValueRange
    vals, Location loc) -> mlir::Optional<Value> { if (resultty.getBitWidth()
    != 64) { return {};
      }

      // now we need a single value;
      if (vals.size() != 1) {
        return {};
      }
      Value val = vals[0];
      if (!isI8Ptr(val.getType())) {
        return {};
      }

      llvm::errs() << "vvvvvv=trying to materialize target:vvvvvv\n";
      llvm::errs() << "-";
      resultty.print(llvm::errs());
      llvm::errs() << "\n";
      llvm::errs() << "-vals: " << vals.size() << "|";
      vals[0].print(llvm::errs());
      llvm::errs() << "\n^^^^^^^^^^^^\n";
      getchar();

      return {rewriter.create<mlir::LLVM::PtrToIntOp>(loc, resultty, val)};
    };
    */

    // void* -> i64
    // Oh fuck me, I deserve hell for this. I keep a reference to `this`
    // so I can query myself what the type of `vals` is *supposed* to be
    // in the target x(
    /*
    addTargetMaterialization(
        [&](OpBuilder &rewriter, mlir::LLVM::LLVMIntegerType resultty,
            ValueRange vals, Location loc) -> mlir::Optional<Value> {
          if (resultty.getBitWidth() != 64) {
            return {};
          }

          // now we need a single value;
          if (vals.size() != 1) {
            return {};
          }
          Value val = vals[0];
          if (!isI8Ptr(this->convertType(val.getType()))) {
            return {};
          }

          llvm::errs() << "vvvvvv=trying to materialize target:vvvvvv\n";
          llvm::errs() << "-";
          resultty.print(llvm::errs());
          llvm::errs() << "\n";
          llvm::errs() << "-vals: " << vals.size() << "|";
          vals[0].print(llvm::errs());
          llvm::errs() << "\n^^^^^^^^^^^^\n";

          return {rewriter.create<mlir::LLVM::PtrToIntOp>(loc, resultty, val)};
        });


    // T1* -> T2*
    // Oh fuck me, I deserve hell for this. I keep a reference to `this`
    // so I can query myself what the type of `vals` is *supposed* to be
    // in the target x(
    addTargetMaterialization([&](OpBuilder &rewriter,
                                 mlir::LLVM::LLVMPointerType resultty,
                                 ValueRange vals,
                                 Location loc) -> mlir::Optional<Value> {
      llvm::errs() << "vvvvvv=trying to materialize (T1* -> T2*):vvvvvv\n";
      llvm::errs() << "-";
      resultty.print(llvm::errs());
      llvm::errs() << "\n";
      llvm::errs() << "-vals: " << vals.size() << "|";
      vals[0].print(llvm::errs());
      llvm::errs() << "\n^^^^^^^^^^^^\n";

      // now we need a single value;
      if (vals.size() != 1) {
        return {};
      }

      Type valty = this->convertType(vals[0].getType());
      if (!valty.isa<LLVM::LLVMPointerType>()) {
        return {};
      }

      return {rewriter.create<mlir::LLVM::BitcastOp>(loc, resultty, vals[0])};
    });
    */

    // arguments: i64 -> llvm.i8ptr
    /*
    addArgumentMaterialization([](OpBuilder &rewriter,
                                  mlir::LLVM::LLVMPointerType voidptrty,
                                  ValueRange vals,
                                  Location loc) -> mlir::Optional<Value> {
      LLVM::LLVMIntegerType ptrElemInt =
          voidptrty.getElementType().dyn_cast<mlir::LLVM::LLVMIntegerType>();
      if (!ptrElemInt) {
        return {};
      }
      if (ptrElemInt.getBitWidth() != 8) {
        return {};
      }
      // so we have a void* as source type.

      // now we need a single value;
      if (vals.size() != 1) {
        return {};
      }
      Value val = vals[0];

      if (!val.getType().isa<mlir::LLVM::LLVMIntegerType>() ||
          val.getType().isa<mlir::IntegerType>()) {
        return {};
      }

      llvm::errs() << "vvvvvv=trying to materialize target:vvvvvv\n";
      llvm::errs() << "-";
      voidptrty.print(llvm::errs());
      llvm::errs() << "\n";
      llvm::errs() << "-vals: " << vals.size() << "|";
      if (vals.size() == 1) {
        vals[0].print(llvm::errs());
      }

      llvm::errs() << "\n^^^^^^^^^^^^\n";
      getchar();

      return {rewriter.create<mlir::LLVM::IntToPtrOp>(loc, voidptrty, val)};
    });
*/
  };
};

class ApOpConversionPattern : public ConversionPattern {
public:
  explicit ApOpConversionPattern(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ApOp::getOperationName(), 1, tc, context) {}

  static FlatSymbolRefAttr getOrInsertMkClosure(PatternRewriter &rewriter,
                                                ModuleOp module, int n) {

    const std::string name = "mkClosure_capture0_args" + std::to_string(n);
    if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
      return SymbolRefAttr::get(name, rewriter.getContext());
    }

    auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    llvm::SmallVector<LLVM::LLVMType, 4> argTys(n + 1, I8PtrTy);
    auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
                                                    /*isVarArg=*/false);

    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApOp ap = cast<ApOp>(op);
    ModuleOp module = ap.getParentOfType<ModuleOp>();

    llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
    // LLVMType kparamty =
    //     haskToLLVMType(rewriter.getContext(), ap.getResult().getType());

    rewriter.setInsertionPointAfter(ap);
    SmallVector<Value, 4> llvmFnArgs;
    // llvmFnArgs.push_back(transmuteToVoidPtr(ap.getFn(), rewriter,
    // ap.getLoc()));

    auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());

    // convert function pointer into void* before pushing back
    llvmFnArgs.push_back(typeConverter->materializeTargetConversion(
        rewriter, ap.getLoc(), I8PtrTy, ap.getFn()));
    // llvmFnArgs.push_back(( ap.getFn());

    for (int i = 0; i < ap.getNumFnArguments(); ++i) {
      // llvmFnArgs.push_back(
      //     transmuteToVoidPtr(ap.getFnArgument(i), rewriter, ap.getLoc()));
      llvmFnArgs.push_back(ap.getFnArgument(i));
    }

    FlatSymbolRefAttr mkclosure =
        getOrInsertMkClosure(rewriter, module, ap.getNumFnArguments());
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op, LLVMType::getInt8PtrTy(rewriter.getContext()), mkclosure,
        llvmFnArgs);
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
    // target.addIllegalDialect<HaskDialect>();
    // target.addLegalDialect<HaskDialect>();
    // target.addIllegalOp<HaskConstructOp>();

    target.addLegalDialect<StandardOpsDialect>();
    // target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalDialect<scf::SCFDialect>();
    target.addLegalDialect<ptr::PtrDialect>();

    target.addLegalOp<ModuleOp, ModuleTerminatorOp, FuncOp>();

    HaskToLLVMTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;

    // OK why is it not able to legalize func? x(
    populateAffineToStdConversionPatterns(patterns, &getContext());
    populateLoopToStdConversionPatterns(patterns, &getContext());
    // populateStdToLLVMConversionPatterns(typeConverter, patterns);

    // patterns.insert<ForceOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<CaseOpConversionPattern>(typeConverter, &getContext());
    patterns.insert<HaskConstructOpConversionPattern>(typeConverter,
                                                      &getContext());
    // patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
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
