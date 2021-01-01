#pragma once
#include "mlir/IR/Dialect.h"
#include "mlir/IR/StandardTypes.h"
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

class VoidPtrType
    : public mlir::Type::TypeBase<VoidPtrType, PtrType, TypeStorage> {
public:
  using Base::Base;
  static VoidPtrType get(MLIRContext *context) { return Base::get(context); }
};

class CharPtrType
    : public mlir::Type::TypeBase<CharPtrType, PtrType, TypeStorage> {
public:
  using Base::Base;
  static CharPtrType get(MLIRContext *context) { return Base::get(context); }
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

// ptr.string "string-I-like"
class PtrStringOp
    : public Op<PtrStringOp, OpTrait::OneResult, OpTrait::ZeroOperands> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.string"; };
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
                    Value vint);
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


class PtrUndefOp : public Op<PtrUndefOp, OpTrait::OneResult> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.undef"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
  static void build(mlir::OpBuilder &builder, mlir::OperationState &state,
                    Type resultty);
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

void registerLowerPointerPass();

}; // namespace ptr
}; // namespace mlir
