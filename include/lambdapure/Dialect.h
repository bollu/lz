#ifndef LAMBDAPURE_DIALECT_H_
#define LAMBDAPURE_DIALECT_H_

#include "mlir/IR/Dialect.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

namespace mlir {
// include generated ops file
#define GET_OP_CLASSES

#include "lambdapure/Ops.h.inc"

namespace lambdapure {

class LambdapureDialect : public mlir::Dialect {
public:
  explicit LambdapureDialect(mlir::MLIRContext *ctx);

  /// Provide a utility accessor to the dialect namespace. This is used by
  /// several utilities for casting between dialects.
  static llvm::StringRef getDialectNamespace() { return "lambdapure"; }

  mlir::Type parseType(mlir::DialectAsmParser &parser) const override;
  void printType(mlir::Type type,
                 mlir::DialectAsmPrinter &printer) const override;
};

class ObjectType
    : public mlir::Type::TypeBase<ObjectType, mlir::Type, TypeStorage> {
public:
  /// Inherit some necessary constructors from 'TypeBase'.
  using Base::Base;
  static ObjectType get(MLIRContext *context) { return Base::get(context); }
};

} // namespace lambdapure
} // namespace mlir

#endif // LAMBDAPURE_DIALECT_H_
