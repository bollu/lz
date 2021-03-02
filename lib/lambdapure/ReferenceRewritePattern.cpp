#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "lambdapure/Dialect.h"
#include "lambdapure/Passes.h"
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"
#include <iostream>

#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

using namespace mlir;

namespace {
class ReferenceRewriterPattern
    : public mlir::PassWrapper<ReferenceRewriterPattern, FunctionPass> {
public:
  void runOnFunction() override {
    auto f = getFunction();
    std::vector<mlir::Value> args;
    std::vector<int> consumes;

    for (int i = 0; i < (int)f.getNumArguments(); ++i) {
      args.push_back(f.getArgument(i));
      consumes.push_back(-1); // assume ownerships => starts with -1
    }
    assert(args.size() == consumes.size());
    runOnRegion(args, consumes, f.getBody());
  }

  void runOnRegion(std::vector<mlir::Value> args, std::vector<int> consumes,
                   mlir::Region &region) {
    assert(args.size() == consumes.size());

    for (Operation &o : region.getOps()) {
      MLIRContext *context = o.getContext();
      mlir::OpBuilder builder = mlir::OpBuilder(context);

      if (lambdapure::ReturnOp op = mlir::dyn_cast<lambdapure::ReturnOp>(o)) {
        // vv HACK TODO: refactor to use this->context

        mlir::Value val = op.getOperand();
        onValue(op.getOperation(), args, consumes, val, builder);
        addAllDecs(op.getOperation(), args, consumes, builder);
      }

      if (auto op = mlir::dyn_cast<lambdapure::ConstructorOp>(o)) {
        MLIRContext *context = op.getContext();
        mlir::OpBuilder builder = mlir::OpBuilder(context);

        args.push_back(op.getResult());
        consumes.push_back(0); // TODO HACK: is this correct?
        for (int i = 0; i < (int)op.getNumOperands(); ++i) {
          onValue(op.getOperation(), args, consumes, op.getOperand(i), builder);
        }
      }

      if (auto op = mlir::dyn_cast<lambdapure::CaseOp>(o)) {
        for (int i = 0; i < (int)op.getNumRegions(); ++i) {
          std::vector<mlir::Value> new_args(args);
          std::vector<int> new_consumes(consumes);
          Region &region = op.getRegion(i);
          runOnRegion(new_args, new_consumes, region);
        }
      }

      if (auto op = mlir::dyn_cast<mlir::lambdapure::ResetOp>(o)) {
        // TODO HACK: doesn't a reset region have exactly 2 regions?!
        // TODO HACK What the fuck is this LOOP?
        for (int i = 0; i < (int)op.getNumRegions(); ++i) {
          std::vector<mlir::Value> new_args(args);
          std::vector<int> new_consumes(consumes);

          auto &region = op.getRegion(i);
          if (i == 0) {
            runOnResetRegion(op.getOperand(), new_args, new_consumes, region);
          } else {
            runOnRegion(new_args, new_consumes, region);
          }
        }
      }

      if (mlir::isa<lambdapure::CallOp>(o) || mlir::isa<lambdapure::AppOp>(o) ||
          mlir::isa<lambdapure::PapOp>(o)) {
        for (int i = 0; i < (int)o.getNumOperands(); ++i) {
          onValue(&o, args, consumes, o.getOperand(i), builder);
        }
      }
    } // end for loop over operations

    // for (auto it = region.op_begin(); it != region.op_end(); ++it) {
    //   auto context = it->getContext();
    //   auto builder = mlir::OpBuilder(context);

    //   // We start with args consume at -1
    //   // check for return,ReuseConstructorOp, Constructor, call,
    //   // application,partial application

    //   auto name = it->getName().getStringRef().str();

    //   if (name == "lambdapure.ReturnOp") {
    //     mlir::Value val = it->getOperand(0);
    //     onValue(&*it, args, consumes, val, builder);
    //     addAllDecs(&*it, args, consumes, builder);
    //   } else if (name == "lambdapure.ReuseConstructorOp") {

    //     // change the value of in args to the new value
    //     for (int i = 0; i < (int)args.size(); ++i) {
    //       if (args[i] == it->getOperand(0)) {
    //         args[i] = it->getOpResult(0);
    //       }
    //     }
    //   } else if (name == "lambdapure.ConstructorOp") {
    //     args.push_back(it->getOpResult(0));
    //     consumes.push_back(0); // TODO HACK: is this correct?
    //     for (int i = 0; i < (int)it->getNumOperands(); ++i) {
    //       onValue(&*it, args, consumes, it->getOperand(i), builder);
    //     }
    //   } else if (name == "lambdapure.CallOp" || name == "lambdapure.AppOp" ||
    //              name == "lambdapure.PapOp") {
    //     for (int i = 0; i < (int)it->getNumOperands(); ++i) {
    //       onValue(&*it, args, consumes, it->getOperand(i), builder);
    //     }
    //   } else if (name == "lambdapure.CaseOp") {
    //     for (int i = 0; i < (int)it->getNumRegions(); ++i) {
    //       std::vector<mlir::Value> new_args(args);
    //       std::vector<int> new_consumes(consumes);
    //       auto &region = it->getRegion(i);
    //       runOnRegion(new_args, new_consumes, region);
    //     }

    //   } else if (name == "lambdapure.ResetOp") {
    //     for (int i = 0; i < (int)it->getNumRegions(); ++i) {
    //       std::vector<mlir::Value> new_args(args);
    //       std::vector<int> new_consumes(consumes);
    //       auto &region = it->getRegion(i);
    //       if (i == 0) {
    //         runOnResetRegion(it->getOperand(0), new_args, new_consumes,
    //         region);
    //       } else {
    //         runOnRegion(new_args, new_consumes, region);
    //       }
    //     }
    //   }
    // }
  }

  void runOnResetRegion(mlir::Value resetValue, std::vector<mlir::Value> args,
                        std::vector<int> consumes, mlir::Region &region) {
    assert(args.size() == consumes.size());
    for (auto it = region.op_begin(); it != region.op_end(); ++it) {
      auto name = it->getName().getStringRef().str();
      if (name == "lambdapure.ProjectionOp" &&
          it->getOperand(0) == resetValue) {
        args.push_back(it->getOpResult(0));
        consumes.push_back(-1);
      }
    }
    std::vector<mlir::Value> new_args(args);
    std::vector<int> new_consumes(consumes);
    runOnRegion(new_args, new_consumes, region);
  }

  // TODO HACK: should be opOperand?
  void onValue(Operation *op, std::vector<mlir::Value> &args,
               std::vector<int> &consumes, mlir::Value val,
               mlir::OpBuilder &builder) {
    assert(args.size() == consumes.size());
    if (isIn(args, val)) {
      int c = consume(args, consumes, val);
      if (c >= 1) {
        builder.setInsertionPoint(op);
        builder.create<mlir::standalone::IncOp>(builder.getUnknownLoc(), val);
      }
    } else {
      builder.setInsertionPoint(op);
      builder.create<mlir::standalone::IncOp>(builder.getUnknownLoc(), val);
    }
  }

  int consume(std::vector<mlir::Value> &args, std::vector<int> &consumes,
              mlir::Value val) {
    std::cerr << "consumes: " << consumes.size() << " |args: " << args.size()
              << "\n";
    assert(args.size() == consumes.size());
    for (int i = 0; i < (int)args.size(); ++i) {
      if (args[i] == val) {
        consumes[i]++;
        return consumes[i];
      }
    }
    return 0;
    // assert(false && "should not reach here.");
  }

  void addAllDecs(Operation *op, std::vector<mlir::Value> &args,
                  std::vector<int> &consumes, mlir::OpBuilder &builder) {
    assert(args.size() == consumes.size());
    builder.setInsertionPoint(op);
    for (int i = 0; i < (int)args.size(); ++i) {
      if (consumes[i] == -1) {
        // HACK: don't really understand why the current code does not handle
        // this
        if (!args[i].getType().isa<lambdapure::ObjectType>()) {
          llvm::errs() << "arg of incorrect type: |" << args[i] << "|\n";
          continue;
        }
        builder.create<mlir::standalone::DecOp>(builder.getUnknownLoc(), args[i]);
      }
      assert(consumes[i] >= -1);
    }
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

std::unique_ptr<Pass> mlir::lambdapure::createReferenceRewriterPattern() {
  return std::make_unique<ReferenceRewriterPattern>();
}
