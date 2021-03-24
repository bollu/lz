#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "llvm/Support/Casting.h"
#include <map>
#include <set>

using namespace mlir;
using namespace standalone;

struct LzLazifyPass : public Pass {
  LzLazifyPass() : Pass(mlir::TypeID::get<LzLazifyPass>()){};
  StringRef getName() const override { return "LzLazifyPass"; }
  LzLazifyPass(const LzLazifyPass &other)
      : Pass(::mlir::TypeID::get<LzLazifyPass>()) {}

  std::unique_ptr<Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto newInst = std::make_unique<LzLazifyPass>(
        *static_cast<const LzLazifyPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }


  void runOnOperation() override {
    mlir::ModuleOp mod(getOperation());
    mlir::OpBuilder builder(mod);

    std::set<std::string> lazifiedFns;
    for(FuncOp fn : mod.getOps<FuncOp>()) {
      if (fn.isDeclaration()) {
        continue;
      }
      // skip the entrypoint.
      if (fn.getName() == "main") { continue; }

      lazifiedFns.insert(fn.getName().str());

      // Step 0: make new function type;
      llvm::SmallVector<mlir::Type, 4> lazyArgTys;
      for (int i = 0; i < (int)fn.getNumArguments(); ++i) {
        lazyArgTys.push_back(standalone::ThunkType::get(
            mod->getContext(), fn.getArgument(i).getType()));
      }

      // update the *function type* itself.
      fn.setType(builder.getFunctionType(lazyArgTys, fn.getType().getResults()));

      // Step 1: change all arguments from T to !lz.thunk<T>
      // Recall that the function type is stashed separately from the
      // types of the arguments, so we need to change the individual argument
      // types as well.
      for (int i = 0; i < (int)fn.getNumArguments(); ++i) {
        // Type argTy = fn.getArgument(i).getType();
        assert (i < (int)lazyArgTys.size());
        fn.getArgument(i).setType(lazyArgTys[i]);


        // Step 2: at all use sites of argument, insert a.
        // Keep this as a vector because we add new uses (inserting Force(%x))
        // while we iterate on the old ones (y = %x)

        mlir::SmallVector<std::pair<mlir::Operation*, int>, 4> users;

        for(mlir::OpOperand &u : fn.getArgument(i).getUses()) {
          users.push_back({u.getOwner(), u.getOperandNumber()});
        }

        for (auto userdata : users) {
          Operation *user = userdata.first;
          const int ix = userdata.second;

          builder.setInsertionPoint(user);
          // %f = op (%x) -> %f = op(force(%xt));
          ForceOp forced = builder.create<ForceOp>(builder.getUnknownLoc(),
                                                   fn.getArgument(i));
          user->setOperand(ix, forced);
          // llvm::errs() << "\tafter: |" << *user << "\n"; getchar();
        }
      }
    }

    for(FuncOp fn : mod.getOps<FuncOp>()) {
      if (fn.isDeclaration()) {
        continue;
      }

      std::set<CallOp> erasedCalls;
      // Step 3: Change all calls to ap+force. This will also allow
      // unused values to be dropped.
      fn.walk([&](CallOp call) {
        // only chance a call if we lazified the function itself.
        if (!lazifiedFns.count(call.getCallee().str())) { return WalkResult::advance(); }

//        llvm::errs() << "lazifying call: |" << call << "\n"; getchar();

        erasedCalls.insert(call);
        builder.setInsertionPoint(call);

        llvm::SmallVector<Type, 4> lazyCallArgTys;
        for(int i  = 0; i < (int)call.getCalleeType().getNumInputs(); ++i) {
          lazyCallArgTys.push_back(ThunkType::get(builder.getContext(),
              call.getCalleeType().getInput(i)));
        }
        FunctionType lazyCallType = builder.getFunctionType(lazyCallArgTys, call.getCalleeType().getResults());
        ConstantOp fnref = builder.create<ConstantOp>(builder.getUnknownLoc(),
                                                      lazyCallType,
                                                       builder.getSymbolRefAttr(call.getCallee()));

        assert(call.getCalleeType().getNumResults() > 0 && "ap needs at least one result");

        SmallVector<Value, 4> args;
        for(Value arg : call.getArgOperands()) {
          args.push_back(builder.create<ThunkifyOp>(builder.getUnknownLoc(), arg));
        }

        // TODO: multiple results?
        ApOp ap = builder.create<standalone::ApOp>(builder.getUnknownLoc(),
                                                   fnref,
                                                   args,
                                                   call.getCalleeType().getResult(0));


        // TODO: I believe this is strictly less precise than the code below,
        // which places the force RIGHT NEXT TO THE USE!
        ForceOp forced = builder.create<ForceOp>(builder.getUnknownLoc(), ap);
        call->replaceAllUsesWith(forced);
        /*
        for(auto &u : call->getUses()) {
          Operation *user = u.getOwner();
          const int ix = u.getOperandNumber();
          builder.setInsertionPoint(user);
          // %y = call f(%x) -> %y = force(ap(f, %x));
          ForceOp forced = builder.create<ForceOp>(builder.getUnknownLoc(), ap);
          user->setOperand(ix, forced);
        }*/

        return WalkResult::advance();
      }); // end walk for CallOp

      // erase all now dead calls;
      for(CallOp c : erasedCalls) { c.erase(); }
    } // end loop over all functions

    llvm::errs() << "vvvvv:module:vvvvv\n";
    mod->print(llvm::errs());
    llvm::errs() << "\n^^^^^^\n";

    llvm::errs() << "vvvvv:verifying:vvvvv\n";
    if (mlir::failed(mod.verify())) {
      llvm::outs() << "ERROR: module fails verification\n";
      assert(false && "module failed verification");
      exit(1);
    } else {
      llvm::errs() << "module succeeds verification!";
    }
    llvm::errs() << "\n^^^^^^\n";

  }
};

std::unique_ptr<mlir::Pass> createLzLazifyPass() {
  return std::make_unique<LzLazifyPass>();
}

void registerLzLazifyPass() {
  //  mlir::PassPipelineRegistration
  ::mlir::registerPass("lz-lazify",
                       "make std lazy using LZ",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLzLazifyPass();
                       });
}
