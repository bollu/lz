//===- HaskToLLVM.cpp - Hask dialect conversion ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "SCFToRGN.h"
#include "Hask/HaskDialect.h"
#include  "Pointer/PointerDialect.h"
#include "RgnDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Block.h"
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

using namespace mlir;
using namespace mlir::standalone;

namespace {

struct ScfYieldToRgn : public OpConversionPattern<scf::YieldOp> {
  using OpConversionPattern::OpConversionPattern;
  void rewrite(scf::YieldOp Op, ArrayRef<Value> operands,
               ConversionPatternRewriter &rewriter) const final {
    rewriter.setInsertionPointAfter(Op);
    rewriter.replaceOpWithNewOp<RgnReturnOp>(Op, Op->getOperands());
  }
};

struct ScfIfToRgn : public OpConversionPattern<scf::IfOp> {
  explicit ScfIfToRgn(mlir::MLIRContext *context)
      : OpConversionPattern(context) {
    setHasBoundedRewriteRecursion();
  }

  void rewrite(scf::IfOp IfOp, mlir::ArrayRef<mlir::Value> operands,
               mlir::ConversionPatternRewriter &rewriter) const final {
    rewriter.setInsertionPointAfter(IfOp);

    RgnValOp ThenRgn =
        rewriter.create<RgnValOp>(IfOp.getLoc(), IfOp->getResultTypes());
    rewriter.cloneRegionBefore(IfOp.thenRegion(), ThenRgn.getRegion(),
                               ThenRgn.getRegion().end());

    RgnValOp ElseRgn =
        rewriter.create<RgnValOp>(IfOp.getLoc(), IfOp->getResultTypes());
    rewriter.cloneRegionBefore(IfOp.elseRegion(), ElseRgn.getRegion(),
                               ElseRgn.getRegion().end());

    mlir::SelectOp SelectRgn = rewriter.create<mlir::SelectOp>(
        IfOp.getLoc(), IfOp.condition(), ThenRgn, ElseRgn);

    RgnCallValOp Call = rewriter.create<RgnCallValOp>(
        IfOp.getLoc(), SelectRgn, mlir::ArrayRef<mlir::Value>(),
        IfOp->getResultTypes());
    rewriter.replaceOp(IfOp, Call.getResults());
  }
};

bool runConversion(mlir::Operation *module, mlir::ConversionTarget &target,
                   mlir::OwningRewritePatternList &patterns) {
  if (mlir::failed(
          mlir::applyPartialConversion(module, target, std::move(patterns)))) {
    // llvm::errs() << "===Failed@Conversion===\n";
    // getOperation()->print(llvm::errs(),
    // mlir::OpPrintingFlags().printGenericOpForm());
    // llvm::errs() << "\n===\n";
    // ::llvm::DebugFlag = false;
    return false;
  };

  if (failed(mlir::verify(module))) {
    // llvm::errs() << "===Failed@Verification===\n";
    // getOperation()->print(llvm::errs());
    // llvm::errs() << "\n===\n";
    // ::llvm::DebugFlag = false;
    return false;
  }
  // ::llvm::DebugFlag = false;
  return true;
}

struct ScfToRgnPass : public mlir::Pass {
  ScfToRgnPass() : mlir::Pass(mlir::TypeID::get<ScfToRgnPass>()){};

  llvm::StringRef getName() const override { return "ScfToRgnPass"; }

  ScfToRgnPass(const ScfToRgnPass &other)
      : mlir::Pass(::mlir::TypeID::get<ScfToRgnPass>()) {}

  std::unique_ptr<mlir::Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto newInst = std::make_unique<ScfToRgnPass>(
        *static_cast<const ScfToRgnPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::ModuleOp mod(getOperation());
    mlir::OpBuilder builder(mod);
    mlir::OwningRewritePatternList patterns(&getContext());
    mlir::ConversionTarget target(getContext());
    target.addIllegalDialect<mlir::scf::SCFDialect>();
    target.addLegalDialect<RgnDialect>();
    target.addLegalDialect<mlir::StandardOpsDialect>();
    target.addIllegalOp<mlir::scf::YieldOp>();
    target.addIllegalOp<mlir::scf::IfOp>();
    // TODO: consider removing FuncOp in favour of our region op.
    target.addLegalOp<mlir::ModuleOp, mlir::ModuleTerminatorOp, mlir::FuncOp>();

    patterns.insert<ScfIfToRgn>(&getContext());
    patterns.insert<ScfYieldToRgn>(&getContext());
    const bool success = runConversion(getOperation(), target, patterns);
    if (!success) {
      signalPassFailure();
    }
  }
};

} // namespace

std::unique_ptr<mlir::Pass> createScfToRgnPass() {
  return std::make_unique<ScfToRgnPass>();
}

void mlir::registerScfToRgnPass() {
  ::mlir::registerPass(
      "scf-to-rgn", "convert SCF instructions to rgn instructions.",
      []() -> std::unique_ptr<::mlir::Pass> { return createScfToRgnPass(); });
}
