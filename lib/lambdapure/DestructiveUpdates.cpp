#include "lambdapure/Dialect.h"
#include "lambdapure/Passes.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"
#include <iostream>
#include <map>
#include <set>

#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"

#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"
using namespace mlir;

// 0. set candidate = { function args }.
// 1. Iterate on all constructors.
//   2. For each constructor, if there is a candidate that can be reset,
//      insert a ResetOp(....) [this is the function insertReset/ what used to
//      be called insertReuse]
// 3. For each ResetOp, check the 0th region (which is the reuse region) ---
//    leave the other region intact (the fallback region). In the 0th region
//    replace ConstructOps with  ReuseOps. [this seems very broken to me?]
// 4. Cleanup after the ReuseOp, by deleting all 'ConstructOp's with zero
//    users.
// 5. Every time we enter a `case`,

namespace {
class DestructiveUpdatePattern
    : public mlir::PassWrapper<DestructiveUpdatePattern, FunctionPass> {
public:
  void runOnFunction() override {
    auto f = getFunction();
    std::vector<mlir::Value> args;
    for (int i = 0; i < (int)f.getNumArguments(); ++i) {
      Value val = f.getArgument(i);
      if (val.getType().isa<mlir::standalone::ValueType>()) {
        args.push_back(val);
      }
    }

    runOnRegion(args, f.getBody());
    cleanAfterResetInsertion(f.getBody());
    insertReuseConstructor(f.getBody());
    cleanAfterReuseInsertion(f);
  }

  void runOnRegion(const std::vector<mlir::Value> candidates,
                   mlir::Region &region) {

    for (standalone::HaskConstructOp construct :
         region.getOps<standalone::HaskConstructOp>()) {

      llvm::errs() << "\nanalyzing constructor: |" << construct << "|\n";
      for (auto candidate : candidates) {
        if (!checkControlPath(candidate, construct)) {
          continue;
        }

        // if no user of candidate is an ancestor of the constructor.
        // THIS DOES NOT HAPPEN:
        // ====================
        // <candidate>
        // foo(<candidate>) {
        //    <constructor>
        // }
        int cand_size = getCandidateSize(candidate, region);
        llvm::errs() << "runOnRegion | candidate: |" << candidate
                     << " | size: |" << cand_size << "|\n";

        if (construct.getNumOperands() > cand_size) {
          continue;
        }
        insertReset(candidate, region);
      }
    }

    for (standalone::CaseOp c : region.getOps<standalone::CaseOp>()) {
      for (int i = 0; i < (int)c->getNumRegions(); ++i) {
        runOnRegion(candidates, c->getRegion(i));
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

  void insertReset(mlir::Value reuseVal, Region &region) {

    BlockAndValueMapping mapper;
    auto context = region.getContext();
    auto builder = mlir::OpBuilder(context);
    assert(region.getBlocks().size() > 0 && "region has no blocks");
    auto &block = region.front();
    builder.setInsertionPointToStart(&block);

    llvm::errs() << __PRETTY_FUNCTION__ << " | creating reuse...\n";
    standalone::ResetOp resetOp =
        builder.create<standalone::ResetOp>(builder.getUnknownLoc(), reuseVal);

    assert(resetOp->getNumRegions() == 2);
    auto &new_region_1 = resetOp->getRegion(0);
    region.cloneInto(&new_region_1, mapper);
    new_region_1.op_begin()->erase();
    auto &new_region_2 = resetOp->getRegion(1);
    region.cloneInto(&new_region_2, mapper);
    new_region_2.op_begin()->erase();
  }

  // Guess: return largest index that is projected out from this value
  // TODO HACK: How does this work cross-module?
  int getCandidateSize(mlir::Value candidate, Region &region) {
    int size = -2;

    for (standalone::ProjectionOp proj :
         region.getOps<standalone::ProjectionOp>()) {
      mlir::Value val = proj.getOperand();
      // HACK TODO: create API for this projection.
      int index = proj.getIndex();
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
      if (standalone::ResetOp reset = dyn_cast<standalone::ResetOp>(*op)) {
        //      auto name = op->getName().getStringRef().str();
        //      if (name == "lambdapure.ResetOp") {
        auto &block = region.front();
        mlir::Operation *last;
        last = &*block.rbegin();
        //        auto last_name = last->getName().getStringRef().str();

        while (!isa<standalone::ResetOp>(*last)) {
          //        while (last_name != "lambdapure.ResetOp") {
          last->erase();
          last = &*block.rbegin();
          //          last_name = last->getName().getStringRef().str();
        }
        //      } else if (name == "lambdapure.CaseOp") {
      }
      if (standalone::CaseOp c = dyn_cast<standalone::CaseOp>(*op)) {
        for (int i = 0; i < (int)op->getNumRegions(); ++i) {
          auto &case_region = op->getRegion(i);
          cleanAfterResetInsertion(case_region);
        }
      } // end case check.
    }   // end loop over cleanup region
  }     // end cleanAfterRese

  void cleanAfterReuseInsertion(mlir::FuncOp f) {
    f.walk([&](standalone::HaskConstructOp op) {
      if (op->use_empty()) {
        op->erase();
      }
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

      for (standalone::HaskConstructOp c :
           resetRegion.getOps<standalone::HaskConstructOp>()) {
        builder.setInsertionPoint(c);
        // const int tag = c->getAttrOfType<IntegerAttr>("tag").getInt();
        std::vector<mlir::Value> operands;
        operands.push_back(reuseVal);
        for (auto operand : c->getOperands()) {
          operands.push_back(operand);
        }

        // assert(false && "unknown reuse");
        standalone::ReuseConstructorOp reuse =
            builder.create<standalone::ReuseConstructorOp>(
                op->getLoc(), c.getDataConstructorName(), operands);
        c->replaceAllUsesWith(reuse);
        // TODO HACK: why clear() ?
        operands.clear();
        // TODO: why not call |c->erase()| right here?
        // TODO: what happens if there are multiple constructors?
      }
    }

    for (standalone::CaseOp c : region.getOps<standalone::CaseOp>()) {
      for (int i = 0; i < (int)c->getNumRegions(); ++i) {
        insertReuseConstructor(c->getRegion(i));
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

  // if no user of candidate is an ancestor of op, return true.
  bool checkControlPath(mlir::Value candidate, Operation *op) {
    for (mlir::OpOperand u : candidate.getUsers()) {
      if (u.getOwner()->isProperAncestor(op)) {
        return false;
      }
    }
    return true;
    /*
    for (auto user_it = candidate.user_begin(); user_it != candidate.user_end();
         ++user_it) {
      if (user_it->isProperAncestor(op))
        return false;
    }
    return true;
     */
  }
};

} // end anonymous namespace

std::unique_ptr<Pass> mlir::lambdapure::createDestructiveUpdatePattern() {
  return std::make_unique<DestructiveUpdatePattern>();
}
