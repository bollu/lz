#include "lambdapure/Dialect.h"
#include "lambdapure/Passes.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"
#include <iostream>
#include <map>
#include <set>

#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
using namespace mlir;

namespace {
struct ConstructorOpLowering
    : public OpRewritePattern<lambdapure::ConstructorOp> {
  using OpRewritePattern<lambdapure::ConstructorOp>::OpRewritePattern;

  LogicalResult matchAndRewrite(lambdapure::ConstructorOp op,
                                PatternRewriter &rewriter) const final {
    return success();
  }
};
} // namespace

namespace {
class DestructiveUpdatePattern
    : public mlir::PassWrapper<DestructiveUpdatePattern, FunctionPass> {
public:
  void runOnFunction() override {
    auto f = getFunction();
    std::vector<mlir::Value> args;
    for (int i = 0; i < (int)f.getNumArguments(); ++i) {
      auto val = f.getArgument(i);
      auto type = val.getType();
      if (mlir::lambdapure::ObjectType::classof(type)) {
        args.push_back(val);
      }
    }
    runOnRegion(args, f.getBody());
    cleanAfterResetInsertion(f.getBody());
    insertReuseConstructor(f.getBody());
    cleanAfterReuseInsertion(f);
  }

  void runOnRegion(std::vector<mlir::Value> cand, mlir::Region &region) {
    // auto context = region.getContext();
    // auto builder = mlir::OpBuilder(context);

    for (auto op = region.op_begin(); op != region.op_end(); ++op) {
      auto name = op->getName().getStringRef().str();
      if (name == "lambdapure.ConstructorOp") {
        // checkControlPath //checkSize //
        int const_size = op->getNumOperands();
        for (auto candidate : cand) {
          if (checkControlPath(candidate, &*op)) {
            int cand_size = getCandidateSize(candidate, region);
            if (const_size <= cand_size) {
              insertReuse(candidate, region);
            }
          }
        }

      } else if (name == "lambdapure.CaseOp") {
        for (int i = 0; i < (int)op->getNumRegions(); ++i) {
          std::vector<mlir::Value> new_cand(cand);
          auto &case_region = op->getRegion(i);
          runOnRegion(new_cand, case_region);
        }
      }
    }
  }

  void insertReuse(mlir::Value reuseVal, Region &region) {

    BlockAndValueMapping mapper;
    auto context = region.getContext();
    auto builder = mlir::OpBuilder(context);
    auto &block = region.front();
    builder.setInsertionPointToStart(&block);
    Operation *resetOp = builder.create<lambdapure::ResetOp>(
        builder.getUnknownLoc(), reuseVal, 2);

    auto &new_region_1 = resetOp->getRegion(0);
    region.cloneInto(&new_region_1, mapper);
    new_region_1.op_begin()->erase();
    auto &new_region_2 = resetOp->getRegion(1);
    region.cloneInto(&new_region_2, mapper);
    new_region_2.op_begin()->erase();
  }

  int getCandidateSize(mlir::Value candidate, Region &region) {
    int size = -2;
    for (auto op = region.op_begin(); op != region.op_end(); ++op) {
      auto name = op->getName().getStringRef().str();
      if (name == "lambdapure.ProjectionOp") {
        auto val = op->getOperand(0);
        int index = op->getAttrOfType<IntegerAttr>("index").getInt();
        if (val == candidate) {
          size = std::max(size, index);
        }
      }
    }
    return size + 1;
  }

  void cleanAfterResetInsertion(mlir::Region &region) {
    for (auto op = region.op_begin(); op != region.op_end(); ++op) {
      auto name = op->getName().getStringRef().str();
      if (name == "lambdapure.ResetOp") {
        auto &block = region.front();
        mlir::Operation *last;
        last = &*block.rbegin();
        auto last_name = last->getName().getStringRef().str();
        while (last_name != "lambdapure.ResetOp") {
          last->erase();
          last = &*block.rbegin();
          last_name = last->getName().getStringRef().str();
        }
      } else if (name == "lambdapure.CaseOp") {
        for (int i = 0; i < (int)op->getNumRegions(); ++i) {
          auto &case_region = op->getRegion(i);
          cleanAfterResetInsertion(case_region);
        }
      }
    }
  }

  void cleanAfterReuseInsertion(mlir::FuncOp f) {
    f.walk([&](mlir::Operation *op) {
      if (op->getName().getStringRef().str() == "lambdapure.ConstructorOp" &&
          op->use_empty()) {
        op->erase();
      }
    });
  }

  void insertReuseConstructor(mlir::Region &region) {
    auto builder = mlir::OpBuilder(region.getContext());
    for (auto op = region.op_begin(); op != region.op_end(); ++op) {
      auto name = op->getName().getStringRef().str();
      if (name == "lambdapure.ResetOp") {
        auto reuseVal = op->getOperand(0);
        auto &resetRegion = op->getRegion(0);
        for (auto inner_op = resetRegion.op_begin();
             inner_op != region.op_end(); ++inner_op) {
          auto inner_name = inner_op->getName().getStringRef().str();
          if (inner_name == "lambdapure.ConstructorOp") {
            builder.setInsertionPoint(&*inner_op);
            int tag = inner_op->getAttrOfType<IntegerAttr>("tag").getInt();
            std::vector<mlir::Value> operands;
            operands.push_back(reuseVal);
            for (auto operand = inner_op->operand_begin();
                 operand != inner_op->operand_end(); ++operand) {
              mlir::Value new_operand = *operand;
              operands.push_back(new_operand);
            }
            auto new_result = builder.create<lambdapure::ReuseConstructorOp>(
                op->getLoc(), tag, operands);
            inner_op->replaceAllUsesWith(new_result);
            operands.clear();
          }
        }
      }

      else if (name == "lambdapure.CaseOp") {
        for (int i = 0; i < (int)op->getNumRegions(); ++i) {
          auto &case_region = op->getRegion(i);
          insertReuseConstructor(case_region);
        }
      }
    }
  }

  bool checkControlPath(mlir::Value candidate, Operation *op) {
    for (auto user_it = candidate.user_begin(); user_it != candidate.user_end();
         ++user_it) {
      if (user_it->isProperAncestor(op))
        return false;
    }
    return true;
  }

  bool isIn(std::vector<mlir::Value> vec, mlir::Value val) {
    for (auto v : vec) {
      if (v == val)
        return true;
    }
    return false;
  }
};

} // end anonymous namespace

std::unique_ptr<Pass> mlir::lambdapure::createDestructiveUpdatePattern() {
  return std::make_unique<DestructiveUpdatePattern>();
}
