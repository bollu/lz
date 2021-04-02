#pragma once
#include "mlir/IR/Dialect.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/InliningUtils.h"
#include <llvm/ADT/ArrayRef.h>

namespace mlir {
namespace unif {

class UnificationDialect : public mlir::Dialect {
public:
  explicit UnificationDialect(mlir::MLIRContext *ctx);
  mlir::Type parseType(mlir::DialectAsmParser &parser) const override;
  void printType(mlir::Type type,
                 mlir::DialectAsmPrinter &printer) const override;
  static llvm::StringRef getDialectNamespace() { return "unif"; }
};

class UnifType : public Type {
public:
  /// Inherit base constructors.
  using Type::Type;

  /// Support for UnificationLikeTypeTraits.
  using Type::getAsOpaquePointer;
  static UnifType getFromOpaquePointer(const void *ptr) {
    return UnifType(static_cast<ImplType *>(const_cast<void *>(ptr)));
  }
  /// Support for isa/cast.
  static bool classof(Type type);
  UnificationDialect &getDialect();
};

class UnifNodeType
    : public mlir::Type::TypeBase<UnifNodeType, UnifType, TypeStorage> {
public:
  using Base::Base;
  static UnifNodeType get(MLIRContext *context) { return Base::get(context); }
};

}; // namespace unif
}; // namespace mlir
