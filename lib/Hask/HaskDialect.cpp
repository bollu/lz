//===- HaskDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/IR/StandardTypes.h"

// includes
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

using namespace mlir;
using namespace mlir::standalone;
//===----------------------------------------------------------------------===//
// Hask type.
//===----------------------------------------------------------------------===//

bool HaskType::classof(Type type) {
  return llvm::isa<HaskDialect>(type.getDialect());
}

HaskDialect &HaskType::getDialect() {
  return static_cast<HaskDialect &>(Type::getDialect());
}

//===----------------------------------------------------------------------===//
// Hask dialect.
//===----------------------------------------------------------------------===//

HaskDialect::HaskDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, TypeID::get<HaskDialect>()) {
  //   addOperations<
  // #define GET_OP_LIST
  // #include "Hask/HaskOps.cpp.inc"
  //       >();
  // clang-format off
  addOperations<
    // DeclareDataConstructorOp,
    HaskReturnOp,
    ApOp,
    ApEagerOp,
    ThunkifyOp,
    CaseOp,
    // HaskRefOp,
    ForceOp,
    HaskConstructOp,
    CaseIntOp,
    HaskLambdaOp
  >();
  addTypes<
    // HaskFnType,
    // ADTType,
    ThunkType,
    ValueType
  >();
  // addAttributes<DataConstructorAttr>();
  addInterfaces<HaskInlinerInterface>();
  // clang-format on
}

mlir::Type HaskDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("thunk"))) {
    Type t;
    if (parser.parseLess() || parser.parseType(t) || parser.parseGreater()) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse ThunkType");
      return Type();
    }
    return ThunkType::get(parser.getBuilder().getContext(), t);
  } else if (succeeded(parser.parseOptionalKeyword("value"))) {
    return ValueType::get(parser.getBuilder().getContext());
  } /* else if (succeeded(parser.parseOptionalKeyword("fn"))) {
    SmallVector<Type, 4> params;
    Type res;
    if (parser.parseLess()) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse function type. Missing `<`");
      return Type();
    }

    if (parser.parseLParen()) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse function type. Missing `(`");
      return Type();
    }

    if (succeeded(parser.parseOptionalRParen())) {
      // empty function
    } else {
      while (1) {
        Type t;
        if (parser.parseType(t)) {
          parser.emitError(parser.getCurrentLocation(),
                           "unable to parse argument type");
          return Type();
        }

        params.push_back(t);

        if (succeeded(parser.parseOptionalRParen())) {
          break;
        }

        if (parser.parseComma()) {
          parser.emitError(parser.getCurrentLocation(),
                           "unable to parse function type. Missing `,` after"
                           "argument");
        }
      }
    }

    if (parser.parseArrow()) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse function type. Missing `->`"
                       "after argument list");
      return Type();
    }

    if (parser.parseType(res)) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse return type.");
      return Type();
    }

    if (parser.parseGreater()) {
      parser.emitError(parser.getCurrentLocation(),
                       "unable to parse function type. Missing `>`");
      return Type();
    }

    return HaskFnType::get(parser.getBuilder().getContext(), params, res);
  } */
  else {
    parser.emitError(parser.getCurrentLocation(),
                     "unknown type for hask/lz dialect");
    // assert(false && "unknown type");
  }
  return Type();
}

void HaskDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  if (type.isa<ThunkType>()) {
    ThunkType thunk = type.cast<ThunkType>();
    p << "thunk<" << thunk.getElementType() << ">";
  } else if (type.isa<ValueType>()) {
    p << "value";
  } /* else if (type.isa<HaskFnType>()) {
    HaskFnType fnty = type.cast<HaskFnType>();
    ArrayRef<Type> intys = fnty.getInputTypes();

    p << "fn<(";
    for (int i = 0; i < (int)intys.size(); ++i) {
      p << intys[i];
      if (i + 1 < (int)intys.size())
        p << ", ";
    }
    p << ") -> " << fnty.getResultType() << ">";
  } */
  else {
    assert(false && "unknown type");
  }
}

// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===
// === ATTRIBUTE HANDLING ===

mlir::Attribute HaskDialect::parseAttribute(mlir::DialectAsmParser &parser,
                                            Type type) const {
  assert(false && "unable to parse attribute");
  return Attribute();
};

void HaskDialect::printAttribute(Attribute attr, DialectAsmPrinter &p) const {
  assert(attr);
  assert(false && "unknown attribute");
}

void HaskInlinerInterface::handleTerminator(
    Operation *op, ArrayRef<Value> valuesToRepl) const {
  if (auto returnOp = mlir::dyn_cast<ReturnOp>(op)) {
    valuesToRepl[0].replaceAllUsesWith(returnOp.getOperand(0));
    return;
  }
  // https://github.com/llvm/llvm-project/blob/1b012a9146b85d30083a47d4929e86f843a5938d/mlir/docs/Tutorials/Toy/Ch-4.md
  if (auto returnOp = mlir::dyn_cast<HaskReturnOp>(op)) {
    valuesToRepl[0].replaceAllUsesWith(returnOp.getOperand());
    return;
  }

  assert(false && "unknown return operation");
}

bool HaskDialect::isFunctionRecursive(FuncOp funcOp) {
  // https://mlir.llvm.org/docs/Tutorials/UnderstandingTheIRStructure/
  bool isrec = false;
  funcOp.walk([&](ConstantOp constop) {
    mlir::FlatSymbolRefAttr ref =
        constop.getValue().dyn_cast<FlatSymbolRefAttr>();
    if (!ref) {
      return WalkResult::advance();
    }

    if (ref.getValue() == funcOp.getName()) {
      isrec = true;
      return WalkResult::interrupt();
    }

    return WalkResult::advance();
  });
  return isrec;
}
