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
#include "mlir/IR/Visitors.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include <ios>
#include <mlir/Parser.h>
#include <set>
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

struct LowerRgnPass : public Pass {
  LowerRgnPass() : Pass(mlir::TypeID::get<LowerRgnPass>()){};
  StringRef getName() const override { return "LowerRgnPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerRgnPass>(
        *static_cast<const LowerRgnPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void
  rewriteJump(RgnJumpValOp jump, mlir::IRRewriter &rewriter,
              std::vector<std::pair<RgnValOp, Block *>> &inlineVals) const {

    static std::set<RgnValOp> seen;
    static std::set<RgnJumpValOp> jumps;
    assert(!jumps.count(jump));
    jumps.insert(jump);

    if (RgnValOp val = jump.getFn().getDefiningOp<RgnValOp>()) {
      llvm::errs() << "\n===jump(rgn)===\n";
      llvm::errs() << "rgnval:\n\t" << val << "\n";
      llvm::errs() << "parent:\n\t" << jump << "\n";
      llvm::errs() << "\n===\n";

      assert(!seen.count(val));
      seen.insert(val);

      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
      rewriter.setInsertionPointAfter(jump);
      assert(val.getRegion().getBlocks().size() > 0);
      rewriter.create<BranchOp>(jump.getLoc(),
                                &val.getRegion().getBlocks().front(),
                                jump.getFnArguments());
      rewriter.inlineRegionBefore(val.getRegion(), *jump->getParentRegion(),
                                  jump->getParentRegion()->end());
      rewriter.eraseOp(jump);
      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
      return;
    }

    if (RgnSelectOp select = jump.getFn().getDefiningOp<RgnSelectOp>()) {

      Block *defaultBB = nullptr;
      SmallVector<int32_t> caseLhss;
      SmallVector<Block *> caseRhss;
      SmallVector<mlir::Value> defaultOperands;

      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
      for (int i = 0; i < (int)select.getNumBranches(); ++i) {
        std::pair<int, mlir::Value> branch = select.getBranch(i);
        RgnValOp v = branch.second.getDefiningOp<RgnValOp>();
        assert(v && "expected select(rgnval)");

        llvm::errs() << "\n===jump(select(rgn))===\n";
        llvm::errs() << "rgnval:\n\t" << v << "\n";
        llvm::errs() << "select:\n\t" << select << "\n";
        llvm::errs() << "parent:\n\t" << jump << "\n";
        llvm::errs() << "\n===\n";
        assert(!seen.count(v));
        seen.insert(v);

        Region *parent = jump->getParentRegion();
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

        if (branch.first == RGN_DIALECT_DEFAULT_CASE_MAGIC) {
          llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
          assert(i == (int)select.getNumBranches() - 1);
          assert(!defaultBB && "can't have two default blocks");
          Region &r = v.getRegion();
          defaultBB = &r.front();
          rewriter.inlineRegionBefore(r, *parent, parent->end());
          llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

        } else {
          llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
          Region &r = v.getRegion();
          assert(r.getBlocks().size() > 0);
          caseLhss.push_back(abs(branch.first));
          caseRhss.push_back(&r.getBlocks().front());
          rewriter.inlineRegionBefore(r, *parent, parent->end());
          llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
        }
      }
      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

      if (!defaultBB) {
        defaultBB = [&]() {
          // createBlock moves the insetion point x(
          OpBuilder::InsertionGuard guard(rewriter);
          Block *b = rewriter.createBlock(jump->getParentRegion(),
                                          jump->getParentRegion()->end(), {});
          rewriter.setInsertionPointToStart(b);
          rewriter.create<ptr::PtrUnreachableOp>(rewriter.getUnknownLoc());
          return b;
        }();
      }
      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

      rewriter.setInsertionPointAfter(jump);
      Value switchval = rewriter.create<LLVM::SExtOp>(
          jump.getLoc(), rewriter.getIntegerType(32), select.getSwitcher());
      // rewriter.create<LLVM::SwitchOp>(jump.getLoc(), switchval, defaultBB,
      //                                 /*default operands*/ defaultOperands,
      //                                 /*case switch LHss*/ caseLhss,
      //                                 /*case switch RHSs*/ caseRhss);
      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

      rewriter.replaceOpWithNewOp<LLVM::SwitchOp>(
          jump, switchval, defaultBB,
          /*default-operands*/ defaultOperands,
          /*case switch LHss*/ caseLhss,
          /*case switch RHSs*/ caseRhss);
      // rewriter.eraseOp(jump);

      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
      return;
    };
    assert(false && "expected argument to call to be a val or a select.");
  }

  void runOnOperation() override {
    std::vector<std::pair<RgnValOp, Block *>> inlineVals;
    mlir::IRRewriter rewriter(getOperation()->getContext());
    getOperation()->walk([&](RgnJumpValOp jmp) {
      this->rewriteJump(jmp, rewriter, inlineVals);
      return WalkResult::advance();
    });

    getOperation()->walk([&](RgnReturnOp ret) {
      rewriter.setInsertionPoint(ret);
      rewriter.replaceOpWithNewOp<ReturnOp>(ret, ret.getOperand());
      return WalkResult::advance();
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    // std::set<RgnValOp> toDelete;
    // for (int i = 0; i < (int)inlineVals.size(); ++i) {
    //   rewriter.inlineRegionBefore(inlineVals[i].first.getRegion(),
    //                               inlineVals[i].second);
    //   // toDelete.insert(inlineVals[i].first);
    // }

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnJumpValOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnSelectOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnValOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    // llvm::outs() << "// ===rewritten===\n";
    // llvm::outs() << *getOperation();

    ::llvm::DebugFlag = true;
    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Hask lowering failed at Verification===\n";
      // getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
      return;
    }

    ::llvm::DebugFlag = false;

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
    //   patterns.insert<HaskStringConstOpLowering>(typeConverter,
    //   &getContext());
    //   patterns.insert<HaskIntegerConstOpLowering>(typeConverter,
    //   &getContext());
    //   patterns.insert<HaskLargeIntegerConstOpLowering>(typeConverter,
    //                                                    &getContext());
    //   patterns.insert<ProjectionOpLowering>(typeConverter, &getContext());
    //   patterns.insert<CallOpLowering>(typeConverter, &getContext());
    //   patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
    //   patterns.insert<ApEagerOpConversionPattern>(typeConverter,
    //   &getContext());
    //   patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
    //   &getContext()); patterns.insert<IncOpLowering>(typeConverter,
    //   &getContext()); patterns.insert<DecOpLowering>(typeConverter,
    //   &getContext());

    //   // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
    //   // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
    //   // patterns.insert<BranchOpTypeConversion>(typeConverter,
    //   &getContext()); runPatterns(target, patterns); return;
    // }

  }; // namespace
};
} // end anonymous namespace.

std::unique_ptr<mlir::Pass> createLowerRgnPass() {
  return std::make_unique<LowerRgnPass>();
}

void registerLowerRgnPass() {
  ::mlir::registerPass(
      "convert-rgn-to-std", "Convert rgn to std",
      []() -> std::unique_ptr<::mlir::Pass> { return createLowerRgnPass(); });
}
