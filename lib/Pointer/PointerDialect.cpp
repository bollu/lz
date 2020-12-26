//===- PtrDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Pointer/PointerDialect.h"
#include "Pointer/PointerOps.h"

// includes
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/TypeSupport.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

// dilect lowering
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Conversion/AffineToStandard/AffineToStandard.h"
#include "mlir/Conversion/SCFToStandard/SCFToStandard.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

using namespace mlir;
using namespace mlir::ptr;

bool PtrType::classof(Type type) {
  return llvm::isa<PtrDialect>(type.getDialect());
}

PtrDialect &PtrType::getDialect() {
  return static_cast<PtrDialect &>(Type::getDialect());
}
PtrDialect::PtrDialect(mlir::MLIRContext *context)
    : Dialect(getDialectNamespace(), context, TypeID::get<PtrDialect>()) {
  // clang-format off
  addOperations<PtrIntToPtrOp, PtrPtrToIntOp, PtrStringOp, PtrFnPtrToVoidPtrOp>();
  addTypes<VoidPtrType, CharPtrType>();

  // clang-format on
}

mlir::Type PtrDialect::parseType(mlir::DialectAsmParser &parser) const {
  if (succeeded(parser.parseOptionalKeyword("void"))) { // !ptr.void
    return VoidPtrType::get(parser.getBuilder().getContext());
  }
  if (succeeded(parser.parseOptionalKeyword("char"))) { // !ptr.char
    return CharPtrType::get(parser.getBuilder().getContext());
  }

  return Type();
}

void PtrDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  if (type.isa<VoidPtrType>()) {
    p << "void"; // !ptr.void
    return;
  }

  if (type.isa<CharPtrType>()) {
    p << "char"; // !ptr.char
    return;
  }

  assert(false && "unknown type to print");
}

// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===
// === INT TO PTR ===

void PtrIntToPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vint) {
  assert(vint.getType().isa<IntegerType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void PtrIntToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===

void PtrFnPtrToVoidPtrOp::build(mlir::OpBuilder &builder,
                                mlir::OperationState &state, Value vint) {
  assert(vint.getType().isa<FunctionType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void PtrFnPtrToVoidPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===

void PtrPtrToIntOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vptr, IntegerType ity) {
  assert(vptr.getType().isa<VoidPtrType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(ity);
};

void PtrPtrToIntOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === STRING OP ===
// === STRING OP ===
// === STRING OP ===
// === STRING OP ===
// === STRING OP ===

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        const char *str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        std::string str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        llvm::StringRef str) {
  state.addAttribute("value", builder.getStringAttr(str));
  state.addTypes(CharPtrType::get(builder.getContext()));
};

void PtrStringOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

class PtrTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  PtrTypeConverter(MLIRContext *ctx) {
    // Convert ThunkType to I8PtrTy.
    // addConversion([](ThunkType type) -> Type {
    //   return LLVM::LLVMType::getInt8PtrTy(type.getContext());
    // });

    addConversion([](Type type) { return type; });
  };
};

struct LowerPointerPass : public Pass {
  LowerPointerPass() : Pass(mlir::TypeID::get<LowerPointerPass>()){};
  StringRef getName() const override { return "LowerPointer"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerPointerPass>(
        *static_cast<const LowerPointerPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    LLVMConversionTarget target(getContext());
    // ConversionTarget target(getContext());
    target.addIllegalDialect<PtrDialect>();
    target.addLegalDialect<LLVM::LLVMDialect>();
    target.addLegalDialect<StandardOpsDialect>();
    PtrTypeConverter typeConverter(&getContext());

    // HaskTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;

    // // OK why is it not able to legalize func? x(
    // populateAffineToStdConversionPatterns(patterns, &getContext());
    // populateLoopToStdConversionPatterns(patterns, &getContext());
    // populateStdToLLVMConversionPatterns(typeConverter, patterns);

    // patterns.insert<ForceOpConversionPattern>(typeConverter,
    // &getContext()); patterns.insert<CaseOpConversionPattern>(typeConverter,
    // &getContext());
    // patterns.insert<HaskConstructOpConversionPattern>(typeConverter,
    //                                                   &getContext());
    // patterns.insert<ConstantOpLowering>(typeConverter, &getContext());
    // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
    // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());

    // patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<ApEagerOpConversionPattern>(typeConverter,
    // &getContext());
    // patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
    //                                                &getContext());
    ::llvm::DebugFlag = true;

    // applyPartialConversion | applyFullConversion
    if (failed(mlir::applyFullConversion(getOperation(), target,
                                         std::move(patterns)))) {
      llvm::errs() << "===Ptr lowering failed at Conversion===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };

    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Ptr lowering failed at Verification===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    }

    ::llvm::DebugFlag = false;
  };
};

std::unique_ptr<mlir::Pass> createLowerPointerPass() {
  return std::make_unique<LowerPointerPass>();
}

void ptr::registerLowerPointerPass() {
  ::mlir::registerPass("ptr-lower", "Perform lowering of ptr to std+llvm",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLowerPointerPass();
                       });
}
