//===- GrinOps.h - Grin dialect ops -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#pragma once
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Interfaces/CallInterfaces.h"
#include "mlir/Interfaces/ControlFlowInterfaces.h"
#include "mlir/Interfaces/DerivedAttributeOpInterface.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"

#include "Unification/UnificationDialect.h"
#include "mlir/Pass/Pass.h"

namespace mlir {
namespace unif {

class UnifRootOp
    : public Op<UnifRootOp, OpTrait::OneResult, OpTrait::ZeroOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "unif.root"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

class UnifConstructorOp
    : public Op<UnifConstructorOp, OpTrait::OneResult, OpTrait::VariadicOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "unif.constructor"; };
  StringRef getConstructorName() {
    return this->getOperation()
        ->getAttrOfType<StringAttr>(getConstructorNameKey())
        .getValue();
  };
  static StringRef getConstructorNameKey() { return "value"; }
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

class UnifVarOp
    : public Op<UnifVarOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "unif.var"; };
  StringRef getName() {
    return this->getOperation()
        ->getAttrOfType<StringAttr>(getNameKey())
        .getValue();
  };
  Value getParent() { return this->getOperand(); }
  static StringRef getNameKey() { return "value"; }
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

class UnifUnifyOp
    : public Op<UnifUnifyOp, OpTrait::OneResult, OpTrait::NOperands<2>::Impl> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "unif.unify"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

} // namespace unif
} // namespace mlir
