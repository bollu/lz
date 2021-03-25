#include "lambdapure/Dialect.h"
#include "lambdapure/Passes.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"
#include <iostream>
#include <map>
#include <set>

#include "Hask/HaskOps.h"
#include "Hask/HaskDialect.h"

#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
using namespace mlir;

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
      if (type.isa<mlir::standalone::ValueType>()) {
        args.push_back(val);
      }
    }
    runOnRegion(args, f.getBody());
    cleanAfterResetInsertion(f.getBody());
    insertReuseConstructor(f.getBody());
    cleanAfterReuseInsertion(f);
  }

  void runOnRegion(std::vector<mlir::Value> candidates, mlir::Region &region) {
    // auto context = region.getContext();
    // auto builder = mlir::OpBuilder(context);
      for (standalone::HaskConstructOp op : region.getOps<standalone::HaskConstructOp
                                                        >()) {
        int const_size = op.getNumOperands();
        for (auto candidate : candidates) {
          if (!checkControlPath(candidate, op)) continue;
            int cand_size = getCandidateSize(candidate, region);
            if (const_size > cand_size) continue;
              insertReuse(candidate, region);
        }
      }

      for(standalone::CaseOp op : region.getOps<standalone::CaseOp>()) {
          for (int i = 0; i < (int)op->getNumRegions(); ++i) {
              std::vector<mlir::Value> new_candidates(candidates);
              auto &case_region = op->getRegion(i);
              runOnRegion(new_candidates, case_region);
          }
      }

    // for (auto op = region.op_begin(); op != region.op_end(); ++op) {
    //   auto name = op->getName().getStringRef().str();
    //   if (name == "lambdapure.ConstructorOp") {
    //     // checkControlPath //checkSize //
    //     int const_size = op->getNumOperands();
    //     for (auto candidate : candidates) {
    //       if (checkControlPath(candidate, &*op)) {
    //         int cand_size = getCandidateSize(candidate, region);
    //         if (const_size <= cand_size) {
    //           insertReuse(candidate, region);
    //         }
    //       }
    //     }

    //   } else if (name == "lambdapure.CaseOp") {
    //     for (int i = 0; i < (int)op->getNumRegions(); ++i) {
    //       std::vector<mlir::Value> new_cand(candidates);
    //       auto &case_region = op->getRegion(i);
    //       runOnRegion(new_cand, case_region);
    //     }
    //   }
    // }
  }

  void insertReuse(mlir::Value reuseVal, Region &region) {

    BlockAndValueMapping mapper;
    auto context = region.getContext();
    auto builder = mlir::OpBuilder(context);
    auto &block = region.front();
    builder.setInsertionPointToStart(&block);

//    Operation *resetOp = builder.create<standalone::ResetOp>(
//        builder.getUnknownLoc(), reuseVal, 2);
    Operation *resetOp = nullptr;

    auto &new_region_1 = resetOp->getRegion(0);
    region.cloneInto(&new_region_1, mapper);
    new_region_1.op_begin()->erase();
    auto &new_region_2 = resetOp->getRegion(1);
    region.cloneInto(&new_region_2, mapper);
    new_region_2.op_begin()->erase();
  }

  // Guess: return largest index that is projected out from this value
  // TODO HACKHow does this work cross-module?
  int getCandidateSize(mlir::Value candidate, Region &region) {
    int size = -2;

    for(standalone::ProjectionOp proj : region.getOps<standalone::ProjectionOp>()) {
        mlir::Value val = proj.getOperand();
        // HACK TODO: create API for this projection.
        int index = proj.getOperation()->getAttrOfType<IntegerAttr>("index").getInt();
        if (val == candidate) {
            size = std::max(size, index);
        }
    }
    // for (auto op = region.op_begin(); op != region.op_end(); ++op) {
    //   auto name = op->getName().getStringRef().str();
    //   if (name == "lambdapure.ProjectionOp") {
    //     auto val = op->getOperand(0);
    //     int index = op->getAttrOfType<IntegerAttr>("index").getInt();
    //     if (val == candidate) {
    //       size = std::max(size, index);
    //     }
    //   }
    // }

    // why do we return (size + 1) ?
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
    f.walk([&](standalone::HaskConstructOp op) {
        if (op->use_empty()) { op->erase(); }
    });
    // f.walk([&](mlir::Operation *op) {
    //   if (op->getName().getStringRef().str() == "lambdapure.ConstructorOp" &&
    //       op->use_empty()) {
    //     op->erase();
    //   }
    // });
  }

  void insertReuseConstructor(mlir::Region &region) {
    auto builder = mlir::OpBuilder(region.getContext());
    for (standalone::ResetOp op : region.getOps<standalone::ResetOp>()) {
        mlir::Value reuseVal = op.getOperand();
        // vvv ResetOp should have SingleRegion?
        mlir::Region &resetRegion = op->getRegion(0);


        for(standalone::HaskConstructOp c : resetRegion.getOps<standalone::HaskConstructOp>()) {
            builder.setInsertionPoint(c);
            // const int tag = c->getAttrOfType<IntegerAttr>("tag").getInt();
            std::vector<mlir::Value> operands;
            operands.push_back(reuseVal);
            for(auto operand : c->getOperands()) {
                operands.push_back(operand);
            }

            assert(false && "unknown reuse");
//          standalone::ReuseConstructorOp reuse  =
//                 builder.create<lambdapure::ReuseConstructorOp>(op->getLoc(), tag, operands);
            standalone::ReuseConstructorOp reuse;
            c->replaceAllUsesWith(reuse);
            // TODO HACK: why clear() ?
            operands.clear();

        }

        for (standalone::CaseOp c : resetRegion.getOps<standalone::CaseOp>()) {
            for (int i = 0; i < (int)c->getNumRegions(); ++i) {
                insertReuseConstructor(c->getRegion(i));
            }
        }
    }
    // for (auto op = region.op_begin(); op != region.op_end(); ++op) {
    //   auto name = op->getName().getStringRef().str();
    //   if (name == "lambdapure.ResetOp") {
    //     auto reuseVal = op->getOperand(0);
    //     auto &resetRegion = op->getRegion(0);
    //     for (auto inner_op = resetRegion.op_begin();
    //          inner_op != region.op_end(); ++inner_op) {
    //       auto inner_name = inner_op->getName().getStringRef().str();
    //       if (inner_name == "lambdapure.ConstructorOp") {
    //         builder.setInsertionPoint(&*inner_op);
    //         int tag = inner_op->getAttrOfType<IntegerAttr>("tag").getInt();
    //         std::vector<mlir::Value> operands;
    //         operands.push_back(reuseVal);
    //         for (auto operand = inner_op->operand_begin();
    //              operand != inner_op->operand_end(); ++operand) {
    //           mlir::Value new_operand = *operand;
    //           operands.push_back(new_operand);
    //         }
    //         auto new_result = builder.create<lambdapure::ReuseConstructorOp>(
    //             op->getLoc(), tag, operands);
    //         inner_op->replaceAllUsesWith(new_result);
    //         operands.clear();
    //       }
    //     }
    //   }

    //   else if (name == "lambdapure.CaseOp") {
    //     for (int i = 0; i < (int)op->getNumRegions(); ++i) {
    //       auto &case_region = op->getRegion(i);
    //       insertReuseConstructor(case_region);
    //     }
    //   }
    // }
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
