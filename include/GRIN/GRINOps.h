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
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/SymbolTable.h"
#include "mlir/Interfaces/CallInterfaces.h"
#include "mlir/Interfaces/ControlFlowInterfaces.h"
#include "mlir/Interfaces/DerivedAttributeOpInterface.h"
#include "mlir/Interfaces/InferTypeOpInterface.h"

#include "GRINDialect.h"
#include "mlir/Pass/Pass.h"

namespace mlir {
namespace grin {

// #define GET_OP_CLASSES
// #include "Hask/HaskOps.h.inc"

// %hpnew = store(%val, %hp)
class GRINStoreOp : public Op<GRINStoreOp, OpTrait::OneResult> {};
// %val = fetch(%hpnod)
class GRINFetchOp : public Op<GRINFetchOp, OpTrait::OneResult> {};
// update(%hpnod, %valnew)
class GRINUpdateOp : public Op<GRINUpdateOp, OpTrait::OneResult> {};

class GrinReturnOp
    : public Op<GrinReturnOp, OpTrait::ZeroResult, OpTrait::ZeroSuccessor,
                OpTrait::IsTerminator, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.return"; };
  Value getInput() { return this->getOperation()->getOperand(0); }
  Type getType() { return this->getInput().getType(); }
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value v);

  void print(OpAsmPrinter &p);
}
