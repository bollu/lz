//===- GRINDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "GRIN/GRINDialect.h"
#include "GRIN/GRINOps.h"

// includes
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

using namespace mlir;
using namespace mlir::grin;

bool GRINType::classof(Type type) {
  return llvm::isa<GRINDialect>(type.getDialect());
}

GRINDialect &GRINType::getDialect() {
  return static_cast<GRINDialect &>(Type::getDialect());
}
GRINDialect::GRINDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, TypeID::get<GRINDialect>()) {
  // clang-format off
  addOperations<GRINStoreOp, GRINUnboxOp>();
  addTypes<BoxType>();

  // clang-format on
}

mlir::Type GRINDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("box"))) {
    return BoxType::get(parser.getBuilder().getContext());
  } else {
    parser.emitError(parser.getCurrentLocation(),
                     "unknown type for grn dialect");
  }
  return Type();
}

void GRINDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  if (type.isa<BoxType>()) {
    p << "box";
  } else if (type.isa<HeapNodeType>()) {
    p << "hp";
  } else {
    assert(false && "unknown type");
  }
}

// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===

mlir::Attribute GRINDialect::parseAttribute(mlir::DialectAsmParser &parser,
                                            Type type) const {
  assert(false && "unable to parse attribute");
  return Attribute();
};

void GRINDialect::printAttribute(Attribute attr, DialectAsmPrinter &p) const {
  assert(attr);
  assert(false && "unknown attribute");
}

// STORE OP
// STORE OP
// STORE OP
// STORE OP
// STORE OP

ParseResult GRINStoreOp::parse(OpAsmParser &parser, OperationState &result) {
  return failure();
};

void GRINStoreOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// UNBOX OP
// UNBOX OP
// UNBOX OP
// UNBOX OP
// UNBOX OP
ParseResult GRINUnboxOp::parse(OpAsmParser &parser, OperationState &result) {
  FlatSymbolRefAttr boxname;
  parser.parseAttribute<FlatSymbolRefAttr>(boxname);
  result.addAttribute("value", boxname);
  SmallVector<OpAsmParser::OperandType, 8> ops;
  SmallVector<Type, 8> tys;

  if (parser.parseOperandList(ops, OpAsmParser::Delimiter::None) ||
      parser.parseColonTypeList(tys) ||
      parser.resolveOperands(ops, tys, parser.getCurrentLocation(),
                             result.operands)) {
    return failure();
  }
  return success();
};

void GRINUnboxOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};
