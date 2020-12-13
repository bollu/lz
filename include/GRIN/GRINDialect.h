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
  void printType(mlir::Type type, mlir::DialectAsmPrinter &printer) const override;
  mlir::Attribute parseAttribute(mlir::DialectAsmParser &parser, Type type) const override;
  void printAttribute(Attribute attr, DialectAsmPrinter &printer) const override;
  static llvm::StringRef getDialectNamespace() { return "grn"; }
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

class BoxType
    : public mlir::Type::TypeBase<BoxType, GRINType, TypeStorage> {
public:
  using Base::Base;
  static BoxType get(MLIRContext *context) { return Base::get(context); }
};

class HeapNodeType
    : public mlir::Type::TypeBase<HeapNodeType, GRINType, TypeStorage> {
public:
  using Base::Base;
  static HeapNodeType get(MLIRContext *context) { return Base::get(context); }
};

};
};
