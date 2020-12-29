//===- PtrDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Pointer/PointerDialect.h"
#include "Hask/HaskOps.h"
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
  addOperations<IntToPtrOp, PtrToIntOp, PtrStringOp, FnToVoidPtrOp, PtrUndefOp>();
  addOperations<PtrToMemrefOp>();
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

void IntToPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       Value vint) {
  assert(vint.getType().isa<IntegerType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void IntToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===

void FnToVoidPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vint) {
  assert(vint.getType().isa<FunctionType>());
  state.addOperands(vint);
  state.addTypes(VoidPtrType::get(builder.getContext()));
};

void FnToVoidPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===

void PtrToIntOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       Value vptr, IntegerType ity) {
  assert(vptr.getType().isa<VoidPtrType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(ity);
};

void PtrToIntOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===

void PtrToMemrefOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vptr, MemRefType mty) {
  assert(vptr.getType().isa<VoidPtrType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(mty);
};

void PtrToMemrefOp::print(OpAsmPrinter &p) {
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

class PtrTypeConverter : public mlir::LLVMTypeConverter {
public:
  using LLVMTypeConverter::LLVMTypeConverter;

  PtrTypeConverter(MLIRContext *ctx) : LLVMTypeConverter(ctx) {
    // !ptr.void -> i8*
    addConversion([](ptr::VoidPtrType ty) {
      LLVM::LLVMType i8 = LLVM::LLVMType::getInt8Ty(ty.getContext());
      return LLVM::LLVMPointerType::get(i8);
    });
    // !ptr.char -> i8*
    addConversion([](ptr::CharPtrType ty) {
      LLVM::LLVMType i8 = LLVM::LLVMType::getInt8Ty(ty.getContext());
      return LLVM::LLVMPointerType::get(i8);
    });
  };
};
// === UNDEF OP ===
// === UNDEF OP ===
// === UNDEF OP ===
// === UNDEF OP ===
// === UNDEF OP ===

ParseResult PtrUndefOp::parse(OpAsmParser &parser, OperationState &result) {
  mlir::Type retty;
  if (parser.parseColonType(retty)) {
    return failure();
  };
  result.addTypes(retty);
  return success();
};

void PtrUndefOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrUndefOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       Type retty) {
  state.addTypes(retty);
}

// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===

struct Fn2VoidPtrLowering : public ConversionPattern {
public:
  explicit Fn2VoidPtrLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(FnToVoidPtrOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    Value fn = rands[0];
    rewriter.replaceOpWithNewOp<LLVM::BitcastOp>(
        rator, LLVM::LLVMType::getInt8PtrTy(fn.getContext()), fn);
    return success();
  }
};

struct StringOpLowering : public ConversionPattern {
public:
  static Value getOrCreateGlobalString(Location loc, OpBuilder &builder,
                                       StringRef name, StringRef value,
                                       ModuleOp module) {
    // Create the global at the entry of the module.
    LLVM::GlobalOp global;
    if (!(global = module.lookupSymbol<LLVM::GlobalOp>(name))) {
      OpBuilder::InsertionGuard insertGuard(builder);
      builder.setInsertionPointToStart(module.getBody());
      auto type = LLVM::LLVMType::getArrayTy(
          LLVM::LLVMType::getInt8Ty(builder.getContext()), value.size());
      global = builder.create<LLVM::GlobalOp>(loc, type, true,
                                              LLVM::Linkage::Internal, name,
                                              builder.getStringAttr(value));
    }

    // Get the pointer to the first character in the global string.
    Value globalPtr = builder.create<LLVM::AddressOfOp>(loc, global);
    Value cst0 = builder.create<LLVM::ConstantOp>(
        loc, LLVM::LLVMType::getInt64Ty(builder.getContext()),
        builder.getIntegerAttr(builder.getIndexType(), 0));
    return builder.create<LLVM::GEPOp>(
        loc, LLVM::LLVMType::getInt8PtrTy(builder.getContext()), globalPtr,
        ArrayRef<Value>({cst0, cst0}));
  }

  explicit StringOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrStringOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    StringAttr str = rator->getAttrOfType<StringAttr>("value");
    mlir::ModuleOp mod = rator->getParentOfType<ModuleOp>();
    Value v = getOrCreateGlobalString(rator->getLoc(), rewriter, str.getValue(),
                                      str.getValue(), mod);
    rewriter.replaceOp(rator, v);
    return success();
  }
};

struct Int2PtrOpLowering : public ConversionPattern {
public:
  explicit Int2PtrOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(IntToPtrOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    Value i = rands[0];
    rewriter.replaceOpWithNewOp<LLVM::IntToPtrOp>(
        rator, LLVM::LLVMType::getInt8PtrTy(rator->getContext()), i);
    return success();
  }
};

struct Ptr2IntOpLowering : public ConversionPattern {
public:
  explicit Ptr2IntOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrToIntOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    Value ptr = rands[0];
    LLVM::LLVMType retty =
        typeConverter->convertType(rator->getResult(0).getType())
            .cast<LLVM::LLVMType>();
    rewriter.replaceOpWithNewOp<LLVM::PtrToIntOp>(rator, retty, ptr);
    return success();
  }
};

// https://github.com/spcl/open-earth-compiler/blob/master/lib/Conversion/StencilToStandard/ConvertStencilToStandard.cpp#L45
class FuncOpLowering : public ConversionPattern {
public:
  explicit FuncOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(FuncOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = operation->getLoc();
    auto funcOp = cast<FuncOp>(operation);

    TypeConverter::SignatureConversion inputs(funcOp.getNumArguments());
    for (auto &en : llvm::enumerate(funcOp.getType().getInputs()))
      inputs.addInputs(en.index(), typeConverter->convertType(en.value()));

    TypeConverter::SignatureConversion results(funcOp.getNumResults());
    for (auto &en : llvm::enumerate(funcOp.getType().getResults()))
      results.addInputs(en.index(), typeConverter->convertType(en.value()));

    auto funcType =
        FunctionType::get(inputs.getConvertedTypes(),
                          results.getConvertedTypes(), funcOp.getContext());

    auto newFuncOp = rewriter.create<FuncOp>(loc, funcOp.getName(), funcType);
    // vvvv SHOOT ME PLEASE.
    // The problem is that I can't copy *all* attributes, because Type
    // is also an attribute x(.

    if (Attribute visibility = funcOp.getAttr("sym_visibility")) {
      newFuncOp.setAttr("sym_visibility", visibility);
    }
    // newFuncOp.setAttrs(funcOp.getAttrs());
    rewriter.inlineRegionBefore(funcOp.getBody(), newFuncOp.getBody(),
                                newFuncOp.end());

    if (failed(rewriter.convertRegionTypes(&newFuncOp.getBody(), *typeConverter,
                                           &inputs))) {
      assert(false && "unable to convert the function's region");
      return failure();
    }
    rewriter.eraseOp(funcOp);

    return success();
  }
};

class ReturnOpLowering : public ConversionPattern {
public:
  explicit ReturnOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ReturnOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto loc = operation->getLoc();
    rewriter.create<ReturnOp>(loc, operands);
    rewriter.eraseOp(operation);
    return success();
  }
};

class PtrUndefOpLowering : public ConversionPattern {
public:
  explicit PtrUndefOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ptr::PtrUndefOp::getOperationName(), 1, tc, context) {
  }

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto undef = mlir::cast<ptr::PtrUndefOp>(operation);
    // vvv LLVM ops can only have LLVM types. *eye roll*
    rewriter.replaceOpWithNewOp<LLVM::UndefOp>(
        undef, typeConverter->convertType(undef.getType()));
    return success();
  }
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
    // target.addLegalDialect<StandardOpsDialect>();

    target.addLegalOp<ModuleOp, ModuleTerminatorOp>();

    PtrTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;
    populateStdToLLVMConversionPatterns(typeConverter, patterns);

    // // OK why is it not able to legalize func? x(
    // populateAffineToStdConversionPatterns(patterns, &getContext());
    // populateLoopToStdConversionPatterns(patterns, &getContext());

    patterns.insert<Fn2VoidPtrLowering>(typeConverter, &getContext());
    patterns.insert<StringOpLowering>(typeConverter, &getContext());
    patterns.insert<Int2PtrOpLowering>(typeConverter, &getContext());
    patterns.insert<Ptr2IntOpLowering>(typeConverter, &getContext());
    // vvv yuge hack.
    patterns.insert<PtrUndefOpLowering>(typeConverter, &getContext());
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

    ModuleOp mod = mlir::cast<ModuleOp>(getOperation());

    // applyPartialConversion | applyFullConversion
    if (failed(mlir::applyFullConversion(mod, target, std::move(patterns)))) {
      llvm::errs() << "===Ptr lowering failed at Conversion===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };

    if (failed(mod.verify())) {
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
