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

  std::string getFnName() {
    ConstantOp nameOp = getFn().getDefiningOp<ConstantOp>();
    FlatSymbolRefAttr nameAttr = nameOp.getValue().cast<FlatSymbolRefAttr>();
    return nameAttr.getValue().str();
  }

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
                    Value fn, Type resultty,
                    const SmallVectorImpl<Value> &params);
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
  // get dictionary attribute that contains all the LHSs
  mlir::DictionaryAttr getAltLHSsDict() {
    return this->getOperation()->getAttrDictionary();
  }
  FlatSymbolRefAttr getAltLHS(int i) {
    return getAltLHSsDict()
        .get("alt" + std::to_string(i))
        .cast<FlatSymbolRefAttr>();
  }

  std::vector<mlir::FlatSymbolRefAttr> getAltLHSs() {
    std::vector<mlir::FlatSymbolRefAttr> out;
    for (int i = 0; i < this->getNumAlts(); ++i) {
      out.push_back(getAltLHS(i));
    }
    return out;
  }

  // std::vector<mlir::Region &> getAltRHS() {
  //   std::vector<mlir::Region &> out;
  //   for (int i = 0; i < this->getNumAlts(); ++i) {
  //     out.push_back(getAltRHS(i));
  //   }
  //   return out;
  // }

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

  llvm::Optional<int> getAltIndexForConstInt(int constval) {
    for (int i = 0; i < this->getNumAlts(); ++i) {
      Optional<IntegerAttr> iattr = this->getAltLHS(i);
      if (!iattr) {
        continue;
      };

      if (iattr->getInt() == constval) {
        return i;
      }
    }
    return this->getDefaultAltIndex();
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
class HaskConstructOp
    : public Op<HaskConstructOp, OpTrait::OneResult, OpTrait::ZeroRegion,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.construct"; };
  static const char *getDataConstructorAttrKey() { return "dataconstructor"; }
  static const char *getDataTypeAttrKey() { return "datatype"; }
  StringRef getDataConstructorName() {
    return getAttrOfType<FlatSymbolRefAttr>(getDataConstructorAttrKey())
        .getValue();
  }

  int getNumOperands() { return this->getOperation()->getNumOperands(); }
  Value getOperand(int i) { return this->getOperation()->getOperand(i); }
  Operation::operand_range getOperands() {
    return this->getOperation()->getOperands();
  }
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    StringRef constructorName, ValueRange args);

  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};

// %mr = ptr2memref %vptr : !ptr.void -> memref
class PtrToHaskValueOp
    : public Op<PtrToHaskValueOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptr2haskval"; };
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vptr);
  void print(OpAsmPrinter &p);
};

class HaskValueToPtrOp
    : public Op<HaskValueToPtrOp, OpTrait::OneOperand, OpTrait::OneResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.value2ptr"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value v);
};

/*
class HaskThunkToPtrOp
    : public Op<HaskThunkToPtrOp, OpTrait::OneOperand, OpTrait::OneResult,
                MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "lz.thunk2ptr"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  void
  getEffects(SmallVectorImpl<SideEffects::EffectInstance<MemoryEffects::Effect>>
                 &effects) {}
};
*/

// lower lz to LLVM by eliminating all the junk.
std::unique_ptr<mlir::Pass> createLowerHaskToLLVMPass();
// canonicalize, eliminating all intermediate waste.
std::unique_ptr<mlir::Pass> createWorkerWrapperPass();

void registerLowerHaskPass();
void registerWorkerWrapperPass();
} // namespace standalone
} // namespace mlir

#endif // STANDALONE_STANDALONEOPS_H
