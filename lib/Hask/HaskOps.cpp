//===- HaskOps.cpp - Hask dialect ops ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskOps.h"
#include "Hask/HaskDialect.h"
#include "Pointer/PointerDialect.h"
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

// pattern matching
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"

// dilect lowering
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

namespace mlir {
namespace standalone {
// #define GET_OP_CLASSES
// #include "Hask/HaskOps.cpp.inc"

// === RETURN OP ===
// === RETURN OP ===
// === RETURN OP ===
// === RETURN OP ===
// === RETURN OP ===

ParseResult HaskReturnOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::OpAsmParser::OperandType in;
  mlir::Type type;
  if (parser.parseOperand(in) || parser.parseColonType(type)) {
    return failure();
  }

  if (parser.resolveOperand(in, type, result.operands))
    return failure();

  return success();
};

void HaskReturnOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                         Value v) {
  state.addOperands(v);
  // state.addTypes(v.getType());
};

void HaskReturnOp::print(OpAsmPrinter &p) {
  // p.printGenericOp(this->getOperation());
  // return;
  p << getOperationName() << " " << getInput() << " : " << getInput().getType();
};

// === APOP OP ===
// === APOP OP ===
// === APOP OP ===
// === APOP OP ===
// === APOP OP ===

ParseResult ApOp::parse(OpAsmParser &parser, OperationState &result) {
  // OpAsmParser::OperandType operand_fn;
  OpAsmParser::OperandType op_fn;
  // (<fn-arg>
  if (parser.parseLParen()) {
    return failure();
  }
  if (parser.parseOperand(op_fn)) {
    return failure();
  }

  // : type
  FunctionType ratorty;
  if (parser.parseColonType<FunctionType>(ratorty)) {
    return failure();
  }
  if (parser.resolveOperand(op_fn, ratorty, result.operands)) {
    return failure();
  }

  if (FunctionType fnty = ratorty.dyn_cast<FunctionType>()) {
    std::vector<Type> paramtys = fnty.getInputs();
    // Type retty = fnty.getResultType();

    for (int i = 0; i < (int)paramtys.size(); ++i) {
      if (parser.parseComma()) {
        return failure();
      }
      OpAsmParser::OperandType op;
      if (parser.parseOperand(op))
        return failure();
      if (parser.resolveOperand(op, paramtys[i], result.operands)) {
        return failure();
      }
    }

    if (parser.parseRParen())
      return failure();
    result.addTypes(parser.getBuilder().getType<ThunkType>(fnty.getResult(0)));
  } else {
    InFlightDiagnostic err =
        parser.emitError(parser.getCurrentLocation(),
                         "expected function type, got non function type: [");
    err << ratorty << "]";
    return failure();
  }

  return success();
};

void ApOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;

  p << getOperationName() << "(";
  p << this->getFn() << " :" << this->getFn().getType();

  for (int i = 0; i < this->getNumFnArguments(); ++i) {
    p << ", " << this->getFnArgument(i);
  }
  p << ")";
};

void ApOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                 Value fnref, SmallVectorImpl<Value> &params, Type retty) {

  // hack! we need to construct the type properly.
  state.addOperands(fnref);
  state.addOperands(params);
  state.addTypes(builder.getType<ThunkType>(retty));
};

void ApOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                 FuncOp fn, SmallVectorImpl<Value> &params) {
  Value fnname = builder.create<ConstantOp>(
      builder.getUnknownLoc(),
      mlir::FlatSymbolRefAttr::get(builder.getContext(), fn.getName()));
  state.addOperands(fnname);
  state.addOperands(params);
  state.addTypes(builder.getType<ThunkType>(fn.getType().getResult(0)));
};

// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===

ParseResult PapOp::parse(OpAsmParser &parser, OperationState &result) {
  // OpAsmParser::OperandType operand_fn;
  OpAsmParser::OperandType op_fn;
  // (<fn-arg>
  if (parser.parseLParen()) {
    return failure();
  }
  if (parser.parseOperand(op_fn)) {
    return failure();
  }

  // : type
  FunctionType ratorty;
  if (parser.parseColonType<FunctionType>(ratorty)) {
    return failure();
  }
  if (parser.resolveOperand(op_fn, ratorty, result.operands)) {
    return failure();
  }

  if (FunctionType fnty = ratorty.dyn_cast<FunctionType>()) {
    std::vector<Type> paramtys = fnty.getInputs();
    // Type retty = fnty.getResultType();

    for (int i = 0; i < (int)paramtys.size(); ++i) {
      if (parser.parseComma()) {
        return failure();
      }
      OpAsmParser::OperandType op;
      if (parser.parseOperand(op))
        return failure();
      if (parser.resolveOperand(op, paramtys[i], result.operands)) {
        return failure();
      }
    }

    if (parser.parseRParen())
      return failure();
    result.addTypes(parser.getBuilder().getType<ThunkType>(fnty.getResult(0)));
  } else {
    InFlightDiagnostic err =
        parser.emitError(parser.getCurrentLocation(),
                         "expected function type, got non function type: [");
    err << ratorty << "]";
    return failure();
  }

  return success();
};

void PapOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

void PapOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                  std::string fnname, SmallVectorImpl<Value> &params) {

  // hack! we need to construct the type properly.
  // state.addOperands(fnref);
  // state.addAttribute("value", fnname);
  state.addAttribute("value", builder.getSymbolRefAttr(fnname));
  state.addOperands(params);
  state.addTypes(builder.getType<standalone::ValueType>());
};

// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===
// === PAPOP OP ===

ParseResult PapExtendOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
  return success();
};

void PapExtendOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

void PapExtendOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        std::string fnname, SmallVectorImpl<Value> &params) {
  assert(false && "unimeplemented");
  // hack! we need to construct the type properly.
  // state.addOperands(fnref);
  // state.addAttribute("value", fnname);
  state.addAttribute("value", builder.getSymbolRefAttr(fnname));
  state.addOperands(params);
  state.addTypes(builder.getType<standalone::ValueType>());
};

// === CASESSA OP ===
// === CASESSA OP ===
// === CASESSA OP ===
// === CASESSA OP ===
// === CASESSA OP ===
ParseResult CaseOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType scrutinee;

  FlatSymbolRefAttr constructorName;
  if (parser.parseAttribute<FlatSymbolRefAttr>(
          constructorName, CaseOp::getCaseTypeKey(), result.attributes)) {
    return failure();
  };

  if (parser.parseOperand(scrutinee))
    return failure();
  if (parser.resolveOperand(scrutinee, parser.getBuilder().getType<ValueType>(),
                            result.operands)) {
    return failure();
  }

  // "[" altname "->" region "]"
  int nattr = 0;
  SmallVector<Region *, 4> altRegions;
  while (succeeded(parser.parseOptionalLSquare())) {
    FlatSymbolRefAttr alt_type_attr;
    const std::string attrname = "alt" + std::to_string(nattr);
    parser.parseAttribute<FlatSymbolRefAttr>(alt_type_attr, attrname,
                                             result.attributes);
    nattr++;
    parser.parseArrow();
    Region *r = result.addRegion();
    altRegions.push_back(r);
    if (parser.parseRegion(*r, {}, {}))
      return failure();
    parser.parseRSquare();
  }

  assert(altRegions.size() > 0);

  HaskReturnOp retFirst = dyn_cast<HaskReturnOp>(
      altRegions[0]->getBlocks().front().getTerminator());
  if (!retFirst) {
    assert(false && "expected caseop to end in lz.return");
    return failure();
  }
  for (int i = 1; i < (int)altRegions.size(); ++i) {
    HaskReturnOp ret =
        cast<HaskReturnOp>(altRegions[i]->getBlocks().front().getTerminator());
    assert(retFirst.getOperand().getType() == ret.getOperand().getType() &&
           "all case branches must return  same levity [value/thunk]");
  }
  result.addTypes(retFirst.getOperand().getType());
  return success();
};

void CaseOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
  p << getOperationName() << " ";
  // p << "[ " << this->getOperation()->getNumOperands() << " | " <<
  // this->getNumAlts() << "] "; p << this->getOperation()->getOperand(0);
  p << this->getOperation()->getAttrOfType<FlatSymbolRefAttr>(
      this->getCaseTypeKey());
  p << " " << this->getScrutinee();
  // p.printOptionalAttrDict(this->getAltLHSs().getValue());
  for (int i = 0; i < this->getNumAlts(); ++i) {
    p << " [" << this->getAltLHS(i) << " -> ";
    p.printRegion(this->getAltRHS(i));
    p << "]\n";
  }
};

llvm::Optional<int> CaseOp::getDefaultAltIndex() {
  for (int i = 0; i < getNumAlts(); ++i) {
    Attribute ai = this->getAltLHS(i);
    FlatSymbolRefAttr sai = ai.dyn_cast<FlatSymbolRefAttr>();
    if (sai && sai.getValue() == "default") {
      return i;
    }
  }
  return llvm::Optional<int>();
}

void CaseOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                   Value scrutinee, SmallVectorImpl<mlir::Attribute> &lhss,
                   SmallVectorImpl<mlir::Region *> &rhss, mlir::Type retty) {

  assert(scrutinee.getType().isa<ValueType>());
  state.addOperands(scrutinee);
  assert(lhss.size() == rhss.size());

  for (Region *r : rhss) {
    std::unique_ptr<mlir::Region> pr(r);
    state.addRegion(std::move(pr));
  }
  for (int i = 0; i < (int)lhss.size(); ++i) {
    state.addAttribute("alt" + std::to_string(i), lhss[i]);
  }
  state.addTypes(retty);
};

void CaseOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                   Value scrutinee, int numrhss) {
  // vv TODO HACK: we need to allow arbitrary scrutinee types? x(
  // if(!scrutinee.getType().isa<ValueType>()) {
  //   llvm::errs() << " |scrutinee: |" << scrutinee << "|\ntype: "<<
  //   scrutinee.getType()<< "|\n";
  // }

  // assert(scrutinee.getType().isa<ValueType>());
  state.addOperands(scrutinee);
  // vvv TODO: Check if this is 0 or 1 indexed
  for (int i = 0; i < numrhss; ++i) {
    mlir::FlatSymbolRefAttr ixAttr =
        builder.getSymbolRefAttr(std::to_string(i));
    state.addAttribute("alt" + std::to_string(i), ixAttr);
    state.addRegion();
  }
  state.addTypes(builder.getType<ValueType>());
  // hack! Say that this case doesn't return anything...
}

// === APEAGEROP OP ===
// === APEAGEROP OP ===
// === APEAGEROP OP ===
// === APEAGEROP OP ===
// === APEAGEROP OP ===

ParseResult ApEagerOp::parse(OpAsmParser &parser, OperationState &result) {
  // OpAsmParser::OperandType operand_fn;
  OpAsmParser::OperandType op_fn;

  // (<fn-arg>
  if (parser.parseLParen()) {
    return failure();
  }

  if (parser.parseOperand(op_fn)) {
    return failure();
  }
  // : type
  FunctionType ratorty;
  if (parser.parseColonType<FunctionType>(ratorty)) {
    return failure();
  }

  if (parser.resolveOperand(op_fn, ratorty, result.operands)) {
    return failure();
  }

  FunctionType fnty = ratorty.dyn_cast<FunctionType>();
  if (!fnty) {
    InFlightDiagnostic err =
        parser.emitError(parser.getCurrentLocation(),
                         "expected function type, got non function type: [");
    err << ratorty << "]";
    return failure();
  }
  std::vector<Type> paramtys = fnty.getInputs();

  for (int i = 0; i < (int)paramtys.size(); ++i) {
    OpAsmParser::OperandType op;
    if (parser.parseComma() || parser.parseOperand(op) ||
        parser.resolveOperand(op, paramtys[i], result.operands)) {
      return failure();
    }
  }

  //)
  if (parser.parseRParen())
    return failure();

  result.addTypes(fnty.getResult(0));
  return success();
};

void ApEagerOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;

  p << getOperationName() << "(";
  p << this->getFn() << " :" << this->getFn().getType();

  for (int i = 0; i < this->getNumFnArguments(); ++i) {
    p << ", " << this->getFnArgument(i);
  }
  p << ")";
};

void ApEagerOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                      Value fn, Type resultty,
                      const SmallVectorImpl<Value> &params) {
  // hack! we need to construct the type properly.
  state.addOperands(fn);
  // assert(fn.getType().isa<FunctionType>());
  // FunctionType fnty = fn.getType().cast<FunctionType>();

  // assert(params.size() == fnty.getInputs().size());
  // for (int i = 0; i < (int)params.size(); ++i) {
  //   assert(params[i].getType() == fnty.getInput(i) &&
  //          "ApEagerOp argument type mismatch");
  // }

  state.addOperands(params);
  state.addTypes(resultty);
};

// === LAMBDA OP ===
// === LAMBDA OP ===
// === LAMBDA OP ===
// === LAMBDA OP ===
// === LAMBDA OP ===

ParseResult HaskLambdaOp::parse(OpAsmParser &parser, OperationState &result) {
  // hask.lambda [    ] { ... } : function-type ?

  //  parser.parseOperandList(operands, OpAsmParser::Delimiter::Square);
  //  parser.resolveOperands(operands,
  //                         ValueType::get(parser.getBuilder().getContext()),
  //                         result.operands);
  if (parser.parseLSquare()) {
    return failure();
  }
  if (failed(parser.parseOptionalRSquare())) {
    while (1) {
      OpAsmParser::OperandType operand;
      Type operandty;
      if (parser.parseOperand(operand) || parser.parseColon() ||
          parser.parseType(operandty) ||
          parser.resolveOperand(operand, operandty, result.operands)) {
        return failure();
      }

      if (succeeded(parser.parseOptionalRSquare())) {
        break;
      } else if (succeeded(parser.parseComma())) {
        continue;
      } else {
        return failure();
      }
    }
  }
  // ( ... )
  if (parser.parseLParen()) {
    return failure();
  }

  SmallVector<OpAsmParser::OperandType, 4> args;
  SmallVector<Type, 4> argTys;
  Type retty;

  if (succeeded(parser.parseOptionalRParen())) {
    // we have no params.
  } else {
    while (1) {
      OpAsmParser::OperandType arg;
      if (parser.parseRegionArgument(arg)) {
        return failure();
      };
      args.push_back(arg);

      if (parser.parseColon()) {
        return failure();
      }
      Type argType;
      if (parser.parseType(argType)) {
        return failure();
      }
      argTys.push_back(argType);
      if (succeeded(parser.parseOptionalRParen())) {
        break;
      } else if (parser.parseComma()) {
        return failure();
      }
    }
  }

  // -> retty
  if (parser.parseArrow() || parser.parseType(retty)) {
    return failure();
  }

  //  result.add
  result.addAttribute(HaskDialect::getReturnTypeAttributeKey(),
                      mlir::TypeAttr::get(retty));
  // result.addTypes(

  Region *r = result.addRegion();
  if (parser.parseRegion(*r, {args}, {argTys})) {
    return failure();
  }

  // result.addTypes(parser.getBuilder().getType<FunctionType>(argTys, retty));
  result.addTypes(FunctionType::get(result.getContext(), argTys, retty));
  return success();
}

void HaskLambdaOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// === FORCE OP ===
// === FORCE OP ===
// === FORCE OP ===
// === FORCE OP ===
// === FORCE OP ===

ParseResult ForceOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType scrutinee;
  mlir::Type retty;

  if (parser.parseLParen() || parser.parseOperand(scrutinee) ||
      parser.parseRParen() || parser.parseColon() || parser.parseType(retty)) {
    return failure();
  }

  SmallVector<Value, 4> results;
  if (parser.resolveOperand(
          scrutinee, parser.getBuilder().getType<ThunkType>(retty), results))
    return failure();
  result.addOperands(results);
  result.addTypes(retty);
  return success();
};

void ForceOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
  p << "hask.force(" << this->getScrutinee() << ")"
    << ":" << this->getResult().getType();
};

void ForceOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee) {

  assert(scrutinee.getType().isa<ThunkType>());
  ThunkType t = scrutinee.getType().cast<ThunkType>();
  state.addOperands(scrutinee);
  state.addTypes(t.getElementType());
}

// === ADT OP ===
// === ADT OP ===
// === ADT OP ===
// === ADT OP ===
// === ADT OP ===
//

// ParseResult HaskADTOp::parse(OpAsmParser &parser, OperationState &result) {
//   OpAsmParser::OperandType scrutinee;
//
//   SmallVector<Value, 4> results;
//   Attribute name;
//   Attribute constructors;
//   if (parser.parseAttribute(name, "name", result.attributes)) {
//     return failure();
//   }
//   if (parser.parseAttribute(name, "constructors", result.attributes)) {
//     return failure();
//   }
//
//   //    result.addAttribute("name", name);
//   //    result.addAttribute("constructors", constructors);
//   //    if(parser.parseAttribute(constructors)) { return failure(); }
//
//   llvm::errs() << "ADT: " << name << "\n"
//                << "cons: " << constructors << "\n";
//   return success();
// };
//
// void HaskADTOp::print(OpAsmPrinter &p) {
//   p << getOperationName();
//   p << " " << this->getAttr("name") << " " << this->getAttr("constructors");
// };

// === CONSTRUCT OP ===
// === CONSTRUCT OP ===
// === CONSTRUCT OP ===
// === CONSTRUCT OP ===
// === CONSTRUCT OP ===

// do I even need this? I'm not sure. Don't think so?
ParseResult HaskConstructOp::parse(OpAsmParser &parser,
                                   OperationState &result) {
  // (<constructor name>, arg1, ..., argn) : hask.adt<type>
  if (parser.parseLParen()) {
    return failure();
  }

  // get constructor name.
  FlatSymbolRefAttr constructor;
  if (parser.parseAttribute<FlatSymbolRefAttr>(
          constructor, getDataConstructorAttrKey(), result.attributes)) {
    return failure();
  }

  if (succeeded(parser.parseOptionalRParen())) {
    // empty
  } else {
    if (parser.parseComma()) {
      return failure();
    }
    while (1) {
      OpAsmParser::OperandType param;
      if (parser.parseOperand(param)) {
        return failure();
      }
      if (parser.parseColon()) {
        return failure();
      }
      Type t;
      if (parser.parseType(t)) {
        return failure();
      }
      if (parser.resolveOperand(param, t, result.operands)) {
        return failure();
      }

      // either we need a close right paren, or a comma.
      if (succeeded(parser.parseOptionalRParen())) {
        break;
      }
      if (parser.parseComma()) {
        return failure();
      }
    }
  }

  result.addTypes(ValueType::get(parser.getBuilder().getContext()));
  return success();
}

void HaskConstructOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;

  p << this->getOperationName();
  p << "(";
  p.printSymbolName(this->getDataConstructorName());
  if (this->getNumOperands() > 0) {
    p << ", ";
  }

  for (int i = 0; i < this->getNumOperands(); ++i) {
    p << this->getOperand(i) << " : " << this->getOperand(i).getType();
    if (i + 1 < this->getNumOperands()) {
      p << ", ";
    }
  }
  p << ") : " << this->getOperation()->getResult(0).getType();
}

void HaskConstructOp::build(mlir::OpBuilder &builder,
                            mlir::OperationState &state,
                            StringRef constructorName,
                            // StringRef ADTTypeName,
                            ValueRange args) {
  state.addAttribute(
      HaskConstructOp::getDataConstructorAttrKey(),
      FlatSymbolRefAttr::get(builder.getContext(), constructorName));
  state.addOperands(args);
  // return type.
  state.addTypes(ValueType::get(builder.getContext()));
};

// === CASE INT OP ===
// === CASE INT OP ===
// === CASE INT OP ===
// === CASE INT OP ===
// === CASE INT OP ===
ParseResult CaseIntOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType scrutinee;
  if (parser.parseOperand(scrutinee))
    return failure();
  if (parser.resolveOperand(scrutinee, parser.getBuilder().getI64Type(),
                            result.operands)) {
    return failure();
  }

  // if(parser.parseOptionalAttrDict(result.attributes)) return failure();

  // "[" altname "->" region "]"
  int nattr = 0;
  SmallVector<Region *, 4> altRegions;
  while (succeeded(parser.parseOptionalLSquare())) {
    Attribute alt_type_attr;
    const std::string attrname = "alt" + std::to_string(nattr);
    parser.parseAttribute(alt_type_attr, attrname, result.attributes);
    assert(alt_type_attr.isa<IntegerAttr>() ||
           alt_type_attr.isa<FlatSymbolRefAttr>());
    nattr++;
    parser.parseArrow();
    Region *r = result.addRegion();
    altRegions.push_back(r);
    if (parser.parseRegion(*r, {}, {}))
      return failure();
    parser.parseRSquare();
  }

  assert(altRegions.size() > 0);

  HaskReturnOp retFirst =
      cast<HaskReturnOp>(altRegions[0]->getBlocks().front().getTerminator());
  for (int i = 1; i < (int)altRegions.size(); ++i) {
    HaskReturnOp ret =
        cast<HaskReturnOp>(altRegions[i]->getBlocks().front().getTerminator());
    assert(retFirst.getOperand().getType() == ret.getOperand().getType() &&
           "all case branches must return  same levity [value/thunk]");
  }

  result.addTypes(retFirst.getOperand().getType());
  return success();
};

void CaseIntOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;

  p << getOperationName() << " ";
  p << this->getScrutinee();
  for (int i = 0; i < this->getNumAlts(); ++i) {
    p << " [" << this->getAltLHSRaw(i) << " -> ";
    p.printRegion(this->getAltRHS(i));
    p << "]\n";
  }
};

llvm::Optional<int> CaseIntOp::getDefaultAltIndex() {
  for (int i = 0; i < getNumAlts(); ++i) {
    Attribute ai = this->getAltLHSRaw(i);
    FlatSymbolRefAttr sai = ai.dyn_cast<FlatSymbolRefAttr>();
    if (sai && sai.getValue() == "default") {
      return i;
    }
  }
  return llvm::Optional<int>();
}

void CaseIntOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                      Value scrutinee, SmallVectorImpl<mlir::Attribute> &lhss,
                      SmallVectorImpl<mlir::Region *> &rhss, mlir::Type retty) {

  assert(scrutinee.getType().isInteger(64));
  state.addOperands(scrutinee);
  assert(lhss.size() == rhss.size());

  for (Region *r : rhss) {
    std::unique_ptr<mlir::Region> pr(r);
    state.addRegion(std::move(pr));
  }
  for (int i = 0; i < (int)lhss.size(); ++i) {
    state.addAttribute("alt" + std::to_string(i), lhss[i]);
  }
  state.addTypes(retty);
}

// === THUNKIFY OP ===
// === THUNKIFY OP ===
// === THUNKIFY OP ===
// === THUNKIFY OP ===
// === THUNKIFY OP ===

ParseResult ThunkifyOp::parse(OpAsmParser &parser, OperationState &result) {
  OpAsmParser::OperandType scrutinee;

  Type type;
  if (parser.parseLParen() || parser.parseOperand(scrutinee) ||
      parser.parseColonType(type) || parser.parseRParen()) {
    return failure();
  }

  SmallVector<Value, 4> results;
  if (parser.resolveOperand(scrutinee, type, results))
    return failure();
  result.addOperands(results);
  result.addTypes(ThunkType::get(parser.getBuilder().getContext(), type));
  return success();
};

void ThunkifyOp::print(OpAsmPrinter &p) {
  p << getOperationName() << "(" << this->getScrutinee() << " :"
    << this->getScrutinee().getType() << ")";
};

void ThunkifyOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       Value scrutinee) {
  state.addOperands(scrutinee);
  state.addTypes(builder.getType<ThunkType>(scrutinee.getType()));
}

// === TAG GET  OP ===
// === TAG GET  OP ===
// === TAG GET  OP ===
// === TAG GET  OP ===
// === TAG GET  OP ===

void TagGetOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                     Value v) {
  state.addOperands(v);
  state.addTypes(builder.getI64Type());
};

ParseResult TagGetOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void TagGetOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === PROJECTION  OP ===
// === PROJECTION  OP ===
// === PROJECTION  OP ===
// === PROJECTION  OP ===
// === PROJECTION  OP ===

void ProjectionOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                         int ix, mlir::Value v, mlir::Type retty) {
  state.addOperands(v);
  state.addAttribute(ProjectionOp::getIndexAttrKey(),
                     builder.getI64IntegerAttr(ix));
  state.addTypes(retty);
};

ParseResult ProjectionOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void ProjectionOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === HaskIntegerConstOp  OP ===
// === HaskIntegerConstOp  OP ===
// === HaskIntegerConstOp  OP ===
// === HaskIntegerConstOp  OP ===
// === HaskIntegerConstOp  OP ===

void HaskIntegerConstOp::build(mlir::OpBuilder &builder,
                               mlir::OperationState &state, int i) {
  state.addAttribute(HaskIntegerConstOp::getValueAttrKey(),
                     builder.getI64IntegerAttr(i));
  state.addTypes(builder.getType<ValueType>());
};

ParseResult HaskIntegerConstOp::parse(OpAsmParser &parser,
                                      OperationState &result) {
  mlir::OpAsmParser::OperandType in;
  mlir::IntegerAttr i;
  if (parser.parseLParen() || parser.parseAttribute<mlir::IntegerAttr>(i) ||
      parser.parseRParen()) {
    return failure();
  }
  result.addAttribute(HaskIntegerConstOp::getValueAttrKey(), i);
  result.addTypes(parser.getBuilder().getType<ValueType>());
  return success();
};

void HaskIntegerConstOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === HaskStringConstOp  OP ===
// === HaskStringConstOp  OP ===
// === HaskStringConstOp  OP ===
// === HaskStringConstOp  OP ===
// === HaskStringConstOp  OP ===

ParseResult HaskStringConstOp::parse(OpAsmParser &parser,
                                     OperationState &result) {
  mlir::OpAsmParser::OperandType in;
  mlir::IntegerAttr i;
  if (parser.parseLParen() || parser.parseAttribute<mlir::IntegerAttr>(i) ||
      parser.parseRParen()) {
    return failure();
  }
  result.addAttribute(HaskStringConstOp::getValueAttrKey(), i);
  result.addTypes(parser.getBuilder().getType<ValueType>());
  return success();
};

void HaskStringConstOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === INC OP ===
// === INC OP ===
// === INC OP ===
// === INC OP ===
// === INC OP ===

void IncOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                  Value v) {
  // vvv HACK: I have no idea why this is failing.
  // assert(v.getType().isa<standalone::ValueType>() && "incop input must be
  // lz::Value");
  state.addOperands(v);
};

ParseResult IncOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::OpAsmParser::OperandType in;
  if (parser.parseLParen() || parser.parseOperand(in) || parser.parseRParen()) {
    return failure();
  }
  parser.resolveOperand(in, parser.getBuilder().getType<ValueType>(),
                        result.operands);
  return success();
};

void IncOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === DEC OP ===
// === DEC OP ===
// === DEC OP ===
// === DEC OP ===
// === DEC OP ===

void DecOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                  Value v) {
  // vvv HACK: I have no idea why this is failing.
  // assert(v.getType().isa<standalone::ValueType>() && "decop input must be
  // lz::Value");
  state.addOperands(v);
};

ParseResult DecOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::OpAsmParser::OperandType in;
  if (parser.parseLParen() || parser.parseOperand(in) || parser.parseRParen()) {
    return failure();
  }
  parser.resolveOperand(in, parser.getBuilder().getType<ValueType>(),
                        result.operands);
  return success();
};

void DecOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === ERASED VAUE OP ===
// === ERASED VAUE OP ===
// === ERASED VAUE OP ===
// === ERASED VAUE OP ===
// === ERASED VAUE OP ===

void ErasedValueOp::build(mlir::OpBuilder &builder,
                          mlir::OperationState &state) {
  state.addTypes(builder.getType<standalone::ValueType>());
};

ParseResult ErasedValueOp::parse(OpAsmParser &parser, OperationState &result) {
  return success();
};

void ErasedValueOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// === HaskBlockOp OP ===
// === HaskBlockOp OP ===
// === HaskBlockOp OP ===
// === HaskBlockOp OP ===
// === HaskBlockOp OP ===

ParseResult HaskBlockOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};
void HaskBlockOp::print(OpAsmPrinter &p) { p.printGenericOp(*this); };

void HaskBlockOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        int blockIx) {
  state.addRegion();
  state.addRegion();
  state.addAttribute("value", builder.getI64IntegerAttr(blockIx));
  return;
  assert(false && "unimplemented");
}

// ===  HaskJumpOp ===
// ===  HaskJumpOp ===
// ===  HaskJumpOp ===
// ===  HaskJumpOp ===
// ===  HaskJumpOp ===

ParseResult HaskJumpOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};
void HaskJumpOp::print(OpAsmPrinter &p) { p.printGenericOp(*this); };
void HaskJumpOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       int blockIx, Value v) {
  state.addAttribute("value", builder.getI64IntegerAttr(blockIx));
  state.addOperands(v);
  return;
  assert(false && "unimplemented");
}

// === HaskCaseRetOp ===
// === HaskCaseRetOp ===
// === HaskCaseRetOp ===
// === HaskCaseRetOp ===
// === HaskCaseRetOp ===

ParseResult HaskCaseRetOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};
void HaskCaseRetOp::print(OpAsmPrinter &p) { p.printGenericOp(*this); };

// === REUSE CONSTRUCTOR OP ===
// === REUSE CONSTRUCTOR OP ===
// === REUSE CONSTRUCTOR OP ===
// === REUSE CONSTRUCTOR OP ===
// === REUSE CONSTRUCTOR OP ===
// === REUSE CONSTRUCTOR OP ===

ParseResult ReuseConstructorOp::parse(OpAsmParser &parser,
                                      OperationState &result) {

  assert(false && "unimplemented");
}

void ReuseConstructorOp::build(mlir::OpBuilder &builder,
                               mlir::OperationState &state,
                               StringRef constructorName, ValueRange args) {
  state.addAttribute(
      ReuseConstructorOp::getDataConstructorAttrKey(),
      FlatSymbolRefAttr::get(builder.getContext(), constructorName));
  state.addOperands(args);
  state.addTypes(ValueType::get(builder.getContext()));
}

void ReuseConstructorOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

// === RESET OP ===
// === RESET OP ===
// === RESET OP ===
// === RESET OP ===
// === RESET OP ===

ParseResult ResetOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
}

void ResetOp::print(OpAsmPrinter &p) { p.printGenericOp(this->getOperation()); }

void ResetOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value v) {
  state.addOperands(v);
  state.addRegion();
  state.addRegion();
  return;
}

// === HASK CALL OP ===
// === HASK CALL OP ===
// === HASK CALL OP ===
// === HASK CALL OP ===
// === HASK CALL OP ===

ParseResult HaskCallOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
}

void HaskCallOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
}

/*
// === THUNK TO PTR OP ===
// === THUNK TO PTR OP ===
// === THUNK TO PTR OP ===
// === THUNK TO PTR OP ===
// === THUNK TO PTR OP ===

ParseResult HaskThunkToPtrOp::parse(OpAsmParser &parser,
                                    OperationState &result) {
  ThunkType thunkty;
  OpAsmParser::OperandType rand; // ope'rand
  if (parser.parseOperand(rand) || parser.parseColonType<ThunkType>(thunkty) ||
      parser.resolveOperand(rand, thunkty, result.operands)) {
    return failure();
  }

  result.addTypes(ptr::VoidPtrType::get(parser.getBuilder().getContext()));
  return success();
};

void HaskThunkToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};
*/

} // namespace standalone
} // namespace mlir
