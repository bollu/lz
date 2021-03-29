#include "Unification/UnificationDialect.h"
#include "Unification/UnificationOps.h"
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

#define DEBUG_TYPE "unifier-pass"
#include "llvm/Support/Debug.h"

namespace mlir {
namespace unif {

struct UnifierPass : public Pass {
  UnifierPass() : Pass(mlir::TypeID::get<UnifierPass>()){};
  StringRef getName() const override { return "UnifierPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst =
        std::make_unique<UnifierPass>(*static_cast<const UnifierPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::OwningRewritePatternList patterns(&getContext());
    //! // force(ap) -> apeager. safe.
    //! patterns.insert<ForceOfKnownApPattern>(&getContext());
    //! // force(thunkify) -> direct val. safe.
    //! patterns.insert<ForceOfThunkifyPattern>(&getContext());
    //! // apeager(f, x, y, z) -> inlined. safe.
    //! patterns.insert<InlineApEagerPattern>(&getContext());

    //! // f(paramt): paramv = force(paramt); use paramv. Safe-ish, since
    //! // we immediately have a force as the first instruction.
    //! // 1. Write as FuncOp pattern
    //! // 2.  Write as closure.
    //! patterns.insert<OutlineRecursiveApEagerOfThunkPattern>(&getContext());
    //! // f(paramConstructor) = case paramConstructor of {
    //! // (Constructor paramValue) -> ..
    //! // }.
    //! // Safe ish, since we immediately expect a case of the first
    //! // instruction.
    //! // 1. Write as FuncOp pattern
    //! // 2. write as closure.
    //! patterns.insert<OutlineRecursiveApEagerOfConstructorPattern>(&getContext());
    //! // same as above?
    //! patterns.insert<OutlineCaseOfFnInput>(&getContext());
    //! // f(x): .. return(Constructor(v)) -> outline the last paer. Safe ish,
    //! // since we only outline the final computation.
    //! patterns.insert<OutlineReturnOfConstructor>(&getContext());
    //! // f: case of {C1 -> D v1; C2 -> D v2; .. Cn -> D vn;} into
    //! //    f: D (case v of {C1 -> v1; C2 -> v2; .. Cn -> vn; }
    //! // Safe.
    //! patterns.insert<PeelConstructorsFromCasePattern>(&getContext());
    //! // Same as peel constructor from case for ints. safe.
    //! patterns.insert<PeelConstructorsFromCaseIntPattern>(&getContext());

    //! // f: case (Ci vi) of { C1 w1 -> e1; C2 w2 -> e2 ... Cn wn -> en};
    //! //    f: ei[wi := vi].
    //! // safe
    //! patterns.insert<CaseOfKnownConstructorPattern>(&getContext());
    //! // same as Case of known constructor for ints. safe.
    //! patterns.insert<CaseOfKnownIntPattern>(&getContext());

    //! ::llvm::DebugFlag = true;

    //! // ConversionTarget target(getContext());
    //! // if (failed(mlir::applyPartialConversion(getOperation(), target,
    //! //                                         std::move(patterns)))) {
    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "\n===Unifier failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    } else {

      llvm::errs() << "===Unifier succeeded===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
    }
    ::llvm::DebugFlag = false;
  };
}; // namespace standalone

std::unique_ptr<mlir::Pass> createUnifierPass() {
  return std::make_unique<UnifierPass>();
}

void registerUnifierPass() {
  ::mlir::registerPass(
      "lz-unifier", "Perform unifier transform",
      []() -> std::unique_ptr<::mlir::Pass> { return createUnifierPass(); });
}
} // namespace unif
} // namespace mlir

