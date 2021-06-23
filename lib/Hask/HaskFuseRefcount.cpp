#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "llvm/Support/Casting.h"
#include <map>
#include <set>

using namespace mlir;
using namespace standalone;

struct FuseRefcountPass : public Pass {
  FuseRefcountPass() : Pass(mlir::TypeID::get<FuseRefcountPass>()){};
  StringRef getName() const override { return "LzFuseRefcountPass"; }
  FuseRefcountPass(const FuseRefcountPass &other)
      : Pass(::mlir::TypeID::get<FuseRefcountPass>()) {}

  std::unique_ptr<Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto newInst = std::make_unique<FuseRefcountPass>(
        *static_cast<const FuseRefcountPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void examineRegion(Region &r) {
    for (IncOp inc : r.getOps<IncOp>()) {
      // get instructions after `inc` for a `dec`. If we find a `dec`, then
      // delete the inc-dec-pair.
      for (auto it = ++inc->getIterator(); it != inc->getBlock()->end(); ++it) {
        DecOp dec = dyn_cast<DecOp>(it);
        if (!dec) {
          continue;
        }

        inc->getBlock()->dump();
        assert(false && "found inc-dec in same BB");
      }
    }
  }

  void runOnOperation() override {
    static int g_nerased = 0;
    mlir::ModuleOp mod(getOperation());
    mlir::OpBuilder builder(mod);

    for (FuncOp fn : mod.getOps<FuncOp>()) {
      // Inc --> Dec crashes on unionfind.lean
      // fn.walk([](IncOp inc) {
      //   // get instructions after `inc` for a `dec`. If we find a `dec`, then
      //   // delete the inc-dec-pair.
      //   for (auto it = ++inc->getIterator(); it != inc->getBlock()->end();
      //        ++it) {
      //     DecOp dec = dyn_cast<DecOp>(it);
      //     if (!dec) { continue; }
      //     if (inc.getOperand() != dec.getOperand()) { continue; }
      //     if (inc.getIncCount() != 1) { continue; }
      //     if (dec.getDecCount() != 1) { continue; }

      //     llvm::errs() << "=======\n";
      //     llvm::errs() << "FUSED: |" <<  ++g_nerased << "|\n";
      //     inc->getBlock()->dump();

      //     inc.erase();
      //     dec.erase();
      //     break;
      //     // assert(false && "found inc-dec in same BB");
      //   }
      //   return WalkResult::advance();
      // });

      fn.walk([](DecOp dec) {
        // get instructions after `inc` for a `dec`. If we find a `dec`, then
        // delete the inc-dec-pair.
        for (auto it = ++dec->getIterator(); it != dec->getBlock()->end();
             ++it) {
          IncOp inc = dyn_cast<IncOp>(it);
          if (!inc) { continue; }
          if (inc.getOperand() != dec.getOperand()) { continue; }
          // if (inc.getIncCount() != 1) { continue; }
          // if (dec.getDecCount() != 1) { continue; }

          llvm::errs() << "=======\n";
          llvm::errs() << "FUSED: |" <<  ++g_nerased << "|\n";
          inc->getBlock()->dump();
          assert(false && "OPTIMIZATION OPPORTUNITY");

          inc.erase();
          dec.erase();
          break;
          // assert(false && "found inc-dec in same BB");
        }
        return WalkResult::advance();
      });
    }
  }
};

std::unique_ptr<mlir::Pass> standalone::createFuseRefcountPass() {
  return std::make_unique<FuseRefcountPass>();
}

void standalone::registerFuseRefcountPass() {
  ::mlir::registerPass("lz-fuse-refcount", "optimize reference counts",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createFuseRefcountPass();
                       });
}
