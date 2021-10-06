#pragma once
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinAttributes.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/OperationSupport.h"
#include "mlir/Interfaces/ControlFlowInterfaces.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LLVM.h"
#include "llvm/BinaryFormat/Dwarf.h"
#include <string>

static const int RGN_DIALECT_DEFAULT_CASE_MAGIC = 42;

class RgnDialect : public mlir::Dialect {
public:
  explicit RgnDialect(mlir::MLIRContext *ctx);

  static llvm::StringRef getDialectNamespace() { return "rgn"; }
};

class RgnSelectOp
    : public mlir::Op<RgnSelectOp, mlir::OpTrait::VariadicOperands,
                      mlir::OpTrait::OneResult, mlir::OpTrait::ZeroRegion,
                      mlir::MemoryEffectOpInterface::Trait> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.select"; };
  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  mlir::Value getSwitcher() {
    return this->getOperand(0);
  }

  int getNumBranches() {
    int ans = this->getNumOperands() - 1; 
    assert(ans > 0);
    return ans;
  }

  std::pair<int, mlir::Value> getBranch(int i) {
    assert(i + 1 < (int)this->getOperands().size());
    mlir::IntegerAttr lhs = this->getOperation()->getAttrOfType<mlir::IntegerAttr>("case" + std::to_string(i));
    mlir::Value rhs = this->getOperand(i + 1);
    return { lhs.getInt(), rhs };
  }

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    mlir::Value switcher,
                    mlir::SmallVectorImpl<int> &is, mlir::ValueRange vs) {
    state.addOperands(switcher);
    for(mlir::Value v : vs) {
      state.addOperands(v);
    }
    state.addTypes(builder.getIntegerType(42));
    assert(vs.size() == is.size());
    for(int i = 0; i < (int)is.size(); ++i) {
      state.addAttribute("case" + std::to_string(i),
          builder.getI64IntegerAttr(is[i]));
    }
  }

  void getEffects(mlir::SmallVectorImpl<mlir::SideEffects::EffectInstance<
                      mlir::MemoryEffects::Effect>> &effects) {}



  void print(mlir::OpAsmPrinter &p);
};



class RgnReturnOp
    : public mlir::Op<RgnReturnOp, mlir::OpTrait::ZeroResult,
                      mlir::OpTrait::ZeroSuccessor, mlir::OpTrait::ReturnLike,
                      mlir::OpTrait::OneOperand, mlir::OpTrait::IsTerminator> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.return"; };

  // Type getType() { return this->getInput().getType(); }
  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    mlir::ValueRange vs) {
    state.addOperands(vs);
  }

  void print(mlir::OpAsmPrinter &p);
};

class RgnEndOp
    : public mlir::Op<RgnEndOp, mlir::OpTrait::ZeroResult,
                      mlir::OpTrait::ZeroSuccessor, mlir::OpTrait::ReturnLike,
                      mlir::OpTrait::ZeroOperands,
                      mlir::OpTrait::IsTerminator> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.end"; };

  // Type getType() { return this->getInput().getType(); }
  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state) {}
  void print(mlir::OpAsmPrinter &p);
};

class RgnValOp
    : public mlir::Op<RgnValOp, mlir::OpTrait::ZeroOperands,
                      mlir::OpTrait::OneResult, mlir::OpTrait::OneRegion,
                      mlir::MemoryEffectOpInterface::Trait,
                      mlir::RegionBranchOpInterface::Trait> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.val"; };
  //    mlir::Block &getEntryBlock() { return this->getRegion().front(); }
  //    mlir::Block::BlockArgListType inputRange() {
  //        return this->getEntryBlock().getArguments();
  //    }
  //    int getNumInputs() { return this->getEntryBlock().getNumArguments(); }
  //    mlir::BlockArgument getInput(int i) {
  //        assert(i < getNumInputs());
  //        return this->getEntryBlock().getArgument(i);
  //    }

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  void print(mlir::OpAsmPrinter &p);

  // declaring a region has no side effects!
  void getEffects(mlir::SmallVectorImpl<mlir::SideEffects::EffectInstance<
                      mlir::MemoryEffects::Effect>> &effects) {}

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state) {
    mlir::Region *rnew = state.addRegion();
    state.addTypes(builder.getIntegerType(42));
  }


  // template <typename RangeT>
  // static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
  //                   RangeT ts) {
  //   mlir::Region *rnew = state.addRegion();
  //   mlir::BlockAndValueMapping mapping;
  //   //  r->cloneInto(rnew, mapping);
  //   state.addTypes(ts);
  // }

  mlir::Region *region();

  void
  getSuccessorRegions(mlir::Optional<unsigned> index,
                      mlir::ArrayRef<mlir::Attribute> operands,
                      mlir::SmallVectorImpl<mlir::RegionSuccessor> &regions);
};

class RgnJumpValOp
    : public mlir::Op<RgnJumpValOp, mlir::OpTrait::VariadicOperands,
                      mlir::OpTrait::ZeroResult, mlir::OpTrait::IsTerminator> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.jumpval"; };

  mlir::Value getFn() { return this->getOperation()->getOperand(0); };

  int getNumFnArguments() {
    return this->getOperation()->getNumOperands() - 1;
  };

  mlir::Value getFnArgument(int i) {
    return this->getOperation()->getOperand(i + 1);
  };

  llvm::SmallVector<mlir::Value, 4> getFnArguments() {
    llvm::SmallVector<mlir::Value, 4> args;
    for (int i = 0; i < getNumFnArguments(); ++i) {
      args.push_back(getFnArgument(i));
    }
    return args;
  }

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    mlir::Value rgn) {
    state.addOperands(rgn);
  }

    static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    mlir::Value rgn, mlir::ValueRange operands) {
    state.addOperands(rgn);
    state.addOperands(operands);
  }



  void print(mlir::OpAsmPrinter &p);
};


/*
class RgnSymOp
    : public mlir::Op<RgnSymOp, mlir::OpTrait::ZeroOperands,
                      mlir::OpTrait::OneResult, mlir::OpTrait::OneRegion> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.sym"; };
  //    mlir::Block &getEntryBlock() { return this->getRegion().front(); }
  //    mlir::Block::BlockArgListType inputRange() {
  //        return this->getEntryBlock().getArguments();
  //    }
  //    int getNumInputs() { return this->getEntryBlock().getNumArguments(); }
  //    mlir::BlockArgument getInput(int i) {
  //        assert(i < getNumInputs());
  //        return this->getEntryBlock().getArgument(i);
  //    }

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  void print(mlir::OpAsmPrinter &p);
};

// call a value.
class RgnCallValOp
    : public mlir::Op<RgnCallValOp, mlir::OpTrait::VariadicOperands,
                      mlir::OpTrait::VariadicResults> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.callval"; };

  mlir::Value getFn() { return this->getOperation()->getOperand(0); };

  int getNumFnArguments() {
    return this->getOperation()->getNumOperands() - 1;
  };

  mlir::Value getFnArgument(int i) {
    return this->getOperation()->getOperand(i + 1);
  };

  llvm::SmallVector<mlir::Value, 4> getFnArguments() {
    llvm::SmallVector<mlir::Value, 4> args;
    for (int i = 0; i < getNumFnArguments(); ++i) {
      args.push_back(getFnArgument(i));
    }
    return args;
  }

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  void print(mlir::OpAsmPrinter &p);

  template <typename ValsT, typename TypesT>
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    mlir::Value rgn, ValsT args, TypesT rettys) {
    state.addOperands(rgn);
    state.addOperands(args);
    state.addTypes(rettys);
  }
};

// call a symbol.
class RgnCallSymOp
    : public mlir::Op<RgnCallSymOp, mlir::OpTrait::VariadicOperands> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.callsym"; };
  //
  //    mlir::StringAttr getFnName() {
  //        return this->getOperation()->getAttrOfType<mlir::StringAttr>(
  //                getFnNameAttrKey());
  //    };
  //
  //    static const char *getFnNameAttrKey() { return "value"; }
  //
  //    int getNumFnArguments() {
  //        return this->getOperation()->getNumOperands();
  //    };
  //
  //    mlir::Value getFnArgument(int i) {
  //        return this->getOperation()->getOperand(i);
  //    };

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  void print(mlir::OpAsmPrinter &p);


};


// jump a symbol.
class RgnJumpSymOp
    : public mlir::Op<RgnJumpSymOp, mlir::OpTrait::VariadicOperands,
                      mlir::OpTrait::ZeroResult, mlir::OpTrait::IsTerminator> {
public:
  using Op::Op;
  static llvm::StringRef getOperationName() { return "rgn.jumpsym"; };

  mlir::StringAttr getFnName() {
    return this->getOperation()->getAttrOfType<mlir::StringAttr>(
        getFnNameAttrKey());
  };

  static const char *getFnNameAttrKey() { return "value"; }

  int getNumFnArguments() { return this->getOperation()->getNumOperands(); };

  mlir::Value getFnArgument(int i) {
    return this->getOperation()->getOperand(i);
  };

  static mlir::ParseResult parse(mlir::OpAsmParser &parser,
                                 mlir::OperationState &result);

  void print(mlir::OpAsmPrinter &p);
};
*/
// create interface for call/jmp
// https://mlir.llvm.org/docs/Interfaces/#attributeoperationtype-interfaces


std::unique_ptr<mlir::Pass> createRgnCSEPass();
void registerRgnCSEPass();
void registerLowerRgnPass();
