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

class VoidPtrType : public mlir::Type::TypeBase<VoidPtrType, PtrType, TypeStorage> {
public:
  using Base::Base;
  static VoidPtrType get(MLIRContext *context) { return Base::get(context); }
};

}; // namespace grin
}; // namespace mlir
