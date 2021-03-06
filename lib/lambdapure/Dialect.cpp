#include "lambdapure/Passes.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Support/LLVM.h"

using namespace llvm;

#include "lambdapure/Dialect.h"

using namespace mlir;
using namespace mlir::lambdapure;

LambdapureDialect::LambdapureDialect(mlir::MLIRContext *ctxt)
    : mlir::Dialect("lambdapure", ctxt,
                    ::mlir::TypeID::get<LambdapureDialect>()) {
  addOperations<
#define GET_OP_LIST
#include "lambdapure/Ops.cpp.inc"
      >();
  // this doesn't seem to be enough?
  addTypes<ObjectType>();
}

mlir::Type LambdapureDialect::parseType(mlir::DialectAsmParser &parser) const {
  assert(false);
  //  if (succeeded(parser.parseOptionalKeyword("Object"))) {
  //    return parser.getBuilder().getType<ObjectType>();
  //  } else {
  //    assert(false && "unknown type");
  //  }
}

void LambdapureDialect::printType(mlir::Type type,
                                  mlir::DialectAsmPrinter &printer) const {
  assert(false);
  //  assert(type.isa<ObjectType>());
  //  printer << "Object";
}

/*
void IntegerConstOp::build(mlir::OpBuilder &builder,
                           mlir::OperationState &state, int value) {
  state.addAttribute("value", builder.getI64IntegerAttr(value));
  mlir::MLIRContext *ctxt = builder.getContext();
  state.addTypes(ObjectType::get(ctxt));
}

void AppOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                  Value func, ArrayRef<Value> args, mlir::Type ty) {

  state.addOperands({func});
  state.addOperands(args);
  state.addTypes(ty);
}

void CallOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                   llvm::StringRef fName, ArrayRef<Value> args, mlir::Type ty) {
  state.addAttribute("callee", builder.getSymbolRefAttr(fName));
  state.addOperands(args);
  state.addTypes(ty);
}

void PapOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                  llvm::StringRef fName, ArrayRef<Value> args) {
  state.addAttribute("callee", builder.getSymbolRefAttr(fName));
  state.addOperands(args);
  state.addTypes(ObjectType::get(builder.getContext()));
  // state.addTypes(ty);
}

void ConstructorOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          int tag, ArrayRef<Value> operands, mlir::Type ty) {
  state.addAttribute("tag", builder.getI64IntegerAttr(tag));
  state.addOperands(operands);
  state.addTypes(ty);
}

void ProjectionOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                         int index, mlir::Value operand, mlir::Type ty) {
  state.addAttribute("index", builder.getI64IntegerAttr(index));
  state.addOperands({operand});
  state.addTypes(ty);
}

void ReuseConstructorOp::build(mlir::OpBuilder &builder,
                               mlir::OperationState &state, int tag,
                               ArrayRef<Value> operands) {
  state.addAttribute("tag", builder.getI64IntegerAttr(tag));
  state.addOperands(operands);

  state.addTypes(ObjectType::get(builder.getContext()));
}
 */

namespace mlir {

#define GET_OP_CLASSES

#include "lambdapure/Ops.cpp.inc"

} // namespace mlir

namespace mlir {
namespace lambdapure {
void registerLambdapureToLeanLowering() {
  ::mlir::registerPass("lz-lambdapure-to-lean",
                       "Perform lowering from lambdapure to lean",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLambdapureToLeanLowering();
                       });
}
void registerReferenceRewriterPattern() {
  ::mlir::registerPass("lz-lambdapure-reference-rewriter",
                       "Rewrite refconts in lambdapure.",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createReferenceRewriterPattern();
                       });
}
void registerDestructiveUpdatePattern() {
  ::mlir::registerPass("lz-lambdapure-destructive-updates",
                       "Optimses object creation with destructive updates.",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createDestructiveUpdatePattern();
                       });
}

} // namespace lambdapure
}; // namespace mlir
