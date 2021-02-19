#include "lambdapure/Dialect.h"
#include "lambdapure/Passes.h"
#include <iostream>

#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

using namespace mlir;

namespace {
class IntegerConstOpLowering : public ConversionPattern {
public:
  IntegerConstOpLowering(MLIRContext *ctxt)
      : ConversionPattern(lambdapure::IntegerConstOp::getOperationName(), 1,
                          ctxt) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const final {
    auto objType = lambdapure::ObjectType::get(rewriter.getContext());
    rewriter.replaceOpWithNewOp<lambdapure::BoxOp>(
        op, objType, op->getAttrOfType<IntegerAttr>("value"));
    return success();
  }
};

class ConstructorOpLowering : public ConversionPattern {
public:
  ConstructorOpLowering(MLIRContext *ctxt)
      : ConversionPattern(lambdapure::ConstructorOp::getOperationName(), 1,
                          ctxt) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const final {
    int i = 0;
    auto loc = op->getLoc();

    mlir::Value alloc_ctor = rewriter.create<lambdapure::AllocCtorOp>(
        loc, op->getResultTypes(), op->getAttrOfType<IntegerAttr>("tag"),
        rewriter.getI64IntegerAttr(op->getNumOperands()));
    for (auto it = op->operand_begin(); it != op->operand_end(); ++it) {
      rewriter.create<lambdapure::CtorSetOp>(loc, rewriter.getI64IntegerAttr(i),
                                             alloc_ctor, *it);
      i++;
    }
    rewriter.replaceOp(op, alloc_ctor);
    return success();
  }
};

class ReuseConstructorOpLowering : public ConversionPattern {
public:
  ReuseConstructorOpLowering(MLIRContext *ctxt)
      : ConversionPattern(lambdapure::ReuseConstructorOp::getOperationName(), 1,
                          ctxt) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const final {
    auto loc = op->getLoc();
    mlir::Value alloc_ctor = rewriter.create<lambdapure::ReuseAllocCtorOp>(
        loc, op->getResultTypes(), op->getAttrOfType<IntegerAttr>("tag"),
        rewriter.getI64IntegerAttr(op->getNumOperands() - 1),
        op->getOperand(0));
    int i = 0;
    for (auto it = op->operand_begin() + 1; it != op->operand_end();
         ++it) { //+ 1 to remove reuseObject operand
      rewriter.create<lambdapure::CtorSetOp>(loc, rewriter.getI64IntegerAttr(i),
                                             alloc_ctor, *it);
      i++;
    }
    rewriter.replaceOp(op, alloc_ctor);
    return success();
  }
};
} // end anonymous namespace

namespace {
struct LambdapureToLeanLoweringPass
    : public PassWrapper<LambdapureToLeanLoweringPass,
                         OperationPass<ModuleOp>> {
  void runOnOperation() final;
};

} // anonymous namespace

void LambdapureToLeanLoweringPass::runOnOperation() {
  ConversionTarget target(getContext());
  target.addLegalDialect<lambdapure::LambdapureDialect>();
  target.addIllegalOp<lambdapure::IntegerConstOp, lambdapure::ConstructorOp,
                      lambdapure::ReuseConstructorOp>();
  OwningRewritePatternList patterns;
  patterns.insert<IntegerConstOpLowering, ConstructorOpLowering,
                  ReuseConstructorOpLowering>(&getContext());

  auto module = getOperation();
  if (failed(applyPartialConversion(module, target, std::move(patterns)))) {
    signalPassFailure();
  }
}
std::unique_ptr<Pass> mlir::lambdapure::createLambdapureToLeanLowering() {
  return std::make_unique<LambdapureToLeanLoweringPass>();
}
