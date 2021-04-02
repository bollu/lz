//===- UnificationDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Unification/UnificationDialect.h"
#include "Unification/UnificationOps.h"

// includes
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

// dilect lowering
#include "Unification/UnificationOps.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/SCFToStandard/SCFToStandard.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

using namespace mlir;
using namespace mlir::unif;

bool UnifType::classof(Type type) {
  return llvm::isa<UnificationDialect>(type.getDialect());
}

UnificationDialect &UnifType::getDialect() {
  return static_cast<UnificationDialect &>(Type::getDialect());
}
UnificationDialect::UnificationDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context,
              TypeID::get<UnificationDialect>()) {

  addTypes<UnifNodeType>();
  addOperations<UnifRootOp>();
  addOperations<UnifConstructorOp>();
  addOperations<UnifVarOp>();
  addOperations<UnifUnifyOp>();
}

mlir::Type UnificationDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("node"))) {
    return parser.getBuilder().getType<UnifNodeType>();
  }
  assert(false && "unknown type for unification dialect");
}

void UnificationDialect::printType(mlir::Type type,
                                   mlir::DialectAsmPrinter &p) const {
  if (type.isa<UnifNodeType>()) {
    p << "node";
    return;
  }
  assert(false && "unknown type for unification dialect");
}
