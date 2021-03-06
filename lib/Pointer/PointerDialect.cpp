//===- PtrDialect.cpp - Hask dialect ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Pointer/PointerDialect.h"
#include "Hask/HaskOps.h"
#include "Hask/HaskDialect.h"
#include "Pointer/PointerOps.h"

// includes
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
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

IntegerType getInt8Ty(MLIRContext *ctx) { return IntegerType::get(ctx, 8); }

IntegerType getInt64Ty(MLIRContext *ctx) { return IntegerType::get(ctx, 64); }

LLVM::LLVMPointerType getInt8PtrTy(MLIRContext *ctx) {
  return LLVM::LLVMPointerType::get(getInt8Ty(ctx));
}

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
  // addOperations<PtrToHaskValueOp> 
  // addOperations<HaskValueToPtrOp>();
  // addOperations<PtrBranchOp>(); 
  addOperations<PtrToMemrefOp>();
  addOperations<DoubleToPtrOp>();
  addOperations<MemrefToVoidPtrOp>();
  addOperations<PtrToFloatOp>();
  addOperations<PtrGlobalOp>();
  addOperations<PtrLoadGlobalOp>();
  addOperations<PtrFnPtrOp>();
  addOperations<PtrStoreGlobalOp>();
  addOperations<PtrUnreachableOp>();
  addOperations<PtrNotOp>();
  addOperations<PtrLoadArrayOp>();
  // addTypes<VoidPtrType, CharPtrType>();
  addTypes<PtrArrayType>();

  // clang-format on
}

mlir::Type PtrDialect::parseType(mlir::DialectAsmParser &parser) const {
  // if (succeeded(parser.parseOptionalKeyword("void"))) { // !ptr.void
  //   return VoidPtrType::get(parser.getBuilder().getContext());
  // }
  // if (succeeded(parser.parseOptionalKeyword("char"))) { // !ptr.char
  //   return CharPtrType::get(parser.getBuilder().getContext());
  // }


  if (succeeded(parser.parseOptionalKeyword("array"))) {
    return PtrArrayType::get(parser.getBuilder().getContext());
    // Type elem;
    // if (parser.parseLess() || parser.parseType(elem) || parser.parseGreater()) {
    //   assert(false && "unable to parse array type for ptr dialect");
    // }
    // return PtrArrayType::get(parser.getBuilder().getContext(), elem);
  }

  assert(false && "this dialect has no types");
  return Type();
}

void PtrDialect::printType(mlir::Type type, mlir::DialectAsmPrinter &p) const {
  // if (type.isa<VoidPtrType>()) {
  //   p << "void"; // !ptr.void
  //   return;
  // }

  // if (type.isa<CharPtrType>()) {
  //   p << "char"; // !ptr.char
  //   return;
  // }

  if (type.isa<PtrArrayType>()) {
    p << "arraay"; // !ptr.array
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
  state.addTypes(standalone::ValueType::get(builder.getContext()));
};

void IntToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === DOUBLE TO PTR ===
// === DOUBLE TO PTR ===
// === DOUBLE TO PTR ===
// === DOUBLE TO PTR ===
// === DOUBLE TO PTR ===

void DoubleToPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value v) {
  FloatType ft = v.getType().dyn_cast<FloatType>();
  assert(ft && "expected argument to be of float type");
  state.addOperands(v);
  state.addTypes(standalone::ValueType::get(builder.getContext()));
};

void DoubleToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===
// === FNPTR TO VOID PTR ===

void FnToVoidPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value v) {
  assert(v.getType().isa<FunctionType>());
  state.addOperands(v);
  state.addTypes(standalone::ValueType::get(builder.getContext()));
};

void FnToVoidPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === MEMREF TO VOID PTR ===
// === MEMREF TO VOID PTR ===
// === MEMREF TO VOID PTR ===
// === MEMREF TO VOID PTR ===
// === MEMREF TO VOID PTR ===

void MemrefToVoidPtrOp::build(mlir::OpBuilder &builder,
                              mlir::OperationState &state, Value v) {
  assert(v.getType().isa<MemRefType>());
  state.addOperands(v);
  state.addTypes(standalone::ValueType::get(builder.getContext()));
};

void MemrefToVoidPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===
// === PTR TO INT ===

void PtrToIntOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                       Value vptr, IntegerType ity) {
  assert(vptr.getType().isa<standalone::ValueType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(ity);
};

void PtrToIntOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO FLOAT ===
// === PTR TO FLOAT ===
// === PTR TO FLOAT ===
// === PTR TO FLOAT ===
// === PTR TO FLOAT ===

void PtrToFloatOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                         Value vptr, FloatType ty) {
  assert(vptr.getType().isa<standalone::ValueType>() &&
         "expected argument to be a void pointer type");
  state.addOperands(vptr);
  state.addTypes(ty);
};

void PtrToFloatOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===
// === PTR TO MEMREF ===

void PtrToMemrefOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                          Value vptr, MemRefType mty) {
  assert(vptr.getType().isa<standalone::ValueType>() &&
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
  // state.addTypes(CharPtrType::get(builder.getContext()));
  // state.addTypes(standalone::ValueType::get(builder.getContext()));
  state.addTypes(mlir::standalone::ValueType::get(builder.getContext()));

};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        std::string str) {
  state.addAttribute("value", builder.getStringAttr(str));
  // state.addTypes(CharPtrType::get(builder.getContext()));
  // state.addTypes(standalone::ValueType::get(builder.getContext()));
  state.addTypes(mlir::standalone::ValueType::get(builder.getContext()));
};

void PtrStringOp::build(mlir::OpBuilder &builder, mlir::OperationState &state,
                        llvm::StringRef str) {
  state.addAttribute("value", builder.getStringAttr(str));
  // state.addTypes(CharPtrType::get(builder.getContext()));
  // state.addTypes(VoidPtrType::get(builder.getContext()));
  state.addTypes(mlir::standalone::ValueType::get(builder.getContext()));
};

void PtrStringOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

ParseResult PtrStringOp::parse(OpAsmParser &parser, OperationState &result) {
  StringAttr attr;
  if (parser.parseAttribute<StringAttr>(attr, "value", result.attributes)) {
    return failure();
  }

  result.addTypes(standalone::ValueType::get(parser.getBuilder().getContext()));
  return success();
}

class PtrTypeConverter : public mlir::LLVMTypeConverter {
public:
  using LLVMTypeConverter::LLVMTypeConverter;

  PtrTypeConverter(MLIRContext *ctx) : LLVMTypeConverter(ctx) {
    // !ptr.array -> i8**
    addConversion(
      [](ptr::PtrArrayType ty) { return LLVM::LLVMPointerType::get(getInt8PtrTy(ty.getContext())); });
    // !ptr.void -> i8*
    addConversion(
        [](standalone::ValueType ty) { return getInt8PtrTy(ty.getContext()); });
    // !ptr.char -> i8*
    addConversion(
        [](standalone::ValueType ty) { return getInt8PtrTy(ty.getContext()); });
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

// === GLOBAL OP ===
// === GLOBAL OP ===
// === GLOBAL OP ===
// === GLOBAL OP ===
// === GLOBAL OP ===

ParseResult PtrGlobalOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrGlobalOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrGlobalOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name,
                  Type resultty) {
    state.addAttribute(PtrGlobalOp::getGlobalTypeAttrKey(), TypeAttr::get(resultty));
    state.addAttribute(PtrGlobalOp::getGlobalNameAttrKey(), builder.getSymbolRefAttr(name));
};

// === FNPTR OP ===
// === FNPTR OP ===
// === FNPTR OP ===
// === FNPTR OP ===
// === FNPTR OP ===


ParseResult PtrFnPtrOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrFnPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrFnPtrOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name, Type fnty) {
  state.addAttribute(PtrFnPtrOp::getGlobalNameAttrKey(), builder.getSymbolRefAttr(name));
  state.addAttribute(PtrFnPtrOp::getGlobalTypeAttrKey(), TypeAttr::get(fnty));
  // state.addTypes(VoidPtrType::get(builder.getContext()));
  state.addTypes(mlir::standalone::ValueType::get(builder.getContext()));
};


// === LOAD GLOBAL OP ===
// === LOAD GLOBAL OP ===
// === LOAD GLOBAL OP ===
// === LOAD GLOBAL OP ===
// === LOAD GLOBAL OP ===

ParseResult PtrLoadGlobalOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrLoadGlobalOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrLoadGlobalOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, std::string name,
                        Type resultty) {
  state.addTypes(resultty);
  state.addAttribute("value", builder.getSymbolRefAttr(name));
};


// === STORE GLOBAL OP ===
// === STORE GLOBAL OP ===
// === STORE GLOBAL OP ===
// === STORE GLOBAL OP ===
// === STORE GLOBAL OP ===

ParseResult PtrStoreGlobalOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrStoreGlobalOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrStoreGlobalOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, Value v, std::string name) {
  state.addOperands(v);
  state.addAttribute("value", builder.getSymbolRefAttr(name));
};


// === PTR UNREACHABLE OP ===
// === PTR UNREACHABLE OP ===
// === PTR UNREACHABLE OP ===
// === PTR UNREACHABLE OP ===
// === PTR UNREACHABLE OP ===

ParseResult PtrUnreachableOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrUnreachableOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrUnreachableOp::build(mlir::OpBuilder &builder, mlir::OperationState &state) {};


// === PTR NOT OP===
// === PTR NOT OP===
// === PTR NOT OP===
// === PTR NOT OP===
// === PTR NOT OP===


ParseResult PtrNotOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrNotOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrNotOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, Value v) {
    state.addOperands(v);
};

// === PTR LOAD ARRAY OP===
// === PTR LOAD ARRAY OP===
// === PTR LOAD ARRAY OP===
// === PTR LOAD ARRAY OP===
// === PTR LOAD ARRAY OP===


ParseResult PtrLoadArrayOp::parse(OpAsmParser &parser, OperationState &result) {
  assert(false && "unimplemented");
};

void PtrLoadArrayOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};

void PtrLoadArrayOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, Value arr, Value ix) {
    state.addOperands(arr);
    state.addOperands(ix);
};



/*
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===
// === PTR TO VALUE ===

void PtrToHaskValueOp::build(mlir::OpBuilder &builder,
                             mlir::OperationState &state, Value vptr) {
  state.addOperands(vptr);
  state.addTypes(standalone::ValueType::get(builder.getContext()));
};

void PtrToHaskValueOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};
*/

// === VALUE TO PTR OP===
// === VALUE TO PTR OP===
// === VALUE TO PTR OP===
// === VALUE TO PTR OP===
// === VALUE TO PTR OP===
/*
ParseResult HaskValueToPtrOp::parse(OpAsmParser &parser,
                                    OperationState &result) {
  OpAsmParser::OperandType rand; // ope'rand
  if (parser.parseOperand(rand) ||
      parser.resolveOperand(rand,
                            standalone::ValueType::get(parser.getBuilder().getContext()),
                            result.operands)) {
    return failure();
  }
  result.addTypes(ptr::VoidPtrType::get(parser.getBuilder().getContext()));
  return success();
};

void HaskValueToPtrOp::build(mlir::OpBuilder &builder,
                             mlir::OperationState &state, mlir::Value v) {

  assert(v.getType().isa<standalone::ValueType>());
  state.addOperands(v);
  state.addTypes(ptr::VoidPtrType::get(builder.getContext()));
}

void HaskValueToPtrOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
};
*/


// === PTR BRANCH OP===
// === PTR BRANCH OP===
// === PTR BRANCH OP===
// === PTR BRANCH OP===
// === PTR BRANCH OP===
/*
ParseResult PtrBranchOp::parse(OpAsmParser &parser, OperationState &result) {
    assert(false && "unimplemented");
};
void PtrBranchOp::print(OpAsmPrinter &p) {
  p.printGenericOp(*this);
};

void PtrBranchOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, 
  mlir::Block *next, mlir::ValueRange args) {
  state.addOperands(args);
  state.addSuccessors(next);
};

void PtrBranchOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, 
    mlir::Block *next, llvm::ArrayRef<Value> &args) {
      state.addOperands(args);
      state.addSuccessors(next);
}
*/




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
        rator, getInt8PtrTy(fn.getContext()), fn);
    return success();
  }
};

// memref: |%13 = llvm.insertvalue %1, %12[4, 0] : !llvm.struct<(ptr<i64>,
// ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>|
struct Memref2VoidPtrLowering : public ConversionPattern {
public:
  explicit Memref2VoidPtrLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(MemrefToVoidPtrOp::getOperationName(), 1, tc,
                          context) {}

  // !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>| ->
  // !ptr.void
  static FuncOp getOrInsertBoxI64Memref(PatternRewriter &rewriter, ModuleOp m,
                                        TypeConverter &tc) {
    const std::string name = "boxI64Memref";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    // MLIRContext *context = rewriter.getContext();
    SmallVector<Type, 4> argtys;

    if (failed(tc.convertType(MemRefType::get({0}, rewriter.getI64Type()),
                              argtys))) {
      assert(false && "unable to convert memref type.");
    };
    // Type retty = ptr::VoidPtrType::get(rewriter.getContext());
    Type retty = standalone::ValueType::get(rewriter.getContext());
    FunctionType fnty = rewriter.getFunctionType(argtys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    Value memref = rands[0];
    llvm::errs() << "memref: |" << memref << "|\n";
    llvm::errs() << "memref.type: " << memref.getType() << "|\n";
    //    assert(false);
    FuncOp boxMemref = getOrInsertBoxI64Memref(rewriter, mod, *typeConverter);
    rewriter.replaceOpWithNewOp<CallOp>(rator, boxMemref, rands);
    return success();
  }
};

//   llvm.func @unboxI64Memref(!llvm.ptr<i8>) -> !llvm.struct<(ptr<i64>,
//   ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> attributes {sym_visibility
//   = "private"}
struct Ptr2MemrefOpLowering : public ConversionPattern {
public:
  explicit Ptr2MemrefOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrToMemrefOp::getOperationName(), 1, tc, context) {}

  // !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>| ->
  // !ptr.void
  static FuncOp getOrInsertUnboxI64Memref(PatternRewriter &rewriter, ModuleOp m,
                                          TypeConverter &tc) {
    const std::string name = "unboxI64Memref";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    // MLIRContext *context = rewriter.getContext();

    // Type argty = ptr::VoidPtrType::get(rewriter.getContext());
    Type argty = standalone::ValueType::get(rewriter.getContext());
    Type retty = tc.convertType(MemRefType::get({0}, rewriter.getI64Type()));
    assert(retty);

    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    FuncOp unboxfn = getOrInsertUnboxI64Memref(rewriter, mod, *typeConverter);
    rewriter.replaceOpWithNewOp<CallOp>(rator, unboxfn, rands);
    return success();
  }
};

struct StringOpLowering : public ConversionPattern {
public:
  static Value getOrCreateGlobalString(Location loc, OpBuilder &builder,
                                       StringRef name, StringAttr strattr,
                                       ModuleOp module) {
    // Create the global at the entry of the module.
    LLVM::GlobalOp global;
    if (!(global = module.lookupSymbol<LLVM::GlobalOp>(name))) {
      OpBuilder::InsertionGuard insertGuard(builder);

      std::string str = strattr.getValue().str();

      builder.setInsertionPointToStart(module.getBody());
      auto type = LLVM::LLVMArrayType::get(getInt8Ty(builder.getContext()),
                                           str.size() + 1);
      global = builder.create<LLVM::GlobalOp>(
          loc, type, true, LLVM::Linkage::Internal, name,
          builder.getStringAttr(StringRef(str.c_str(), str.size() + 1)));
    }

    // Get the pointer to the first character in the global string.
    Value globalPtr = builder.create<LLVM::AddressOfOp>(loc, global);
    Value cst0 = builder.create<LLVM::ConstantOp>(
        loc, getInt64Ty(builder.getContext()),
        builder.getIntegerAttr(builder.getIndexType(), 0));
    return builder.create<LLVM::GEPOp>(loc, getInt8PtrTy(builder.getContext()),
                                       globalPtr,
                                       ArrayRef<Value>({cst0, cst0}));
  }

  explicit StringOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrStringOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    StringAttr str = rator->getAttrOfType<StringAttr>("value");
    mlir::ModuleOp mod = rator->getParentOfType<ModuleOp>();
    // create a new name for the string. Otherwise we could have something like:
    // func @foo {
    // %x = str "foo"
   //}

    // which will lower to:
    // @foo = "foo"
    // func @foo {...}

    // which is of course illegal.
    // Jesus fuck MLIR is stupid.
    Value v = getOrCreateGlobalString(rator->getLoc(), rewriter, "g_str_" + str.getValue().str(),
                                      str, mod);
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
        rator, getInt8PtrTy(rator->getContext()), i);
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
    // LLVM::LLVMType retty =
    //     typeConverter->convertType(rator->getResult(0).getType())
    //         .cast<LLVM::LLVMType>();
    IntegerType retty =
        typeConverter->convertType(rator->getResult(0).getType())
            .cast<IntegerType>();
    rewriter.replaceOpWithNewOp<LLVM::PtrToIntOp>(rator, retty, ptr);
    return success();
  }
};

struct DoubleToPtrOpLowering : public ConversionPattern {
public:
  explicit DoubleToPtrOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(DoubleToPtrOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    Value i = rands[0];
    rewriter.replaceOpWithNewOp<LLVM::BitcastOp>(
        rator, getInt8PtrTy(rator->getContext()), i);
    return success();
  }
};

struct Ptr2FloatOpLowering : public ConversionPattern {
public:
  explicit Ptr2FloatOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrToFloatOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    Value ptr = rands[0];
    // LLVM::LLVMType retty =
    //     typeConverter->convertType(rator->getResult(0).getType())
    //         .cast<LLVM::LLVMType>();
    Type retty = typeConverter->convertType(rator->getResult(0).getType());
    rewriter.replaceOpWithNewOp<LLVM::BitcastOp>(rator, retty, ptr);
    return success();
  }
};

FunctionType convertFunctionType(FunctionType fnty, TypeConverter &tc,
                                 OpBuilder &builder) {
  SmallVector<Type, 4> argtys;
  for (Type t : fnty.getInputs()) {
    argtys.push_back(tc.convertType(t));
  }

  SmallVector<Type, 4> rettys;
  for (Type t : fnty.getResults()) {
    rettys.push_back(tc.convertType(t));
  }
  return builder.getFunctionType(argtys, rettys);
};

class ConstantOpLowering : public ConversionPattern {
public:
  explicit ConstantOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ConstantOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto constant = cast<ConstantOp>(rator);

    FunctionType fnty = constant.getResult().getType().dyn_cast<FunctionType>();
    assert(fnty && "was asked to lower a constant op that's not a reference to "
                   "a function?!");

    FunctionType outty = convertFunctionType(fnty, *typeConverter, rewriter);

    ConstantOp newconst = rewriter.create<ConstantOp>(constant.getLoc(), outty,
                                                      constant.getValue());
    constant.getResult().replaceAllUsesWith(newconst.getResult());
    rewriter.eraseOp(constant);

    return success();
  }
};

struct PtrLoadGlobalOpLowering : public ConversionPattern {
public:
  explicit PtrLoadGlobalOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrLoadGlobalOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
//    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    PtrLoadGlobalOp load = cast<PtrLoadGlobalOp>(rator);
    // LLVM::GlobalOp llvmGlobal = mod.lookupSymbol<LLVM::GlobalOp>(load.getGlobalName());
      // %0 = llvm.mlir.addressof @const : !llvm.ptr<i32>
      // %1 = llvm.load %0 : !llvm.ptr<i32>
    // TODO: Do I need to create a !llvm.ptr?
    Type valty = typeConverter->convertType(load.getGlobalType());
    Type valptrty = LLVM::LLVMPointerType::get(valty);

      LLVM::AddressOfOp addr =
          rewriter.create<LLVM::AddressOfOp>(load.getLoc(),
          valptrty, load.getGlobalNameAttr());
    rewriter.replaceOpWithNewOp<LLVM::LoadOp>(rator, addr);
    return success();
  }
};

struct PtrStoreGlobalOpLowering : public ConversionPattern {
public:
  explicit PtrStoreGlobalOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrStoreGlobalOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
//    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    PtrStoreGlobalOp store = cast<PtrStoreGlobalOp>(rator);
    // LLVM::GlobalOp llvmGlobal = mod.lookupSymbol<LLVM::GlobalOp>(useglobal.getGlobalName());
    // %addr = llvm.mlir.addressof @const : !llvm.ptr<T>
    // llvm.store %addr, %val : !llvm.ptr<T>, i32
    Type valty = typeConverter->convertType(store.getOperand().getType());
    Type valptrty = LLVM::LLVMPointerType::get(valty);

    LLVM::AddressOfOp addr =
        rewriter.create<LLVM::AddressOfOp>(store.getLoc(),
                                           valptrty,
                                           store.getGlobalNameAttr());
    rewriter.replaceOpWithNewOp<LLVM::StoreOp>(rator, store.getOperand(), addr);
    return success();
  }
};

struct PtrFnPtrOpLowering : public ConversionPattern {
public:
  explicit PtrFnPtrOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrFnPtrOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PtrFnPtrOp ptr = cast<PtrFnPtrOp>(rator);


    LLVM::AddressOfOp addr = rewriter.create<LLVM::AddressOfOp>(rator->getLoc(),
                                                               typeConverter->convertType(ptr.getGlobalType()),
                                                                ptr.getGlobalName());

    // create an i8*, since our PtrFnPtrOp creates an i8*. AddressOf
    // gives us like the "real pointer" which we don't care for.
    rewriter.replaceOpWithNewOp<LLVM::BitcastOp>(rator, getInt8PtrTy(rator->getContext()), addr);
//    rewriter.replaceOpWithNewOp<ptr::FnToVoidPtrOp>(rator, addr);
    return success();
  }
};


struct PtrGlobalOpLowering : public ConversionPattern {
public:
  explicit PtrGlobalOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrGlobalOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
//    ModuleOp mod = rator->getParentOfType<ModuleOp>();
    PtrGlobalOp global = cast<PtrGlobalOp>(rator);

    // Type type, bool isConstant, Linkage linkage, StringRef name, Attribute value,
    const Attribute value;
    const bool isConstant = false;
    rewriter.replaceOpWithNewOp<LLVM::GlobalOp>(global,
                                                typeConverter->convertType(global.getGlobalType()),
                                                isConstant,
                                                LLVM::Linkage::Weak,
                                                global.getGlobalName(), value);
    return success();
  }
};

struct PtrUnreachableOpLowering : public ConversionPattern {
public:
  explicit PtrUnreachableOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrUnreachableOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PtrUnreachableOp ptr = cast<PtrUnreachableOp>(rator);
    rewriter.replaceOpWithNewOp<LLVM::UnreachableOp>(ptr);
    return success();
  }
};

struct PtrNotOpLowering : public ConversionPattern {
public:
  explicit PtrNotOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrNotOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PtrNotOp notop = cast<PtrNotOp>(rator);
    assert(rands.size() == 1);
    IntegerType ity = notop.getOperand().getType().cast<IntegerType>();
    // assert(ity.getWidth() == 8 && "expected lean to generate a NOT on a i8 because it's weird like that");
    rewriter.setInsertionPoint(notop);
    
    // llvm::errs() << "Not operand: |" << rands[0] << "|\n"; getchar();

    // x == 0 <-> !x
    Value c0 = rewriter.create<ConstantIntOp>(notop.getLoc(), 0, ity.getWidth());
    rewriter.setInsertionPointAfter(notop);
    CmpIOp cmp = rewriter.create<CmpIOp>(notop.getLoc(), CmpIPredicate::eq, rands[0], c0);
    assert(notop.getResult().getType().isa<IntegerType>() && "return type of ptr.not must be int");
    IntegerType iretty = notop.getResult().getType().cast<IntegerType>();
    //sign extend the value to the desired type.
    ZeroExtendIOp zext = rewriter.create<ZeroExtendIOp>(notop.getLoc(), cmp.getResult(), iretty);
    rewriter.replaceOp(notop, zext.getResult());
    // rewriter.eraseOp(notop);
    // rewriter.replaceOpWithNewOp<CmpIOp>(notop, 
    //         CmpIPredicate::ne, rands[0], c0);
    return success();
  }
};

struct PtrLoadArrayOpLowering : public ConversionPattern {
public:
  explicit PtrLoadArrayOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PtrLoadArrayOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PtrLoadArrayOp load = cast<PtrLoadArrayOp>(rator);
    assert(rands.size() == 2);
    rewriter.setInsertionPoint(rator);
    
    llvm::errs() << "building voidPtrTy...\n";
    Type void_ptr_ptr_ty =  LLVM::LLVMPointerType::get(getInt8PtrTy(rewriter.getContext()));
    llvm::errs() << "void_ptr_ptr_ty: |" << void_ptr_ptr_ty << "|\n";
    LLVM::GEPOp gep = rewriter.create<LLVM::GEPOp>(rator->getLoc(), void_ptr_ptr_ty, rands[0], rands[1]);
    llvm::errs() << "gep: |" << gep << "|\n";
    LLVM::LoadOp gepload = rewriter.create<LLVM::LoadOp>(rator->getLoc(), gep);
    rewriter.replaceOp(load, gepload.getResult());
    return success();
  }
};



// struct PtrBranchOpLowering : public ConversionPattern {
// public:
//   explicit PtrBranchOpLowering(TypeConverter &tc, MLIRContext *context)
//       : ConversionPattern(PtrBranchOp::getOperationName(), 1, tc, context) {}
// 
//   LogicalResult
//   matchAndRewrite(Operation *rator, ArrayRef<Value> rands,
//                   ConversionPatternRewriter &rewriter) const override {
//     PtrBranchOp ptr = cast<PtrBranchOp>(rator);
//     rewriter.replaceOpWithNewOp<LLVM::BrOp>(rator, rands, ptr.getSuccessor());
//     return success();
//   }
// };


/*
//
https://github.com/spcl/open-earth-compiler/blob/master/lib/Conversion/StencilToStandard/ConvertStencilToStandard.cpp#L45
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

// I don't understand why I need this.
class CallOpLowering : public ConversionPattern {
public:
  explicit CallOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(CallOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto call = cast<CallOp>(operation);
    rewriter.replaceOpWithNewOp<CallOp>(operation, call.getCallee(),
                                        call.getResultTypes(), operands);
    return success();
  }
};
*/


bool isTypeLegal(Type t) {
  if (t.isa<ptr::PtrType>()) {
    return false;
  }
  if (auto fnty = t.dyn_cast<FunctionType>()) {

    for (Type t : fnty.getInputs()) {
      if (!isTypeLegal(t)) {
        return false;
      }
    }

    for (Type t : fnty.getResults()) {
      if (!isTypeLegal(t)) {
        return false;
      }
    }
  }
  return true;
}

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
    mlir::OwningRewritePatternList patterns(&getContext());
    populateStdToLLVMConversionPatterns(typeConverter, patterns);

    // This is wrong. We need to recursively check if function type
    // is legal.
    /*
    target.addDynamicallyLegalOp<FuncOp>(
        [](FuncOp funcOp) { return isTypeLegal(funcOp.getType()); });

    // LLVM should take care of this automatically!
    target.addDynamicallyLegalOp<ReturnOp>([](ReturnOp ret) {
      for (Value arg : ret.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }
      return true;
    });

    target.addDynamicallyLegalOp<CallOp>([](CallOp call) {
      for (Value arg : call.getOperands()) {
        if (!isTypeLegal(arg.getType())) {
          return false;
        }
      }
      return true;
    });

    target.addDynamicallyLegalOp<ConstantOp>(
        [](ConstantOp op) {
          FunctionType fnty = op.getResult().getType().dyn_cast<FunctionType>();
          if (!fnty) { return true; }
          return isTypeLegal(fnty);
        });
 */

    // // OK why is it not able to legalize func? x(
    // populateAffineToStdConversionPatterns(patterns, &getContext());
    // populateLoopToStdConversionPatterns(patterns, &getContext());

    patterns.insert<Fn2VoidPtrLowering>(typeConverter, &getContext());
    patterns.insert<Memref2VoidPtrLowering>(typeConverter, &getContext());

    //    patterns.insert<CallOpLowering>(typeConverter, &getContext());

    patterns.insert<StringOpLowering>(typeConverter, &getContext());
    patterns.insert<Int2PtrOpLowering>(typeConverter, &getContext());
    patterns.insert<DoubleToPtrOpLowering>(typeConverter, &getContext());

    patterns.insert<Ptr2IntOpLowering>(typeConverter, &getContext());
    patterns.insert<Ptr2FloatOpLowering>(typeConverter, &getContext());

    // vvv yuge hack.
    // patterns.insert<PtrUndefOpLowering>(typeConverter, &getContext());
    patterns.insert<Ptr2MemrefOpLowering>(typeConverter, &getContext());

    patterns.insert<PtrLoadGlobalOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrStoreGlobalOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrGlobalOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrFnPtrOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrUnreachableOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrNotOpLowering>(typeConverter, &getContext());
    patterns.insert<PtrLoadArrayOpLowering>(typeConverter, &getContext());

    // patterns.insert<PtrBranchOpLowering>(typeConverter, &getContext());


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

    ModuleOp mod = mlir::cast<ModuleOp>(getOperation());

    // ::llvm::DebugFlag = true;
    // applyPartialConversion | applyFullConversion
    if (failed(mlir::applyFullConversion(mod, target, std::move(patterns)))) {
      llvm::errs() << "===Ptr lowering failed at Conversion===\n";
      // getOperation()->print(llvm::errs());
      // llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
    };

    if (failed(mod.verify())) {
      llvm::errs() << "===Ptr lowering failed at Verification===\n";
      // getOperation()->print(llvm::errs());
      // llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
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
