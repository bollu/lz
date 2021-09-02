//===- HaskToLLVM.cpp - Hask dialect conversion ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Pointer/PointerDialect.h"
#include "RgnDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Block.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/Types.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"

#include <mlir/Parser.h>
#include <sstream>

// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/BuiltinTypes.h"

// pattern matching
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"

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

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

// library.ll
// define nonnull %struct.lean_object* @lean_box(i64 %0) local_unnamed_addr #0 {

// https://github.com/llvm/llvm-project/blob/a048e2fa1d0285a3582bd224d5652dbf1dc91cb4/mlir/examples/toy/Ch6/mlir/LowerToLLVM.cpp
// https://github.com/llvm/llvm-project/blob/706d992cedaf2ca3190e4445015da62faf2db544/mlir/lib/Conversion/StandardToLLVM/StandardToLLVM.cpp

namespace mlir {
namespace standalone {

namespace {

/*
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
 */

// class HaskTypeConverter : public mlir::LLVMTypeConverter {
class HaskTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  HaskTypeConverter(MLIRContext *ctx) {

    addConversion([](Type type) { return type; });
  };
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
    assert(fnty && "expected function");

    FunctionType outty =
        typeConverter->convertType(fnty).dyn_cast<FunctionType>();
    assert(outty &&
           "was asked to lower a constant op that's not a reference to "
           "a function?!");

    // Anything whose legality is checked with `isDynamicallyLegal` needs to be
    // `rewrite.erase`d and then `rewriter.create`d. It seems like you can't
    // use `rewriter.replaceOpWithNewOp` for such operations.
    // vvvvv
    // create new function ref with new types
    // rewriter.replaceOpWithNewOp<ConstantOp>(constant, outty,
    //                                         constant.getValue());

    ConstantOp newconst = rewriter.create<ConstantOp>(constant.getLoc(), outty,
                                                      constant.getValue());
    constant.getResult().replaceAllUsesWith(newconst.getResult());
    rewriter.eraseOp(constant);

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
        FunctionType::get(funcOp.getContext(), inputs.getConvertedTypes(),
                          results.getConvertedTypes());

    auto newFuncOp = rewriter.create<FuncOp>(loc, funcOp.getName(), funcType);
    // vvvv SHOOT ME PLEASE.
    // The problem is that I can't copy *all* attributes, because Type
    // is also an attribute x(.

    if (Attribute visibility = funcOp->getAttr("sym_visibility")) {
      newFuncOp->setAttr("sym_visibility", visibility);
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

class ScfYieldOpLowering : public ConversionPattern {
public:
  explicit ScfYieldOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(scf::YieldOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    assert(false);
    rewriter.replaceOpWithNewOp<scf::YieldOp>(op, rands);
    assert(false);
    return success();
  }
};

class AffineYieldOpLowering : public ConversionPattern {
public:
  explicit AffineYieldOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(AffineYieldOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    rewriter.replaceOpWithNewOp<AffineYieldOp>(op, rands);
    return success();
  }
};

class HaskIntegerConstOpLowering : public ConversionPattern {
public:
  // i64 -> !ptr.void
  static FuncOp getOrCreateLeanUnsignedToNat(PatternRewriter &rewriter,
                                             ModuleOp m) {
    const std::string name = "lean_unsigned_to_nat";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = rewriter.getI32Type();
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit HaskIntegerConstOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskIntegerConstOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskIntegerConstOp op = cast<HaskIntegerConstOp>(operation);
    // I don't think this is right! It should stay

    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp fn = getOrCreateLeanUnsignedToNat(rewriter, mod);
    const int width = 32;
    Value i = rewriter.create<ConstantIntOp>(rewriter.getUnknownLoc(),
                                             op.getValue(), width);
    rewriter.replaceOpWithNewOp<CallOp>(operation, fn, i);
    return success();

    //    const int width = 64;
    //      rewriter.replaceOpWithNewOp<ConstantIntOp>(op, op.getValue(),
    //      width);
    //    return success();
  }
};

class HaskLargeIntegerConstOpLowering : public ConversionPattern {
public:
  // (str: !lz.value) -> (mpz_int: !lz.value)
  static FuncOp getOrCreateLeanCstrToNat(PatternRewriter &rewriter,
                                         ModuleOp m) {
    const std::string name = "lean_cstr_to_nat";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit HaskLargeIntegerConstOpLowering(TypeConverter &tc,
                                           MLIRContext *context)
      : ConversionPattern(HaskLargeIntegerConstOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskLargeIntegerConstOp op = cast<HaskLargeIntegerConstOp>(operation);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp fn = getOrCreateLeanCstrToNat(rewriter, mod);
    Value istr = rewriter.create<ptr::PtrStringOp>(rewriter.getUnknownLoc(),
                                                   op.getValue());
    rewriter.replaceOpWithNewOp<CallOp>(operation, fn, istr);
    return success();
  }
};

class HaskStringConstOpLowering : public ConversionPattern {
public:
  // !ptr.void -> !ptr.void
  static FuncOp getOrCreateLeanMkString(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_mk_string";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }
  explicit HaskStringConstOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskStringConstOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskStringConstOp op = cast<HaskStringConstOp>(operation);
    ModuleOp mod = op->getParentOfType<ModuleOp>();

    FuncOp lean_mk_str = getOrCreateLeanMkString(rewriter, mod);
    ptr::PtrStringOp str =
        rewriter.create<ptr::PtrStringOp>(op.getLoc(), op.getValue());
    llvm::SmallVector<Value, 1> args{str};
    rewriter.replaceOpWithNewOp<CallOp>(op, lean_mk_str, args);
    //  LitVal.str v => emit "lean_mk_string("; emit (quoteString v); emitLn
    //  ");"
    return success();
  }
};

// I don't understand why I need this.
class CallOpLowering : public ConversionPattern {
public:
  explicit CallOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskCallOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *operation, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    auto call = cast<HaskCallOp>(operation);
    SmallVector<Type, 4> resultTypes;
    if (failed(
            typeConverter->convertTypes(call->getResultTypes(), resultTypes))) {
      return failure();
    }

    CallOp newcall = rewriter.replaceOpWithNewOp<CallOp>(
        operation, call.getCallee(), resultTypes, operands);

    StringAttr musttail = call->getAttrOfType<StringAttr>("musttail");
    if (musttail) {
      newcall->setAttr("musttail", musttail);
    }
    return success();
  }
};

// I don't understand why I need this.
class CallIndirectOpLowering : public ConversionPattern {
public:
  explicit CallIndirectOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(CallIndirectOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    //    auto call = cast<CallIndirectOp>(op);
    //    typeConverter->convertTypes(call.getResultTypes(), resultTypes);
    rewriter.replaceOpWithNewOp<CallIndirectOp>(op, rands[0],
                                                rands.drop_front(1));
    llvm::errs() << "=====call indirect parent fn=====\n";
    op->getParentOfType<FuncOp>().print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n=====\n";
    return success();
  }
};

struct ForceOpConversionPattern : public mlir::ConversionPattern {
  explicit ForceOpConversionPattern(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, tc, context), tc(tc) {
  }

  HaskTypeConverter &tc;

  // !ptr.void -> !ptr.void
  static FuncOp getOrInsertEvalClosure(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "evalClosure";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    FuncOp parent = op->getParentOfType<FuncOp>();
    // ForceOp force = mlir::cast<ForceOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp evalClosure = getOrInsertEvalClosure(rewriter, mod);
    rewriter.setInsertionPointAfter(op);

    // vvv HACK: I ought not need this!
    //    SmallVector<Value, 4> args(rands.begin(), rands.end());
    rewriter.setInsertionPointAfter(op);
    // Value toForce = tc.toVoidPointer(rewriter, rands[0]);
    Value toForce;
    assert(false && "why is force in LEAN?");
    CallOp call = rewriter.create<CallOp>(op->getLoc(), evalClosure, toForce);
    rewriter.setInsertionPointAfter(call);
    // Value out = tc.fromVoidPointer(rewriter, call.getResult(0),
    //                                force.getResult().getType());
    Value out;
    assert(false && "why is force in LEAN?");
    rewriter.replaceOp(op, out);
    llvm::errs() << "vvvv--after-force---vvv\n";
    parent.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "^^^^^^^\n";
    return success();
  }
};

class HaskConstructOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit HaskConstructOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskConstructOp::getOperationName(), 1, tc, context),
        tc(tc) {}
  static FuncOp getOrInsertLeanBox(PatternRewriter &rewriter, ModuleOp module) {
    const std::string name = "lean_box";
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<mlir::Type, 4> argTys{rewriter.getI32Type()};
    mlir::Type retty = ValueType::get(rewriter.getContext());

    auto fntype = rewriter.getFunctionType(argTys, retty);
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());

    FuncOp fndecl =
        rewriter.create<FuncOp>(rewriter.getUnknownLoc(), name, fntype);

    fndecl.setPrivate();
    return fndecl;
  }

  static FuncOp getOrInsertLeanAllocCtor(PatternRewriter &rewriter,
                                         ModuleOp module) {
    const std::string name = "lean_alloc_ctor";
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<mlir::Type, 4> argTys;
    argTys.push_back(rewriter.getI32Type()); // idx
    argTys.push_back(rewriter.getI32Type()); // size/nargs
    argTys.push_back(rewriter.getI32Type()); // scalar size

    mlir::Type retty = ValueType::get(rewriter.getContext());

    auto fntype = rewriter.getFunctionType(argTys, retty);
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());

    FuncOp fndecl =
        rewriter.create<FuncOp>(rewriter.getUnknownLoc(), name, fntype);

    fndecl.setPrivate();
    return fndecl;
  }

  static FuncOp getOrInsertLeanCtorSet(PatternRewriter &rewriter,
                                       ModuleOp module) {
    const std::string name = "lean_ctor_set";
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<mlir::Type, 4> argTys;
    argTys.push_back(ValueType::get(rewriter.getContext())); // ctor
    argTys.push_back(rewriter.getI32Type());                 // ix
    argTys.push_back(ValueType::get(rewriter.getContext())); // val

    mlir::Type retty = ValueType::get(rewriter.getContext());

    auto fntype = rewriter.getFunctionType(argTys, retty);
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());

    FuncOp fndecl =
        rewriter.create<FuncOp>(rewriter.getUnknownLoc(), name, fntype);

    fndecl.setPrivate();
    return fndecl;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    const int width = 32;
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    HaskConstructOp cons = cast<HaskConstructOp>(op);
    std::string name = cons.getDataConstructorName().str();
    assert(std::to_string(atoi(name.c_str())) == name);

    if (operands.size() == 0) {
      FuncOp box = getOrInsertLeanBox(rewriter, mod);
      ConstantIntOp allocIx = rewriter.create<ConstantIntOp>(
          cons->getLoc(), atoi(name.c_str()), width);
      mlir::SmallVector<Value, 1> boxArgs{allocIx};
      CallOp callBox = rewriter.create<CallOp>(cons->getLoc(), box, boxArgs);
      rewriter.replaceOp(cons, callBox.getResult(0));
      return success();
    }

    assert(operands.size() > 0);
    FuncOp alloc = getOrInsertLeanAllocCtor(rewriter, mod);
    // TODO: fix this mess; just store int indexes.

    ConstantIntOp allocIx = rewriter.create<ConstantIntOp>(
        cons->getLoc(), atoi(name.c_str()), width);
    ConstantIntOp allocNumArgs =
        rewriter.create<ConstantIntOp>(cons->getLoc(), operands.size(), width);
    // TODO: what is size?
    ConstantIntOp allocSz =
        rewriter.create<ConstantIntOp>(cons->getLoc(), cons.getSize(), width);
    mlir::SmallVector<Value, 3> allocArgs{allocIx, allocNumArgs, allocSz};
    CallOp callAlloc =
        rewriter.create<CallOp>(cons->getLoc(), alloc, allocArgs);
    Value out = callAlloc.getResult(0);

    FuncOp set = getOrInsertLeanCtorSet(rewriter, mod);
    for (int i = 0; i < (int)operands.size(); ++i) {
      ConstantIntOp ix =
          rewriter.create<ConstantIntOp>(cons->getLoc(), i, width);
      mlir::SmallVector<Value, 4> setArgs{out, ix, operands[i]};
      rewriter.create<CallOp>(cons->getLoc(), set, setArgs);
    }
    rewriter.replaceOp(cons, out);
    return success();
  }
};

class ProjectionOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit ProjectionOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ProjectionOp::getOperationName(), 1, tc, context),
        tc(tc) {}

  static FuncOp getOrInsertLeanCtorGet(PatternRewriter &rewriter,
                                       ModuleOp module) {

    const std::string name = "lean_ctor_get";
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    SmallVector<mlir::Type, 4> argTys;
    argTys.push_back(ValueType::get(rewriter.getContext()));
    argTys.push_back(IntegerType::get(rewriter.getContext(), 32));

    mlir::Type retty = ValueType::get(rewriter.getContext());
    auto fntype = rewriter.getFunctionType(argTys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());

    FuncOp fndecl =
        rewriter.create<FuncOp>(rewriter.getUnknownLoc(), name, fntype);

    fndecl.setPrivate();
    return fndecl;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    ProjectionOp proj = cast<ProjectionOp>(op);
    // ModuleOp mod = cons.getParentOfType<ModuleOp>();

    FuncOp fn =
        getOrInsertLeanCtorGet(rewriter, op->getParentOfType<ModuleOp>());

    rewriter.setInsertionPoint(proj);
    Value ix = rewriter.create<ConstantIntOp>(
        rewriter.getUnknownLoc(), proj.getIndex(), rewriter.getI32Type());
    SmallVector<Value, 4> args = {proj.getOperand(), ix};

    rewriter.replaceOpWithNewOp<CallOp>(proj, fn, args);
    return success();
  }
};

class ThunkifyOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit ThunkifyOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ThunkifyOp::getOperationName(), 1, tc, context),
        tc(tc) {}
  // !ptr.void -> !ptr.void
  static FuncOp getOrInsertMkClosureThunkify(PatternRewriter &rewriter,
                                             ModuleOp m) {
    const std::string name = "mkClosure_thunkify";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    Type retty = ValueType::get(context);
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
    // Value param = tc.toVoidPointer(rewriter, rands[0]);
    Value param = rands[0];
    FuncOp mkClosure = getOrInsertMkClosureThunkify(rewriter, mod);
    rewriter.replaceOpWithNewOp<CallOp>(rator, mkClosure, param);
    return success();
  }
};

class ApOpConversionPattern : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit ApOpConversionPattern(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ApOp::getOperationName(), 1, tc, context), tc(tc) {}
  // !ptr.void x [!ptr.void*n] -> !ptr.void
  // fnptr x args -> closure
  static FuncOp getOrInsertMkClosure(PatternRewriter &rewriter, ModuleOp module,
                                     int n) {
    const std::string name = "mkClosure_capture0_args" + std::to_string(n);
    if (FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *ctx = rewriter.getContext();

    // auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
    // llvm::SmallVector<LLVM::LLVMType, 4> argTys(n + 1, I8PtrTy);
    // auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
    // /*isVarArg=*/false);

    SmallVector<Type, 4> argTys;
    for (int i = 0; i < n + 1; ++i) {
      argTys.push_back(ValueType::get(ctx));
    }
    Type retty = ValueType::get(ctx);
    FunctionType fnty = rewriter.getFunctionType(argTys, retty);

    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    FuncOp fn = rewriter.create<FuncOp>(module.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApOp ap = cast<ApOp>(op);
    ModuleOp module = ap->getParentOfType<ModuleOp>();

    rewriter.setInsertionPointAfter(ap);
    SmallVector<Value, 4> args;

    // function.
    // args.push_back(tc.toVoidPointer(rewriter, rands[0]));
    args.push_back(rands[0]);

    // function arguments
    for (int i = 1; i < (int)rands.size(); ++i) {
      // args.push_back(tc.toVoidPointer(rewriter, rands[i]));
      args.push_back(rands[i]);
    }

    FuncOp mkclosure =
        getOrInsertMkClosure(rewriter, module, ap.getNumFnArguments());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, mkclosure, args);
    return success();
  }
};

class ApEagerOpConversionPattern : public ConversionPattern {
public:
  explicit ApEagerOpConversionPattern(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ApEagerOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    ApEagerOp ap = cast<ApEagerOp>(op);
    rewriter.setInsertionPointAfter(ap);

    Value fn = operands[0];
    SmallVector<Value, 4> args;
    for (int i = 1; i < (int)operands.size(); ++i) {
      args.push_back(operands[i]);
    }

    rewriter.replaceOpWithNewOp<mlir::CallIndirectOp>(ap, fn, args);
    return success();
  }
};

struct HaskReturnOpConversionPattern : public mlir::ConversionPattern {
  explicit HaskReturnOpConversionPattern(TypeConverter &tc,
                                         MLIRContext *context)
      : ConversionPattern(HaskReturnOp::getOperationName(), 1, tc, context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    HaskReturnOp ret = cast<HaskReturnOp>(op);
    // FuncOp fn = op->getParentOfType<FuncOp>();
    // llvm::errs() << "\n============\n";
    // llvm::errs() << fn;
    // llvm::errs() << "\n============\n";
    // getchar();

    rewriter.setInsertionPointAfter(ret);
    // rewriter.replaceOpWithNewOp<scf::YieldOp>(ret, operands);
    // rewriter.replaceOpWithNewOp<::mlir::ReturnOp>(ret, operands);
    rewriter.replaceOpWithNewOp<RgnReturnOp>(ret, operands);
    return success();
  }
};

class HaskJoinPointOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit HaskJoinPointOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskJoinPointOp::getOperationName(), 1, tc, context),
        tc(tc) {
    setHasBoundedRewriteRecursion();


        }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {

    HaskJoinPointOp jpOp = cast<HaskJoinPointOp>(op);

    rewriter.setInsertionPointAfter(jpOp);
    RgnValOp rgnval = rewriter.create<RgnValOp>(jpOp.getLoc());
    rewriter.inlineRegionBefore(jpOp.getLaterJumpedIntoRegion(),
      rgnval.getRegion(), rgnval.getRegion().end());

    jpOp.getFirstRegionWithJmp().walk([&](HaskJumpOp jmp) {
      rewriter.setInsertionPoint(jmp);
      if (jmp.getJoinPointId() != jpOp.getJoinPointId()) {
        return WalkResult::advance();
      }

      // Block *jumpTarget = &jpOp.getLaterJumpedIntoRegion().front();
      rewriter.setInsertionPointAfter(jmp);
      rewriter.create<RgnJumpValOp>(jmp.getLoc(), rgnval, jmp.getOperands());
      // rewriter.create<BranchOp>(jmp.getLoc(), jumpTarget, jmp.getOperands());
      rewriter.eraseOp(jmp);

      return WalkResult::advance();
    });

    rewriter.inlineRegionBefore(jpOp.getLaterJumpedIntoRegion(),
                            *jpOp->getParentRegion(),
                            jpOp->getParentRegion()->end());

    // begin --> fstRegion
    rewriter.setInsertionPointToEnd(jpOp->getBlock());
    rewriter.create<mlir::BranchOp>(jpOp->getLoc(), &jpOp.getFirstRegionWithJmp().front());

    // inline fstRegion at (begin ---> fstRegion)
    rewriter.inlineRegionBefore(jpOp.getFirstRegionWithJmp(), 
      *jpOp->getParentRegion(), jpOp->getParentRegion()->end());


    rewriter.eraseOp(jpOp);
    return success();

  }
};

/*
class HaskJumpOpLowering : public ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit HaskJumpOpLowering(HaskTypeConverter &tc, MLIRContext *context)
      : ConversionPattern(HaskJumpOp::getOperationName(), 1, tc, context),
        tc(tc) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskJumpOp jmpop = cast<HaskJumpOp>(op);
    assert(false && "jump op lowering");
    rewriter.eraseOp(jmpop);
    // rewriter.replaceOpWithNewOp<BranchOp>()
    return success();
  }
};
*/

struct AllocOpLowering : public mlir::ConversionPattern {
  explicit AllocOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::AllocOp::getOperationName(), 1, tc, context) {
  }
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    memref::AllocaOp alloc = cast<memref::AllocaOp>(op);
    rewriter.setInsertionPointAfter(alloc);
    assert(false && "I don't know what this is supposed to be");
    MemRefType memrefty =
        typeConverter->convertType(alloc.getType()).cast<MemRefType>();

    llvm::errs() << "===\n";
    llvm::errs() << "dynamicSizes.size(): " << alloc.getDynamicSizes().size()
                 << "\n";
    llvm::errs() << "getOperands.size(): " << alloc.getOperands().size()
                 << "\n";
    llvm::errs() << "rands.size(): " << rands.size() << "\n";
    llvm::errs() << "===\n";
    rewriter.replaceOpWithNewOp<memref::AllocaOp>(alloc, memrefty, rands);
    return success();
  }
};

struct StoreOpLowering : public mlir::ConversionPattern {
  explicit StoreOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::StoreOp::getOperationName(), 1, tc, context) {
  }
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    memref::StoreOp store = cast<memref::StoreOp>(op);
    rewriter.setInsertionPointAfter(store);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 3 &&
           "store needs memref, value to store, and store indeces");
    rewriter.replaceOpWithNewOp<memref::StoreOp>(store, rands[0], rands[1],
                                                 rands.drop_front(2));
    return success();
  }
};

struct LoadOpLowering : public mlir::ConversionPattern {
  explicit LoadOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(memref::LoadOp::getOperationName(), 1, tc, context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    // assert(false);
    using namespace mlir::LLVM;
    memref::LoadOp load = cast<memref::LoadOp>(op);
    rewriter.setInsertionPointAfter(load);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 2 && "oad needs memref and store indeces");
    rewriter.replaceOpWithNewOp<memref::LoadOp>(op, rands[0],
                                                rands.drop_front(1));
    return success();
  }
};

struct AffineLoadOpLowering : public mlir::ConversionPattern {
  explicit AffineLoadOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineLoadOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    // assert(false);
    using namespace mlir::LLVM;
    mlir::AffineLoadOp load = cast<mlir::AffineLoadOp>(op);
    rewriter.setInsertionPointAfter(load);
    llvm::errs() << "rands.size()|" << rands.size() << "|\n";
    assert(rands.size() >= 2 && "oad needs memref and store indeces");
    rewriter.replaceOpWithNewOp<mlir::AffineLoadOp>(op, load.getAffineMap(),
                                                    rands);
    return success();
  }
};

struct AffineStoreOpLowering : public mlir::ConversionPattern {
  explicit AffineStoreOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineStoreOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    mlir::AffineStoreOp store = cast<mlir::AffineStoreOp>(op);
    rewriter.setInsertionPointAfter(store);
    assert(rands.size() >= 3 &&
           "affine store needs memref, value to store, and store indeces");
    rewriter.replaceOpWithNewOp<mlir::AffineStoreOp>(store, rands[0], rands[1],
                                                     rands.drop_front(2));
    return success();
  }
};

struct AffineForOpLowering : public mlir::ConversionPattern {
  explicit AffineForOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(mlir::AffineForOp::getOperationName(), 1, tc,
                          context) {}
  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {

    llvm::errs() << "===FOR==\n";
    op->print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^FOR^^^\n";
    mlir::AffineForOp for_ = cast<mlir::AffineForOp>(op);
    Location loc = for_.getLoc();

    AffineMap lbMap = for_.getLowerBoundMap();
    AffineMap ubMap = for_.getUpperBoundMap();
    int step = for_.getStep();
    // Value step = rewriter.create<ConstantIndexOp>(loc, op.getStep());
    ValueRange lbOperands = for_.getLowerBoundOperands();
    ValueRange ubOperands = for_.getUpperBoundOperands();

    AffineForOp newForOp =
        rewriter.create<AffineForOp>(loc, lbOperands, lbMap, ubOperands, ubMap,
                                     step, for_.getIterOperands());
    // https://github.com/llvm/llvm-project/blob/ed23229a64aed5b9d6120d57138d475291ca3667/mlir/lib/Conversion/AffineToStandard/AffineToStandard.cpp#L360
    // WTF: why is this in the source code? o_O |
    // rewriter.eraseBlock(scfForOp.getBody())
    rewriter.eraseBlock(newForOp.getBody());

    rewriter.inlineRegionBefore(for_.region(), newForOp.region(),
                                newForOp.region().end());

    for (int i = 0; i < (int)newForOp->getNumOperands(); ++i) {
      Type t = newForOp.getOperand(i).getType();
      Type tnew = typeConverter->convertType(t);
      newForOp.getOperand(i).setType(tnew);
    }

    for (int i = 0; i < (int)newForOp.region().getNumArguments(); ++i) {
      Type t = newForOp.region().getArgument(i).getType();
      Type tnew = typeConverter->convertType(t);
      newForOp.region().getArgument(i).setType(tnew);
    }

    for (int i = 0; i < (int)newForOp->getNumResults(); ++i) {
      newForOp.getResult(i).setType(
          typeConverter->convertType(newForOp.getResult(i).getType()));
    }

    llvm::errs() << "===NEW FOR OP===\n";
    newForOp.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());

    llvm::errs() << "\n^^^^NEW FOR OP^^^^\n";

    rewriter.replaceOp(op, newForOp.results());
    return success();
  }
};

bool isTypeLegal(Type t) {
  if (t.isa<HaskType>()) {
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

  if (auto memrefty = t.dyn_cast<MemRefType>()) {
    if (!isTypeLegal(memrefty.getElementType())) {
      return false;
    }
  }
  return true;
}

template <typename T>
// bool isOpArgsAndResultsLegal(Operation op) {
bool isOpArgsAndResultsLegal(T op) {
  for (Value arg : op->getOperands()) {
    if (!isTypeLegal(arg.getType())) {
      return false;
    }
  }

  for (Value arg : op->getResults()) {
    if (!isTypeLegal(arg.getType())) {
      return false;
    }
  }
  return true;
}

// I don't know why, but OpConversionPattern just dies.
// class ErasedValueOpLowering : public OpConversionPattern<ErasedValueOp> {
struct ErasedValueOpLowering : public mlir::ConversionPattern {
public:
  // i64 -> !ptr.void
  static FuncOp getOrCreateLeanBox(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_box";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = rewriter.getI32Type();
    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit ErasedValueOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ErasedValueOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp leanbox = getOrCreateLeanBox(rewriter, mod);
    Value c0 = rewriter.create<ConstantIntOp>(rewriter.getUnknownLoc(), 0,
                                              rewriter.getI32Type());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, leanbox, c0);
    return success();
  }
};

// I don't know why, but OpConversionPattern just dies.
// class ErasedValueOpLowering : public OpConversionPattern<ErasedValueOp> {
struct TagGetOpLowering : public mlir::ConversionPattern {
public:
  explicit TagGetOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(TagGetOp::getOperationName(), 1, tc, context) {}

  static FuncOp getOrCreateLeanTag(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_obj_tag";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    // Type argty = ValueType::get(context);
    Type argty = ValueType::get(context);
    Type retty = rewriter.getI32Type();
    FunctionType fnty = rewriter.getFunctionType(argty, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    TagGetOp tagget = cast<TagGetOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp f = getOrCreateLeanTag(rewriter, mod);
    // rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, tagget.getOperand());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, rands);
    return success();
  }
};

struct PapExtendOpLowering : public mlir::ConversionPattern {
public:
  // TODO: need variadic arguments?
  static FuncOp getOrCreateLeanApply(int nargs, PatternRewriter &rewriter,
                                     ModuleOp m) {
    const std::string name = "lean_apply_" + std::to_string(nargs);
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *context = rewriter.getContext();
    SmallVector<Type, 4> argtys;

    argtys.push_back(ValueType::get(context)); // argument.
    for (int i = 0; i < nargs; ++i) {
      argtys.push_back(ValueType::get(context));
    }

    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argtys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit PapExtendOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PapExtendOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PapExtendOp papext = cast<PapExtendOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    // def emitApp (z : VarId) (f : VarId) (ys : Array Arg) : M Unit :=
    // if ys.size > closureMaxArgs then do
    //  emit "{ lean_object* _aargs[] = {"; emitArgs ys; emitLn "};";
    // emitLhs z; emit "lean_apply_m("; emit f; emit ", "; emit ys.size; emitLn
    // ", _aargs); }" else do
    //   emitLhs z; emit "lean_apply_"; emit ys.size; emit "("; emit f; emit ",
    //   "; emitArgs ys; emitLn ");"
    // TODO: generate lean_apply_m;
    FuncOp f = getOrCreateLeanApply(papext.getNumFnArguments(), rewriter, mod);
    // rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, papext->getOperands());
    rewriter.replaceOpWithNewOp<mlir::CallOp>(op, f, rands);

    return success();
  }
};

struct PapOpLowering : public mlir::ConversionPattern {
public:
  static FuncOp getOrCreateLeanAllocClosure(PatternRewriter &rewriter,
                                            ModuleOp m) {
    const std::string name = "lean_alloc_closure";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *context = rewriter.getContext();
    SmallVector<Type, 4> argtys;

    argtys.push_back(ValueType::get(context)); // fn.
    argtys.push_back(rewriter.getI32Type());   // arity of fn
    argtys.push_back(rewriter.getI32Type());   // nargs

    Type retty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argtys, retty);

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }
  static FuncOp getOrCreateLeanClosureSet(PatternRewriter &rewriter,
                                          ModuleOp m) {
    const std::string name = "lean_closure_set";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }
    MLIRContext *context = rewriter.getContext();
    SmallVector<Type, 4> argtys;

    argtys.push_back(ValueType::get(context)); // closure
    argtys.push_back(rewriter.getI32Type());   // nargs
    argtys.push_back(ValueType::get(context)); // value

    FunctionType fnty = rewriter.getFunctionType(argtys, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  explicit PapOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(PapOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    PapOp pap = cast<PapOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();

    // def emitPartialApp (z : VarId) (f : FunId) (ys : Array Arg) : M Unit :=
    // do
    //   let decl ← getDecl f
    //   let arity := decl.params.size;
    //   emitLhs z;
    //     emit "lean_alloc_closure((void*)("; emitCName f; emit "), "; emit
    //     arity; emit ", "; emit ys.size; emitLn ");";
    //   ys.size.forM fun i => do
    //     let y := ys[i]
    // emit "lean_closure_set("; emit z; emit ", "; emit i; emit ", ";
    //    emitArg y; emitLn ")";

    FuncOp alloc = getOrCreateLeanAllocClosure(rewriter, mod);
    FuncOp calledFn = mod.lookupSymbol<FuncOp>(pap.getFnName());
    if (!calledFn) {
      llvm::errs() << "unable to find called function: |" << pap.getFnName()
                   << "|\n";
      assert(false && "unable to find PAP function");
    }

    rewriter.setInsertionPoint(pap);

    const int width = 32;
    // vvvv I don't need the name, I need the fucking function pointer!
    Value fnptr = rewriter.create<ptr::PtrFnPtrOp>(
        pap->getLoc(), pap.getFnName(), calledFn.getType());
    //    Value name = rewriter.create<ptr::PtrStringOp>(pap->getLoc(),
    //    pap.getFnName());

    // const int LEAN_CLOSURE_MAX_ARGS = 16; // this is just asking for trouble.
    // Unfortunately, I don't know a better way to coordinate this. const int
    // arityint = calledFn.getNumArguments() > LEAN_CLOSURE_MAX_ARGS ? 1 :
    // calledFn.getNumArguments(); const int arityint =
    // calledFn.getNumArguments();
    Value arity =
        rewriter.create<ConstantIntOp>(pap->getLoc(), pap.getFnArity(), width);
    Value nargs = rewriter.create<ConstantIntOp>(
        pap->getLoc(), pap.getNumFnArguments(), width);
    mlir::SmallVector<Value, 4> allocArgs{fnptr, arity, nargs};
    CallOp callAlloc =
        rewriter.create<mlir::CallOp>(pap->getLoc(), alloc, allocArgs);
    Value closure = callAlloc.getResult(0);

    FuncOp closureSet = this->getOrCreateLeanClosureSet(rewriter, mod);
    for (int i = 0; i < pap.getNumFnArguments(); ++i) {
      Value ix = rewriter.create<ConstantIntOp>(pap->getLoc(), i, width);
      mlir::SmallVector<Value, 4> setArgs = {closure, ix, pap.getFnArgument(i)};
      rewriter.create<mlir::CallOp>(pap->getLoc(), closureSet, setArgs);
    }
    rewriter.replaceOp(pap, closure);
    return success();
  }
};

class PtrGlobalOpTypeConversion : public ConversionPattern {
public:
  explicit PtrGlobalOpTypeConversion(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ptr::PtrGlobalOp::getOperationName(), 1, tc,
                          context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ptr::PtrGlobalOp global = cast<ptr::PtrGlobalOp>(op);
    rewriter.replaceOpWithNewOp<ptr::PtrGlobalOp>(
        op, global.getGlobalName(),
        typeConverter->convertType(global.getGlobalType()));
    return success();
  }
};

class PtrLoadGlobalOpTypeConversion : public ConversionPattern {
public:
  explicit PtrLoadGlobalOpTypeConversion(TypeConverter &tc,
                                         MLIRContext *context)
      : ConversionPattern(ptr::PtrLoadGlobalOp::getOperationName(), 1, tc,
                          context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ptr::PtrLoadGlobalOp use = cast<ptr::PtrLoadGlobalOp>(op);
    rewriter.replaceOpWithNewOp<ptr::PtrLoadGlobalOp>(
        op, use.getGlobalName(),
        typeConverter->convertType(use.getGlobalType()));
    return success();
  }
};

class PtrStoreGlobalOpTypeConversion : public ConversionPattern {
public:
  explicit PtrStoreGlobalOpTypeConversion(TypeConverter &tc,
                                          MLIRContext *context)
      : ConversionPattern(ptr::PtrStoreGlobalOp::getOperationName(), 1, tc,
                          context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ptr::PtrStoreGlobalOp store = cast<ptr::PtrStoreGlobalOp>(op);
    assert(rands.size() == 1 && "store op must have an operand");
    rewriter.replaceOpWithNewOp<ptr::PtrStoreGlobalOp>(op, rands[0],
                                                       store.getGlobalName());
    return success();
  }
};

class PtrFnPtrOpTypeConversion : public ConversionPattern {
public:
  explicit PtrFnPtrOpTypeConversion(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ptr::PtrFnPtrOp::getOperationName(), 1, tc, context) {
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ptr::PtrFnPtrOp ptr = cast<ptr::PtrFnPtrOp>(op);
    rewriter.replaceOpWithNewOp<ptr::PtrFnPtrOp>(
        op, ptr.getGlobalName(),
        typeConverter->convertType(ptr.getGlobalType()));
    return success();
  }
};

class BranchOpTypeConversion : public ConversionPattern {
public:
  explicit BranchOpTypeConversion(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(BranchOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    assert(false);
    BranchOp br = cast<BranchOp>(op);
    // rewriter.replaceOpWithNewOp<BranchOp>(br, br.getDest(),
    // br->getOperands());
    rewriter.replaceOpWithNewOp<BranchOp>(br, br.getDest(), rands);
    return success();
  }
};

class ReturnOpTypeConversion : public ConversionPattern {
public:
  explicit ReturnOpTypeConversion(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(ReturnOp::getOperationName(), 1, tc, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ReturnOp ret = cast<ReturnOp>(op);
    // rewriter.replaceOpWithNewOp<ReturnOp>(ret, ret->getOperands());
    rewriter.replaceOpWithNewOp<ReturnOp>(ret, rands);
    return success();
  }
};

struct HaskCaseIntRetOpConversionPattern : public mlir::ConversionPattern {
public:
  explicit HaskCaseIntRetOpConversionPattern(HaskTypeConverter &tc,
                                             MLIRContext *context)
      : ConversionPattern(HaskCaseIntRetOp::getOperationName(), 1, tc,
                          context) {
    setHasBoundedRewriteRecursion();


      }

  // generate the order[i]th case alt of caseop, We need this `order` thing
  // to make sure we generate the default case last. I guess we don't need it if
  // we are sure that people always write the default case last? whatever.
  RgnValOp genCaseAlt(HaskCaseIntRetOp caseop, Value scrutinee, int i, int n,
                      ConversionPatternRewriter &rewriter) const {

    assert(caseop.getAltRHS(i).getNumArguments() == 0);
    RgnValOp rv = rewriter.create<RgnValOp>(caseop.getLoc());
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), rv.getRegion(),
                               rv.getRegion().end());

    return rv;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto caseop = cast<HaskCaseIntRetOp>(op);
    ModuleOp mod = caseop->getParentOfType<ModuleOp>();

    assert(rands.size() == 1);
    rewriter.setInsertionPoint(caseop);

    SmallVector<Value, 4> rhss;
    SmallVector<int, 4> lhss;
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      rhss.push_back(
          genCaseAlt(caseop, rands[0], i, caseop.getNumAlts(), rewriter));
      Optional<int> lhs = caseop.getAltLHS(i);
      lhss.push_back(
          lhs ? *lhs
              : RGN_DIALECT_DEFAULT_CASE_MAGIC); // HACK HACK HACK: use "-42" to denote default case.
    }

    assert(rhss.size() > 0);

    assert(rands.size() > 0);
    Value tag = rands[0];
    // TODO: actually pick a value using a rgn.switch.
    llvm::errs() << "creating select...\n";
    RgnSelectOp to_execute =
        rewriter.create<RgnSelectOp>(caseop.getLoc(), tag, lhss, rhss);
    rewriter.create<RgnJumpValOp>(caseop.getLoc(), to_execute);
    rewriter.eraseOp(caseop);

    return success();
  }
};

struct HaskCaseRetOpConversionPattern : public mlir::ConversionPattern {
private:
  HaskTypeConverter &tc;

public:
  explicit HaskCaseRetOpConversionPattern(HaskTypeConverter &tc,
                                          MLIRContext *context)
      : ConversionPattern(HaskCaseRetOp::getOperationName(), 1, tc, context),
        tc(tc) {
    setHasBoundedRewriteRecursion();


        }
  static FuncOp getOrInsertGetObjTag(PatternRewriter &rewriter,
                                     ModuleOp module) {
    // emit "lean_obj_tag("; emit x; emit ")";
    MLIRContext *context = rewriter.getContext();
    const std::string name = "lean_obj_tag";
    if (mlir::FuncOp fn = module.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    // constructor, string constructor name
    SmallVector<Type, 4> argtys{ValueType::get(context)};
    Type retty = rewriter.getI32Type();
    auto llvmFnType = rewriter.getFunctionType(argtys, retty);
    // Insert the printf function into the body of the parent module.
    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(module.getBody());
    FuncOp fn = rewriter.create<FuncOp>(module.getLoc(), name, llvmFnType);
    fn.setPrivate();
    return fn;
  };

  // fill the region `out` with the ith RHS of the caseop.
  void genCaseAltRHS(Region *out, HaskCaseRetOp caseop, Value scrutinee, int i,
                     ConversionPatternRewriter &rewriter) const {
    assert(out->args_empty());
    assert(out->getBlocks().size() == 1);
    llvm::SmallVector<Value, 4> rhsVals;

    assert(caseop.getAltRHS(i).getNumArguments() == 0);
    Block *caseEntryBB = &caseop.getAltRHS(i).front();
    assert(caseEntryBB);
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), *out, out->end());
    rewriter.mergeBlocks(caseEntryBB, &out->getBlocks().front(), rhsVals);
  }

  RgnValOp genCaseAlt(HaskCaseRetOp caseop, Value scrutinee, int i, int n,
                      ConversionPatternRewriter &rewriter) const {
    // ModuleOp mod = caseop->getParentOfType<ModuleOp>();

    // Value condition = [&]() {
    //     Optional<int> lhsIx = caseop.getAltLHS(i);
    //     if (!lhsIx) {
    //       ConstantIntOp out =
    //       rewriter.create<ConstantIntOp>(caseop.getLoc(), /*value=*/1,
    //       /*width=*/1); return out.getResult();
    //     } else {
    //       FuncOp fn = getOrInsertGetObjTag(rewriter, mod);
    //       SmallVector<Value, 4> params{scrutinee};
    //       CallOp tag = rewriter.create<CallOp>(caseop.getLoc(), fn,
    //       params); Value lhsConst =
    //       rewriter.create<ConstantIntOp>(caseop.getLoc(), *lhsIx,
    //       rewriter.getI32Type()); CmpIOp isEq = rewriter.create<CmpIOp>(
    //           caseop.getLoc(), CmpIPredicate::eq, tag.getResult(0),
    //           lhsConst);
    //       return isEq.getResult();
    //     }
    // }();

    // Block *falseBB =  [&]() {
    //   // createBlock moves the insetion point x(
    //   OpBuilder::InsertionGuard guard(rewriter);
    //   return rewriter.createBlock(caseop->getParentRegion(),
    //     caseop->getParentRegion()->end(), {});
    // }();

    // rewriter.create<mlir::CondBranchOp>(caseop.getLoc(), condition,
    //   &caseop.getAltRHS(i).front(), falseBB);
    assert(caseop.getAltRHS(i).getNumArguments() == 0);
    RgnValOp rv = rewriter.create<RgnValOp>(caseop.getLoc());
    rewriter.inlineRegionBefore(caseop.getAltRHS(i), rv.getRegion(),
                               rv.getRegion().end());

    // this is because LEAN never uses arguments, it chooses to extract
    // arguments by using intrincics from a case scrutinee. v This assert is
    // no longer true, since we now use `scf`, so on lowering `scf` we can
    // get more than one block inside a case.
    // assert(caseop.getAltRHS(i).getBlocks().size() == 1);
    return rv;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    auto caseop = cast<HaskCaseRetOp>(op);
    ModuleOp mod = caseop->getParentOfType<ModuleOp>();

    assert(rands.size() == 1);
    rewriter.setInsertionPoint(caseop);

    SmallVector<Value, 4> rhss;
    SmallVector<int, 4> lhss;
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      rhss.push_back(
          genCaseAlt(caseop, rands[0], i, caseop.getNumAlts(), rewriter));
      Optional<int> lhs = caseop.getAltLHS(i);
      lhss.push_back(lhs ? *lhs : RGN_DIALECT_DEFAULT_CASE_MAGIC);
    }

    assert(rhss.size() > 0);

    FuncOp fn = getOrInsertGetObjTag(rewriter, mod);
    // HACK, TODO: change this to a real switch case. Order of appearance
    // of arguments is not the same order as that of values.
    assert(rands.size() > 0);
    Value scrutinee = rands[0];

    CallOp tag =
        rewriter.create<CallOp>(caseop.getLoc(), fn, scrutinee);

    // TODO: actually pick a value using a rgn.switch.
    Value to_execute =
        rewriter.create<RgnSelectOp>(caseop.getLoc(), tag.getResult(0), lhss, rhss);
    rewriter.create<RgnJumpValOp>(caseop.getLoc(), to_execute);
    rewriter.eraseOp(caseop);

    return success();
  }
};

/*
class HaskValueToPtrOpTypeConversion : public ConversionPattern {
public:
  explicit HaskValueToPtrOpTypeConversion(TypeConverter &tc, MLIRContext
*context) : ConversionPattern(ptr::HaskValueToPtrOp::getOperationName(), 1,
tc, context) {
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    ptr::HaskValueToPtrOp ptr = cast<ptr::HaskValueToPtrOp>(op);
    assert(rands.size() == 1);
    rewriter.replaceOp(ptr, rands[0]);
    return success();
  }
};
*/

// class PtrBranchOpTypeConversion : public ConversionPattern {
// public:
//   explicit PtrBranchOpTypeConversion(TypeConverter &tc, MLIRContext
//   *context)
//       : ConversionPattern(ptr::PtrBranchOp::getOperationName(), 1, tc,
//       context) {}
//
//   LogicalResult
//   matchAndRewrite(Operation *op, ArrayRef<Value> rands,
//                   ConversionPatternRewriter &rewriter) const override {
//     assert(false && "legalizing ptr branch op");
//     ptr::PtrBranchOp br = cast<ptr::PtrBranchOp>(op);
//     // rewriter.replaceOpWithNewOp<BranchOp>(br, br.getDest(),
//     br->getOperands()); rewriter.replaceOpWithNewOp<ptr::PtrBranchOp>(br,
//     br.getSuccessor(), rands); return success();
//   }
// };

struct DecOpLowering : public mlir::ConversionPattern {
public:
  explicit DecOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(DecOp::getOperationName(), 1, tc, context) {}

  static FuncOp getOrCreateLeanDec(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_dec";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    DecOp dec = cast<DecOp>(op);
    assert(dec.getDecCount() == 1 && "cannot decrement more than 1");
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    FuncOp f = getOrCreateLeanDec(rewriter, mod);
    rewriter.replaceOpWithNewOp<CallOp>(dec, f, rands);
    // rewriter.eraseOp(dec);
    return success();
  }
};

struct IncOpLowering : public mlir::ConversionPattern {
public:
  explicit IncOpLowering(TypeConverter &tc, MLIRContext *context)
      : ConversionPattern(IncOp::getOperationName(), 1, tc, context) {}

  static FuncOp getOrCreateLeanInc(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_inc";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  static FuncOp getOrCreateLeanIncN(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_inc_n";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    llvm::SmallVector<Type, 2> argty = {ValueType::get(context),
                                        rewriter.getI32Type()};
    FunctionType fnty = rewriter.getFunctionType(argty, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  static FuncOp getOrCreateLeanIncRef(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_inc_ref";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    Type argty = ValueType::get(context);
    FunctionType fnty = rewriter.getFunctionType(argty, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  static FuncOp getOrCreateLeanIncRefN(PatternRewriter &rewriter, ModuleOp m) {
    const std::string name = "lean_inc_ref_n";
    if (FuncOp fn = m.lookupSymbol<FuncOp>(name)) {
      return fn;
    }

    MLIRContext *context = rewriter.getContext();
    llvm::SmallVector<Type, 2> argty = {ValueType::get(context),
                                        rewriter.getI32Type()};
    FunctionType fnty = rewriter.getFunctionType(argty, {});

    PatternRewriter::InsertionGuard insertGuard(rewriter);
    rewriter.setInsertionPointToStart(m.getBody());
    FuncOp fn = rewriter.create<FuncOp>(m.getLoc(), name, fnty);
    fn.setPrivate();
    return fn;
  }

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> rands,
                  ConversionPatternRewriter &rewriter) const override {
    assert(rands.size() == 1);
    IncOp inc = cast<IncOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();

    if (inc.getIncCount() == 1) {
      FuncOp f = inc.isCheckRef() ? getOrCreateLeanInc(rewriter, mod)
                                  : getOrCreateLeanIncRef(rewriter, mod);
      llvm::SmallVector<Value, 1> args = {rands[0]};
      rewriter.replaceOpWithNewOp<CallOp>(inc, f, args);
    } else {
      assert(false && "unhandled lean_inc with n > 1");
      // n > 1
      FuncOp f = inc.isCheckRef() ? getOrCreateLeanIncN(rewriter, mod)
                                  : getOrCreateLeanIncRefN(rewriter, mod);
      const int WIDTH = 32;
      ConstantIntOp n = rewriter.create<ConstantIntOp>(
          inc.getLoc(), inc.getIncCount(), WIDTH);
      llvm::SmallVector<Value, 2> args = {rands[0], n};
      rewriter.replaceOpWithNewOp<CallOp>(inc, f, args);
    }
    return success();
  }
};

struct LowerLeanRgnPass : public Pass {
  LowerLeanRgnPass() : Pass(mlir::TypeID::get<LowerLeanRgnPass>()){};
  StringRef getName() const override { return "LowerLeanPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerLeanRgnPass>(
        *static_cast<const LowerLeanRgnPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runPatterns(ConversionTarget &target,
                   mlir::OwningRewritePatternList &patterns) {

    // ::llvm::DebugFlag = true;

    if (failed(mlir::applyPartialConversion(getOperation(), target,
                                            std::move(patterns)))) {
      llvm::errs() << "===Hask lowering failed at Conversion===\n";
      // getOperation()->print(llvm::errs(),
      // mlir::OpPrintingFlags().printGenericOpForm());
      llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
      return;
    };

    if (failed(mlir::verify(getOperation()))) {
      llvm::errs() << "===Hask lowering failed at Verification===\n";
      // getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
      ::llvm::DebugFlag = false;
      return;
    }

    ::llvm::DebugFlag = false;
  }

  void runOnOperation() override {

    {

      HaskTypeConverter typeConverter(&getContext());
      mlir::OwningRewritePatternList patterns(&getContext());
      ConversionTarget target(getContext());
      target.addIllegalDialect<scf::SCFDialect>();

      target.addLegalDialect<HaskDialect, ptr::PtrDialect>();
      target.addLegalDialect<StandardOpsDialect>();
      target.addLegalDialect<AffineDialect>();
      target.addLegalDialect<RgnDialect>();

      target.addLegalDialect<ptr::PtrDialect>();
      target.addLegalOp<ModuleOp, ModuleTerminatorOp, FuncOp>();

      target.addIllegalOp<HaskCaseIntRetOp>();
      target.addIllegalOp<HaskCaseRetOp>();
      target.addIllegalOp<HaskJoinPointOp>();
      patterns.insert<HaskJoinPointOpLowering>(typeConverter, &getContext());
      patterns.insert<HaskCaseRetOpConversionPattern>(typeConverter,
                                                      &getContext());
      patterns.insert<HaskCaseIntRetOpConversionPattern>(typeConverter,
                                                         &getContext());
      // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
      // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
      // patterns.insert<BranchOpTypeConversion>(typeConverter, &getContext());
      // patterns.insert<PtrBranchOpTypeConversion>(typeConverter,
      // &getContext());
      runPatterns(target, patterns);
    }

    // === control flow has been lowered. lower simple instructions ===/
    {

      HaskTypeConverter typeConverter(&getContext());
      mlir::OwningRewritePatternList patterns(&getContext());
      ConversionTarget target(getContext());
      target.addIllegalDialect<HaskDialect>();
      target.addLegalDialect<ptr::PtrDialect>();
      target.addLegalDialect<StandardOpsDialect>();
      target.addLegalDialect<AffineDialect>();
      target.addLegalDialect<RgnDialect>();
      target.addIllegalDialect<scf::SCFDialect>();
      // target.addLegalDialect<scf::SCFDialect>();
      target.addLegalDialect<ptr::PtrDialect>();
      target.addLegalOp<ModuleOp, ModuleTerminatorOp, FuncOp>();

      patterns.insert<HaskConstructOpLowering>(typeConverter, &getContext());
      patterns.insert<ErasedValueOpLowering>(typeConverter, &getContext());
      patterns.insert<TagGetOpLowering>(typeConverter, &getContext());
      patterns.insert<PapExtendOpLowering>(typeConverter, &getContext());
      patterns.insert<PapOpLowering>(typeConverter, &getContext());
      patterns.insert<HaskStringConstOpLowering>(typeConverter, &getContext());
      patterns.insert<HaskIntegerConstOpLowering>(typeConverter, &getContext());
      patterns.insert<HaskLargeIntegerConstOpLowering>(typeConverter,
                                                       &getContext());
      patterns.insert<ProjectionOpLowering>(typeConverter, &getContext());
      patterns.insert<CallOpLowering>(typeConverter, &getContext());
      patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
      patterns.insert<ApEagerOpConversionPattern>(typeConverter, &getContext());
      patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
                                                     &getContext());
      patterns.insert<IncOpLowering>(typeConverter, &getContext());
      patterns.insert<DecOpLowering>(typeConverter, &getContext());

      // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
      // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
      // patterns.insert<BranchOpTypeConversion>(typeConverter, &getContext());
      runPatterns(target, patterns);
      return;
    }
  }
};

} // namespace

std::unique_ptr<mlir::Pass> createLowerLeanRgnPass() {
  return std::make_unique<LowerLeanRgnPass>();
}

void registerLowerLeanRgnPass() {
  ::mlir::registerPass("lean-lower-rgn",
                       "Perform lowering from LEAN-lz to std+rgn+ptr",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLowerLeanRgnPass();
                       });
}



} // namespace standalone
} // namespace mlir