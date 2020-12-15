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
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

namespace mlir {
namespace standalone {

class HaskToLLVMTypeConverter : public mlir::TypeConverter {
  using TypeConverter::TypeConverter;
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
    mlir::ConversionTarget target(getContext());
    target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalOp<mlir::ModuleOp, mlir::ModuleTerminatorOp>();
    target.addIllegalDialect<HaskDialect>();
    mlir::LLVMTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;

    mlir::populateStdToLLVMConversionPatterns(typeConverter, patterns);
    if (failed(mlir::applyFullConversion(getOperation(), target,
                                         std::move(patterns)))) {
      llvm::errs() << "===Hask -> LLVM lowering failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };
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
