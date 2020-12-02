#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/Module.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/InliningUtils.h"
#include <mlir/Parser.h>
#include <sstream>
// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"

// pattern matching
#include "mlir/IR/Matchers.h"
#include "mlir/IR/PatternMatch.h"

// dilect lowering
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Transforms/DialectConversion.h"
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVM.h"
#include "mlir/Conversion/StandardToLLVM/ConvertStandardToLLVMPass.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/DialectConversion.h"

#define DEBUG_TYPE "hask-ops"
#include "llvm/Support/Debug.h"

namespace mlir {
namespace standalone {

mlir::FlatSymbolRefAttr getConstantFnRefFromOp(mlir::ConstantOp constant) {
  return constant.getValue().dyn_cast<FlatSymbolRefAttr>();
}

mlir::FlatSymbolRefAttr getConstantFnRefFromValue(mlir::Value v) {
  mlir::ConstantOp constant = v.getDefiningOp<mlir::ConstantOp>();
  if (!v) {
    return mlir::FlatSymbolRefAttr();
  }
  return getConstantFnRefFromOp(constant);
}

struct ForceOfKnownApPattern : public mlir::OpRewritePattern<ForceOp> {
  /// We register this pattern to match every toy.transpose in the IR.
  /// The "benefit" is used by the framework to order the patterns and process
  /// them in order of profitability.
  ForceOfKnownApPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ForceOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(ForceOp force,
                  mlir::PatternRewriter &rewriter) const override {

    // HaskFuncOp fn = force.getParentOfType<HaskFuncOp>();

    ApOp ap = force.getOperand().getDefiningOp<ApOp>();
    if (!ap) {
      return failure();
    }

    // HaskRefOp ref = ap.getFn().getDefiningOp<HaskRefOp>();
    // if (!ref) {
    //   return failure();
    // }
    FlatSymbolRefAttr apfnname = getConstantFnRefFromValue(ap.getFn());
    if (!apfnname) {
      return failure();
    }
    ModuleOp mod = force.getParentOfType<ModuleOp>();
    FuncOp fn = mod.lookupSymbol<FuncOp>(apfnname);
    if (!fn) {
      return failure();
    }
    // cannot inline a recursive function. Can replace with
    // an apEager
    rewriter.setInsertionPoint(ap);
    ApEagerOp eager =
        rewriter.create<ApEagerOp>(ap.getLoc(), ap.getFn(), ap.getFnArguments(),
                                   fn.getType().getResult(0));
    rewriter.replaceOp(force, eager.getResult());
    return success();
  };
};

// outline stuff that occurs after the force of a constructor at the
// top-level of a function.
struct OutlineUknownForcePattern : public mlir::OpRewritePattern<ForceOp> {
  OutlineUknownForcePattern(mlir::MLIRContext *context)
      : OpRewritePattern<ForceOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(ForceOp force,
                  mlir::PatternRewriter &rewriter) const override {

    // we should not have a force of thunkify, or force of known ap
    if (force.getOperand().getDefiningOp<ThunkifyOp>()) {
      return failure();
    }

    // TODO: think about what to do.
    if (ApOp ap = force.getOperand().getDefiningOp<ApOp>()) {
      FlatSymbolRefAttr apfn = getConstantFnRefFromValue(ap.getFn());

      if (!apfn) {
        return failure();
      }

      // how to get dominance information? I should outline everything in the
      // region that is dominated by the BB that `force` lives in.
      // For now, approximate.
      if (force.getOperation()->getBlock() !=
          &force.getParentRegion()->front()) {
        ModuleOp mod = force.getParentOfType<ModuleOp>();
        llvm::errs() << "\n=====\n";
        llvm::errs() << mod;
        llvm::errs() << "\n=====\n";
        assert(false && "force not in entry BB");
        return failure();
      }

      // is this going to break *completely*? or only partially?
      std::unique_ptr<Region> r = std::make_unique<Region>();
      // create a hask func op.
      FuncOp parentfn = force.getParentOfType<FuncOp>();

      ModuleOp module = parentfn.getParentOfType<ModuleOp>();
      rewriter.setInsertionPointToEnd(&module.getBodyRegion().front());

      FuncOp outlinedFn = rewriter.create<FuncOp>(
          force.getLoc(), parentfn.getName().str() + "_outline",
          parentfn.getType());
      (void)outlinedFn;

      rewriter.eraseOp(force);
      return success();
    }
    return failure();
  }
};

struct ForceOfThunkifyPattern : public mlir::OpRewritePattern<ForceOp> {
  /// We register this pattern to match every toy.transpose in the IR.
  /// The "benefit" is used by the framework to order the patterns and process
  /// them in order of profitability.
  ForceOfThunkifyPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ForceOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(ForceOp force,
                  mlir::PatternRewriter &rewriter) const override {
    // HaskFuncOp fn = force.getParentOfType<HaskFuncOp>();
    ThunkifyOp thunkify = force.getOperand().getDefiningOp<ThunkifyOp>();
    if (!thunkify) {
      return failure();
    }
    //    assert(false && "force of thunkify");
    rewriter.replaceOp(force, thunkify.getOperand());
    return success();
  }
};

struct InlineApEagerPattern : public mlir::OpRewritePattern<ApEagerOp> {
  InlineApEagerPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ApEagerOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(ApEagerOp ap,
                  mlir::PatternRewriter &rewriter) const override {

    FuncOp parent = ap.getParentOfType<FuncOp>();
    ModuleOp mod = ap.getParentOfType<ModuleOp>();

    FlatSymbolRefAttr apfn = getConstantFnRefFromValue(ap.getFn());
    if (!apfn) {
      return failure();
    }

    if (parent.getName() == apfn.getValue().str()) {
      return failure();
    }

    FuncOp called = mod.lookupSymbol<FuncOp>(apfn);
    assert(called && "unable to find called function.");

    // TODO: setup mapping for arguments in mapper
    // This is not safe! Fuck me x(
    // consider f () { stmt; f(); } | g() { f (); }
    // this will expand into
    //   g() { f(); } -> g() { stmt; f(); } -> g { stmt; stmt; f(); } -> ...
    InlinerInterface inliner(rewriter.getContext());
    if (!HaskDialect::isFunctionRecursive(called)) {
      LogicalResult isInlined = inlineRegion(
          inliner, &called.getBody(), ap, ap.getFnArguments(), ap.getResult());
      assert(succeeded(isInlined) && "unable to inline");
      return success();
    } else {
      return failure();
    }
  }
};

// TODO: we need to know which argument was forced.
FunctionType mkForcedFnType(FunctionType fty) {
  SmallVector<Type, 4> forcedTys;
  for (Type ty : fty.getInputs()) {
    ThunkType thunkty = ty.dyn_cast<ThunkType>();
    assert(thunkty);
    forcedTys.push_back(thunkty.getElementType());
  }
  return FunctionType::get(forcedTys, fty.getResult(0), fty.getContext());
}

// ===IN===
// @f(%int: thunk<V>):
//    %inv = force(%int) : V
//    -----
//    %recw = ... : V
//    %rect = thunkify(%recw) : thunk<V>
//    %outt = ap(@f, %rect)
// ===OUT===
// @fforced(%inv: V)
//    %f = ref @f
//    %recw = ... : V
//    %rect = thunkify(%recw) : thunk<V>
//    %outt = ap(%f, %rect)
// @f(%int: thunk<V>):
//    %inv = force(%int) : V
//    apEager(@fforced, inv)

// convert ap(thunkify(...)) of a recursive call that is force(...) d
// into an "immediate" function call.

struct OutlineRecursiveApEagerOfThunkPattern
    : public mlir::OpRewritePattern<ApEagerOp> {
  OutlineRecursiveApEagerOfThunkPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ApEagerOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(ApEagerOp ap,
                  mlir::PatternRewriter &rewriter) const override {

    FuncOp parentfn = ap.getParentOfType<FuncOp>();
    ModuleOp mod = ap.getParentOfType<ModuleOp>();

    FlatSymbolRefAttr apfnname = getConstantFnRefFromValue(ap.getFn());
    if (!apfnname) {
      return failure();
    }

    // if the call is not recursive, bail
    if (parentfn.getName() != apfnname.getValue().str()) {
      return failure();
    }

    // called == parentfn?
    FuncOp called = mod.lookupSymbol<FuncOp>(apfnname);
    assert(called && "unable to find called function.");

    if (ap.getNumFnArguments() != 1) {
      assert(false && "cannot handle functions with multiple args just yet");
    }

    SmallVector<Value, 4> clonedFnCallArgs;
    ThunkifyOp thunkifiedArgument =
        ap.getFnArgument(0).getDefiningOp<ThunkifyOp>();
    if (!thunkifiedArgument) {
      return failure();
    }
    clonedFnCallArgs.push_back(thunkifiedArgument.getOperand());

    // TODO: this is an over-approximation of course, we only need
    // a single argument (really, the *same* argument to be reused).
    // I've moved the code here to test that the crash isn't because of a
    // bail-out.

    for (int i = 0; i < (int)called.getBody().getNumArguments(); ++i) {
      Value arg = called.getBody().getArgument(i);
      if (!arg.hasOneUse()) {
        return failure();
      }

      ForceOp uniqueForceOfArg = dyn_cast<ForceOp>(arg.use_begin().getUser());
      if (!uniqueForceOfArg) {
        return failure();
      }
    }

    std::string clonedFnName = called.getName().str() + "rec_force_outline";
    rewriter.setInsertionPoint(ap);

    // ConstantOp original = ap.getFn().getDefiningOp<ConstantOp>();

    // original.dump();
    // mlir::OpPrintingFlags flags;
    // original.print(llvm::errs(), flags.printGenericOpForm());
    // assert(original.getValue().isa<mlir::FlatSymbolRefAttr>() &&
    //        "is a flat symbol ref");
    // assert(original.getValue().isa<mlir::SymbolRefAttr>() && "is a symbol
    // ref");

    ConstantOp clonedFnRef = rewriter.create<ConstantOp>(
        rewriter.getUnknownLoc(), mkForcedFnType(called.getType()),
        mlir::FlatSymbolRefAttr::get(clonedFnName, rewriter.getContext()));

    rewriter.replaceOpWithNewOp<ApEagerOp>(ap, clonedFnRef, clonedFnCallArgs,
                                           called.getType().getResult(0));

    // TODO: this disastrous house of cards depends on the order of cloning.
    // We first replace the reucrsive call, and *then* clone the function.
    FuncOp clonedfn = parentfn.clone();
    clonedfn.setName(clonedFnName);
    clonedfn.setType(mkForcedFnType(called.getType()));

    // TODO: consider if going forward is more sensible or going back is
    // more sensible. Right now I am reaching forward, but perhaps
    // it makes sense to reach back.
    for (int i = 0; i < (int)clonedfn.getBody().getNumArguments(); ++i) {
      Value arg = clonedfn.getBody().getArgument(i);
      if (!arg.hasOneUse()) {
        assert(false && "this precondition as already been checked!");
      }
      // This is of course crazy. We should handle the case if we have
      // multiple force()s.

      ForceOp uniqueForceOfArg = dyn_cast<ForceOp>(arg.use_begin().getUser());
      if (!uniqueForceOfArg) {
        assert(false && "this precondition has already been checked!");
        return failure();
      }

      // we are safe to create a new function because we have a unique force
      // of an argument. We can change the type of the function and we can
      // change the argument.

      // replace argument.
      uniqueForceOfArg.replaceAllUsesWith(arg);
      arg.setType(uniqueForceOfArg.getType());
      rewriter.eraseOp(uniqueForceOfArg);
    }

    mod.push_back(clonedfn);
    return success();
  }
};

// ===INPUT===
// C { MKC(V) }
// @f(%inc: C)
//  %inv = extract(@MKC, %inc) : V
//  %w = ... : V
//  %wc = construct(@MKC, w) : C
//  %rec = apEager(@f, wc)
// ===OUTPUT===
// @frec(%inv: V)
//  %inv = extract(@MKC, %inc) : V
//  %w = ... : V
//  %wc = construct(@MKC, w) : C
//  %rec = apEager(@f, wc)

// @f(%inc: C)
//  %inv = extract(%inc) : V
//  apEager(@frec, inv)

struct OutlineRecursiveApEagerOfConstructorPattern
    : public mlir::OpRewritePattern<ApEagerOp> {
  OutlineRecursiveApEagerOfConstructorPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ApEagerOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(ApEagerOp ap,
                  mlir::PatternRewriter &rewriter) const override {
    FuncOp parentfn = ap.getParentOfType<FuncOp>();
    ModuleOp mod = ap.getParentOfType<ModuleOp>();

    mlir::FlatSymbolRefAttr ref = getConstantFnRefFromValue(ap.getFn());
    // auto ref = ap.getFn().getDefiningOp<HaskRefOp>();
    if (!ref) {
      return failure();
    }

    // if the call is not recursive, bail
    if (parentfn.getName() != ref.getValue().str()) {
      return failure();
    }

    FuncOp called = mod.lookupSymbol<FuncOp>(ref);
    assert(called && "unable to find called function.");

    if (ap.getNumFnArguments() != 1) {
      assert(false && "cannot handle functions with multiple args just yet");
    }

    HaskConstructOp constructedArgument =
        ap.getFnArgument(0).getDefiningOp<HaskConstructOp>();
    if (!constructedArgument) {
      return failure();
    }

    // First focus on SimpleInt. Then expand to Maybe.
    assert(constructedArgument.getNumOperands() == 1);
    SmallVector<Value, 4> improvedFnCallArgs(
        {constructedArgument.getOperand(0)});

    assert(parentfn.getNumArguments() == 1);

    BlockArgument arg = parentfn.getBody().getArgument(0);
    // has multiple uses, we can't use this for our purposes.
    if (!arg.hasOneUse()) {
      return failure();
    }
    // MLIR TODO: add arg.getSingleUse()
    CaseOp caseOfArg = dyn_cast<CaseOp>(arg.getUses().begin().getUser());
    if (!caseOfArg) {
      return failure();
    }

    std::string clonedFnName =
        called.getName().str() + "_rec_construct_" +
        constructedArgument.getDataConstructorName().str() + "_outline";
    rewriter.setInsertionPoint(ap);

    // 1. Replace the ApEager with a simpler apEager
    //    that directly passes the parameter
    SmallVector<Value, 4> clonedFnCallArgs({constructedArgument.getOperand(0)});
    SmallVector<Type, 4> clonedFnCallArgTys{
        (constructedArgument.getOperand(0).getType())};

    mlir::FunctionType clonedFnTy = mlir::FunctionType::get(
        clonedFnCallArgTys, called.getType().getResult(0),
        rewriter.getContext());

    ConstantOp clonedFnRef = rewriter.create<ConstantOp>(
        ap.getFn().getLoc(), clonedFnTy,
        mlir::FlatSymbolRefAttr::get(clonedFnName, rewriter.getContext()));

    // HaskRefOp clonedFnRef = rewriter.create<HaskRefOp>(
    //     ref.getLoc(), clonedFnName,
    //     FunctionType::get(
    //         clonedFnCallArgTys,
    //         parentfn.getType().cast<FunctionType>().getResult(0),
    //         mod.getContext()));
    // HaskFnType::get(mod.getContext(), clonedFnCallArgTys,
    //                 parentfn.getType().cast<FunctionType>().getResult(0)));

    rewriter.replaceOpWithNewOp<ApEagerOp>(ap, clonedFnRef, clonedFnCallArgs,
                                           called.getType().getResult(0));
    FuncOp clonedfn = parentfn.clone();

    // 2. Build the cloned function that is an unboxed version of the
    //    case. Eliminate the case for the argument RHS.
    clonedfn.setName(clonedFnName);
    // NOTE THE REPETITION!
    clonedfn.getBody().getArgument(0).setType(
        constructedArgument.getOperand(0).getType());
    // clonedfn.setType(mkForcedFnType(called.getType()));

    CaseOp caseClonedFnArg = cast<CaseOp>(
        clonedfn.getBody().getArgument(0).getUses().begin().getUser());

    int altIx = *caseClonedFnArg.getAltIndexForConstructor(
        constructedArgument.getDataConstructorName());

    InlinerInterface inliner(rewriter.getContext());
    LogicalResult isInlined = inlineRegion(
        inliner, &caseClonedFnArg.getAltRHS(altIx), caseClonedFnArg,
        clonedfn.getBody().getArgument(0), caseClonedFnArg.getResult());

    rewriter.eraseOp(caseClonedFnArg);
    assert(succeeded(isInlined) && "unable to inline");

    // 3. add the function into the module
    mod.push_back(clonedfn);
    return success();

    assert(false && "matched against f(arg) { case(arg): ...; apEager(f, "
                    "construct(...); } ");
  }
};

struct CaseOfKnownConstructorPattern : public mlir::OpRewritePattern<CaseOp> {
  /// We register this pattern to match every toy.transpose in the IR.
  /// The "benefit" is used by the framework to order the patterns and process
  /// them in order of profitability.
  CaseOfKnownConstructorPattern(mlir::MLIRContext *context)
      : OpRewritePattern<CaseOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseOp caseop,
                  mlir::PatternRewriter &rewriter) const override {

    // ModuleOp mod = caseop.getParentOfType<ModuleOp>();
    // HaskFuncOp fn = caseop.getParentOfType<HaskFuncOp>();

    HaskConstructOp constructor =
        caseop.getScrutinee().getDefiningOp<HaskConstructOp>();
    if (!constructor) {
      return failure();
    }

    rewriter.setInsertionPoint(caseop);
    int altIx =
        *caseop.getAltIndexForConstructor(constructor.getDataConstructorName());

    InlinerInterface inliner(rewriter.getContext());
    LogicalResult isInlined =
        inlineRegion(inliner, &caseop.getAltRHS(altIx), caseop,
                     constructor.getOperands(), caseop.getResult());
    assert(succeeded(isInlined) &&
           "unable to inline case of known constructor");

    return success();
  };
};

// @f {
//   x = ...
//    ybox = apEager(@f, x);
//    z = case ybox of { Box y -> g(y); };
//    return construct(Box, z)
// }
// Convert to:
// @funbox {
//  ...
//   return z
// }
// @f {
//  y = apEager(@funbox, x)
//  z = g(y)
// return construct(Box, z)
// }
struct CaseOfBoxedRecursiveApWithFinalConstruct
    : public mlir::OpRewritePattern<CaseOp> {
  CaseOfBoxedRecursiveApWithFinalConstruct(mlir::MLIRContext *context)
      : OpRewritePattern<CaseOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseOp caseop,
                  mlir::PatternRewriter &rewriter) const override {

    FuncOp fn = caseop.getParentOfType<FuncOp>();

    // case(ap(..., ))
    ApEagerOp apeager = caseop.getScrutinee().getDefiningOp<ApEagerOp>();
    if (!apeager) {
      return failure();
    }

    mlir::FlatSymbolRefAttr ref = getConstantFnRefFromValue(apeager.getFn());
    // HaskRefOp ref = apeager.getFn().getDefiningOp<HaskRefOp>();
    if (!ref) {
      return failure();
    }

    if (ref.getValue() != fn.getName()) {
      return failure();
    }

    // figure out if the return value is always a `hask.construct(...)`
    // TODO: generalize
    if (fn.getBody().getBlocks().size() != 1) {
      return failure();
    }

    // find the return operations
    HaskReturnOp ret = dyn_cast<HaskReturnOp>(
        fn.getBody().getBlocks().front().getTerminator());
    if (!ret) {
      return failure();
    }

    HaskConstructOp construct =
        ret.getOperand().getDefiningOp<HaskConstructOp>();
    if (!construct) {
      return failure();
    }

    assert(false && "case of boxed recursive ap eager");
  }
};

// Can be generalized?
struct PeelCommonConstructorsInCase : public mlir::OpRewritePattern<CaseOp> {
  PeelCommonConstructorsInCase(mlir::MLIRContext *context)
      : OpRewritePattern<CaseOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseOp caseop,
                  mlir::PatternRewriter &rewriter) const override {

    SmallVector<HaskReturnOp, 4> rets;
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      Region &r = caseop.getAltRHS(i);
      r.walk([&](HaskReturnOp ret) { rets.push_back(ret); });
    }
    assert(rets.size() && "expected at least one return value");

    SmallVector<HaskConstructOp, 4> retConstructs;

    for (HaskReturnOp ret : rets) {
      HaskConstructOp construct =
          ret.getOperand().getDefiningOp<HaskConstructOp>();
      if (!construct) {
        return failure();
      }
      retConstructs.push_back(construct);
    }

    // TODO: this is too restrictive and will not work for Maybe! Need to
    // encode things differently
    for (int i = 0; i < (int)retConstructs.size() - 1; ++i) {
      if (retConstructs[i].getDataConstructorName() !=
          retConstructs[i + 1].getDataConstructorName()) {
        return failure();
      }
    }

    // OK, we know everything we need to know.

    // 1. Fix the returns by directly returning the thing the constructor is
    //    wrapping..
    for (int i = 0; i < (int)rets.size(); ++i) {
      assert(retConstructs[i].getNumOperands() == 1);
      rets[i].setOperand(retConstructs[i].getOperand(0));
      rewriter.eraseOp(retConstructs[i]);
    }

    // 2. Create the peeled constructor
    SmallVector<Location, 4> constructorLocs;
    for ([[maybe_unused]] HaskConstructOp cons : retConstructs) {
      // TODO use correct locations for error messages
      // constructorLocs.push_back(cons.getLoc());
      constructorLocs.push_back(rewriter.getUnknownLoc());
    }

    rewriter.setInsertionPointAfter(caseop);

    HaskConstructOp peeledConstructor = rewriter.create<HaskConstructOp>(
        FusedLoc::get(constructorLocs, caseop.getContext()),
        retConstructs[0].getDataConstructorName(),
        // retConstructs[0].getDataTypeName(),
        caseop.getResult());

    // Now walk all the uses of case other than the peeledConstructor
    // and replace it with peeledConstructor
    for (OpOperand &u : caseop.getResult().getUses()) {
      if (u.getOwner() == peeledConstructor.getOperation()) {
        continue;
      }
      u.getOwner()->replaceUsesOfWith(caseop.getResult(),
                                      peeledConstructor.getResult());
    }

    return success();
  }
};

struct WorkerWrapperPass : public Pass {
  WorkerWrapperPass() : Pass(mlir::TypeID::get<WorkerWrapperPass>()){};
  StringRef getName() const override { return "WorkerWrapperPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<WorkerWrapperPass>(
        *static_cast<const WorkerWrapperPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::OwningRewritePatternList patterns;
    patterns.insert<ForceOfKnownApPattern>(&getContext());
    patterns.insert<ForceOfThunkifyPattern>(&getContext());
    patterns.insert<OutlineRecursiveApEagerOfThunkPattern>(&getContext());
    patterns.insert<OutlineRecursiveApEagerOfConstructorPattern>(&getContext());
    patterns.insert<CaseOfKnownConstructorPattern>(&getContext());
    patterns.insert<CaseOfBoxedRecursiveApWithFinalConstruct>(&getContext());

    // change:
    //   retval = case x of L1 -> { ...; return Foo(x1); } L2 -> { ...; return
    //   Foo(x2); }
    // into:
    //  v = case x of L1 -> { ...; return x1; } L2 -> { ...; return x2; };
    //  retval = Foo(v)
    patterns.insert<PeelCommonConstructorsInCase>(&getContext());
    patterns.insert<InlineApEagerPattern>(&getContext());

    ::llvm::DebugFlag = true;

    // ConversionTarget target(getContext());
    // if (failed(mlir::applyPartialConversion(getOperation(), target,
    //                                         std::move(patterns)))) {
    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "===Worker wrapper failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    } else {

      llvm::errs() << "===Worker wrapper succeeded===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
    }
    ::llvm::DebugFlag = false;
  };
}; // namespace standalone

std::unique_ptr<mlir::Pass> createWorkerWrapperPass() {
  return std::make_unique<WorkerWrapperPass>();
}

void registerWorkerWrapperPass() {
  ::mlir::registerPass("lz-worker-wrapper", "Perform worker wrapper transform",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createWorkerWrapperPass();
                       });
}

} // namespace standalone
} // namespace mlir