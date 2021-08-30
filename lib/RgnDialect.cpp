#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Mangler.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

// https://www.youtube.com/watch?v=7ziEHEq0wNo
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch3/toyc.cpp
#include "mlir/IR/AsmState.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Parser.h"
#include "mlir/Target/LLVMIR/Export.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/InliningUtils.h"
#include "mlir/Transforms/Passes.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/ErrorOr.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

// Execution
#include "mlir/Transforms/RegionUtils.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

const bool DEBUG = false;

// RGN DIALECT
// ===========
#include "mlir/Dialect/Rgn/RgnDialect.h"

RgnDialect::RgnDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, mlir::TypeID::get<RgnDialect>()) {
  //   addOperations<
  // #define GET_OP_LIST
  // #include "Hask/HaskOps.cpp.inc"
  //       >();
  // clang-format off
    // addOperations<RgnReturnOp, RgnSymOp, RgnValOp, RgnCallSymOp, RgnCallValOp, RgnJumpSymOp, RgnJumpValOp
    // >();
    addOperations<RgnReturnOp, RgnSymOp, RgnValOp, RgnCallSymOp
    , RgnCallValOp, RgnJumpSymOp, RgnJumpValOp, RgnEndOp>();

    // addAttributes<DataConstructorAttr>();
    // addInterfaces<HaskInlinerInterface>();
  // clang-format on
}

// bool HaskDialect::isFunctionRecursive(FuncOp funcOp) {
// }

// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp

mlir::ParseResult RgnReturnOp::parse(mlir::OpAsmParser &parser,
                                     mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnReturnOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// template <typename ValsT>
// void RgnReturnOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
//                         mlir::SmallVectorImpl<mlir::Value> &vs) {
// }

// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp
// RGN OPS::RgnReturnOp

mlir::ParseResult RgnEndOp::parse(mlir::OpAsmParser &parser,
                                     mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnEndOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// RGN OPS::RgnValOp
// RGN OPS::RgnValOp
// RGN OPS::RgnValOp
// RGN OPS::RgnValOp
// RGN OPS::RgnValOp

mlir::ParseResult RgnValOp::parse(mlir::OpAsmParser &parser,
                                  mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnValOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// template <typename RangeT>
// void RgnValOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
//                      RangeT ts) {
//   mlir::Region *rnew = state.addRegion();
//   mlir::BlockAndValueMapping mapping;
//   //  r->cloneInto(rnew, mapping);
//   state.addTypes(ts);
// }

void RgnValOp::getSuccessorRegions(
    mlir::Optional<unsigned> index, mlir::ArrayRef<mlir::Attribute> operands,
    mlir::SmallVectorImpl<mlir::RegionSuccessor> &regions) {
  // regions.push_back(mlir::RegionSuccessor(this->getOperation()->getResults()));
  return;
}

// RGN OPS::RgnSymOp
// RGN OPS::RgnSymOp
// RGN OPS::RgnSymOp
// RGN OPS::RgnSymOp
// RGN OPS::RgnSymOp

mlir::ParseResult RgnSymOp::parse(mlir::OpAsmParser &parser,
                                  mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnSymOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// RGN OPS::RgnCallValOp
// RGN OPS::RgnCallValOp
// RGN OPS::RgnCallValOp
// RGN OPS::RgnCallValOp
// RGN OPS::RgnCallValOp
// template <typename ValsT, typename TypesT>
// void RgnCallValOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
//                          mlir::Value rgn, ValsT args, TypesT resultTypes) {
//   state.addOperands(rgn);
//   state.addOperands(args);
//   state.addTypes(resultTypes);
// }

mlir::ParseResult RgnCallValOp::parse(mlir::OpAsmParser &parser,
                                      mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnCallValOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// RGN OPS::RgnCallSymOp
// RGN OPS::RgnCallSymOp
// RGN OPS::RgnCallSymOp
// RGN OPS::RgnCallSymOp
// RGN OPS::RgnCallSymOp

mlir::ParseResult RgnCallSymOp::parse(mlir::OpAsmParser &parser,
                                      mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnCallSymOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// RGN OPS::RgnJumpValOp
// RGN OPS::RgnJumpValOp
// RGN OPS::RgnJumpValOp
// RGN OPS::RgnJumpValOp
// RGN OPS::RgnJumpValOp

mlir::ParseResult RgnJumpValOp::parse(mlir::OpAsmParser &parser,
                                      mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnJumpValOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// RGN OPS::RgnJumpSymOp
// RGN OPS::RgnJumpSymOp
// RGN OPS::RgnJumpSymOp
// RGN OPS::RgnJumpSymOp
// RGN OPS::RgnJumpSymOp

mlir::ParseResult RgnJumpSymOp::parse(mlir::OpAsmParser &parser,
                                      mlir::OperationState &result) {
  assert(false && "unimplemented");
}

void RgnJumpSymOp::print(mlir::OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// ===== HELPERS ====== //

// ==== REGION OPTIMIZATION ====
// ==== REGION OPTIMIZATION ====
// ==== REGION OPTIMIZATION ====
// ==== REGION OPTIMIZATION ====
// ==== REGION OPTIMIZATION ====

struct PatternCallValKnownRegion : public mlir::OpRewritePattern<RgnCallValOp> {
  /// We register this pattern to match every toy.transpose in the IR.
  /// The "benefit" is used by the framework to order the patterns and process
  /// them in order of profitability.
  PatternCallValKnownRegion(mlir::MLIRContext *context)
      : OpRewritePattern<RgnCallValOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(RgnCallValOp call,
                  mlir::PatternRewriter &rewriter) const override {
    RgnValOp rgnval = call.getFn().getDefiningOp<RgnValOp>();
    if (!rgnval) {
      return mlir::failure();
    }

    // code from:
    // https://github.com/llvm/llvm-project/blob/9a11c70c1856f4e801d0863c552c754f28110237/mlir/lib/Conversion/SCFToStandard/SCFToStandard.cpp#L411
    auto loc = call.getLoc();
    auto *condBlock = rewriter.getInsertionBlock();
    auto opPosition = rewriter.getInsertionPoint();
    auto *remainingOpsBlock = rewriter.splitBlock(condBlock, opPosition);

    auto &region = rgnval.getRegion();
    rewriter.setInsertionPointToEnd(condBlock);
    rewriter.create<mlir::BranchOp>(loc, &region.front());

    for (mlir::Block &block : region) {
      if (auto terminator =
              mlir::dyn_cast<mlir::scf::YieldOp>(block.getTerminator())) {
        mlir::ValueRange terminatorOperands = terminator->getOperands();
        rewriter.setInsertionPointToEnd(&block);
        rewriter.create<mlir::BranchOp>(loc, remainingOpsBlock,
                                        terminatorOperands);
        rewriter.eraseOp(terminator);
      }
    }

    rewriter.inlineRegionBefore(region, remainingOpsBlock);

    mlir::SmallVector<mlir::Value> vals;
    for (auto arg : remainingOpsBlock->addArguments(call->getResultTypes())) {
      vals.push_back(arg);
    }
    rewriter.replaceOp(call, vals);
    return mlir::success();

    // rewriter.cloneRegionBefore(call->getParentRegion(), rgnval.getRegion(),
    // call->getIterator(), mapping);
    // TODO: need to replace with |scf.execute_region|.
    assert(false && "TODO: implement.");
    return mlir::success();
  }
};

struct RgnOptPass : public mlir::Pass {
  RgnOptPass() : mlir::Pass(mlir::TypeID::get<RgnOptPass>()){};

  llvm::StringRef getName() const override { return "RgnOptPass"; }

  RgnOptPass(const RgnOptPass &other)
      : mlir::Pass(::mlir::TypeID::get<RgnOptPass>()) {}

  std::unique_ptr<mlir::Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto newInst =
        std::make_unique<RgnOptPass>(*static_cast<const RgnOptPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::ModuleOp mod(getOperation());
    mlir::OpBuilder builder(mod);
    mlir::OwningRewritePatternList patterns(&getContext());
    patterns.insert<PatternCallValKnownRegion>(&getContext());

    if (DEBUG) {
      ::llvm::DebugFlag = true;
    }

    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "\n==Cannonicalization Failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    } else {
      //      llvm::errs() << "==Cannonicalization Succeeded===\n";
      //      getOperation()->print(llvm::errs());
      //      llvm::errs() << "\n===\n";
    }
    ::llvm::DebugFlag = false;
  }
};

std::unique_ptr<mlir::Pass> createRgnOptPass() {
  return std::make_unique<RgnOptPass>();
}

void registerRgnOptPass() {
  ::mlir::registerPass(
      "rgn-opt", "optimize rgn",
      []() -> std::unique_ptr<::mlir::Pass> { return createRgnOptPass(); });
}
