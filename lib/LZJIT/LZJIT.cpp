#include "LZJIT/LZJIT.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
#include "mlir/Pass/Pass.h"
using namespace mlir;

struct LZJITPass : public Pass {
  LZJITPass() : Pass(mlir::TypeID::get<LZJITPass>()){};
  StringRef getName() const override { return "LZJIT"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LZJITPass>(
        *static_cast<const LZJITPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
      assert(false && "JITting");
  };
};

std::unique_ptr<mlir::Pass> createLZJITPass() {
  return std::make_unique<LZJITPass>();
}

void registerLZJITPass() {
  ::mlir::registerPass(
      "lz-jit", "JIT LLVM code that's generated from lz+std+scf+affine",
      []() -> std::unique_ptr<::mlir::Pass> { return createLZJITPass(); });
}

