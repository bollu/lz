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
    runOnRegion(args, consumes, f.getBody());
  }

  void runOnRegion(std::vector<mlir::Value> args, std::vector<int> consumes,
                   mlir::Region &region) {
    for (auto it = region.op_begin(); it != region.op_end(); ++it) {
      auto context = it->getContext();
      auto builder = mlir::OpBuilder(context);

      // We start with args consume at -1
      // check for return,ReuseConstructorOp, Constructor, call,
      // application,partial application

      auto name = it->getName().getStringRef().str();

      if (name == "lambdapure.ReturnOp") {
        mlir::Value val = it->getOperand(0);
        onValue(&*it, args, consumes, val, builder);
        addAllDecs(&*it, args, consumes, builder);
      } else if (name == "lambdapure.ReuseConstructorOp") {

        // change the value of in args to the new value
        for (int i = 0; i < (int)args.size(); ++i) {
          if (args[i] == it->getOperand(0)) {
            args[i] = it->getOpResult(0);
          }
        }
      } else if (name == "lambdapure.ConstructorOp") {
        args.push_back(it->getOpResult(0));
        for (int i = 0; i < (int)it->getNumOperands(); ++i) {
          onValue(&*it, args, consumes, it->getOperand(i), builder);
        }
      } else if (name == "lambdapure.CallOp" || name == "lambdapure.AppOp" ||
                 name == "lambdapure.PapOp") {
        for (int i = 0; i < (int)it->getNumOperands(); ++i) {
          onValue(&*it, args, consumes, it->getOperand(i), builder);
        }
      } else if (name == "lambdapure.CaseOp") {
        for (int i = 0; i < (int)it->getNumRegions(); ++i) {
          std::vector<mlir::Value> new_args(args);
          std::vector<int> new_consumes(consumes);
          auto &region = it->getRegion(i);
          runOnRegion(new_args, new_consumes, region);
        }

      } else if (name == "lambdapure.ResetOp") {
        for (int i = 0; i < (int)it->getNumRegions(); ++i) {
          std::vector<mlir::Value> new_args(args);
          std::vector<int> new_consumes(consumes);
          auto &region = it->getRegion(i);
          if (i == 0) {
            runOnResetRegion(it->getOperand(0), new_args, new_consumes, region);
          } else {
            runOnRegion(new_args, new_consumes, region);
          }
        }
      }
    }
  }

  void runOnResetRegion(mlir::Value resetValue, std::vector<mlir::Value> args,
                        std::vector<int> consumes, mlir::Region &region) {
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

  void onValue(Operation *op, std::vector<mlir::Value> &args,
               std::vector<int> &consumes, mlir::Value val,
               mlir::OpBuilder &builder) {
    if (isIn(args, val)) {
      int c = consume(args, consumes, val);
      if (c >= 1) {
        builder.setInsertionPoint(op);
        builder.create<lambdapure::IncOp>(builder.getUnknownLoc(), val);
      }
    } else {
      builder.setInsertionPoint(op);
      builder.create<lambdapure::IncOp>(builder.getUnknownLoc(), val);
    }
  }

  int consume(std::vector<mlir::Value> &args, std::vector<int> &consumes,
              mlir::Value val) {
    std::cerr << "consumes: " << consumes.size() << " |args: " << args.size() << "\n";
    // assert(consumes.size() == args.size());
    // HACK! THINK ABOUT THIS PROPERLY!
    // for (int i = 0; i < (int)args.size(); ++i) {
    for (int i = 0; i < (int)consumes.size(); ++i) {
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
    builder.setInsertionPoint(op);
    // HACK! THINK ABOUT THIS PROPERLY
    // for (int i = 0; i < (int)args.size(); ++i) {
    for (int i = 0; i < (int)consumes.size(); ++i) {
      if (consumes[i] == -1) {
        builder.create<lambdapure::DecOp>(builder.getUnknownLoc(), args[i]);
      }
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
