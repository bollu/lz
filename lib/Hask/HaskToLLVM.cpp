//===- HaskToLLVM.cpp - Hask dialect conversion ---------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "Hask/HaskOps.h"
#include "Hask/HaskDialect.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
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
// =SATURATE AP=
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch3/mlir/ToyCombine.cpp
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch3/toyc.cpp
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch3/mlir/Dialect.cpp

// ===== FORCE OP REWRITES =====

// clone the basic block toBeCloned into `beforeInDest`, before location
// `before`, using `args for the arguments.
// https://github.com/llvm/llvm-project/blob/f91f28c350df6815d37c521e8f3dc0641a3ca467/mlir/lib/IR/Region.cpp#L79
Block *cloneBlock(Block &toBeCloned) {
  assert(false && "very dubious");
  BlockAndValueMapping mapper;
  Block *newBlock = new Block();
  mapper.map(&toBeCloned, newBlock);
  for (BlockArgument &arg : toBeCloned.getArguments()) {
    mapper.map(arg, newBlock->addArgument(arg.getType()));
  }

  // Clone and remap the operations within this block.
  for (auto &op : toBeCloned) {
    newBlock->push_back(op.clone(mapper));
  }

  auto remapOperands = [&](Operation &op) {
    for (auto &operand : op.getOpOperands())
      if (auto mappedOp = mapper.lookupOrNull(operand.get()))
        operand.set(mappedOp);
    for (auto &succOp : op.getBlockOperands())
      if (auto *mappedOp = mapper.lookupOrNull(succOp.get()))
        succOp.set(mappedOp);
  };

  for (Operation &op : *newBlock) {
    remapOperands(op);
  }

  return newBlock;
};

// https://github.com/llvm/llvm-project/blob/1372e23c7d4b25fd23689842246e66f70c949b46/mlir/lib/IR/PatternMatch.cpp#L136
Block *cloneBlockBefore(mlir::PatternRewriter &rewriter,
                        Operation *beforeAtDest, Block &src,
                        ValueRange argValues = llvm::None) {
  assert(beforeAtDest);
  Block *newbb = cloneBlock(src);
  rewriter.mergeBlockBefore(&src, beforeAtDest, argValues);
  return newbb;
}

// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===
// === LOWERING ===

// TODO: fix this to use the TypeConverter machinery, not this hacky
// stuff I wrote.
Value transmuteToVoidPtr(Value v, ConversionPatternRewriter &rewriter,
                         Location loc) {
  if (v.getType().isa<LLVM::LLVMType>()) {
    LLVM::LLVMType vty = v.getType().cast<LLVM::LLVMType>();
    if (vty.isPointerTy()) {
      return rewriter.create<LLVM::BitcastOp>(
          loc, LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()),
          ValueRange(v));
    } else if (vty.isIntegerTy()) {

      return rewriter.create<LLVM::IntToPtrOp>(
          loc, LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), v);
    } else {
      assert(false && "unable to transmute into void pointer");
    }
  } else {
    assert(v.getType().isa<FunctionType>() || v.getType().isa<ValueType>() ||
           v.getType().isa<ThunkType>());
    if (v.getType().isa<FunctionType>()) {
      return rewriter.create<LLVM::BitcastOp>(
          loc, LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), v);
    } else {
      return rewriter.create<LLVM::IntToPtrOp>(
          loc, LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), v);
    }
  }
}

Value transmuteToInt(Value v, ConversionPatternRewriter &rewriter,
                     Location loc) {
  if (v.getType().isa<LLVM::LLVMType>()) {
    LLVM::LLVMType vty = v.getType().cast<LLVM::LLVMType>();
    if (vty.isPointerTy()) {
      return rewriter.create<LLVM::PtrToIntOp>(
          loc, LLVM::LLVMType::getInt64Ty(rewriter.getContext()), v);
    } else if (vty.isIntegerTy()) {
      return v;
    } else {
      assert(false && "unable to transmute LLVM type into int");
    }
  } else {
    assert(v.getType().isa<FunctionType>() || v.getType().isa<ValueType>() ||
           v.getType().isa<ThunkType>());
    // this maybe completely borked x(
    return rewriter.create<LLVM::PtrToIntOp>(
        loc, LLVM::LLVMType::getInt64Ty(rewriter.getContext()), v);
  }
}

// Value transmuteFromVoidPtr(Value v, LLVM::LLVMType desired,
// ConversionPatternRewriter &rewriter) {
//     assert(vty.isPointerTy());
//     LLVM::LLVMType vty = v.getType().cast<LLVM::LLVMType>();
//
//     if (desired.isPointerTy()) {
//         return rewriter.create<LLVM::BitcastOp>(
//                 LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), v);
//     } else if (vty.isIntegerTy()) {
//
//         return rewriter.create<LLVM::IntToPtrOp>(
//                 LLVM::LLVMType::getInt8PtrTy(rewriter.getContext()), v);
//     }
//     else {
//         assert(false && "unable to transmute into void pointer");
//     }
//
// }

class HaskToLLVMTypeConverter : public mlir::TypeConverter {
  using TypeConverter::TypeConverter;
};

mlir::LLVM::LLVMType haskToLLVMType(MLIRContext *context, Type t) {
  using namespace mlir::LLVM;

  if (t.isa<ValueType>() || t.isa<ThunkType>()) {
    // return LLVMType::getInt64Ty(context);
    return LLVMType::getInt8PtrTy(context);
  } /* else if (auto fnty = t.dyn_cast<HaskFnType>()) {
    ArrayRef<Type> argTys = fnty.getInputTypes();
    Type retty = fnty.getResultType();

    // recall that functions can occur in negative position:
    // (a -> a) -> a
    // should become (int -> int) -> int
    std::vector<LLVMType> llvmArgTys;
    for (Type arg : argTys) {
      (void)arg;
      llvmArgTys.push_back(LLVMType::getInt8PtrTy(context));
      // llvmArgTys.push_back(haskToLLVMType(context, arg));
    }
    return LLVMType::getFunctionTy(haskToLLVMType(context, retty), llvmArgTys,
                                   false);
  } */
  else {
    assert(false && "unknown haskell type");
  }
};

// http://localhost:8000/structanonymous__namespace_02ConvertStandardToLLVM_8cpp_03_1_1FuncOpConversion.html#a9043f45e0e37eb828942ff867c4fe38d
// class HaskFuncOpConversionPattern : public ConversionPattern {
// public:
//   explicit HaskFuncOpConversionPattern(MLIRContext *context)
//       : ConversionPattern(HaskFuncOp::getOperationName(), 1, context) {}
//
//   LogicalResult
//   matchAndRewrite(Operation *op, ArrayRef<Value> operands,
//                   ConversionPatternRewriter &rewriter) const override {
//     using namespace mlir::LLVM;
//
//     // Operation *module = op->getParentOp();
//     // Now lower the [LambdaOp + HaskFuncOp together]
//     // TODO: deal with free floating lambads. This LambdaOp is going to
//     // become a top-level function. Other lambdas will become toplevel
//     functions
//     // with synthetic names.
//     assert(false);
//     // 1 llvm::errs() << "running HaskFuncOpConversionPattern on: " <<
//     // op->getName() 1              << " | " << op->getLoc() << "\n"; 1 auto
//     fn
//     // = cast<HaskFuncOp>(op); 1 LambdaOp lam = fn.getLambda();
//
//     // 1 SmallVector<LLVM::LLVMType, 4> fnArgTys;
//     // 1 auto I8PtrTy = LLVMType::getInt8PtrTy(rewriter.getContext());
//     // 1 for (int i = 0; i < lam.getNumInputs(); ++i) {
//     // 1   //
//     fnArgTys.push_back(LLVMType::getInt64Ty(rewriter.getContext()));
//     // 1   fnArgTys.push_back(I8PtrTy);
//     // 1 }
//
//     // 1 LLVMFuncOp llvmfn =
//     // 1     rewriter.create<LLVMFuncOp>(fn.getLoc(), fn.getFuncName().str(),
//     // 1                                 LLVMFunctionType::get(I8PtrTy,
//     // fnArgTys));
//
//     // 1 Region &lamBody = lam.getBody();
//     // 1 Block *llvmfnEntry = llvmfn.addEntryBlock();
//     // 1 Block &lamEntry = lamBody.getBlocks().front();
//
//     // 1 llvm::errs() << "converting lambda:\n";
//     // 1 llvm::errs() << *lamBody.getParentOp() << "\n";
//     // 1 rewriter.mergeBlocks(&lamBody.getBlocks().front(), llvmfnEntry,
//     // 1                      llvmfnEntry->getArguments());
//
//     // 1 rewriter.eraseOp(op);
//     // llvm::errs() << *module << "\n";
//     // assert(false);
//     // assert(false);
//
//     /*
//     FuncOp stdFunc = ::mlir::FuncOp::create(fn.getLoc(),
//             fn.getFuncName().str(),
//             FunctionType::get({}, {rewriter.getI64Type()},
//     rewriter.getContext())); rewriter.inlineRegionBefore(lam.getBody(),
//     stdFunc.getBody(), stdFunc.end()); rewriter.insert(stdFunc);
//     */
//
//     return success();
//   }
// };

// isConstructorTagEq(TAG : char *, constructor: void * -> bool)
static FlatSymbolRefAttr
getOrInsertIsConstructorTagEq(PatternRewriter &rewriter, ModuleOp module) {
  const std::string name = "isConstructorTagEq";
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto llvmI1Ty = LLVM::LLVMType::getInt1Ty(rewriter.getContext());

  // constructor, string constructor name
  SmallVector<mlir::LLVM::LLVMType, 4> argsTy{llvmI8PtrTy, llvmI8PtrTy};
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI1Ty, argsTy,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

// extractConstructorArgN(constructor: void *, arg_ix: int) -> bool)
static FlatSymbolRefAttr
getOrInsertExtractConstructorArg(PatternRewriter &rewriter, ModuleOp module) {
  const std::string name = "extractConstructorArg";
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto llvmI64Ty = LLVM::LLVMType::getInt64Ty(rewriter.getContext());

  // string constructor name, <n> arguments.
  SmallVector<mlir::LLVM::LLVMType, 4> argsTy{llvmI8PtrTy, llvmI64Ty};
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI8PtrTy, argsTy,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

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
    global = builder.create<LLVM::GlobalOp>(loc, type, /*isConstant=*/true,
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

class CaseOpConversionPattern : public ConversionPattern {
public:
  explicit CaseOpConversionPattern(MLIRContext *context)
      : ConversionPattern(CaseOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    auto caseop = cast<CaseOp>(op);
    ModuleOp mod = op->getParentOfType<ModuleOp>();
    const Optional<int> default_ix = caseop.getDefaultAltIndex();

    // delete the use of the case.
    // TODO: Change the IR so that we create a landing pad BB where the
    // case uses all wind up.
    for (Operation *user : op->getUsers()) {
      rewriter.eraseOp(user);
    }
    Value scrutinee = caseop.getScrutinee();

    rewriter.setInsertionPoint(caseop);
    // TODO: get block of current caseop?

    Block *prevBB = rewriter.getInsertionBlock();
    for (int i = 0; i < caseop.getNumAlts(); ++i) {
      if (default_ix && i == *default_ix) {
        continue;
      }
      // Type result, IntegerAttr predicate, Value lhs, Value rhs
      FlatSymbolRefAttr is_cons_tag_eq =
          getOrInsertIsConstructorTagEq(rewriter, mod);
      Value lhsName = getOrCreateGlobalString(
          caseop.getLoc(), rewriter, caseop.getAltLHS(i).getValue(),
          caseop.getAltLHS(i).getValue(), mod);
      SmallVector<Value, 4> is_cons_tag_eq_params{scrutinee, lhsName};
      LLVM::CallOp scrut_eq_alt = rewriter.create<LLVM::CallOp>(
          caseop.getLoc(), LLVMType::getInt1Ty(rewriter.getContext()),
          is_cons_tag_eq, is_cons_tag_eq_params);

      Block *thenBB =
          rewriter.createBlock(caseop.getParentRegion(), /*insertPt=*/{});

      rewriter.setInsertionPointToEnd(thenBB);
      Block &altRhs = caseop.getAltRHS(i).getBlocks().front();
      SmallVector<Value, 4> extractedFields;
      FlatSymbolRefAttr extractConstructorArg =
          getOrInsertExtractConstructorArg(rewriter, mod);
      llvm::errs() << "-number of arguments: [" << altRhs.getNumArguments()
                   << "]--\n";
      for (int i = 0; i < (int)altRhs.getNumArguments(); ++i) {
        Value ival = rewriter.create<LLVM::ConstantOp>(
            caseop.getLoc(), LLVMType::getInt64Ty(rewriter.getContext()),
            rewriter.getI64IntegerAttr(i));
        SmallVector<Value, 2> args = {scrutinee, ival};
        LLVM::CallOp call = rewriter.create<LLVM::CallOp>(
            caseop.getLoc(), LLVMType::getInt8PtrTy(rewriter.getContext()),
            extractConstructorArg, args);
        extractedFields.push_back(call.getResult(0));
      }
      llvm::errs() << "-----merging blocks-----\n";
      rewriter.mergeBlocks(&altRhs, thenBB, extractedFields);
      llvm::errs() << "--DONE MERGE BLOCKS (CaseOp)--\n";

      Block *elseBB =
          rewriter.createBlock(caseop.getParentRegion(), /*insertPt=*/{});
      rewriter.setInsertionPointToEnd(prevBB);
      rewriter.create<LLVM::CondBrOp>(
          rewriter.getUnknownLoc(), scrut_eq_alt.getResult(0), thenBB, elseBB);
      rewriter.setInsertionPointToEnd(elseBB);
    }

    // we have a default block
    if (default_ix) {
      // default block should have ha no parameters!
      llvm::errs() << "--MERGE BLOCKS (CaseOp/Default)--\n";
      rewriter.mergeBlocks(&caseop.getAltRHS(*default_ix).front(),
                           rewriter.getInsertionBlock(), scrutinee);
      llvm::errs() << "--MERGE BLOCKS (CaseOp/Default)--\n";
    } else {
      // wut?
      // if (!rewriter.getInsertionBlock()->getTerminator()) {
      rewriter.create<mlir::LLVM::UnreachableOp>(rewriter.getUnknownLoc());
      // }
    }
    rewriter.eraseOp(caseop);
    return success();
  }
};

// 1 class LambdaOpConversionPattern : public ConversionPattern {
// 1 public:
// 1   explicit LambdaOpConversionPattern(MLIRContext *context)
// 1       : ConversionPattern(LambdaOp::getOperationName(), 1,
// 1                           context) {}
// 1
// 1   LogicalResult
// 1   matchAndRewrite(Operation *op, ArrayRef<Value> operands,
// 1                   ConversionPatternRewriter &rewriter) const override {
// 1     auto lam = cast<LambdaOp>(op);
// 1     assert(lam);
// 1     llvm::errs() << "running LambdaOpConversionPattern on: " <<
// op->getName() 1                  << " | " << op->getLoc() << "\n";
// 1
// 1     return failure();
// 1   }
// 1 };

// Humongous hack: we run a sort of "type inference" algorithm, where at the
// call-site, we convert from a !hask.untyped to a concrete (say, int64)
// type. We bail with an error if we are unable to replace the type.
void unifyOpTypeWithType(Value src, Type dstty) {
  if (src.getType() == dstty) {
    return;
  }
  assert(false && "unable to unify types!");
}

static FlatSymbolRefAttr getOrInsertMkClosure(PatternRewriter &rewriter,
                                              ModuleOp module, int n) {

  const std::string name = "mkClosure_capture0_args" + std::to_string(n);
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  llvm::SmallVector<LLVM::LLVMType, 4> argTys(n + 1, I8PtrTy);
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

class ApOpConversionPattern : public ConversionPattern {
public:
  explicit ApOpConversionPattern(MLIRContext *context)
      : ConversionPattern(ApOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    llvm::errs() << "running ApSSAConversionPattern on: " << op->getName()
                 << " | " << op->getLoc() << "\n";
    ApOp ap = cast<ApOp>(op);
    ModuleOp module = ap.getParentOfType<ModuleOp>();

    llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
    // LLVMType kparamty =
    //     haskToLLVMType(rewriter.getContext(), ap.getResult().getType());

    // Wow, in what order does the conversion happen? I have no idea.
    // LLVMFuncOp parent = ap.getParentOfType<LLVMFuncOp>();
    // assert(parent && "found lambda parent");
    // LLVMType kretty =
    // parent.getType().cast<LLVMFunctionType>().getReturnType(); llvm::errs()
    // << "kretty: " << kretty << "\n";

    // LLVMType kFnTy = LLVM::LLVMType::getFunctionTy(kretty, kparamty,
    //         /*isVarArg=*/false);
    // llvm::errs() << "kFnTy: " << kFnTy << "\n";
    // // I deserve to be shot for this. This is not even deterministic!
    // // I'm not even sure how to get deterministic names inside MLIR Which is
    // multi threaded.
    // // What information uniquely identifies an `ap`? it's parameters? but we
    // want names that are unique
    // // across functions. So hash(fn name + hash(params))? this is crazy.
    // // K = kontinuation.
    // std::string kname = "ap_" + std::to_string(rand());
    // // Insert the printf function into the body of the parent module.
    // PatternRewriter::InsertionGuard insertGuard(rewriter);
    // rewriter.setInsertionPointToStart(module.getBody());
    // LLVMFuncOp apK = rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(),
    // kname, kFnTy); SymbolRefAttr kfn =  SymbolRefAttr::get(kname,
    // rewriter.getContext()); Block *entry = apK.addEntryBlock();
    // rewriter.setInsertionPoint(entry, entry->end());

    rewriter.setInsertionPointAfter(ap);
    SmallVector<Value, 4> llvmFnArgs;
    llvmFnArgs.push_back(transmuteToVoidPtr(ap.getFn(), rewriter, ap.getLoc()));
    for (int i = 0; i < ap.getNumFnArguments(); ++i) {
      llvmFnArgs.push_back(
          transmuteToVoidPtr(ap.getFnArgument(i), rewriter, ap.getLoc()));
    }

    FlatSymbolRefAttr mkclosure =
        getOrInsertMkClosure(rewriter, module, ap.getNumFnArguments());
    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op, LLVMType::getInt8PtrTy(rewriter.getContext()), mkclosure,
        llvmFnArgs);
    return success();
  }
};

static FlatSymbolRefAttr getOrInsertEvalClosure(PatternRewriter &rewriter,
                                                ModuleOp module) {
  const std::string name = "evalClosure";
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto VoidPtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(VoidPtrTy, VoidPtrTy,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

class ForceOpConversionPattern : public ConversionPattern {
public:
  explicit ForceOpConversionPattern(MLIRContext *context)
      : ConversionPattern(ForceOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    ForceOp force = cast<ForceOp>(op);
    using namespace mlir::LLVM;
    // assert(force.getScrutinee().getType().isa<LLVMFunctionType>());
    // LLVMFunctionType scrutty =
    // force.getScrutinee().getType().cast<LLVMFunctionType>();

    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op, LLVMType::getInt8PtrTy(rewriter.getContext()),
        getOrInsertEvalClosure(rewriter, force.getParentOfType<ModuleOp>()),
        force.getScrutinee());
    return success();
  }
};

[[maybe_unused]] static FlatSymbolRefAttr
getOrInsertMalloc(PatternRewriter &rewriter, ModuleOp module) {
  if (module.lookupSymbol<LLVM::LLVMFuncOp>("malloc")) {
    return SymbolRefAttr::get("malloc", rewriter.getContext());
  }

  auto llvmI64Ty = LLVM::LLVMType::getInt64Ty(rewriter.getContext());
  auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI8PtrTy, llvmI64Ty,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), "malloc", llvmFnType);
  return SymbolRefAttr::get("malloc", rewriter.getContext());
}

static FlatSymbolRefAttr getOrInsertMkConstructor(PatternRewriter &rewriter,
                                                  ModuleOp module, int n) {
  const std::string name = "mkConstructor" + std::to_string(n);
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  // auto llvmI64Ty = LLVM::LLVMType::getInt64Ty(rewriter.getContext());
  auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());

  // string constructor name, <n> arguments.
  SmallVector<mlir::LLVM::LLVMType, 4> argsTy(n + 1, llvmI8PtrTy);
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI8PtrTy, argsTy,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

class HaskConstructOpConversionPattern : public ConversionPattern {
public:
  explicit HaskConstructOpConversionPattern(MLIRContext *context)
      : ConversionPattern(HaskConstructOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    HaskConstructOp cons = cast<HaskConstructOp>(op);
    ModuleOp mod = cons.getParentOfType<ModuleOp>();

    using namespace mlir::LLVM;

    FlatSymbolRefAttr mkConstructor = getOrInsertMkConstructor(
        rewriter, op->getParentOfType<ModuleOp>(), cons.getNumOperands());

    Value consName = getOrCreateGlobalString(
        cons.getLoc(), rewriter, cons.getDataConstructorName(),
        cons.getDataConstructorName(), mod);
    SmallVector<Value, 4> args = {consName};
    for (int i = 0; i < cons.getNumOperands(); ++i) {
      // args.push_back(transmuteToVoidPtr(cons.getOperand(i), rewriter,
      //             cons.getLoc()));
      args.push_back(cons.getOperand(i));
    }

    rewriter.replaceOpWithNewOp<mlir::LLVM::CallOp>(
        op, LLVMType::getInt8PtrTy(rewriter.getContext()), mkConstructor, args);

    // FlatSymbolRefAttr malloc = getOrInsertMalloc(rewriter,
    // op->getParentOfType<ModuleOp>());
    // // allocate some huge amount because we can't be arsed to calculate the
    // correct ammount. static const int HUGE = 4200; mlir::LLVM::ConstantOp
    // mallocSz = rewriter.create<mlir::LLVM::ConstantOp>(op->getLoc(),
    //                                         LLVMType::getInt64Ty(rewriter.getContext()),
    //                                         rewriter.getI32IntegerAttr(HUGE));

    // SmallVector<Value, 4> llvmFnArgs = {mallocSz};

    // rewriter.replaceOpWithNewOp<mlir::LLVM::CallOp>(op,
    //                                     LLVMType::getInt8PtrTy(rewriter.getContext()),
    //                                     malloc,
    //                                     llvmFnArgs);

    return success();
  }
};

[[maybe_unused]] static FlatSymbolRefAttr
getOrInsertIsIntEq(PatternRewriter &rewriter, ModuleOp module) {
  const std::string name = "isIntEq";
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto llvmI8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  auto llvmI1Ty = LLVM::LLVMType::getInt1Ty(rewriter.getContext());
  SmallVector<mlir::LLVM::LLVMType, 4> argsTy{llvmI8PtrTy, llvmI8PtrTy};
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(llvmI1Ty, argsTy,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

Block *splitBlockAfter(PatternRewriter &rewriter, Block::iterator after) {
  return rewriter.splitBlock(after->getBlock(), ++after);
}

class CaseIntOpConversionPattern : public ConversionPattern {
public:
  explicit CaseIntOpConversionPattern(MLIRContext *context)
      : ConversionPattern(CaseIntOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
    using namespace mlir::LLVM;
    auto caseop = cast<CaseIntOp>(op);

    const Optional<int> default_ix = caseop.getDefaultAltIndex();

    Value scrutineeInt = rewriter.create<LLVM::PtrToIntOp>(
        caseop.getLoc(), LLVM::LLVMType::getInt64Ty(rewriter.getContext()),
        caseop.getScrutinee());
    Type caseRetty = caseop.getResult().getType();

    Block *prevBB = caseop.getOperation()->getBlock();
    Block *afterCaseBB =
        splitBlockAfter(rewriter, caseop.getOperation()->getIterator());

    afterCaseBB->addArgument(caseRetty);

    // Type result, IntegerAttr predicate, Value lhs, Value rhs
    auto I64Ty = LLVM::LLVMType::getInt64Ty(rewriter.getContext());
    // auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());

    // TODO: get block of current caseop?
    for (int i = 0; i < caseop.getNumAlts(); ++i) {

      if (default_ix && i == *default_ix) {
        continue;
      }

      Block *thenBB =
          rewriter.createBlock(caseop.getParentRegion(), /*insertPt=*/{});
      Block *elseBB =
          rewriter.createBlock(caseop.getParentRegion(), /*insertPt=*/{});

      LLVM::ConstantOp altLhsInt = rewriter.create<LLVM::ConstantOp>(
          caseop.getLoc(), I64Ty, *caseop.getAltLHS(i));

      // prev -> {then, else}
      rewriter.setInsertionPointToEnd(prevBB);
      Value scrut_eq_alt = rewriter.create<LLVM::ICmpOp>(
          caseop.getLoc(), LLVM::ICmpPredicate::eq, scrutineeInt, altLhsInt);

      rewriter.create<LLVM::CondBrOp>(rewriter.getUnknownLoc(), scrut_eq_alt,
                                      thenBB, elseBB);

      // then -> code
      rewriter.setInsertionPointToEnd(thenBB);
      Block &altRhs = caseop.getAltRHS(i).getBlocks().front();
      mlir::ReturnOp altRhsRet = cast<mlir::ReturnOp>(altRhs.getTerminator());
      rewriter.replaceOpWithNewOp<LLVM::BrOp>(
          altRhsRet, altRhsRet.getOperand(0), afterCaseBB);
      rewriter.mergeBlocks(&altRhs, thenBB, scrutineeInt);

      // next
      prevBB = elseBB;
    }

    // we have a default block
    if (default_ix) {
      // default block should have have no parameters?
      Block &defaultRhsBlock = caseop.getAltRHS(*default_ix).front();
      mlir::ReturnOp defaultRet =
          cast<mlir::ReturnOp>(defaultRhsBlock.getTerminator());
      rewriter.mergeBlocks(&defaultRhsBlock, prevBB, {});
      rewriter.replaceOpWithNewOp<LLVM::BrOp>(
          defaultRet, defaultRet.getOperand(0), afterCaseBB);

    } else {
      rewriter.setInsertionPointToEnd(prevBB);
      rewriter.create<mlir::LLVM::UnreachableOp>(rewriter.getUnknownLoc());
    }

    rewriter.replaceOp(caseop, afterCaseBB->getArgument(0));
    return success();
  }
};

static FlatSymbolRefAttr getOrInsertMkClosureThunkify(PatternRewriter &rewriter,
                                                      ModuleOp module) {

  const std::string name = "mkClosure_thunkify";
  if (module.lookupSymbol<LLVM::LLVMFuncOp>(name)) {
    return SymbolRefAttr::get(name, rewriter.getContext());
  }

  auto I8PtrTy = LLVM::LLVMType::getInt8PtrTy(rewriter.getContext());
  llvm::SmallVector<LLVM::LLVMType, 4> argTys{I8PtrTy};
  auto llvmFnType = LLVM::LLVMType::getFunctionTy(I8PtrTy, argTys,
                                                  /*isVarArg=*/false);

  // Insert the printf function into the body of the parent module.
  PatternRewriter::InsertionGuard insertGuard(rewriter);
  rewriter.setInsertionPointToStart(module.getBody());
  rewriter.create<LLVM::LLVMFuncOp>(module.getLoc(), name, llvmFnType);
  return SymbolRefAttr::get(name, rewriter.getContext());
}

class ThunkifyOpConversionPattern : public ConversionPattern {
public:
  explicit ThunkifyOpConversionPattern(MLIRContext *context)
      : ConversionPattern(ThunkifyOp::getOperationName(), 1, context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {

    ThunkifyOp thunkify = cast<ThunkifyOp>(op);
    ModuleOp mod = thunkify.getParentOfType<ModuleOp>();

    using namespace mlir::LLVM;

    FlatSymbolRefAttr llvmThunkifyFn =
        getOrInsertMkClosureThunkify(rewriter, mod);

    rewriter.replaceOpWithNewOp<LLVM::CallOp>(
        op, LLVMType::getInt8PtrTy(rewriter.getContext()), llvmThunkifyFn,
        thunkify.getScrutinee());
    return success();
  }
};
// === LowerHaskToLLVMPass ===
// === LowerHaskToLLVMPass ===
// === LowerHaskToLLVMPass ===

// === LowerHaskToStandardPass ===
// === LowerHaskToStandardPass ===
// === LowerHaskToStandardPass ===
// === LowerHaskToStandardPass ===

namespace {
struct LowerHaskToStandardPass : public Pass {
  LowerHaskToStandardPass()
      : Pass(mlir::TypeID::get<LowerHaskToStandardPass>()){};
  void runOnOperation() override;
  StringRef getName() const override { return "LowerHaskToStandardPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerHaskToStandardPass>(
        *static_cast<const LowerHaskToStandardPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }
};
} // end anonymous namespace.

// http://localhost:8000/ConvertSPIRVToLLVMPass_8cpp_source.html#l00031
void LowerHaskToStandardPass::runOnOperation() {
  ConversionTarget target(getContext());
  // do I not need a pointer to the dialect? I am so confused :(
  HaskToLLVMTypeConverter converter;
  target.addLegalDialect<mlir::StandardOpsDialect>();
  target.addLegalDialect<mlir::LLVM::LLVMDialect>();
  target.addLegalDialect<mlir::scf::SCFDialect>();
  target.addLegalOp<mlir::LLVM::UnreachableOp>();

  // Why do I need this? Isn't adding StandardOpsDialect enough?
  target.addLegalOp<mlir::FuncOp>();
  target.addLegalOp<mlir::ModuleOp>();
  target.addLegalOp<mlir::ModuleTerminatorOp>();

  target.addIllegalDialect<HaskDialect>();
  // target.addLegalOp<HaskRefOp>();
  // target.addLegalOp<HaskADTOp>();
  // target.addLegalOp<LambdaOp>();
  // target.addLegalOp<HaskReturnOp>();
  // target.addLegalOp<CaseOp>();
  // target.addLegalOp<ApOp>();
  // target.addLegalOp<HaskConstructOp>();
  // target.addLegalOp<ForceOp>();

  OwningRewritePatternList patterns;
  // patterns.insert<HaskFuncOpConversionPattern>(&getContext());
  patterns.insert<CaseOpConversionPattern>(&getContext());
  // patterns.insert<LambdaOpConversionPattern>(&getContext());
  // patterns.insert<HaskReturnOpConversionPattern>(&getContext());
  // patterns.insert<HaskRefOpConversionPattern>(&getContext());
  patterns.insert<HaskConstructOpConversionPattern>(&getContext());
  patterns.insert<ForceOpConversionPattern>(&getContext());
  patterns.insert<ApOpConversionPattern>(&getContext());
  patterns.insert<CaseIntOpConversionPattern>(&getContext());
  patterns.insert<ThunkifyOpConversionPattern>(&getContext());

  // llvm::errs() << "===Enabling Debugging...===\n";
  //::llvm::DebugFlag = true;

  if (failed(applyPartialConversion(this->getOperation(), target,
                                    std::move(patterns)))) {
    llvm::errs() << "===Partial conversion failed===\n";
    getOperation()->print(llvm::errs());
    llvm::errs() << "\n===\n";
    signalPassFailure();
  } else {
    llvm::errs() << "===Partial conversion succeeded===\n";
    getOperation()->print(llvm::errs());
    llvm::errs() << "\n===\n";
  }

  //  ::llvm::DebugFlag = false;
  return;
}

std::unique_ptr<mlir::Pass> createLowerHaskToStandardPass() {
  return std::make_unique<LowerHaskToStandardPass>();
}

// === LowerHaskStandardToLLVMPass ===
// === LowerHaskStandardToLLVMPass ===
// === LowerHaskStandardToLLVMPass ===
// === LowerHaskStandardToLLVMPass ===
// === LowerHaskStandardToLLVMPass ===

// this is run in a second phase, so we delete data constructors only
// after we are done processing data constructors.
/*
class MakeDataConstructorOpConversionPattern : public ConversionPattern {
public:
  explicit MakeDataConstructorOpConversionPattern(MLIRContext *context)
      : ConversionPattern(DeclareDataConstructorOp::getOperationName(), 1,
context) {}

  LogicalResult
  matchAndRewrite(Operation *op, ArrayRef<Value> operands,
                  ConversionPatternRewriter &rewriter) const override {
      rewriter.eraseOp(op);
    return success();
  }
};
*/

namespace {
struct LowerHaskStandardToLLVMPass : public Pass {
  LowerHaskStandardToLLVMPass()
      : Pass(mlir::TypeID::get<LowerHaskStandardToLLVMPass>()){};
  StringRef getName() const override { return "LowerHaskToStandardPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LowerHaskStandardToLLVMPass>(
        *static_cast<const LowerHaskStandardToLLVMPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::ConversionTarget target(getContext());
    target.addLegalDialect<mlir::LLVM::LLVMDialect>();
    target.addLegalOp<mlir::ModuleOp, mlir::ModuleTerminatorOp>();
    target.addIllegalDialect<HaskDialect>();
    mlir::LLVMTypeConverter typeConverter(&getContext());
    mlir::OwningRewritePatternList patterns;
    // patterns.insert<MakeDataConstructorOpConversionPattern>(&getContext());

    mlir::populateStdToLLVMConversionPatterns(typeConverter, patterns);
    if (failed(mlir::applyFullConversion(getOperation(), target,
                                         std::move(patterns)))) {
      llvm::errs() << "===Hask+Std -> LLVM lowering failed===\n";
      getOperation()->print(llvm::errs());
      llvm::errs() << "\n===\n";
      signalPassFailure();
    };
  };
};
} // end anonymous namespace.

std::unique_ptr<mlir::Pass> createLowerHaskStandardToLLVMPass() {
  return std::make_unique<LowerHaskStandardToLLVMPass>();
}

} // namespace standalone
} // namespace mlir
