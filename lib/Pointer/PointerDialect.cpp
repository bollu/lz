//===- PtrDialect.cpp - Hask dialect ---------------*- C++ -*-===//
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

bool PtrType::classof(Type type) {
  return llvm::isa<PtrDialect>(type.getDialect());
}

PtrDialect &PtrType::getDialect() {
  return static_cast<PtrDialect &>(Type::getDialect());
}
PtrDialect::PtrDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, TypeID::get<PtrDialect>()) {
  // clang-format off
  addOperations<PtrIntToPtrOp, PtrPtrToIntOp, PtrStringOp, PtrFnPtrToVoidPtrOp>();
  addTypes<VoidPtrType, CharPtrType>();

  // clang-format on
}

mlir::Type PtrDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("void"))) { // !ptr.void
    return VoidPtrType::get(parser.getBuilder().getContext());
  }
  if (succeeded(parser.parseOptionalKeyword("char"))) { // !ptr.char
    return CharPtrType::get(parser.getBuilder().getContext());
  }

  return Type();
}

void PtrDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  if (type.isa<VoidPtrType>()) {
    p << "void"; // !ptr.void
    return;
  }

  if (type.isa<CharPtrType>()) {
    p << "char"; // !ptr.char
    return;
  }

  assert(false && "unknown type to print");
}

// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===

void PtrIntToPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vint) {
  assert(vint.getType().isa<IntegerType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void PtrIntToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===

void PtrFnPtrToVoidPtrOp::build(mlir::OpBuilder &builder,
                                mlir::OperationState &state, Value vint) {
  assert(vint.getType().isa<FunctionType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void PtrFnPtrToVoidPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===

void PtrPtrToIntOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vptr, IntegerType ity) {
  assert(vptr.getType().isa<VoidPtrType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(ity);
};

void PtrPtrToIntOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === STRING OP ===
// === STRING OP ===
// === STRING OP ===
// === STRING OP ===
// === STRING OP ===

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        const char *str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        std::string str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        llvm::StringRef str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};
