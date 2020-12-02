//===- HaskOps.h - Hask dialect ops -----------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef STANDALONE_STANDALONEOPS_H
#define STANDALONE_STANDALONEOPS_H

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

#include "mlir/Pass/Pass.h"

#include "HaskDialect.h"

namespace mlir {
namespace standalone {

// #define GET_OP_CLASSES
// #include "Hask/HaskOps.h.inc"

class HaskReturnOp
    : public Op<HaskReturnOp, OpTrait::ZeroResult, OpTrait::ZeroSuccessor,
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
};

class MakeI64Op
    : public Op<MakeI64Op, OpTrait::OneResult, OpTrait::ZeroSuccessor,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.make_i64"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);

  IntegerAttr getValue() {
    return this->getOperation()->getAttrOfType<IntegerAttr>("value");
  }
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class MakeStringOp
    : public Op<MakeStringOp, OpTrait::OneResult, OpTrait::ZeroSuccessor,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.make_string"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);

  Attribute getValue() { return this->getOperation()->getAttr("value"); }
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class ApOp
    : public Op<ApOp, OpTrait::OneResult, MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.ap"; };
  Value getFn() { return this->getOperation()->getOperand(0); };
  int getNumFnArguments() {
    return this->getOperation()->getNumOperands() - 1;
  };
  Value getFnArgument(int i) {
    return this->getOperation()->getOperand(i + 1);
  };

  SmallVector<Value, 4> getFnArguments() {
    SmallVector<Value, 4> args;
    for (int i = 0; i < getNumFnArguments(); ++i) {
      args.push_back(getFnArgument(i));
    }
    return args;
  }
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}

  // NOTE: the return type should be the return type of the *function*. The ApOp
  // will wrap the fnretty in a ThunkType
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value fnref, SmallVectorImpl<Value> &params, Type fnretty);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    FuncOp fn, SmallVectorImpl<Value> &params);

  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

// https://mlir.llvm.org/docs/Interfaces/
class ApEagerOp
    : public Op<ApEagerOp, OpTrait::OneResult, MemoryEffectOpInterface::Trait,
                CallOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.apEager"; };
  Value getFn() { return this->getOperation()->getOperand(0); };
  int getNumFnArguments() {
    return this->getOperation()->getNumOperands() - 1;
  };
  Value getFnArgument(int i) {
    return this->getOperation()->getOperand(i + 1);
  };

  SmallVector<Value, 4> getFnArguments() {
    SmallVector<Value, 4> args;
    for (int i = 0; i < getNumFnArguments(); ++i) {
      args.push_back(getFnArgument(i));
    }
    return args;
  }
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value fn, const SmallVectorImpl<Value> &params,
                    Type resultty);
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);

  CallInterfaceCallable getCallableForCallee() {
    assert(false && "unimplement getCallableForCallee");
  };
  Operation::operand_range getArgOperands() {
    assert(false && "unimplemented getArgOperands");
  };
  Operation *resolveCallable() {
    assert(false && "unimplemented resolveCallable");
  }
};

class CaseOp
    : public Op<CaseOp, OpTrait::OneResult, MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.case"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  Value getScrutinee() { return this->getOperation()->getOperand(0); }
  int getNumAlts() { return this->getOperation()->getNumRegions(); }

  Region &getAltRHS(int i) { return this->getOperation()->getRegion(i); }
  Region &getDefaultRHS() {
    assert(this->getDefaultAltIndex().hasValue());
    return this->getAltRHS(*this->getDefaultAltIndex());
  }
  mlir::DictionaryAttr getAltLHSs() {
    return this->getOperation()->getAttrDictionary();
  }
  FlatSymbolRefAttr getAltLHS(int i) {
    return getAltLHSs()
        .get("alt" + std::to_string(i))
        .cast<FlatSymbolRefAttr>();
  }

  Optional<int> getAltIndexForConstructor(llvm::StringRef constructorName) {
    for (int i = 0; i < this->getNumAlts(); ++i) {
      if (this->getAltLHS(i).getValue() == constructorName) {
        return i;
      }
    }
    return {};
  };

  static const char *getCaseTypeKey() { return "constructorName"; }
  void print(OpAsmPrinter &p);
  llvm::Optional<int> getDefaultAltIndex();
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee, SmallVectorImpl<mlir::Attribute> &lhss,
                    SmallVectorImpl<mlir::Region *> &rhss, mlir::Type retty);
};

class CaseIntOp
    : public Op<CaseIntOp, OpTrait::OneResult, MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.caseint"; };
  Value getScrutinee() { return this->getOperation()->getOperand(0); }
  int getNumAlts() { return this->getOperation()->getNumRegions(); }
  Region &getAltRHS(int i) { return this->getOperation()->getRegion(i); }
  Region &getDefaultRHS() {
    assert(this->getDefaultAltIndex().hasValue());
    return this->getAltRHS(*this->getDefaultAltIndex());
  }

  mlir::DictionaryAttr getAltLHSs() {
    return this->getOperation()->getAttrDictionary();
  }
  Optional<IntegerAttr> getAltLHS(int i) {
    Attribute lhs = getAltLHSs().get("alt" + std::to_string(i));
    if (lhs.isa<IntegerAttr>()) {
      return {lhs.cast<IntegerAttr>()};
    }
    return {};
  }
  Attribute getAltLHSRaw(int i) {
    return getAltLHSs().get("alt" + std::to_string(i));
  }

  void print(OpAsmPrinter &p);
  llvm::Optional<int> getDefaultAltIndex();
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee, SmallVectorImpl<mlir::Attribute> &lhss,
                    SmallVectorImpl<mlir::Region *> &rhss, mlir::Type retty);
};

class DefaultCaseOp : public Op<DefaultCaseOp, OpTrait::OneResult,
                                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.defaultcase"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static const char *getCaseTypeKey() { return "constructorName"; }
  std::string getConstructorTag() {
    return this->getOperation()
        ->getAttrOfType<FlatSymbolRefAttr>(getCaseTypeKey())
        .getValue()
        .str();
  }
  Value getScrutinee() { return this->getOperation()->getOperand(0); }
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

// LAMBDA OP
class HaskLambdaOp : public Op<HaskLambdaOp, OpTrait::VariadicOperands,
                               OpTrait::OneResult, OpTrait::OneRegion> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.lambda"; };
  Block &getEntryBlock() { return this->getRegion().front(); }
  Block::BlockArgListType inputRange() {
    return this->getEntryBlock().getArguments();
  }
  int getNumInputs() { return this->getEntryBlock().getNumArguments(); }
  mlir::BlockArgument getInput(int i) {
    assert(i < getNumInputs());
    return this->getEntryBlock().getArgument(i);
  }

  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  // TODO: check that we only access those values we capture
  //  void verify();
};

/*
class HaskRefOp
    : public Op<HaskRefOp, OpTrait::OneResult, OpTrait::ZeroOperands,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.ref"; };
  llvm::StringRef getRef() {
    return getAttrOfType<StringAttr>(::mlir::SymbolTable::getSymbolAttrName())
        .getValue();
  }

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    std::string refname, Type retty);

  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  LogicalResult verify();
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};
*/

// class HaskFuncOp : public Op<HaskFuncOp, OpTrait::ZeroOperands,
//                              OpTrait::ZeroResult, OpTrait::OneRegion,
//                              // OpTrait::AffineScope,
//                              CallableOpInterface::Trait,
//                              SymbolOpInterface::Trait, OpTrait::AffineScope>
//                              {
// public:
//   using Op::Op;
//   static StringRef getOperationName() { return "lz.func"; };
//   Region &getBody() { return this->getRegion(); }
//   void print(OpAsmPrinter &p);
//   // MLIR TODO: expose this as part of the Callable interface.
//   int getNumArguments() { return this->getBody().getNumArguments(); }
//   llvm::StringRef getFuncName();
//   HaskFnType getFunctionType();
//   Type getReturnType();
//
//   bool isRecursive();
//   static ParseResult parse(OpAsmParser &parser, OperationState &result);
//   static const char *getReturnTypeAttributeKey() { return "retty"; }
//   Region *getCallableRegion() { return &this->getRegion(); };
//   ArrayRef<Type> getCallableResults() { return this->getReturnType(); };
//
//   static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
//                     std::string FuncName, HaskFnType fnty);
// };

// replace case x of name { default -> ... } with name = force(x);
class ForceOp : public Op<ForceOp, OpTrait::OneResult, OpTrait::OneOperand,
                          MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.force"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  Value getScrutinee() { return this->getOperation()->getOperand(0); }
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee);

  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

// class HaskADTOp
//     : public Op<HaskADTOp, OpTrait::ZeroResult, OpTrait::ZeroOperands> {
// public:
//   using Op::Op;
//   static StringRef getOperationName() { return "lz.adt"; };
//   static ParseResult parse(OpAsmParser &parser, OperationState &result);
//   void print(OpAsmPrinter &p);
// };

// do I need this? unclear.
class HaskGlobalOp
    : public Op<HaskGlobalOp, OpTrait::ZeroOperands, OpTrait::ZeroResult,
                OpTrait::OneRegion, // OpTrait::IsIsolatedFromAbove,
                SymbolOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.global"; };
  Region &getRegion() { return this->getOperation()->getRegion(0); };
  Type getType() {
    Region &r = getRegion();
    ReturnOp ret = dyn_cast<ReturnOp>(r.getBlocks().front().getTerminator());
    assert(ret && "global does not have a return value");
    return ret.getOperand(0).getType();
  }
  llvm::StringRef getGlobalName();
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

class HaskConstructOp
    : public Op<HaskConstructOp, OpTrait::OneResult, OpTrait::ZeroRegion,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.construct"; };
  static StringRef getDataConstructorAttrName() { return "dataconstructor"; }
  static StringRef getDataTypeAttrName() { return "datatype"; }
  StringRef getDataConstructorName() {
    return getAttrOfType<FlatSymbolRefAttr>(getDataConstructorAttrName())
        .getValue();
  }

  //  StringRef getDataTypeName() { assert(false && "unimplemented"); return
  //  "DATATYPE"; }
  int getNumOperands() { return this->getOperation()->getNumOperands(); }
  Value getOperand(int i) { return this->getOperation()->getOperand(i); }
  Operation::operand_range getOperands() {
    return this->getOperation()->getOperands();
  }
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    StringRef constructorName,
                    //   StringRef ADTTypeName,
                    ValueRange args);

  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class HaskPrimopAddOp
    : public Op<HaskPrimopAddOp, OpTrait::OneResult,
                OpTrait::NOperands<2>::Impl, MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.primop_add"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class HaskPrimopSubOp
    : public Op<HaskPrimopSubOp, OpTrait::OneResult,
                OpTrait::NOperands<2>::Impl, MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.primop_sub"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class ThunkifyOp
    : public Op<ThunkifyOp, OpTrait::OneResult, OpTrait::OneOperand,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.thunkify"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  Value getScrutinee() { return this->getOperation()->getOperand(0); }
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

class TransmuteOp
    : public Op<TransmuteOp, OpTrait::OneResult, OpTrait::OneOperand,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.transmute"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value scrutinee);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

// lower lz.to standard.
std::unique_ptr<mlir::Pass> createLowerHaskToStandardPass();
// lower lz.standard to LLVM by eliminating all the junk.
std::unique_ptr<mlir::Pass> createLowerHaskStandardToLLVMPass();
// canonicalize, eliminating all intermediate waste.
std::unique_ptr<mlir::Pass> createWorkerWrapperPass();

void registerWorkerWrapperPass();
} // namespace standalone
} // namespace mlir

#endif // STANDALONE_STANDALONEOPS_H
