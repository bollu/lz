#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Transforms/InliningUtils.h"
#include "llvm/ADT/SmallPtrSet.h"
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

// The nonsense that is MLIR only sets the type that is tracked by the
// type *attribute* and not *the type of the entry block arguments.
// This really sets the type of the entry block arguments as well.
void reallySetFunctionType(mlir::FuncOp f, mlir::FunctionType ty) {
  f.setType(ty);
  assert(f.getNumArguments() == ty.getNumInputs());

  for (int i = 0; i < (int)f.getNumArguments(); ++i) {
    f.getArgument(i).setType(ty.getInput(i));
  }
}

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
    ModuleOp mod = force->getParentOfType<ModuleOp>();
    FuncOp fn = mod.lookupSymbol<FuncOp>(apfnname);
    if (!fn) {
      return failure();
    }
    // cannot inline a recursive function. Can replace with
    // an apEager
    rewriter.setInsertionPoint(ap);
    ApEagerOp eager = rewriter.create<ApEagerOp>(ap.getLoc(), ap.getFn(),
                                                 fn.getType().getResult(0),
                                                 ap.getFnArguments());
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
          &force->getParentRegion()->front()) {
        assert(false && "force not in entry BB");
        return failure();
      }

      // is this going to break *completely*? or only partially?
      std::unique_ptr<Region> r = std::make_unique<Region>();
      // create a hask func op.
      FuncOp parentfn = force->getParentOfType<FuncOp>();

      ModuleOp module = parentfn->getParentOfType<ModuleOp>();
      rewriter.setInsertionPointToEnd(&module.getBodyRegion().front());

      FuncOp outlinedFn = rewriter.create<FuncOp>(
          force.getLoc(), parentfn.getName().str() + "_outline_unknown_force",
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
    // HaskFuncOp fn = force->getParentOfType<HaskFuncOp>();
    ThunkifyOp thunkify = force.getOperand().getDefiningOp<ThunkifyOp>();
    if (!thunkify) {
      return failure();
    }
    rewriter.replaceOp(force, thunkify.getOperand());

    return success();
  }
};


struct ThunkifyOfForcePattern : public mlir::OpRewritePattern<ThunkifyOp> {
  ThunkifyOfForcePattern(mlir::MLIRContext *context)
      : OpRewritePattern<ThunkifyOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(ThunkifyOp thunkify,
                  mlir::PatternRewriter &rewriter) const override {
    // HaskFuncOp fn = force->getParentOfType<HaskFuncOp>();
    ForceOp force = thunkify.getOperand().getDefiningOp<ForceOp>();
    if (!force) {
      return failure();
    }
    rewriter.replaceOp(thunkify, force.getOperand());
    return success();
  }
};

struct InlineApEagerPattern : public mlir::OpRewritePattern<ApEagerOp> {
  InlineApEagerPattern(mlir::MLIRContext *context)
      : OpRewritePattern<ApEagerOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(ApEagerOp ap,
                  mlir::PatternRewriter &rewriter) const override {

    FuncOp parent = ap->getParentOfType<FuncOp>();
    ModuleOp mod = ap->getParentOfType<ModuleOp>();

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
      return isInlined;
      // assert(succeeded(isInlined) && "unable to inline");
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
  return FunctionType::get(fty.getContext(),  forcedTys, fty.getResult(0));
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

    FuncOp parentfn = ap->getParentOfType<FuncOp>();
    ModuleOp mod = ap->getParentOfType<ModuleOp>();

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
        mlir::FlatSymbolRefAttr::get(rewriter.getContext(), clonedFnName));

    rewriter.replaceOpWithNewOp<ApEagerOp>(
        ap, clonedFnRef, called.getType().getResult(0), clonedFnCallArgs);

    // TODO: this disastrous house of cards depends on the order of cloning.
    // We first replace the reucrsive call, and *then* clone the function.
    FuncOp clonedfn = parentfn.clone();
    clonedfn.setName(clonedFnName);
    reallySetFunctionType(clonedfn, mkForcedFnType(called.getType()));

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
//  case inc of {
//    C inv -> {
//      %inv = extract(@MKC, %inc) : V
//      %w = ... : V
//      %wc = construct(@MKC, w) : C
//      %rec = apEager(@f, wc)
//    }
// }
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
    FuncOp parentfn = ap->getParentOfType<FuncOp>();
    ModuleOp mod = ap->getParentOfType<ModuleOp>();

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

    mlir::FunctionType clonedFnTy = mlir::FunctionType::get(rewriter.getContext(),
        clonedFnCallArgTys, called.getType().getResult(0));

    ConstantOp clonedFnRef = rewriter.create<ConstantOp>(
        ap.getFn().getLoc(), clonedFnTy,
        mlir::FlatSymbolRefAttr::get(rewriter.getContext(), clonedFnName));

    // HaskRefOp clonedFnRef = rewriter.create<HaskRefOp>(
    //     ref.getLoc(), clonedFnName,
    //     FunctionType::get(
    //         clonedFnCallArgTys,
    //         parentfn.getType().cast<FunctionType>().getResult(0),
    //         mod.getContext()));
    // HaskFnType::get(mod.getContext(), clonedFnCallArgTys,
    //                 parentfn.getType().cast<FunctionType>().getResult(0)));

    rewriter.replaceOpWithNewOp<ApEagerOp>(
        ap, clonedFnRef, called.getType().getResult(0), clonedFnCallArgs);
    FuncOp clonedfn = parentfn.clone();

    // 2. Build the cloned function that is an unboxed version of the
    //    case. Eliminate the case for the argument RHS.
    clonedfn.setName(clonedFnName);
    reallySetFunctionType(clonedfn, clonedFnTy);

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
    rewriter.notifyOperationInserted(clonedfn);

    return success();

    assert(false && "matched against f(arg) { case(arg): ...; apEager(f, "
                    "construct(...); } ");
  }
};

// find the single case op of v that is at the same level as of v.
// We can have other uses of v nested inside the case op that is found.
// If there are multiple uses, then give up.
CaseOp findSingleCaseOpUse(BlockArgument v, Region *r) {
  CaseOp c;
  for (auto it : v.getUsers()) {
    if (!c) {
      // the case is not a top-level case. ignored.
      if (it->getParentRegion() != r) {
        continue;
      }
      c = mlir::dyn_cast<CaseOp>(*it);
    } else {
      // we found an operation that is *not* the ancestor of the
      // case of we believe is the corret one.
      if (c.getOperation()->isAncestor(it)) {
        continue;
      }
    }
  }
  return c;
}

// ==INPUT==
// data Box { MkBox(int) }
// @f(x: Box):
// <STUFF-BEFORE-CASE>
// case x of ...
//   MkBox val ->
//      <RHS-OF-CASE-1>
//      f(MkBox(y))
//      <RHS-OF-CASE-2>
// ==OUTPUT==
// @fBox(val: int):
//   case (MkBox val) of ...
//   <RHS-OF-CASE-1>
//    ...
//    fBox(y)
//    <RHS-OF-CASE-2>
//  ----------
//  @f(x):
//    <STUFF-BEFORE-CASE>
//    case x of
//      MkBox val ->
//        <RHS-OF-CASE-1>;
//        fBox(val) <- here is where the problem comes. the
//                               |computation of `val` could depend on other
//                               | random stuff in <stuff-before-case>
//         <RHS-OF-CASE-2>;
//     ..
// This not so easy! We need to carry all the values that are referenced
// by the RHS *into* the outlined function x(oi2
struct OutlineCaseOfFnInput : public mlir::OpRewritePattern<FuncOp> {
  OutlineCaseOfFnInput(mlir::MLIRContext *context)
      : OpRewritePattern<FuncOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(FuncOp parentfn,
                  mlir::PatternRewriter &rewriter) const override {
    mlir::ModuleOp mod = parentfn->getParentOfType<ModuleOp>();

    if (parentfn.getArguments().size() != 1) {
      return failure();
    }

    // TODO: ACTUALLY CHECK THIS CONDITION!
    // The current problem is that something like:
    // case x  of  (1)
    //   Foo x' -> ...
    //    default -> use x (2)
    // counts as TWO uses!

    mlir::standalone::CaseOp caseOfArg =
        findSingleCaseOpUse(parentfn.getArgument(0), &parentfn.getRegion());
    if (!caseOfArg) {
      return failure();
    }

    // TODO: generalize
    if (caseOfArg.getNumAlts() != 1) {
      return failure();
    }

    if (caseOfArg.getAltRHS(0).getNumArguments() != 1) {
      return failure();
    }

    std::string outlinedFnName = parentfn.getName().str() + "_outline_case_arg";
    // <original inputs> -> unwrapped output
    mlir::FunctionType outlinedFnty = rewriter.getFunctionType(
        caseOfArg.getAltRHS(0).getArgument(0).getType(),
        parentfn.getType().getResults());

    // pass has already run and outlined; fail to indicate we have made no
    // progress / have terminated the rewrite system.
    if (mod.lookupSymbol<FuncOp>(outlinedFnName)) {
      return failure();
    }

    llvm::SmallVector<ApEagerOp, 2> recursiveCalls;
    parentfn.walk([&](ApEagerOp call) {
      if (call.getFnName() != parentfn.getName()) {
        return WalkResult::advance();
      }
      recursiveCalls.push_back(call);
      return WalkResult::advance();
    }); // end walk

    // llvm::errs() << "Considering function: |" << parentfn.getName() << "|
    // \n";

    // llvm::errs() << "region:\n" << caseOfArg;
    // llvm::errs() << "\n===\n";

    // try to find ops that we need to copy
    bool canBeSelfContained = true;
    caseOfArg.getAltRHS(0).walk([&](Operation *op) {
      for (Value v : op->getOperands()) {
        if (caseOfArg.getAltRHS(0).isAncestor(v.getParentRegion())) {
          continue;
        }

        // has different region as owner.
        ConstantOp vconst = v.getDefiningOp<ConstantOp>();
        if (vconst) {
          continue;
        }

        canBeSelfContained = false;
        return WalkResult::interrupt();
      }
      return WalkResult::advance();
    }); // end walk

    if (!canBeSelfContained) {
      return failure();
    }

    for (ApEagerOp call : recursiveCalls) {
      llvm::SmallVector<Value, 4> callArgs;
      // replace call = f(argConstruct = Constructor(v)) with fConstructor(v);
      HaskConstructOp argConstruct =
          call.getFnArgument(0).getDefiningOp<HaskConstructOp>();

      if (!argConstruct) {
        continue;
      }
      callArgs.push_back(argConstruct.getOperand(0));
      rewriter.setInsertionPointAfter(call);
      ConstantOp outlinedFnNameSymbol = rewriter.create<ConstantOp>(
          call.getLoc(), outlinedFnty,
          mlir::FlatSymbolRefAttr::get(rewriter.getContext(), outlinedFnName));
      ApEagerOp outlinedCall = rewriter.create<ApEagerOp>(
          call.getLoc(), outlinedFnNameSymbol,
          outlinedFnty.getResult(0), // type of result
          callArgs);
      rewriter.replaceOp(call, outlinedCall.getResult());
    }

    // OK, now create the actually outlined function by cloning our function.
    // Then fixup the return by removing the constructor around the return.
    rewriter.setInsertionPointAfter(parentfn);
    mlir::FuncOp outlinedFn = parentfn.clone();
    outlinedFn.setName(outlinedFnName);
    reallySetFunctionType(outlinedFn, outlinedFnty);
    BlockArgument outlinedFnArg = outlinedFn.getArgument(0);
    rewriter.setInsertionPointToStart(&outlinedFn.getRegion().front());
    HaskConstructOp wrappedOutlinedFnArg = rewriter.create<HaskConstructOp>(
        rewriter.getUnknownLoc(), caseOfArg.getAltLHS(0).getValue(),
        outlinedFnArg);

    llvm::SmallPtrSet<Operation *, 4> except = {
        wrappedOutlinedFnArg.getOperation()};
    outlinedFnArg.replaceAllUsesExcept(wrappedOutlinedFnArg, except);

    llvm::errs() << "===Finished run: CaseOfFnInput===\n";
    llvm::errs() << mod;
    llvm::errs() << "\n===\n";
    mod.push_back(outlinedFn);
    rewriter.notifyOperationInserted(outlinedFn);
    return success();
  }
};

// ===INPUT===
// C { MKC(V) }
// @f(%inc: C)
// ...
// %out = constructor(C, %w)
// lz.return (%out)
struct OutlineReturnOfConstructor : public mlir::OpRewritePattern<FuncOp> {
  OutlineReturnOfConstructor(mlir::MLIRContext *context)
      : OpRewritePattern<FuncOp>(context, /*benefit=*/1) {}
  mlir::LogicalResult
  matchAndRewrite(FuncOp parentfn,
                  mlir::PatternRewriter &rewriter) const override {

    // TODO: use postdom info.
    llvm::errs() << "parentfn: " << parentfn.getName() << "\n";

    if (parentfn.getBlocks().size() != 1) {
      return failure();
    }
    HaskReturnOp ret = mlir::dyn_cast<HaskReturnOp>(
        parentfn.getBlocks().front().getTerminator());
    if (!ret) {
      return failure();
    }
    ModuleOp mod = parentfn->getParentOfType<ModuleOp>();

    HaskConstructOp constructor =
        ret.getOperand().getDefiningOp<HaskConstructOp>();
    if (!constructor) {
      return failure();
    }

    // currently our functions only support a single argument constructor.
    // Will need to generalize by allowing tuple of results.
    if (constructor.getNumOperands() != 1) {
      return failure();
    }

    const std::string outlinedFnName =
        parentfn.getName().str() + "_outline_ret_cons";

    // pass has already run and outlined; fail to indicate we have made no
    // progress / have terminated the rewrite system.
    if (mod.lookupSymbol<FuncOp>(outlinedFnName)) {
      return failure();
    }

    llvm::SmallVector<ApEagerOp, 2> recursiveCalls;
    // replace all recursive calls f() with. constructor(f_outline())
    parentfn.walk([&](ApEagerOp call) {
      if (call.getFnName() != parentfn.getName()) {
        return WalkResult::advance();
      }
      recursiveCalls.push_back(call);
      return WalkResult::advance();
    }); // end walk

    for (ApEagerOp call : recursiveCalls) {
      llvm::SmallVector<Value, 4> callArgs;
      for (int i = 0; i < call.getNumFnArguments(); ++i) {
        callArgs.push_back(call.getFnArgument(i));
      }
      rewriter.setInsertionPointAfter(call);
      ConstantOp outlinedFnNameSymbol = rewriter.create<ConstantOp>(
          call.getLoc(),
          rewriter.getFunctionType(parentfn.getType().getInputs(),
                                   constructor.getOperand(0).getType()),
          mlir::FlatSymbolRefAttr::get(rewriter.getContext(), outlinedFnName));

      ApEagerOp outlinedCall = rewriter.create<ApEagerOp>(
          call.getLoc(), outlinedFnNameSymbol,
          constructor.getOperand(0).getType(), // type of result
          callArgs);
      HaskConstructOp outlinedCallWrap = rewriter.create<HaskConstructOp>(
          call.getLoc(), constructor.getDataConstructorName(),
          outlinedCall.getResult());
      rewriter.replaceOp(call, outlinedCallWrap.getResult());
    }
    // OK, now create the actually outlined function by cloning our function.
    // Then fixup the return by removing the constructor around the return.
    mlir::FuncOp outlinedFn = parentfn.clone();
    outlinedFn.setName(outlinedFnName);

    assert(outlinedFn.getBody().getBlocks().size() == 1);
    HaskReturnOp clonedRet =
        mlir::cast<HaskReturnOp>(outlinedFn.getBody().front().getTerminator());
    HaskConstructOp clonedConstructor =
        clonedRet.getOperand().getDefiningOp<HaskConstructOp>();
    Value clonedConstructorArg = clonedConstructor.getOperand(0);

    // <original inputs> -> unwrapped output
    mlir::FunctionType outlinedFnty = rewriter.getFunctionType(
        parentfn.getType().getInputs(), clonedConstructorArg.getType());
    reallySetFunctionType(outlinedFn, outlinedFnty);
    // return constructor(val) -> return val
    rewriter.setInsertionPointAfter(clonedRet);
    rewriter.replaceOpWithNewOp<HaskReturnOp>(clonedRet, clonedConstructorArg);
    rewriter.eraseOp(clonedConstructor);
    mod.push_back(outlinedFn);
    rewriter.notifyOperationInserted(outlinedFn);

    return success();
  }
};

class AlwaysInlinerInterface : public InlinerInterface {
public:
  AlwaysInlinerInterface(MLIRContext *ctx) : InlinerInterface(ctx) {}

  virtual void processInlinedBlocks(
      iterator_range<Region::iterator> inlinedBlocks) override {}

  bool isLegalToInline(Operation *call, Operation *callable,
                       bool wouldBeCloned) const override {
    return true;
  };
  bool isLegalToInline(Region *dest, Region *src, bool wouldBeCloned,
                       BlockAndValueMapping &valueMapping) const override {
    return true;
  }
  bool isLegalToInline(Operation *op, Region *dest, bool wouldBeCloned,
                       BlockAndValueMapping &valueMapping) const override {
    return true;
  }
  bool shouldAnalyzeRecursively(Operation *op) const override { return true; };
};

struct CaseOfKnownConstructorPattern : public mlir::OpRewritePattern<CaseOp> {
  CaseOfKnownConstructorPattern(mlir::MLIRContext *context)
      : OpRewritePattern<CaseOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseOp caseop,
                  mlir::PatternRewriter &rewriter) const override {
    HaskConstructOp constructor =
        caseop.getScrutinee().getDefiningOp<HaskConstructOp>();
    if (!constructor) {
      return failure();
    }

    rewriter.setInsertionPoint(caseop);
    int altIx =
        *caseop.getAltIndexForConstructor(constructor.getDataConstructorName());

    AlwaysInlinerInterface inliner(rewriter.getContext());

    ModuleOp mod = caseop->getParentOfType<ModuleOp>();
    (void)(mod);
    FuncOp fn = caseop->getParentOfType<FuncOp>();

    llvm::errs() << "===parent func:===\n";
    fn.getOperation()->print(llvm::errs(),
                             mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n\n~~~~~~constructor:~~~~~~\n\n";
    constructor.getOperation()->print(
        llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());

    llvm::errs() << "\n\n~~~~~~case:~~~~~~\n\n";
    caseop.getOperation()->print(llvm::errs(),
                                 mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^^^^\n";

    LogicalResult isInlined =
        inlineRegion(inliner, &caseop.getAltRHS(altIx), caseop,
                     constructor.getOperands(), caseop.getResult());
    assert(succeeded(isInlined) &&
           "unable to inline case of known constructor");

    return success();
  };
};

struct CaseOfKnownIntPattern : public mlir::OpRewritePattern<CaseIntOp> {
  CaseOfKnownIntPattern(mlir::MLIRContext *context)
      : OpRewritePattern<CaseIntOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseIntOp caseop,
                  mlir::PatternRewriter &rewriter) const override {
    ConstantOp constint = caseop.getScrutinee().getDefiningOp<ConstantOp>();
    if (!constint) {
      return failure();
    }

    mlir::IntegerAttr val = constint.value().dyn_cast<mlir::IntegerAttr>();
    if (!val) {
      return failure();
    }

    rewriter.setInsertionPoint(caseop);
    int altIx = *caseop.getAltIndexForConstInt(val.getInt());

    InlinerInterface inliner(rewriter.getContext());

    // note that the default alt index DOES NOT HAVE ARGUMENTS!
    if (altIx == caseop.getDefaultAltIndex()) {
      LogicalResult isInlined =
          inlineRegion(inliner, &caseop.getAltRHS(altIx), caseop,
                       /*inlineOperands=*/{}, caseop.getResult());
      assert(succeeded(isInlined) &&
             "unable to inline the default case of a caseint of known int ");

    } else {
      LogicalResult isInlined =
          inlineRegion(inliner, &caseop.getAltRHS(altIx), caseop,
                       constint.getResult(), caseop.getResult());
      assert(succeeded(isInlined) && "unable to inline the non-default known "
                                     "branch case of a  caseint of known int");
    }
    return success();
  };
}; // namespace standalone

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

    FuncOp fn = caseop->getParentOfType<FuncOp>();

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
// ===INPUT===
// @f(box: List) = case List of Nil -> Foo y; Cons x xs -> Foo z
// ===OUTPUT====
// @f(box: List) = Foo (case List of Nil -> y; Cons x xs -> z)
struct PeelConstructorsFromCasePattern : public mlir::OpRewritePattern<CaseOp> {
  PeelConstructorsFromCasePattern(mlir::MLIRContext *context)
      : OpRewritePattern<CaseOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseOp caseop,
                  mlir::PatternRewriter &rewriter) const override {
    llvm::Optional<std::string> constructorName;

    // ret[i](constructors[i](val)) -> ret[i](val)
    std::vector<mlir::standalone::HaskReturnOp> rets;
    std::vector<mlir::standalone::HaskConstructOp> constructors;

    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      mlir::Region &rhs = caseop.getAltRHS(i);
      if (rhs.getBlocks().size() > 1) {
        return failure();
      }

      mlir::standalone::HaskReturnOp ret =
          mlir::dyn_cast<HaskReturnOp>(rhs.getBlocks().front().getTerminator());
      if (!ret) {
        return failure();
      }
      rets.push_back(ret);

      mlir::standalone::HaskConstructOp constructor =
          ret.getOperand().getDefiningOp<HaskConstructOp>();
      if (!constructor) {
        return failure();
      }
      constructors.push_back(constructor);

      if (!constructorName) {
        constructorName = constructor.getDataConstructorName().str();
        continue;
      }
      assert(constructorName);
      if (constructorName != constructor.getDataConstructorName().str()) {
        return failure();
      }

      // TODO: handle multi argument constructors. Fuck me.
      if (constructor.getNumOperands() != 1) {
        return failure();
      }
    } // end alts loop

    assert(constructorName &&
           "must have found constructor. Otherwise, the case has zero alts!");

    assert(rets.size() == constructors.size());
    std::vector<HaskReturnOp> newRets;
    // ret[i](constructors[i](val)) -> ret[i](val)
    for (int i = 0; i < (int)rets.size(); ++i) {
      rewriter.setInsertionPointAfter(rets[i]);
      newRets.push_back(rewriter.create<mlir::standalone::HaskReturnOp>(
          rets[i].getLoc(), constructors[i].getOperand(0)));
      rewriter.eraseOp(rets[i]);
    }
    assert(newRets.size() > 0);
    caseop.getResult().setType(newRets[0].getType());

    // OK, so all branches have a constructor. pull constructor out
    // after the case.
    rewriter.setInsertionPointAfter(caseop);
    HaskConstructOp peeledConstructor = rewriter.create<HaskConstructOp>(
        rewriter.getUnknownLoc(), *constructorName, caseop.getResult());
    // does this *remove* the old op?

    llvm::SmallPtrSet<mlir::Operation *, 4> exceptions(
        {peeledConstructor.getOperation()});

    // replace all uses, except the one by peeledConstructor
    caseop.getResult().replaceAllUsesExcept(peeledConstructor.getResult(),
                                            exceptions);

    return success();
  }
};

// ===INPUT===
// @f(i: i64) = case box of 0 -> Foo y; 1 -> Foo z
// ===OUTPUT====
// @f(i: i64) = Foo (case i of 0 -> y; 1 -> z)
struct PeelConstructorsFromCaseIntPattern
    : public mlir::OpRewritePattern<CaseIntOp> {
  PeelConstructorsFromCaseIntPattern(mlir::MLIRContext *context)
      : OpRewritePattern<CaseIntOp>(context, /*benefit=*/1) {}

  mlir::LogicalResult
  matchAndRewrite(CaseIntOp caseop,
                  mlir::PatternRewriter &rewriter) const override {
    llvm::Optional<std::string> constructorName;

    // ret[i](constructors[i](val)) -> ret[i](val)
    std::vector<mlir::standalone::HaskReturnOp> rets;
    std::vector<mlir::standalone::HaskConstructOp> constructors;

    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      mlir::Region &rhs = caseop.getAltRHS(i);
      if (rhs.getBlocks().size() > 1) {
        return failure();
      }

      mlir::standalone::HaskReturnOp ret =
          mlir::dyn_cast<HaskReturnOp>(rhs.getBlocks().front().getTerminator());
      if (!ret) {
        return failure();
      }
      rets.push_back(ret);

      mlir::standalone::HaskConstructOp constructor =
          ret.getOperand().getDefiningOp<HaskConstructOp>();
      if (!constructor) {
        return failure();
      }
      constructors.push_back(constructor);

      if (!constructorName) {
        constructorName = constructor.getDataConstructorName().str();
        continue;
      }
      assert(constructorName);
      if (constructorName != constructor.getDataConstructorName().str()) {
        return failure();
      }

      // TODO: handle multi argument constructors. Fuck me.
      if (constructor.getNumOperands() != 1) {
        return failure();
      }
    } // end alts loop

    assert(constructorName &&
           "must have found constructor. Otherwise, the case has zero alts!");

    assert(rets.size() == constructors.size());
    std::vector<HaskReturnOp> newRets;
    // ret[i](constructors[i](val)) -> ret[i](val)
    for (int i = 0; i < (int)rets.size(); ++i) {
      rewriter.setInsertionPointAfter(rets[i]);
      newRets.push_back(rewriter.create<mlir::standalone::HaskReturnOp>(
          rets[i].getLoc(), constructors[i].getOperand(0)));
      rewriter.eraseOp(rets[i]);
    }

    assert(newRets.size() > 0);
    caseop.getResult().setType(newRets[0].getType());

    // OK, so all branches have a constructor. pull constructor out
    // after the case.
    rewriter.setInsertionPointAfter(caseop);
    HaskConstructOp peeledConstructor = rewriter.create<HaskConstructOp>(
        rewriter.getUnknownLoc(), *constructorName, caseop.getResult());
    // does this *remove* the old op?

    llvm::SmallPtrSet<mlir::Operation *, 4> exceptions(
        {peeledConstructor.getOperation()});

    // replace all uses, except the one by peeledConstructor
    caseop.getResult().replaceAllUsesExcept(peeledConstructor.getResult(),
                                            exceptions);

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
    // force(ap) -> apeager. safe.
    patterns.insert<ForceOfKnownApPattern>(&getContext());
    // force(thunkify(x)) -> x. safe.
    patterns.insert<ForceOfThunkifyPattern>(&getContext());
    // apeager(f, x, y, z) -> inlined. safe.
    patterns.insert<InlineApEagerPattern>(&getContext());

    // f(paramt): paramv = force(paramt); use paramv. Safe-ish, since
    // we immediately have a force as the first instruction.
    // 1. Write as FuncOp pattern
    // 2.  Write as closure.
    patterns.insert<OutlineRecursiveApEagerOfThunkPattern>(&getContext());
    // f(paramConstructor) = case paramConstructor of {
    // (Constructor paramValue) -> ..
    // }.
    // Safe ish, since we immediately expect a case of the first
    // instruction.
    // 1. Write as FuncOp pattern
    // 2. write as closure.
    patterns.insert<OutlineRecursiveApEagerOfConstructorPattern>(&getContext());
    // same as above?
    patterns.insert<OutlineCaseOfFnInput>(&getContext());
    // f(x): .. return(Constructor(v)) -> outline the last paer. Safe ish,
    // since we only outline the final computation.
    patterns.insert<OutlineReturnOfConstructor>(&getContext());
    // f: case of {C1 -> D v1; C2 -> D v2; .. Cn -> D vn;} into
    //    f: D (case v of {C1 -> v1; C2 -> v2; .. Cn -> vn; }
    // Safe.
    patterns.insert<PeelConstructorsFromCasePattern>(&getContext());
//     Same as peel constructor from case for ints. safe.
    patterns.insert<PeelConstructorsFromCaseIntPattern>(&getContext());

    // f: case (Ci vi) of { C1 w1 -> e1; C2 w2 -> e2 ... Cn wn -> en};
    //    f: ei[wi := vi].
    // safe
    patterns.insert<CaseOfKnownConstructorPattern>(&getContext());
    // same as Case of known constructor for ints. safe.
    patterns.insert<CaseOfKnownIntPattern>(&getContext());

    ::llvm::DebugFlag = true;

    // ConversionTarget target(getContext());
    // if (failed(mlir::applyPartialConversion(getOperation(), target,
    //                                         std::move(patterns)))) {
    if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "\n===Worker wrapper failed===\n";
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
};


struct WrapperWorkerPass : public Pass {
  WrapperWorkerPass() : Pass(mlir::TypeID::get<WrapperWorkerPass>()){};
  StringRef getName() const override { return "WrapperWorkerPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<WrapperWorkerPass>(
        *static_cast<const WrapperWorkerPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::OwningRewritePatternList patterns;
    patterns.insert<ThunkifyOfForcePattern>(&getContext());

    ::llvm::DebugFlag = true;
  if (failed(mlir::applyPatternsAndFoldGreedily(getOperation(),
                                                  std::move(patterns)))) {
      llvm::errs() << "\n===Worker wrapper failed===\n";
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
};

std::unique_ptr<mlir::Pass> createWorkerWrapperPass() {
  return std::make_unique<WorkerWrapperPass>();
}

std::unique_ptr<mlir::Pass> createWrapperWorkerPass() {
  return std::make_unique<WrapperWorkerPass>();
}

void registerWorkerWrapperPass() {
  ::mlir::registerPass("lz-worker-wrapper", "Perform worker wrapper transform to expose computation",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createWorkerWrapperPass();
                       });
}

void registerWrapperWorkerPass() {
  ::mlir::registerPass("lz-wrapper-worker", "Perform wrapper worker transform to hide computation",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createWrapperWorkerPass();
                       });
}


} // namespace standalone
} // namespace mlir
