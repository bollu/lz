#pragma once
#include "mlir/IR/Dialect.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/InliningUtils.h"
#include <llvm/ADT/ArrayRef.h>

namespace mlir {
namespace ptr {

class PtrDialect : public mlir::Dialect {
public:
  explicit PtrDialect(mlir::MLIRContext *ctx);
  mlir::Type parseType(mlir::DialectAsmParser &parser) const override;
  void printType(mlir::Type type,
                 mlir::DialectAsmPrinter &printer) const override;
  // mlir::Attribute parseAttribute(mlir::DialectAsmParser &parser,
  //                               Type type) const override;
  // void printAttribute(Attribute attr,
  //                     DialectAsmPrinter &printer) const override;
  static llvm::StringRef getDialectNamespace() { return "ptr"; }
};

class PtrType : public Type {
public:
  /// Inherit base constructors.
  using Type::Type;

  /// Support for PointerLikeTypeTraits.
  using Type::getAsOpaquePointer;
  static PtrType getFromOpaquePointer(const void *ptr) {
    return PtrType(static_cast<ImplType *>(const_cast<void *>(ptr)));
  }
  /// Support for isa/cast.
  static bool classof(Type type);
  PtrDialect &getDialect();
};

// class VoidPtrType
//     : public mlir::Type::TypeBase<VoidPtrType, PtrType, TypeStorage> {
// public:
//   using Base::Base;
//   static VoidPtrType get(MLIRContext *context) { return Base::get(context); }
// };
// 
// class CharPtrType
//     : public mlir::Type::TypeBase<CharPtrType, PtrType, TypeStorage> {
// public:
//   using Base::Base;
//   static CharPtrType get(MLIRContext *context) { return Base::get(context); }
// };


// HACK: for now, we assume that an array only contains !lz.value.
class PtrArrayType
    : public mlir::Type::TypeBase<PtrArrayType, PtrType, TypeStorage> {
public:
  using Base::Base;
  static PtrArrayType get(MLIRContext *context) { return Base::get(context); }
};


// %ptr = inttoptr %i
class IntToPtrOp
    : public Op<IntToPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.int2ptr"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vint);
  void print(OpAsmPrinter &p);
};

// %ptr = doubletoptr %i
class DoubleToPtrOp
    : public Op<DoubleToPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.double2ptr"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vint);
  void print(OpAsmPrinter &p);
};

// %ptr = ptrtoint %i
class PtrToIntOp
    : public Op<PtrToIntOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptr2int"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vptr, IntegerType ity);
  void print(OpAsmPrinter &p);
};

// %ptr = ptrtofloat %i
class PtrToFloatOp
    : public Op<PtrToFloatOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptr2float"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vptr, FloatType fty);
  void print(OpAsmPrinter &p);
};

// ptr.string "string-I-like"
class PtrStringOp
    : public Op<PtrStringOp, OpTrait::OneResult, OpTrait::ZeroOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.string"; };
  std::string getString() {
    return this->getOperation()
        ->getAttrOfType<StringAttr>("value")
        .getValue()
        .str();
  }

  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    const char *str);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    std::string str);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    llvm::StringRef str);

  void print(OpAsmPrinter &p);
};

// fnptr -> !ptr.void
class FnToVoidPtrOp
    : public Op<FnToVoidPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.fn2voidptr"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vfn);
  void print(OpAsmPrinter &p);
};

// memref -> !ptr.void
class MemrefToVoidPtrOp
    : public Op<MemrefToVoidPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.memref2voidptr"; };
  // static ParseResult parse(OpAsmParser &parser, OperationState &result);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vint);
  void print(OpAsmPrinter &p);
};

// %mr = ptr2memref %vptr : !ptr.void -> memref
class PtrToMemrefOp
    : public Op<PtrToMemrefOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptr2memref"; };
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vptr, MemRefType ity);
  void print(OpAsmPrinter &p);
};

class PtrUndefOp : public Op<PtrUndefOp, OpTrait::OneResult,
                             OpTrait::OneTypedResult<Type>::Impl> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.undef"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Type resultty);
};


class PtrGlobalOp : public Op<PtrGlobalOp, OpTrait::ZeroOperands, OpTrait::ZeroResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.global"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static const char *getGlobalNameAttrKey() { return "value"; }
  static const char *getGlobalTypeAttrKey() { return "type"; }

  Type getGlobalType() { return this->getOperation()->getAttrOfType<TypeAttr>(getGlobalTypeAttrKey()).getValue(); }
  std::string getGlobalName() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>(getGlobalNameAttrKey()).getValue().str(); }
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name,
                    Type resultty);

};

// fn name -> !ptr.void
class PtrFnPtrOp : public Op<PtrFnPtrOp, OpTrait::ZeroOperands, OpTrait::OneResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.fnptr"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static const char *getGlobalNameAttrKey() { return "value"; }
  static const char *getGlobalTypeAttrKey() { return "type"; }

  Type getGlobalType() { return this->getOperation()->getAttrOfType<TypeAttr>(getGlobalTypeAttrKey()).getValue(); }
  std::string getGlobalName() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>(getGlobalNameAttrKey()).getValue().str(); }
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name, Type fnty);

};


class PtrLoadGlobalOp : public Op<PtrLoadGlobalOp, OpTrait::OneResult, OpTrait::ZeroOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.loadglobal"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  std::string getGlobalName() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>("value").getValue().str(); }
  FlatSymbolRefAttr getGlobalNameAttr() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>("value"); }

  Type getGlobalType() { return this->getResult().getType(); }
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name,
                    Type resultty);

};


class PtrStoreGlobalOp : public Op<PtrStoreGlobalOp, OpTrait::ZeroResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.storeglobal"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  std::string getGlobalName() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>("value").getValue().str(); }
  FlatSymbolRefAttr getGlobalNameAttr() { return this->getOperation()->getAttrOfType<FlatSymbolRefAttr>("value"); }
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, Value v, std::string name);
};
/*
class PtrToHaskValueOp
    : public Op<PtrToHaskValueOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptr2haskval"; };
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value vptr);
  void print(OpAsmPrinter &p);
};
*/

/*
class HaskValueToPtrOp
    : public Op<HaskValueToPtrOp, OpTrait::OneOperand, OpTrait::OneResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.haskval2ptr"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Value v);
};
*/

/*
class PtrBranchOp : 
  public Op<PtrBranchOp, OpTrait::VariadicOperands, 
      OpTrait::IsTerminator, OpTrait::ZeroResult, OpTrait::OneSuccessor> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.br"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, 
    mlir::Block *next, mlir::ValueRange args);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, 
    mlir::Block *next, llvm::ArrayRef<Value> &args);

};
*/

class PtrUnreachableOp : 
  public Op<PtrUnreachableOp, OpTrait::IsTerminator, OpTrait::ZeroResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.unreachable"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state);

};

// this is for lean, which uses i8's everywhere but still wants a negation operation..
class PtrNotOp : 
  public Op<PtrNotOp, OpTrait::OneOperand, OpTrait::OneResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.not"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state, Value v);

};

class PtrLoadArrayOp : public Op<PtrLoadArrayOp, OpTrait::OneResult, OpTrait::NOperands<2>::Impl> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.loadarray"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  Value getArray() { return this->getOperand(0); }
  Value getIx() { return this->getOperand(1); }
  void build(mlir::OpBuilder &builder, mlir::OperationState &state, Value arr, Value ix);
};


void registerLowerPointerPass();

}; // namespace ptr
}; // namespace mlir
