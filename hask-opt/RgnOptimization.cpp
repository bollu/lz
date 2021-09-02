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
#include "RgnDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Block.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/Types.h"
#include "mlir/IR/Verifier.h"
#include "mlir/IR/Visitors.h"
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

// library.ll
// define nonnull %struct.lean_object* @lean_box(i64 %0) local_unnamed_addr #0 {

// https://github.com/llvm/llvm-project/blob/a048e2fa1d0285a3582bd224d5652dbf1dc91cb4/mlir/examples/toy/Ch6/mlir/LowerToLLVM.cpp
// https://github.com/llvm/llvm-project/blob/706d992cedaf2ca3190e4445015da62faf2db544/mlir/lib/Conversion/StandardToLLVM/StandardToLLVM.cpp

namespace mlir {
namespace standalone {

namespace {


struct OptimizeRgnPass : public Pass {
  OptimizeRgnPass() : Pass(mlir::TypeID::get<OptimizeRgnPass>()){};
  StringRef getName() const override { return "OptimizeRgnPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<OptimizeRgnPass>(
        *static_cast<const OptimizeRgnPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runPatterns(ConversionTarget &target,
                   mlir::OwningRewritePatternList &patterns) {

    // ::llvm::DebugFlag = true;

    if (failed(mlir::applyPartialConversion(getOperation(), target,
                                            std::move(patterns)))) {
      llvm::errs() << "===Hask lowering failed at Conversion===\n";
      // getOperation()->print(llvm::errs(),
      // mlir::OpPrintingFlags().printGenericOpForm());
      llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
      return;
    };

    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Hask lowering failed at Verification===\n";
      // getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
      return;
    }

    ::llvm::DebugFlag = false;
  }

  void runOnOperation() override {
    int known_constructors = 0;
    getOperation()->walk([&](ProjectionOp proj) {
        HaskConstructOp cons = proj.getOperand().getDefiningOp<HaskConstructOp>();
        if (!cons) { return WalkResult::advance(); }
        llvm::errs() << "#optimizable constructs |" << ++known_constructors << "|\n";
        assert(false);
        return WalkResult::advance();
    });

    getOperation()->walk([&](RgnSelectOp select) {
        return WalkResult::advance();
    });


  }
};

} // namespace

std::unique_ptr<mlir::Pass> createOptimizeRegionPass() {
  return std::make_unique<OptimizeRgnPass>();
}



} // namespace standalone
} // namespace mlir

void registerOptimizeRgnPass() {
  ::mlir::registerPass("rgn-opt",
                       "Perform peephole rewrites on regions",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return mlir::standalone::createOptimizeRegionPass();
                       });
}

