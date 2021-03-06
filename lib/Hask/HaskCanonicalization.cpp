#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/InliningUtils.h"
#include "llvm/ADT/SmallPtrSet.h"
#include <Pointer/PointerDialect.h>
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

struct CanonicalizeCaseRetPattern
    : public mlir::OpRewritePattern<HaskCaseRetOp> {
  CanonicalizeCaseRetPattern(mlir::MLIRContext *context)
      : OpRewritePattern<HaskCaseRetOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(HaskCaseRetOp caseret,
                  mlir::PatternRewriter &rewriter) const override {
    // TODO: convert caseRet to case.
    SmallVector<mlir::Attribute, 4> lhss;
    SmallVector<mlir::Region *, 4> rhss;

    rewriter.setInsertionPoint(caseret);
    //   static void build(mlir::OpBuilder &builder, mlir::OperationState
    //   &state,
    //                Value scrutinee, int numrhss);
    // TagGetOp tag = rewriter.create<mlir::standalone::TagGetOp>(
    //    rewriter.getUnknownLoc(), caseret.getScrutinee());
    CaseOp caseop = rewriter.create<CaseOp>(rewriter.getUnknownLoc(), caseret.getScrutinee(),
                                            caseret.getNumAlts());

    BlockAndValueMapping mapper;
    for (int i = 0; i < caseret.getNumAlts(); ++i) {
      caseret->getRegion(i).cloneInto(&caseop->getRegion(i), mapper);
    }

    rewriter.create<HaskReturnOp>(rewriter.getUnknownLoc(), caseop.getResult());
    rewriter.eraseOp(caseret);
    return success();
  }
};


struct CanonicalizeCaseIntRetPattern
    : public mlir::OpRewritePattern<HaskCaseIntRetOp> {
  CanonicalizeCaseIntRetPattern(mlir::MLIRContext *context)
      : OpRewritePattern<HaskCaseIntRetOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(HaskCaseIntRetOp caseret,
                  mlir::PatternRewriter &rewriter) const override {
    // TODO: convert caseRet to case.
    SmallVector<mlir::Attribute, 4> lhss;
    SmallVector<mlir::Region *, 4> rhss;

    rewriter.setInsertionPoint(caseret);
    CaseIntOp caseop = rewriter.create<CaseIntOp>(rewriter.getUnknownLoc(), caseret.getScrutinee(),
                                            caseret->getAttrs());

    BlockAndValueMapping mapper;
    for (int i = 0; i < caseret.getNumAlts(); ++i) {
      caseret->getRegion(i).cloneInto(&caseop->getRegion(i), mapper);
    }

    rewriter.create<HaskReturnOp>(rewriter.getUnknownLoc(), caseop.getResult());
    rewriter.eraseOp(caseret);
    return success();
  }
};

struct CanonicalizeHaskCallPattern : public mlir::OpRewritePattern<HaskCallOp> {
  CanonicalizeHaskCallPattern(mlir::MLIRContext *context)
      : OpRewritePattern<HaskCallOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(HaskCallOp call,
                  mlir::PatternRewriter &rewriter) const override {
    rewriter.setInsertionPoint(call);
    StringRef fnname = call.getCallee();
    ModuleOp mod = call->getParentOfType<ModuleOp>();
    ValueType vty = rewriter.getType<ValueType>();

    mlir::SmallVector<mlir::Type, 4> inputTys;
    for (int i = 0; i < (int)call.getNumOperands(); ++i) {
      inputTys.push_back(vty);
    }
    mlir::SmallVector<mlir::Type, 4> resultTys{vty};

    rewriter.setInsertionPointAfter(call);

    // TODO: think about if I really want to recreate the op.
    // rewriter.replaceOpWithNewOp<CallOp>(call, fnname, resultTys,
    //                                     call->getOperands());
    rewriter.replaceOpWithNewOp<HaskCallOp>(call, fnname.str(), resultTys,
                                        call->getOperands());
    
    // module has the function.
    if (mod.lookupSymbol<FuncOp>(fnname)) {
      return failure();
    } else {
      // create forward declaration.

      mlir::FunctionType fty = rewriter.getFunctionType(inputTys, resultTys);
      mlir::FuncOp fwdDecl =
          mlir::FuncOp::create(rewriter.getUnknownLoc(), fnname, fty);
      fwdDecl.setPrivate();
      mod.push_back(fwdDecl);
      return success();
    }
  }
};

struct CanonicalizeHaskReturnOpPattern
    : public mlir::OpRewritePattern<HaskReturnOp> {
  CanonicalizeHaskReturnOpPattern(mlir::MLIRContext *context)
      : OpRewritePattern<HaskReturnOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(HaskReturnOp ret,
                  mlir::PatternRewriter &rewriter) const override {
    CaseOp caseParent = ret.getOperation()->getParentOfType<CaseOp>();
    CaseIntOp caseIntParent = ret.getOperation()->getParentOfType<CaseIntOp>();

    if (caseParent || caseIntParent) {
      return failure();
    } else {
      rewriter.replaceOpWithNewOp<ReturnOp>(ret, ret.getOperand());
      return success();
    }
  }
};




class HaskCanonicalizationPass : public Pass {
public:
  HaskCanonicalizationPass()
      : Pass(mlir::TypeID::get<HaskCanonicalizationPass>()){};
  StringRef getName() const override { return "HaskCanonicalizationPass"; }
  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<HaskCanonicalizationPass>(
        *static_cast<const HaskCanonicalizationPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::OwningRewritePatternList patterns(&getContext());
    // TODO: use the MLIR canonicalization hooks, instead of writing a pass.
    // https://mlir.llvm.org/docs/Canonicalization/
    // const int MAX_ITERATIONS = 100;
    // vvv Disable the caseRet -> case conversion.
    // patterns.insert<CanonicalizeCaseRetPattern>(&getContext());
    // patterns.insert<CanonicalizeCaseIntRetPattern>(&getContext());

    patterns.insert<CanonicalizeHaskReturnOpPattern>(&getContext());
    patterns.insert<CanonicalizeHaskCallPattern>(&getContext());
    ::llvm::DebugFlag = true;
    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "\n===cannonicalization failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    } else {

      //      llvm::errs() << "===cannonicalization succeeded===\n";
      //      getOperation()->print(llvm::errs());
      //      llvm::errs() << "\n===\n";
    }
    ::llvm::DebugFlag = false;
  }
};

std::unique_ptr<mlir::Pass> createHaskCanonicalizePass() {
  return std::make_unique<HaskCanonicalizationPass>();
}

void registerHaskCanonicalizePass() {
  ::mlir::registerPass("lz-canonicalize",
                       "Perform canonicalization, reducing to minimal LZ",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createHaskCanonicalizePass();
                       });
}

} // namespace standalone
} // namespace mlir
