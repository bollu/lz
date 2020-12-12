#pragma once

#include "mlir/IR/Dialect.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/InliningUtils.h"
#include <llvm/ADT/ArrayRef.h>

namespace mlir {
namespace grin {

class GRINDialect : public mlir::Dialect {
public:
  explicit GRINDialect(mlir::MLIRContext *ctx);
  mlir::Type parseType(mlir::DialectAsmParser &parser) const override;
  void printType(mlir::Type type,
                 mlir::DialectAsmPrinter &printer) const override;
  mlir::Attribute parseAttribute(mlir::DialectAsmParser &parser,
                                 Type type) const override;
  void printAttribute(Attribute attr,
                      DialectAsmPrinter &printer) const override;
  static llvm::StringRef getDialectNamespace() { return "lz"; }
  static llvm::StringRef getReturnTypeAttributeKey() { return "retty"; }
  static bool isFunctionRecursive(FuncOp);
};

class GRINType : public Type {
public:
  /// Inherit base constructors.
  using Type::Type;

  /// Support for PointerLikeTypeTraits.
  using Type::getAsOpaquePointer;
  static GRINType getFromOpaquePointer(const void *ptr) {
    return GRINType(static_cast<ImplType *>(const_cast<void *>(ptr)));
  }
  /// Support for isa/cast.
  static bool classof(Type type);
  GRINDialect &getDialect();
};

class ValueType
    : public mlir::Type::TypeBase<ValueType, GRINType, TypeStorage> {
public:
  using Base::Base;
  static ValueType get(MLIRContext *context) { return Base::get(context); }
};

struct ThunkTypeStorage : public TypeStorage {
  ThunkTypeStorage(ArrayRef<Type> const t) : t(t) {}

  /// The hash key used for uniquing.
  using KeyTy = ArrayRef<Type>;
  bool operator==(const KeyTy &key) const { return key == t; }

  /// Construction.
  static ThunkTypeStorage *construct(TypeStorageAllocator &allocator,
                                     const KeyTy &key) {
    return new (allocator.allocate<ThunkTypeStorage>())
        ThunkTypeStorage(allocator.copyInto(key));
  }

  ArrayRef<Type> getElementType() const { return t; }
  ArrayRef<Type> const t;
};

class ThunkType
    : public mlir::Type::TypeBase<ThunkType, GRINType, ThunkTypeStorage> {
public:
  using Base::Base;
  static ThunkType get(MLIRContext *context, Type elemty) {
    return Base::get(context, elemty);
  }
  Type getElementType() { return *this->getImpl()->getElementType().data(); }
};

};
};