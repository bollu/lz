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

// %hp = store %val
class GRINStoreOp
    : public Op<GRINStoreOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.store"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// %val = fetch %hp
class GRINFetchOp
    : public Op<GRINFetchOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.fetch"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value v);
  void print(OpAsmPrinter &p);
};

// grn.box @Tag
class GRINBoxOp
    : public Op<GRINBoxOp, OpTrait::OneResult, OpTrait::VariadicOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.box"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// grn.unboxtag %box : Tag
class GRINUnboxTagOp
    : public Op<GRINUnboxTagOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.unboxtag"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// grn.unboxtag %box, %ix : valty
class GRINUnboxIxOp : public Op<GRINUnboxIxOp, OpTrait::OneResult,
                                OpTrait::NOperands<2>::Impl> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.unboxix"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// grn.unbox @Tag %node
class GRINUnboxOp
    : public Op<GRINUnboxOp, OpTrait::VariadicResults, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.unbox"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// grn.return %val1, ..., %valn
class GRINReturnOp
    : public Op<GRINReturnOp, OpTrait::IsTerminator, OpTrait::VariadicResults> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.return"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

class GRINCaseOp
    : public Op<GRINCaseOp, OpTrait::OneOperand, OpTrait::VariadicRegions,
                OpTrait::VariadicResults> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.case"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// update %hp, %val
class GRINUpdateOp : public Op<GRINUpdateOp, OpTrait::ZeroResult,
                               OpTrait::NOperands<2>::Impl> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "grn.update"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

} // namespace grin
} // namespace mlir
