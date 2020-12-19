//===- GRINDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Pointer/PointerDialect.h"
#include "Pointer/PointerOps.h"

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
using namespace mlir::ptr;

bool GRINType::classof(Type type) {
  return llvm::isa<GRINDialect>(type.getDialect());
}

GRINDialect &GRINType::getDialect() {
  return static_cast<GRINDialect &>(Type::getDialect());
}
GRINDialect::GRINDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, TypeID::get<GRINDialect>()) {
  // clang-format off
  addOperations<GRINStoreOp
                , GRINUnboxOp
                , GRINBoxOp
                , GRINReturnOp
                , GRINUnboxTagOp
                , GRINCaseOp
                , GRINUnboxIxOp
                , GRINFetchOp
                , GRINUpdateOp>();
  addTypes<BoxType, HeapNodeType, TagType>();

  // clang-format on
}

mlir::Type GRINDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("box"))) {
    return BoxType::get(parser.getBuilder().getContext());
  } else if (succeeded(parser.parseOptionalKeyword("hp"))) {
    return HeapNodeType::get(parser.getBuilder().getContext());
  } else if (succeeded(parser.parseOptionalKeyword("tag"))) {
    return TagType::get(parser.getBuilder().getContext());
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
  } else if (type.isa<TagType>()) {
    p << "tag";
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

// -- BOX OP --
// -- BOX OP --
// -- BOX OP --
// -- BOX OP --
// -- BOX OP --
ParseResult GRINBoxOp::parse(OpAsmParser &parser, OperationState &result) {
  FlatSymbolRefAttr boxname;
  parser.parseAttribute<FlatSymbolRefAttr>(boxname);
  result.addAttribute("value", boxname);

  SmallVector<Type, 8> tys;
  if (succeeded(parser.parseOptionalComma())) {
    SmallVector<OpAsmParser::OperandType, 8> ops;
    if (parser.parseOperandList(ops, OpAsmParser::Delimiter::None) ||
        parser.parseColonTypeList(tys) ||
        parser.resolveOperands(ops, tys, parser.getCurrentLocation(),
                               result.operands)) {
      return failure();
    }
  }
  result.addTypes(BoxType::get(parser.getBuilder().getContext()));
  return success();
};

void GRINBoxOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// -- STORE OP --
// -- STORE OP --
// -- STORE OP --
// -- STORE OP --
// -- STORE OP --

ParseResult GRINStoreOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType box;
  if (parser.parseOperand(box) ||
      parser.resolveOperand(box, BoxType::get(parser.getBuilder().getContext()),
                            result.operands)) {
    return failure();
  }

  result.addTypes(HeapNodeType::get(parser.getBuilder().getContext()));
  return success();
};

void GRINStoreOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// -- FETCH OP --
// -- FETCH OP --
// -- FETCH OP --
// -- FETCH OP --
// -- FETCH OP --

ParseResult GRINFetchOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType hp;
  if (parser.parseOperand(hp) ||
      parser.resolveOperand(hp,
                            HeapNodeType::get(parser.getBuilder().getContext()),
                            result.operands)) {
    return failure();
  }

  result.addTypes(BoxType::get(parser.getBuilder().getContext()));
  return success();
};

void GRINFetchOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// --- UNBOX OP ---
// --- UNBOX OP ---
// --- UNBOX OP ---
// --- UNBOX OP ---
// --- UNBOX OP ---
ParseResult GRINUnboxOp::parse(OpAsmParser &parser, OperationState &result) {
  FlatSymbolRefAttr boxname;
  parser.parseAttribute<FlatSymbolRefAttr>(boxname);
  result.addAttribute("value", boxname);
  OpAsmParser::OperandType box;
  SmallVector<Type, 8> tys;

  // TODO: box with 0 types?
  if (parser.parseComma() || parser.parseOperand(box) ||
      parser.resolveOperand(box, BoxType::get(parser.getBuilder().getContext()),
                            result.operands) ||
      parser.parseColonTypeList(tys)) {
    return failure();
  };

  result.addTypes(tys);
  return success();
};

void GRINUnboxOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// --- UNBOXTAG OP ---
// --- UNBOXTAG OP ---
// --- UNBOXTAG OP ---
// --- UNBOXTAG OP ---
// --- UNBOXTAG OP ---
ParseResult GRINUnboxTagOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::OpAsmParser::OperandType box;
  if (parser.parseOperand(box) ||
      parser.resolveOperand(box, BoxType::get(parser.getBuilder().getContext()),
                            result.operands)) {
    return failure();
  }

  result.addTypes(TagType::get(parser.getBuilder().getContext()));
  return success();
};

void GRINUnboxTagOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// --- UNBOXIX OP ---
// --- UNBOXIX OP ---
// --- UNBOXIX OP ---
// --- UNBOXIX OP ---
// --- UNBOXIX OP ---
ParseResult GRINUnboxIxOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::OpAsmParser::OperandType box, ix;
  Type ty;

  if (parser.parseOperand(box) || parser.parseComma() ||
      parser.parseOperand(ix) ||
      parser.resolveOperand(box, BoxType::get(parser.getBuilder().getContext()),
                            result.operands) ||
      parser.resolveOperand(ix, parser.getBuilder().getI64Type(),
                            result.operands) ||
      parser.parseColonType(ty)

  ) {
    return failure();
  }

  result.addTypes(ty);
  return success();
};

void GRINUnboxIxOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// -- RETURN OP --
// -- RETURN OP --
// -- RETURN OP --
// -- RETURN OP --
// -- RETURN OP --

ParseResult GRINReturnOp::parse(OpAsmParser &parser, OperationState &result) {
  llvm::SmallVector<mlir::OpAsmParser::OperandType, 4> ops;
  llvm::SmallVector<mlir::Type, 4> tys;
  if (parser.parseOperandList(ops) || parser.parseColonTypeList(tys) ||
      parser.resolveOperands(ops, tys, parser.getCurrentLocation(),
                             result.operands)) {
    return failure();
  }
  return success();
};

void GRINReturnOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// -- CASE OP --
// -- CASE OP --
// -- CASE OP --
// -- CASE OP --
// -- CASE OP --
ParseResult GRINCaseOp::parse(OpAsmParser &parser, OperationState &result) {

  llvm::SmallVector<mlir::OpAsmParser::OperandType, 4> ops;
  llvm::SmallVector<mlir::Type, 4> tys;
  mlir::OpAsmParser::OperandType scrutinee;
  parser.parseOperand(scrutinee) ||
      parser.resolveOperand(scrutinee,
                            TagType::get(parser.getBuilder().getContext()),
                            result.operands);
  llvm::SmallVector<mlir::FlatSymbolRefAttr, 4> alts;
  int i = 0;
  while (1) {
    mlir::FlatSymbolRefAttr alt;
    parser.parseAttribute<FlatSymbolRefAttr>(alt, "alt" + std::to_string(i),
                                             result.attributes);
    mlir::Region *r = result.addRegion();
    parser.parseRegion(*r);
    i++;
    if (failed(parser.parseOptionalComma())) {
      break;
    }
  }
  mlir::Type ty;
  parser.parseColonType(ty);
  result.addTypes(ty);
  return success();
};
void GRINCaseOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// -- UPDATE OP --
// -- UPDATE OP --
// -- UPDATE OP --
// -- UPDATE OP --
// -- UPDATE OP --

ParseResult GRINUpdateOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType hpnod, box;
  if (parser.parseOperand(hpnod) || parser.parseComma() ||
      parser.parseOperand(box) ||
      parser.resolveOperand(hpnod,
                            HeapNodeType::get(parser.getBuilder().getContext()),
                            result.operands) ||
      parser.resolveOperand(box, BoxType::get(parser.getBuilder().getContext()),
                            result.operands)) {
    return failure();
  }
  return success();
};

void GRINUpdateOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};
