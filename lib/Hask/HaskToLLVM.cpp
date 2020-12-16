//===- HaskToLLVM.cpp - Hask dialect conversion ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
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

namespace mlir {
namespace standalone {

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

static FlatSymbolRefAttr getOrInsertEvalClosure(PatternRewriter &rewriter,
                                                ModuleOp m) {
  const std::string name = "evalClosure";
  if (m.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto I8PtrToI8PtrTy = LLVM::LLVMType::getFunctionTy(I8PtrTy, I8PtrTy,
                                                      /*isVarArg=*/false);

  // Insert the printf function into the body of the parent m.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(m.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(m.getLoc(), name, I8PtrToI8PtrTy);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

struct ForceOpConversionPattern : public mlir::ConversionPattern {
  explicit ForceOpConversionPattern(MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ForceOp f = cast<ForceOp>(op);
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op, LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()),
        getOrInsertEvalClosure(rewriter, f.getParentOfType<ModuleOp>()),
        f.getScrutinee());
    return success();
  }
};

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

// extractConstructorArgN(constructor: void *, arg_ix: int) -> bool)
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

struct CaseOpConversionPattern : public mlir::ConversionPattern {
  explicit CaseOpConversionPattern(MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto caseop = cast<CaseOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    const Optional<int> defaultIx = caseop.getDefaultAltIndex();

    rewriter.setInsertionPointAfter(op);

    scf::IfOp replacement;
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      if (defaultIx && i == *defaultIx) {
        continue;
      }

      FlatSymbolRefAttr isConsTagEqFn =
          getOrInsertIsConstructorTagEq(rewriter, mod);
      Value lhs = getOrCreateGlobalString(caseop.getLoc(), rewriter,
                                          caseop.getAltLHS(i).getValue(),
                                          caseop.getAltLHS(i).getValue(), mod);
      SmallVector<Value, 4> isConsTagEqArgs{caseop.getScrutinee(), lhs};
      LLVM::CallOp isEq = rewriter.create<LLVM::CallOp>(
          caseop.getLoc(), LLVM::LLVMType::getInt1Ty(rewriter.getContext()),
          isConsTagEqFn, isConsTagEqArgs);

      const bool createElse = (i + 1 < caseop.getNumAlts()) || defaultIx;
      scf::IfOp ite =
          rewriter.create<mlir::scf::IfOp>(caseop.getLoc(), isEq.getResult(0),
                                           /* createelse=*/createElse);
      if (!replacement) {
        replacement = ite;
      }

      // ===THEN BLOCK===
      rewriter.setInsertionPointToStart(&ite.thenRegion().front());

      mlir::BlockAndValueMapping mapper;

      // arg(j) := extractConstructorArg(scrutinee, j)
      for (int j = 0; j < (int)ite.thenRegion().getNumArguments(); ++j) {
        Value jv = rewriter.create<LLVM::ConstantOp>(
            caseop.getLoc(), LLVM::LLVMType::getInt64Ty(rewriter.getContext()),
            rewriter.getI64IntegerAttr(i));
        SmallVector<Value, 2> args = {caseop.getScrutinee(), jv};
        FlatSymbolRefAttr fn = getOrInsertExtractConstructorArg(rewriter, mod);
        LLVM::CallOp call = rewriter.create<LLVM::CallOp>(
            caseop.getLoc(),
            LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), fn, args);
        mapper.map(ite.thenRegion().getArgument(i), call.getResult(0));
      }
      caseop.getAltRHS(i).cloneInto(&ite.thenRegion(), mapper);

      // ===ELSE BLOCK===
      if (createElse) {
        rewriter.setInsertionPointToStart(&ite.elseRegion().front());
      }
    }

    // ===DEFAULT CASE===
    if (defaultIx) {
      mlir::BlockAndValueMapping mapper;
      // TODO: map arguments.
      caseop.getAltRHS(*defaultIx)
          .cloneInto(rewriter.getInsertionBlock()->getParent(), mapper);
    }

    // ===FINAL REPLACEMENT===
    rewriter.replaceOp(caseop, replacement.getResults());
    rewriter.eraseOp(caseop);
    return success();
  }
};

class HaskToLLVMTypeConverter : public mlir::LLVMTypeConverter {
public:
  using LLVMTypeConverter::LLVMTypeConverter;

  HaskToLLVMTypeConverter(MLIRContext *ctx) : mlir::LLVMTypeConverter(ctx) {
    // Convert ThunkType to I8PtrTy.
    addConversion([](ThunkType type) -> Type {
      return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    });

    // TODO: We really want to know the ADT that this represents so we can
    // figure out storage requirements. For now, hack it, say `void*`.
    addConversion([](ValueType type) -> Type {
      return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    });
  };
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
    LLVMConversionTarget target(getContext());
    target.addLegalOp<ModuleOp, ModuleTerminatorOp>();

    HaskToLLVMTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;

    // OK why is it not able to legalize func? x(
    populateAffineToStdConversionPatterns(patterns, &getContext());
    populateLoopToStdConversionPatterns(patterns, &getContext());
    populateStdToLLVMConversionPatterns(typeConverter, patterns);

    patterns.insert<ForceOpConversionPattern>(&getContext());
    ::llvm::DebugFlag = true;

    if (failed(mlir::applyFullConversion(getOperation(), target,
                                         std::move(patterns)))) {
      llvm::errs() << "===Hask -> LLVM lowering failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };

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
