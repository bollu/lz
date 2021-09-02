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
#include "mlir/IR/Value.h"
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
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/IR/Instructions.h"

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

// library.ll
// define nonnull %struct.lean_object* @lean_box(i64 %0) local_unnamed_addr #0 {

// https://github.com/llvm/llvm-project/blob/a048e2fa1d0285a3582bd224d5652dbf1dc91cb4/mlir/examples/toy/Ch6/mlir/LowerToLLVM.cpp
// https://github.com/llvm/llvm-project/blob/706d992cedaf2ca3190e4445015da62faf2db544/mlir/lib/Conversion/StandardToLLVM/StandardToLLVM.cpp

namespace {
using namespace mlir;

class RgnTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  RgnTypeConverter(MLIRContext *ctx) {

    addConversion([](Type type) { return type; });
  };
};

struct RgnJumpValOpConversionPattern
    : public mlir::OpRewritePattern<RgnJumpValOp> {
  /// We register this pattern to match every toy.transpose in the IR.
  /// The "benefit" is used by the framework to order the patterns and process
  /// them in order of profitability.
  RgnJumpValOpConversionPattern(mlir::MLIRContext *context)
      : OpRewritePattern<RgnJumpValOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(RgnJumpValOp call,
                  mlir::PatternRewriter &rewriter) const override {

    if (RgnValOp val = call.getFn().getDefiningOp<RgnValOp>()) {
      assert(false && "screwing up region");
      rewriter.create<BranchOp>(call.getLoc(), &val.getRegion().getBlocks().front(), call.getFnArguments());
      rewriter.inlineRegionBefore(val.getRegion(), call->getBlock());
      rewriter.eraseOp(call);
      assert(false);
      return success();
    }

    if (RgnSelectOp select = call.getFn().getDefiningOp<RgnSelectOp>()) {
      Block *defaultbb = nullptr;
      SmallVector<int32_t> caseValues;
      SmallVector<Block *> caseDestinations;
      SmallVector<RgnValOp> toErase;

      for(int i = 0; i < select.getNumBranches(); ++i) {
        std::pair<int, mlir::Value> branch = select.getBranch(i);
        RgnValOp val = branch.second.getDefiningOp<RgnValOp>();

        if (branch.first == -42) {
          assert(defaultbb == nullptr && "can't have two defaults!");
          defaultbb = &val.getRegion().getBlocks().front();
        } else {
          caseValues.push_back(branch.first);
          caseDestinations.push_back(&val.getRegion().getBlocks().front());
        }        
        toErase.push_back(val);
        rewriter.inlineRegionBefore(val.getRegion(), call->getBlock());

      }
      if (!defaultbb) {
        assert(caseDestinations.size());
        defaultbb = caseDestinations[0];
      }
      assert(defaultbb);

      SmallVector<Value, 1> emptyArgs;
      assert(call->getUsers().empty());
      rewriter.replaceOpWithNewOp<LLVM::SwitchOp>(call, select.getSwitcher(), defaultbb,
        /*default operands*/emptyArgs,
        caseValues, caseDestinations);
      rewriter.eraseOp(select);
      for(RgnValOp v: toErase) { rewriter.eraseOp(v); }
        
      // rewriter.create<RgnEndOp>(call.getLoc());
      // rewriter.eraseOp(call);
      return success();
    }
    assert(false && "expected argument to call to be a val or a select.");
  }
};

struct LowerRgnPass : public Pass {
  LowerRgnPass() : Pass(mlir::TypeID::get<LowerRgnPass>()){};
  StringRef getName() const override { return "LowerRgnPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerRgnPass>(
        *static_cast<const LowerRgnPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runPatterns(mlir::OwningRewritePatternList &patterns) {

    ::llvm::DebugFlag = true;

    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
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

  void runOnOperation() override{

      {

          RgnTypeConverter typeConverter(&getContext());
  mlir::OwningRewritePatternList patterns(&getContext());

  patterns.insert<RgnJumpValOpConversionPattern>(&getContext());
  runPatterns(patterns);
}

// // === control flow has been lowered. lower simple instructions ===/
// {

//   RgnTypeConverter typeConverter(&getContext());
//   mlir::OwningRewritePatternList patterns(&getContext());
//   ConversionTarget target(getContext());
//   target.addIllegalDialect<HaskDialect>();
//   target.addLegalDialect<ptr::PtrDialect>();
//   target.addLegalDialect<StandardOpsDialect>();
//   target.addLegalDialect<AffineDialect>();
//   target.addLegalDialect<scf::SCFDialect>();
//   target.addLegalDialect<ptr::PtrDialect>();
//   target.addLegalOp<ModuleOp, ModuleTerminatorOp, FuncOp>();

//   patterns.insert<HaskConstructOpLowering>(typeConverter, &getContext());
//   patterns.insert<ErasedValueOpLowering>(typeConverter, &getContext());
//   patterns.insert<TagGetOpLowering>(typeConverter, &getContext());
//   patterns.insert<PapExtendOpLowering>(typeConverter, &getContext());
//   patterns.insert<PapOpLowering>(typeConverter, &getContext());
//   patterns.insert<HaskStringConstOpLowering>(typeConverter, &getContext());
//   patterns.insert<HaskIntegerConstOpLowering>(typeConverter, &getContext());
//   patterns.insert<HaskLargeIntegerConstOpLowering>(typeConverter,
//                                                    &getContext());
//   patterns.insert<ProjectionOpLowering>(typeConverter, &getContext());
//   patterns.insert<CallOpLowering>(typeConverter, &getContext());
//   patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
//   patterns.insert<ApEagerOpConversionPattern>(typeConverter, &getContext());
//   patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
//   &getContext()); patterns.insert<IncOpLowering>(typeConverter,
//   &getContext()); patterns.insert<DecOpLowering>(typeConverter,
//   &getContext());

//   // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
//   // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
//   // patterns.insert<BranchOpTypeConversion>(typeConverter, &getContext());
//   runPatterns(target, patterns);
//   return;
// }

}; // namespace
}
;
} // end anonymous namespace.

std::unique_ptr<mlir::Pass> createLowerRgnPass() {
  return std::make_unique<LowerRgnPass>();
}

void registerLowerRgnPass() {
  ::mlir::registerPass(
      "convert-rgn-to-std", "Convert rgn to std",
      []() -> std::unique_ptr<::mlir::Pass> { return createLowerRgnPass(); });
}
