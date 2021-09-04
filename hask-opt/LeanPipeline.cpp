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
#include "mlir/IR/Visitors.h"
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

#include <set>

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

// library.ll
// define nonnull %struct.lean_object* @lean_box(i64 %0) local_unnamed_addr #0 {

// https://github.com/llvm/llvm-project/blob/a048e2fa1d0285a3582bd224d5652dbf1dc91cb4/mlir/examples/toy/Ch6/mlir/LowerToLLVM.cpp
// https://github.com/llvm/llvm-project/blob/706d992cedaf2ca3190e4445015da62faf2db544/mlir/lib/Conversion/StandardToLLVM/StandardToLLVM.cpp

namespace mlir {
namespace standalone {

namespace {

class HaskTypeConverter : public mlir::TypeConverter {
public:
  // using LLVMTypeConverter::LLVMTypeConverter;
  using TypeConverter::convertType;

  HaskTypeConverter(MLIRContext *ctx) {

    addConversion([](Type type) { return type; });
  };
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
    rewriter.create<mlir::BranchOp>(jpOp->getLoc(),
                                    &jpOp.getFirstRegionWithJmp().front());

    // inline fstRegion at (begin ---> fstRegion)
    rewriter.inlineRegionBefore(jpOp.getFirstRegionWithJmp(),
                                *jpOp->getParentRegion(),
                                jpOp->getParentRegion()->end());

    rewriter.eraseOp(jpOp);
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
              : RGN_DIALECT_DEFAULT_CASE_MAGIC); // HACK HACK HACK: use "-42" to
                                                 // denote default case.
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

  RgnValOp genCaseAlt(HaskCaseRetOp caseop, Value scrutinee, int i, int n,
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

    CallOp tag = rewriter.create<CallOp>(caseop.getLoc(), fn, scrutinee);

    // TODO: actually pick a value using a rgn.switch.
    Value to_execute = rewriter.create<RgnSelectOp>(
        caseop.getLoc(), tag.getResult(0), lhss, rhss);
    rewriter.create<RgnJumpValOp>(caseop.getLoc(), to_execute);
    rewriter.eraseOp(caseop);

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

class HaskReturnOpConversionPattern : public mlir::ConversionPattern {
public:
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

void rewriteJump(RgnJumpValOp jump, mlir::IRRewriter &rewriter,
                 std::vector<std::pair<RgnValOp, Block *>> &inlineVals) {

  static std::set<RgnValOp> seen;
  static std::set<RgnJumpValOp> jumps;
  assert(true || !jumps.count(jump));
  jumps.insert(jump);

  if (RgnValOp val = jump.getFn().getDefiningOp<RgnValOp>()) {
    // llvm::errs() << "\n===jump(rgn)===\n";
    // llvm::errs() << "rgnval:\n\t" << val << "\n";
    // llvm::errs() << "parent:\n\t" << jump << "\n";
    // llvm::errs() << "\n===\n";

    assert(true || !seen.count(val));
    seen.insert(val);

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    rewriter.setInsertionPointAfter(jump);
    assert(val.getRegion().getBlocks().size() > 0);
    Block *newEntry = rewriter.cloneRegionBeforeAndReturnEntry(
        val.getRegion(), *jump->getParentRegion(),
        jump->getParentRegion()->end());

    rewriter.create<BranchOp>(jump.getLoc(), newEntry, jump.getFnArguments());
    rewriter.eraseOp(jump);
    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    return;
  }

  if (RgnSelectOp select = jump.getFn().getDefiningOp<RgnSelectOp>()) {

    Block *defaultBB = nullptr;
    SmallVector<int32_t> caseLhss;
    SmallVector<Block *> caseRhss;
    SmallVector<mlir::Value> defaultOperands;

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    for (int i = 0; i < (int)select.getNumBranches(); ++i) {
      std::pair<int, mlir::Value> branch = select.getBranch(i);
      RgnValOp v = branch.second.getDefiningOp<RgnValOp>();
      assert(v && "expected select(rgnval)");

      // llvm::errs() << "\n===jump(select(rgn))===\n";
      // llvm::errs() << "rgnval:\n\t" << v << "\n";
      // llvm::errs() << "select:\n\t" << select << "\n";
      // llvm::errs() << "parent:\n\t" << jump << "\n";
      // llvm::errs() << "\n===\n";
      assert(true || !seen.count(v));
      seen.insert(v);

      Region *parent = jump->getParentRegion();
      llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

      if (branch.first == RGN_DIALECT_DEFAULT_CASE_MAGIC) {
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
        assert(i == (int)select.getNumBranches() - 1);
        assert(!defaultBB && "can't have two default blocks");
        Region &r = v.getRegion();
        // defaultBB = &r.front();
        defaultBB =
            rewriter.cloneRegionBeforeAndReturnEntry(r, *parent, parent->end());
        // rewriter.inlineRegionBefore(r, *parent, parent->end());
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

      } else {
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
        Region &r = v.getRegion();
        assert(r.getBlocks().size() > 0);
        caseLhss.push_back(abs(branch.first));
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
        Block *newEntry =
            rewriter.cloneRegionBeforeAndReturnEntry(r, *parent, parent->end());
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

        caseRhss.push_back(newEntry);
        llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
      }
    }
    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    if (!defaultBB) {
      defaultBB = [&]() {
        // createBlock moves the insetion point x(
        OpBuilder::InsertionGuard guard(rewriter);
        Block *b = rewriter.createBlock(jump->getParentRegion(),
                                        jump->getParentRegion()->end(), {});
        rewriter.setInsertionPointToStart(b);
        rewriter.create<ptr::PtrUnreachableOp>(rewriter.getUnknownLoc());
        return b;
      }();
    }
    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    rewriter.setInsertionPointAfter(jump);
    Value switchval = rewriter.create<LLVM::SExtOp>(
        jump.getLoc(), rewriter.getIntegerType(32), select.getSwitcher());
    // rewriter.create<LLVM::SwitchOp>(jump.getLoc(), switchval, defaultBB,
    //                                 /*default operands*/ defaultOperands,
    //                                 /*case switch LHss*/ caseLhss,
    //                                 /*case switch RHSs*/ caseRhss);
    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    rewriter.replaceOpWithNewOp<LLVM::SwitchOp>(
        jump, switchval, defaultBB,
        /*default-operands*/ defaultOperands,
        /*case switch LHss*/ caseLhss,
        /*case switch RHSs*/ caseRhss);
    // rewriter.eraseOp(jump);

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    return;
  };
  assert(false && "expected argument to call to be a val or a select.");
}

struct LeanPipelinePass : public Pass {
  LeanPipelinePass() : Pass(mlir::TypeID::get<LeanPipelinePass>()){};
  StringRef getName() const override { return "LeanPipelinePass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LeanPipelinePass>(
        *static_cast<const LeanPipelinePass *>(this));
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

  // lower control flow to Rgn
  void lowerControlFlowToRgn() {

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

  void peepholeRewrites() {
    // Step 1: lower case and case int ret to rgn.blah.

    mlir::IRRewriter rewriter(getOperation()->getContext());

    getOperation()->walk([&](RgnSelectOp op) {
      CallOp call = op.getSwitcher().getDefiningOp<CallOp>();
      assert(call &&
             "we always have switch(lean_int_dec_lt(blah)|lean_obj_tag(blah))");
      llvm::errs() << call << "\n";
      llvm::errs() << "\t" << call.getOperand(0) << "\n";
      if (call.getNumOperands() >= 2) { llvm::errs() << "\t" << call.getOperand(1) << "\n"; };
      getchar();

      if (call.getCallee() == "lean_int_dec_eq") {
      } else if (call.getCallee() == "lean_int_dec_lt") {

      } else if (call.getCallee() == "lean_nat_dec_eq") {
      } else if (call.getCallee() == "lean_obj_tag") {
      } else if (call.getCallee() == "lean_string_dec_eq") {
      } else {
        llvm::errs() << "select: " << op << "\n";
        llvm::errs() << "call: " << call << "\n";
        assert(false && "select(call(<unk>))!");
      }
    });
  }

  void lowerRgn() {
    std::vector<std::pair<RgnValOp, Block *>> inlineVals;
    mlir::IRRewriter rewriter(getOperation()->getContext());
    getOperation()->walk([&](RgnJumpValOp jmp) {
      rewriteJump(jmp, rewriter, inlineVals);
      return WalkResult::advance();
    });

    getOperation()->walk([&](RgnReturnOp ret) {
      rewriter.setInsertionPoint(ret);
      rewriter.replaceOpWithNewOp<ReturnOp>(ret, ret.getOperand());
      return WalkResult::advance();
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    // std::set<RgnValOp> toDelete;
    // for (int i = 0; i < (int)inlineVals.size(); ++i) {
    //   rewriter.inlineRegionBefore(inlineVals[i].first.getRegion(),
    //                               inlineVals[i].second);
    //   // toDelete.insert(inlineVals[i].first);
    // }

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnJumpValOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnSelectOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";
    getOperation()->walk([&](RgnValOp v) {
      if (!v.use_empty()) {
        llvm::errs() << "region val has use: |" << v << "|\n";
        assert(false);
      }
      rewriter.eraseOp(v);
    });

    llvm::errs() << __FILE__ << ":" << __LINE__ << "\n";

    // llvm::outs() << "// ===rewritten===\n";
    // llvm::outs() << *getOperation();

    ::llvm::DebugFlag = true;
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

  void lowerNonControlFlowToStd() {
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
    // patterns.insert<ErasedValueOpLowering>(typeConverter, &getContext());
    patterns.insert<TagGetOpLowering>(typeConverter, &getContext());
    patterns.insert<PapExtendOpLowering>(typeConverter, &getContext());
    patterns.insert<PapOpLowering>(typeConverter, &getContext());
    patterns.insert<HaskStringConstOpLowering>(typeConverter, &getContext());
    patterns.insert<HaskIntegerConstOpLowering>(typeConverter, &getContext());
    patterns.insert<HaskLargeIntegerConstOpLowering>(typeConverter,
                                                     &getContext());
    patterns.insert<ProjectionOpLowering>(typeConverter, &getContext());
    patterns.insert<CallOpLowering>(typeConverter, &getContext());
    // patterns.insert<ApOpConversionPattern>(typeConverter, &getContext());
    // patterns.insert<ApEagerOpConversionPattern>(typeConverter,
    // &getContext());
    patterns.insert<HaskReturnOpConversionPattern>(typeConverter,
                                                   &getContext());
    patterns.insert<IncOpLowering>(typeConverter, &getContext());
    patterns.insert<DecOpLowering>(typeConverter, &getContext());

    // patterns.insert<FuncOpLowering>(typeConverter, &getContext());
    // patterns.insert<ReturnOpLowering>(typeConverter, &getContext());
    // patterns.insert<BranchOpTypeConversion>(typeConverter, &getContext());
    runPatterns(target, patterns);
  }
  void runOnOperation() override {
    lowerControlFlowToRgn();
    lowerNonControlFlowToStd();
    peepholeRewrites();
    lowerRgn();
  }
};

} // namespace

std::unique_ptr<mlir::Pass> createLeanPipelinePass() {
  return std::make_unique<LeanPipelinePass>();
}

} // namespace standalone
} // namespace mlir

void registerLeanPipelinePass() {
  ::mlir::registerPass("lean-pipeline", "lower LEAN. all together now.",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return mlir::standalone::createLeanPipelinePass();
                       });
}
