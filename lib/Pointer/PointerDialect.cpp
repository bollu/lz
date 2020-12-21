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
  // addOperations<PtrStoreOp
  //               , PtrUnboxOp
  //               , PtrBoxOp
  //               , PtrReturnOp
  //               , PtrUnboxTagOp
  //               , PtrCaseOp
  //               , PtrUnboxIxOp
  //               , PtrFetchOp
  //               , PtrUpdateOp>();
  addTypes<VoidPtrType>();

  // clang-format on
}

mlir::Type PtrDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("void"))) {
    return VoidPtrType::get(parser.getBuilder().getContext());
  } 
  return Type();
}

void PtrDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  if (type.isa<VoidPtrType>()) {
    p << "void";
  }
}
