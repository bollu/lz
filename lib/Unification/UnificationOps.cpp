#include "Unification/UnificationOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
#include <mlir/Parser.h>
#include <sstream>

// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"

#define DEBUG_TYPE "unification-ops"
#include "llvm/Support/Debug.h"

using namespace mlir;
using namespace mlir::unif;

// ROOT OP
// ROOT OP
// ROOT OP
// ROOT OP
// ROOT OP
// ROOT OP

ParseResult UnifRootOp::parse(OpAsmParser &parser, OperationState &result) {
  result.addTypes(UnifNodeType::get(parser.getBuilder().getContext()));
  return success();
}

void UnifRootOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// CONSTRUCTOR OP
// CONSTRUCTOR OP
// CONSTRUCTOR OP
// CONSTRUCTOR OP
// CONSTRUCTOR OP
// CONSTRUCTOR OP

ParseResult UnifConstructorOp::parse(OpAsmParser &parser,
                                     OperationState &result) {
  if (failed(parser.parseLParen())) {
    return failure();
  }
  StringAttr name;
  if (failed(parser.parseAttribute<StringAttr>(name))) {
    return failure();
  }
  result.addAttribute(UnifConstructorOp::getConstructorNameKey(), name);

  // ")"
  if (failed(parser.parseOptionalRParen())) {
    while (1) {
      // ","
      if (failed(parser.parseComma())) {
        return failure();
      }
      // <arg>
      OpAsmParser::OperandType arg;
      parser.parseOperand(arg);
      parser.resolveOperand(arg,
                            UnifNodeType::get(parser.getBuilder().getContext()),
                            result.operands);
      // ")"?
      if (succeeded(parser.parseOptionalRParen())) {
        break;
      }
    }
  }
  result.addTypes(unif::UnifNodeType::get(parser.getBuilder().getContext()));
  return success();
};

void UnifConstructorOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// VAR OP
// VAR OP
// VAR OP
// VAR OP
// VAR OP
// VAR OP

ParseResult UnifVarOp::parse(OpAsmParser &parser, OperationState &result) {
  StringAttr name;
  if (parser.parseLParen() || parser.parseAttribute<StringAttr>(name)) {
    return failure();
  }

  result.addAttribute(UnifConstructorOp::getConstructorNameKey(), name);

  OpAsmParser::OperandType parent;
  if (parser.parseComma() || parser.parseOperand(parent) ||
      parser.parseRParen()) {
    return failure();
  }
  parser.resolveOperand(parent,
                        UnifNodeType::get(parser.getBuilder().getContext()),
                        result.operands);

  result.addTypes(unif::UnifNodeType::get(parser.getBuilder().getContext()));
  return success();
};

void UnifVarOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// UNIFY OP
// UNIFY OP
// UNIFY OP
// UNIFY OP
// UNIFY OP
// UNIFY OP

ParseResult UnifUnifyOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType lhs, rhs;
  if (parser.parseLParen() || parser.parseOperand(lhs) || parser.parseComma() ||
      parser.parseOperand(rhs) || parser.parseRParen()) {
    return failure();
  }
  parser.resolveOperand(lhs,
                        UnifNodeType::get(parser.getBuilder().getContext()),
                        result.operands);
  parser.resolveOperand(rhs,
                        UnifNodeType::get(parser.getBuilder().getContext()),
                        result.operands);
  result.addTypes(UnifNodeType::get(parser.getBuilder().getContext()));
  return success();
};

void UnifUnifyOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};
