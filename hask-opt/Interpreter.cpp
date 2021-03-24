#include "Interpreter.h"
#include "GRIN/GRINOps.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Pointer/PointerOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "llvm/Support/Casting.h"
#include <Pointer/PointerDialect.h>
#include <map>

using namespace mlir;
using namespace standalone;

const char *G_ERASED_VALUE_TAG = "ERASED-VALUE";

// build the argv linked list from stdio.
InterpValue buildArgv(const Pass::ListOption<std::string> &ss) {
  // List.nil -> ... ; List.cons -> ... ;
  InterpValue tail = InterpValue::constructor("0", {});
  for(int i = ss.size() - 1; i >= 0; i--) {
    tail = InterpValue::constructor("1", {InterpValue::s(ss[i]), tail});
  }
  
  return tail;
}

// I have no idea WTF this representation is, but I'm just obeying it.
InterpValue buildRealWorld() {
  return InterpValue::constructor("0", {InterpValue::i(420), InterpValue::i(420)});

}

llvm::raw_ostream &operator<<(llvm::raw_ostream &o, const InterpStats &s) {
  o << "num_thunkify_calls(" << s.num_thunkify_calls << ")\n";
  o << "num_force_calls(" << s.num_force_calls << ")\n";
  o << "num_construct_calls(" << s.num_construct_calls << ")\n";
  return o;
}

llvm::raw_ostream &operator<<(llvm::raw_ostream &o, const InterpValue &v) {
  switch (v.type) {
  case InterpValueType::ClosureTopLevel: {
    o << "closure(";
    o << v.closureTopLevelFn() << ", ";
    for (int i = 0; i < v.closureTopLevelNumArgs(); ++i) {
      o << v.closureArg(i);
      if (i + 1 < v.closureTopLevelNumArgs()) {
        o << " ";
      }
    }
    o << ")";
    break;
  };
  case InterpValueType::Ref: {
    o << v.ref();
    break;
  }
  case InterpValueType::I64: {
    o << v.i();
    break;
  }
  case InterpValueType::ThunkifiedValue: {
    o << "thunk(" << v.thunkifiedValue() << ")";
    break;
  }

  case InterpValueType::Constructor: {
    o << "constructor(" << v.constructorTag() << " ";
    for (int i = 0; i < v.constructorNumArgs(); ++i) {
      o << v.constructorArg(i);
      if (i + 1 < v.constructorNumArgs()) {
        o << " ";
      }
    }
    o << ")";
    break;
  }
  default:
    assert("WTF SIDDHARTH");
  } // end switch
  return o;
}

struct InterpreterError {
  InFlightDiagnostic diag;

  InterpreterError(mlir::Location loc)
      : diag(loc.getContext()->getDiagEngine().emit(
            loc, DiagnosticSeverity::Error)) {}

  ~InterpreterError() {
    diag.report();
    assert(false && "interpreter error");
    exit(1);
  }
};

InterpreterError &operator<<(InterpreterError &err, std::string s) {
  err.diag << s;
  return err;
}

InterpreterError &operator<<(InterpreterError &err, int i) {
  err.diag << i;
  return err;
}

InterpreterError &operator<<(InterpreterError &err, Operation &op) {
  err.diag << op;
  return err;
}

struct Env {
public:
  void addNew(mlir::Value k, const InterpValue &v) {
    assert(!find(k));
    insert(k, v);
  }

  void update(mlir::Value k, const InterpValue &v) {
    for (auto &it : env) {
      if (it.first == k) {
        it.second = v;
        return;
      }
    }
    assert(false && "unable to find element in Env");
  }

  /// loc: location to throw error at
  /// k: value to lookup
  InterpValue lookup(mlir::Location loc, mlir::Value k) const {
    // DiagnosticEngine &diagEngine = k.getContext()->getDiagEngine();
    auto it = find(k);
    if (!it) {
      InterpreterError err(k.getLoc());
      llvm::errs() << "\n\n===unable to find key: |";
      k.print(llvm::errs());
      llvm::errs() << "|====\n";
      llvm::errs() << "\n====owning block:=====\n";
      k.getParentBlock()->print(llvm::errs());
      llvm::errs() << "\n=====owning op:=====\n";
      k.getParentBlock()->getParentOp()->print(llvm::errs());

      llvm::errs() << "\n";
      err << "unable to find key";
      assert(false && "unable to find key in the interpreter");
    }
    return it.getValue();
  }

private:
  Optional<InterpValue> find(mlir::Value k) const {
    for (const auto &it : env) {
      if (it.first == k) {
        return {it.second};
      }
    }
    return {};
  }
  void insert(mlir::Value k, const InterpValue &v) { env.emplace_back(k, v); }

  // you have got to be f***ing kidding me. Value doesn't have a < operator?
  std::vector<std::pair<mlir::Value, InterpValue>> env;
};

enum class TerminatorResultType { Branch, ReturnValue, ReturnVoid };
struct TerminatorResult {
  const TerminatorResultType type;

  TerminatorResult(Block *bbNext)
      : type(TerminatorResultType::Branch), bbNext_(bbNext) {}
  TerminatorResult(InterpValue returnValue)
      : type(TerminatorResultType::ReturnValue), returnValue_(returnValue) {}

  explicit TerminatorResult() : type(TerminatorResultType::ReturnVoid) {}

  InterpValue returnValue() {
    assert(type == TerminatorResultType::ReturnValue);
    assert(returnValue_);
    return returnValue_.getValue();
  }
  Block *bbNext() {
    assert(type == TerminatorResultType::Branch);
    return bbNext_;
  }

private:
  Block *bbNext_;
  Optional<InterpValue> returnValue_;
};

struct Interpreter {
  // TODO: generalize to multi dimensional affine expressions
  int interpAffineBound(Location loc, AffineBound b, const Env &env) {
    AffineExpr expr = b.getMap().getResult(0);
    if (auto c = expr.dyn_cast<AffineConstantExpr>()) {
      return c.getValue();
    }

    if (auto s = expr.dyn_cast<AffineSymbolExpr>()) {
      return env.lookup(loc, b.getOperand(s.getPosition())).i();
    }

    InterpreterError err(loc);
    err << "unknown affine expression";
    llvm::errs() << "unknown affine expression: |" << expr << "|\n";
    assert(false && "unknown affine expression");
  }
  // dispatch the correct interpret function.
  void interpretOperation(Operation &op, Env &env) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting operation:--\n";
    llvm::errs().resetColor();
    op.print(llvm::errs());
    llvm::errs() << "\n";
    mlir::OpPrintingFlags printGeneric =
        mlir::OpPrintingFlags().printGenericOpForm();
    op.print(llvm::errs(), printGeneric);
    fprintf(stderr, "\n");
    fflush(stdout);
    // =========== PtrOps ===========================//
    if (ptr::PtrStringOp ptrStrOp = dyn_cast<ptr::PtrStringOp>(op)) {
      env.addNew(ptrStrOp.getResult(), InterpValue::s(ptrStrOp.getString()));
      return;
    }

    //============= HaskOps ========================//
    if (HaskConstructOp cons = dyn_cast<HaskConstructOp>(op)) {
      stats.num_construct_calls++;
      std::vector<InterpValue> vs;
      for (int i = 0; i < cons.getNumOperands(); ++i) {
        vs.push_back(env.lookup(cons.getLoc(), cons.getOperand(i)));
      }
      env.addNew(
          cons.getResult(),
          InterpValue::constructor(cons.getDataConstructorName().str(), vs));
      return;
    }

    if (ThunkifyOp thunkify = dyn_cast<ThunkifyOp>(op)) {
      stats.num_thunkify_calls++;
      env.addNew(thunkify.getResult(),
                 InterpValue::thunkifiedValue(
                     env.lookup(thunkify.getLoc(), thunkify.getOperand())));
      return;
    }

    if (ApOp ap = dyn_cast<ApOp>(op)) {
      InterpValue fn = env.lookup(ap.getLoc(), ap.getFn());
      stats.num_thunkify_calls++;

      if (fn.type == InterpValueType::Ref) {

        std::vector<InterpValue> args;
        for (int i = 0; i < ap.getNumFnArguments(); ++i) {
          args.push_back(env.lookup(ap.getLoc(), ap.getFnArgument(i)));
        }
        env.addNew(ap.getResult(), InterpValue::closureTopLevel(fn, args));

      } else {
        assert(fn.type == InterpValueType::ClosureLambda);
        // [[NOTE: hacky lambda representation]]
        // add all arguments into the closure.
        // HACK: if we have:
        // l = lambda [a, b] (c, d) <code>
        // z = ap(l, v1, v2)

        // [[l]] = closureLambda with pointer to l, vs: [[a]], [[b]]
        // [[z]] = closureLambda with pointer to l, vs: [[a]], [[b]], [[v1]],
        // [[v2]] so that upon execution, we know what `a` and `b` are, and also
        // what `c` and `d` are.
        std::vector<InterpValue> args;
        for (int i = 0; i < fn.closureLambdaNumArguments(); ++i) {
          args.push_back(fn.closureLambdaArgument(i));
        }

        for (int i = 0; i < ap.getNumFnArguments(); ++i) {
          args.push_back(env.lookup(ap.getLoc(), ap.getFnArgument(i)));
        }
        env.addNew(ap.getResult(),
                   InterpValue::closureLambda(fn.closureLambdaLam(), args));
      }
      return;
    }
    if (ForceOp force = dyn_cast<ForceOp>(op)) {
      stats.num_force_calls++;
      InterpValue scrutinee = env.lookup(force.getLoc(), force.getScrutinee());
      
      if (scrutinee.type == InterpValueType::ThunkifiedValue) {
        env.addNew(force.getResult(), scrutinee.thunkifiedValue());
        return;
      } else if (scrutinee.type == InterpValueType::ClosureLambda) {
        // see [[NOTE: hacky lambda representation]]
        env.addNew(force.getResult(),
                   interpretLambda(scrutinee.closureLambdaLam(),
                                   scrutinee.closureLambdaArguments()));
        return;
      } else if (scrutinee.type == InterpValueType::ClosureTopLevel) {
        assert(scrutinee.type == InterpValueType::ClosureTopLevel);
        InterpValue scrutineefn = scrutinee.closureTopLevelFn();
        assert(scrutineefn.type == InterpValueType::Ref);
        std::vector<InterpValue> args(scrutinee.closureArgBegin(),
                                      scrutinee.closureArgEnd());
        env.addNew(force.getResult(),
                   *interpretFunction(scrutineefn.ref(), args));
        return;
      } else {
	llvm::errs() << "ERROR: expected scrutinee to be lazy value\n";
	llvm::errs() << "scrutinee value: |" << scrutinee  << "|\n";

	assert(scrutinee.type == InterpValueType::ThunkifiedValue ||
	       scrutinee.type == InterpValueType::ClosureTopLevel ||
	       scrutinee.type == InterpValueType::ClosureLambda);
	assert(false && "incorrect scrutinee type");
      }
    }
    if (CaseOp case_ = dyn_cast<CaseOp>(op)) {
      InterpValue scrutinee = env.lookup(case_.getLoc(), case_.getScrutinee());
      assert(scrutinee.type == InterpValueType::Constructor);

      for (int i = 0; i < case_.getNumAlts(); ++i) {
        // no match
        if (case_.getAltLHS(i).getValue().str() != scrutinee.constructorTag()) {
          continue;
        }

        // skip default case
        if (case_.getDefaultAltIndex().getValueOr(-1) == i) {
          continue;
        }

        // matched!
        env.addNew(case_.getResult(),
                   *interpretRegion(case_.getAltRHS(i),
                                    scrutinee.constructorArgs(), env));
        return;
      }

      llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
      if (!case_.getDefaultAltIndex()) {
        llvm::errs() << "vvvv ERROR CASE vvvvv\n";
        llvm::errs() << case_ << "\n";
        llvm::errs() << "scrutinee: " << scrutinee << "\n";
        llvm::errs () << "ERROR: no valid case alternative, nor valid default alt\n";
        llvm::errs() << "^^^^ ERROR CASE ^^^^\n";
      }

      assert(case_.getDefaultAltIndex() && "neither match, nor default");
      llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
      env.addNew(case_,
                 *interpretRegion(case_.getAltRHS(*case_.getDefaultAltIndex()),
                                  {}, env));
      return;
    }

    if (CaseIntOp caseInt = dyn_cast<CaseIntOp>(op)) {
      InterpValue scrutinee =
          env.lookup(caseInt.getLoc(), caseInt.getScrutinee());
      assert(scrutinee.type == InterpValueType::I64);

      // bool matched = false;
      for (int i = 0; i < caseInt.getNumAlts(); ++i) {

        // skip default case
        if (caseInt.getDefaultAltIndex().getValueOr(-1) == i) {
          continue;
        }
        // no match
        llvm::errs() << "getAltLhs(i=" << i << "): " << caseInt.getAltLHS(i)
                     << "\n";
        if (caseInt.getAltLHS(i)->getInt() != scrutinee.i()) {
          continue;
        }
        // matched!
        env.addNew(caseInt, *interpretRegion(caseInt.getAltRHS(i), {}, env));
        return;
      }

      assert(caseInt.getDefaultAltIndex() && "neither match, nor default");
      env.addNew(caseInt, *interpretRegion(caseInt.getDefaultRHS(), {}, env));
      return;
    }

    if (ApEagerOp ap = dyn_cast<ApEagerOp>(op)) {
      InterpValue fnval = env.lookup(ap.getLoc(), ap.getFn());
      assert(fnval.type == InterpValueType::Ref);

      std::vector<InterpValue> args;
      for (int i = 0; i < ap.getNumFnArguments(); ++i) {
        args.push_back(env.lookup(ap.getLoc(), ap.getFnArgument(i)));
      }
      env.addNew(ap.getResult(), *interpretFunction(fnval.ref(), args));
      return;
    }

    if (HaskLambdaOp lam = dyn_cast<HaskLambdaOp>(op)) {
      std::vector<InterpValue> args;
      for (int i = 0; i < (int)lam.getNumOperands(); ++i) {
        args.push_back(env.lookup(lam.getLoc(), lam.getOperand(i)));
      }

      env.addNew(lam.getResult(), InterpValue::closureLambda(lam, args));
      return;
    }

    if (standalone::IntegerConstOp cst = dyn_cast<IntegerConstOp>(op)) {
      env.addNew(cst.getResult(), InterpValue::i(cst.getValue()));
      return;
    }

    if (TagGetOp tagget = dyn_cast<TagGetOp>(op)) {
      InterpValue constructor = env.lookup(tagget->getLoc(), tagget.getOperand());
      std::string tag = constructor.constructorTag();
      // This might fuck up royally, let's see
      env.addNew(tagget.getResult(), InterpValue::constructor(tag, {}));
      return;
    }

    if (ProjectionOp pi = dyn_cast<ProjectionOp>(op)) {
      InterpValue constructor = env.lookup(pi->getLoc(), pi.getOperand());
      int ix = pi.getIndex(); // recall that ix is 0-indexed.
      env.addNew(pi.getResult(), constructor.constructorArg(ix ));
      return;
    }

    if (ErasedValueOp erased = dyn_cast<ErasedValueOp>(op)) {
      // How can this ever run in the first place?
      env.addNew(erased.getResult(), InterpValue::constructor(G_ERASED_VALUE_TAG, {}));
      return;
    }

    if (IncOp inc = dyn_cast<IncOp>(op)) {
      InterpValue v = env.lookup(inc->getLoc(), inc.getOperand());
      v.refcountIncrement();
      env.update(inc.getOperand(), v);
      return;
    }

    if (DecOp dec = dyn_cast<DecOp>(op)) {
      InterpValue v = env.lookup(dec->getLoc(), dec.getOperand());
      v.refcountDecrement();
      if (v.refcount_ < -1) {
        llvm::errs() << "ERROR: reference count dropped below zero: |" << dec << "|\n";
      }
      assert(v.refcount_ >= -1 && "expected refcount to be non-negative");
      env.update(dec.getOperand(), v);
      return;
    }

    /*
    if (PapOp pap = dyn_cast<PapOp>(op)) {
      std::vector<InterpValue> args;
      for(int i = 0; i < pap->getNumOperands(); ++i) {
        args.push_back(env.lookup(pap.getLoc(), pap->getOperand(i)));
      }

      env.addNew(pap.getResult(), InterpValue::closureTopLevel(pap.getFn(), args));
    }
     */


    //============= StdOps ========================//
    if (mlir::ConstantIntOp cint = mlir::dyn_cast<mlir::ConstantIntOp>(op)) {
      env.addNew(cint.getResult(), InterpValue::i(cint.getValue()));
      return;
    }
    if (mlir::ConstantOp constop = mlir::dyn_cast<mlir::ConstantOp>(op)) {
      if (mlir::IntegerAttr consti =
              constop.getValue().dyn_cast<mlir::IntegerAttr>()) {
        env.addNew(constop.getResult(), InterpValue::i(consti.getInt()));
        return;
      }

      if (mlir::FlatSymbolRefAttr constref =
              constop.getValue().dyn_cast<mlir::FlatSymbolRefAttr>()) {
        env.addNew(constop.getResult(),
                   InterpValue::ref(constref.getValue().str()));
        return;
      }
      InterpreterError err(op.getLoc());
      err << "INTERPRETER ERROR: unknown type of constant: |" << op << "|\n";

      return;
    }

    if (auto add = dyn_cast<mlir::AddIOp>(op)) {
      InterpValue a = env.lookup(add.getLoc(), add.getOperand(0));
      InterpValue b = env.lookup(add.getLoc(), add.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(add.getResult(), InterpValue::i(a.i() + b.i()));
      return;
    }

    if (auto sub = dyn_cast<mlir::SubIOp>(op)) {
      InterpValue a = env.lookup(sub.getLoc(), sub.getOperand(0));
      InterpValue b = env.lookup(sub.getLoc(), sub.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(sub.getResult(), InterpValue::i(a.i() - b.i()));
      return;
    }
    if (auto mul = dyn_cast<mlir::MulIOp>(op)) {
      InterpValue a = env.lookup(mul.getLoc(), mul.getOperand(0));
      InterpValue b = env.lookup(mul.getLoc(), mul.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(mul.getResult(), InterpValue::i(a.i() * b.i()));
      return;
    }
    if (auto cmp = dyn_cast<mlir::CmpIOp>(op)) {
      InterpValue a = env.lookup(cmp.getLoc(), cmp.getOperand(0));
      InterpValue b = env.lookup(cmp.getLoc(), cmp.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      switch (cmp.predicate()) {
      case CmpIPredicate::eq:
        env.addNew(cmp.getResult(), InterpValue::i(a.i() == b.i()));
        return;
      case CmpIPredicate::ne:
      case CmpIPredicate::slt:
      case CmpIPredicate::sle:
      case CmpIPredicate::sgt:
      case CmpIPredicate::sge:
      case CmpIPredicate::ult:
      case CmpIPredicate::ule:
      case CmpIPredicate::ugt:
      case CmpIPredicate::uge:
        assert(false && "unhandled compare predicate");
      }
      return;
    }

    // NOTE: Indexes. We choose to track no difference between indexes
    // and i64s.
    if (auto indexCastOp = mlir::dyn_cast<mlir::IndexCastOp>(op)) {
      auto v = env.lookup(op.getLoc(), indexCastOp.getOperand());
      env.addNew(indexCastOp.getResult(), v);
      return;
    }

    if (auto allocOp = mlir::dyn_cast<mlir::AllocOp>(op)) {
      std::vector<int> dims;
      for (Value dimv : allocOp.getDynamicSizes()) {
        dims.push_back(env.lookup(allocOp.getLoc(), dimv).i());
      }
      env.addNew(allocOp.getResult(), InterpValue::mem(new MemRef(dims)));
      return;
    }

    if (auto dimOp = mlir::dyn_cast<mlir::DimOp>(op)) {
      auto v =
          env.lookup(dimOp.memrefOrTensor().getLoc(), dimOp.memrefOrTensor());
    }

    if (auto call = dyn_cast<mlir::CallOp>(op)) {
      std::vector<InterpValue> args;
      for (Value operand : call.getArgOperands()) {
        args.push_back(env.lookup(call.getLoc(), operand));
      }
      // TODO: generalize to more than 1 result
      // assert(call.getNumResults() == 1);

      Optional<InterpValue> res =
          interpretFunction(call.getCallee().str(), args);

      if (call.getNumResults() == 1) {
        assert(res && "call has a result but function returned no result!");
        env.addNew(call.getResult(0), *res);
      } else {
        assert(!res && "call has no results but function returned a result!");
      }

      return;
    }

    if (auto store = dyn_cast<mlir::StoreOp>(op)) {
      std::vector<InterpValue> args;
      InterpValue memref = env.lookup(store.getLoc(), store.memref());
      InterpValue v = env.lookup(store.getLoc(), store.value());
      // TODO: generalize to multi dimensional indexes
      InterpValue ix = env.lookup(store.getLoc(), *store.getIndices().begin());
      memref.store({ix.i()}, v);
      env.update(store.memref(), memref);
      return;
    }

    if (auto load = dyn_cast<mlir::LoadOp>(op)) {
      std::vector<InterpValue> args;
      InterpValue memref = env.lookup(load.getLoc(), load.memref());
      InterpValue ix = env.lookup(load.getLoc(), *load.getIndices().begin());
      InterpValue result = memref.load({ix.i()});
      env.addNew(load.getResult(), result);
      return;
    }

    if (auto dim = dyn_cast<mlir::DimOp>(op)) {
      InterpValue ix = env.lookup(dim.getLoc(), dim.index());
      InterpValue memref = env.lookup(dim.getLoc(), dim.memrefOrTensor());
      env.addNew(dim.getResult(), InterpValue::i(memref.sizeOfDim(ix.i())));
      return;
    }

    //============= AffineOps ========================//
    // affine.for %arg1 = 0 to %0 {
    //   %2 = index_cast %arg1 : index to i64
    //   affine.store %2, %1[%arg1] : memref<?xi64>
    // }
    // lb: |() -> (0)|; ub: |()[s0] -> (s0)|
    if (mlir::AffineForOp forop = mlir::dyn_cast<mlir::AffineForOp>(op)) {
      AffineBound lb = forop.getLowerBound();
      AffineBound ub = forop.getUpperBound();
      const int lo = interpAffineBound(forop.getLoc(), lb, env);
      const int hi = interpAffineBound(forop.getLoc(), ub, env);

      llvm::Optional<InterpValue> out;
      assert(forop.getNumIterOperands() <= 1);

      llvm::SmallVector<InterpValue, 4> iterArgs;
      for (Value v : forop.getIterOperands()) {
        iterArgs.push_back(env.lookup(forop.getLoc(), v));
      }
      for (int i = lo; i < hi; i += forop.getStep()) {
        llvm::SmallVector<InterpValue, 4> args;
        args.push_back(InterpValue::i(i));
        args.insert(args.end(), iterArgs.begin(), iterArgs.end());

        // this style of copying the region on each interpretRegion()
        // does not preserve loop carried stuff?
        // TODO: this seems like a bug waiting to happen.
        out = interpretRegion(forop.getRegion(), args, env);
        if (out) {
          iterArgs[0] = *out;
        }
      }

      assert(forop.getNumResults() <= 1);
      // a => b <-> !a || b
      assert(!(forop.getNumResults() == 1) || bool(out));
      if (forop.getNumResults() == 1) {
        env.addNew(forop.getResult(0), *out);
      }
      return;
    }

    if (auto store = mlir::dyn_cast<mlir::AffineStoreOp>(op)) {
      // TODO: figure out if it's possible to merge with StoreOp
      std::vector<InterpValue> args;
      InterpValue memref = env.lookup(store.getLoc(), store.memref());
      InterpValue v = env.lookup(store.getLoc(), store.value());
      // TODO: generalize to multi dimensional indexes
      // #indices = 0 is a single cell of memory
      assert(store.indices().size() <= 1);
      if (store.indices().size() == 1) {
        InterpValue ix = env.lookup(store.getLoc(), *store.indices().begin());
        memref.store({ix.i()}, v);
      } else {
        memref.store({0}, v);
      }
      env.update(store.memref(), memref);
      return;
    }

    if (auto load = dyn_cast<mlir::AffineLoadOp>(op)) {
      std::vector<InterpValue> args;
      InterpValue memref = env.lookup(load.getLoc(), load.memref());
      // #indices = 0 is a single cell of memory
      assert(load.indices().size() <= 1);
      if (load.indices().size() == 1) {
        InterpValue ix = env.lookup(load.getLoc(), *load.indices().begin());
        env.addNew(load.getResult(), memref.load({ix.i()}));
      } else {
        env.addNew(load.getResult(), memref.load({0}));
      }

      return;
    }

    //============= GRINOps ========================//
    if (auto box = dyn_cast<grin::GRINBoxOp>(op)) {
      stats.num_construct_calls++;
      std::vector<InterpValue> vs;
      for (int i = 0; i < (int)box.getNumOperands(); ++i) {
        vs.push_back(env.lookup(box.getLoc(), box.getOperand(i)));
      }
      env.addNew(box.getResult(),
                 InterpValue::constructor(box.getDataConstructorName(), vs));
      return;
    }

    if (auto store = dyn_cast<grin::GRINStoreOp>(op)) {
      InterpValue tostore = env.lookup(store.getLoc(), store.getOperand());
      env.addNew(store.getResult(), InterpValue::hpnode(tostore));
      return;
    }

    if (auto fetch = dyn_cast<grin::GRINFetchOp>(op)) {
      InterpValue hpnod = env.lookup(fetch.getLoc(), fetch.getOperand());
      env.addNew(fetch.getResult(), hpnod.hpnodeLoad());
      return;
    }

    if (auto unboxtag = dyn_cast<grin::GRINUnboxTagOp>(op)) {
      InterpValue box = env.lookup(unboxtag.getLoc(), unboxtag.getOperand());
      env.addNew(unboxtag.getResult(),
                 InterpValue::constructorTag(box.constructorTag()));
      return;
    }

    if (auto caseop = dyn_cast<grin::GRINCaseOp>(op)) {
      InterpValue scrutinee =
          env.lookup(caseop.getOperand().getLoc(), caseop.getOperand());
      assert(scrutinee.type == InterpValueType::ConstructorTag);

      for (int i = 0; i < (int)caseop.getNumAlts(); ++i) {
        if (caseop.getAltTag(i) != scrutinee.constructorTag()) {
          continue;
        }
        // TODO: handle "default"
        llvm::Optional<InterpValue> retval =
            interpretRegion(caseop.getRegion(i), {}, env);
        // TODO: handle case that doesn't return anything?
        assert(retval);
        // TODO: handle multiple result
        env.addNew(caseop.getResult(0), *retval);
        return;
      }
      InterpreterError err(op.getLoc());
      err << "INTERPRETER ERROR: unknown case scrutinee: |"
          << scrutinee.constructorTag() << "|\n";
      return;
    }

    if (auto unboxix = dyn_cast<grin::GRINUnboxIxOp>(op)) {
      InterpValue box = env.lookup(unboxix.getLoc(), unboxix.getBox());
      InterpValue ix = env.lookup(unboxix.getLoc(), unboxix.getIx());
      env.addNew(unboxix.getResult(), box.constructorArg(ix.i()));
      return;
    }

    if (auto unbox = dyn_cast<grin::GRINUnboxOp>(op)) {
      InterpValue box = env.lookup(unbox.getLoc(), unbox.getBox());
      assert(box.type == InterpValueType::Constructor);
      assert((int)unbox.getNumResults() == (int)box.constructorNumArgs());
      assert(box.constructorTag() == unbox.getTag());

      for (int i = 0; i < (int)unbox.getNumResults(); ++i) {
        env.addNew(unbox.getResult(i), box.constructorArg(i));
      }
      return;
    }

    if (auto upd = dyn_cast<grin::GRINUpdateOp>(op)) {
      InterpValue hpnode = env.lookup(upd.getLoc(), upd.getHeapNode());
      InterpValue box = env.lookup(upd.getLoc(), upd.getBox());
      hpnode.hpnodeUpdate(box);
      return;
    }

    InterpreterError err(op.getLoc());
    err << "INTERPRETER ERROR: unknown operation:\n|" << op << "|\n";
  };

  TerminatorResult interpretTerminator(Operation &op, Env &env) {
    if (auto ret = dyn_cast<mlir::ReturnOp>(op)) {
      return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand(0)));
    }

    if (auto ret = dyn_cast<HaskReturnOp>(op)) {
      // TODO: we assume we have only one return value
      return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand()));
    }

    if (auto ret = dyn_cast<grin::GRINReturnOp>(op)) {
      assert(ret.getNumOperands() == 1);
      // TODO: we assume we have only one return value
      return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand(0)));
    }

    if (auto ret = dyn_cast<mlir::AffineYieldOp>(op)) {
      assert(ret.getNumOperands() <= 1);
      if (ret.getNumOperands() == 0) {
        return TerminatorResult();
      } else if (ret.getNumOperands() == 1) {
        return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand(0)));
      }
    }

    if (auto condbr = dyn_cast<mlir::CondBranchOp>(op)) {
      InterpValue cond = env.lookup(condbr.getLoc(), condbr.condition());
      assert(cond.type == InterpValueType::I64);
      if (cond.i() == 1) {
        return TerminatorResult(condbr.trueDest());
      } else {
        return TerminatorResult(condbr.falseDest());
      }
    }

    if (auto br = dyn_cast<mlir::BranchOp>(op)) {
      return TerminatorResult(br.dest());
    }

    if (auto blockop = dyn_cast<standalone::HaskBlockOp>(op)) {
      Optional<InterpValue> retval = interpretRegion(blockop.getRestRegion(), {}, env);
      assert(retval && "block operation expects return value.");
      return TerminatorResult(*retval);
    }

    // interesting: semantics of jump is determined by "enclosing block",
    // something that regions help make precise!
    // vvv TODO: need to figure out what we do with blockIx
    if (auto jumpop = dyn_cast<standalone::HaskJumpOp>(op)) {
      standalone::HaskBlockOp parent = jumpop->getParentOfType<standalone::HaskBlockOp>();
      assert(parent && "jumpop must be surrounded by parent.");
      InterpValue arg = env.lookup(jumpop->getLoc(), jumpop.getOperand());
      Optional<InterpValue> retval = interpretRegion(parent.getBlockRegion(), {arg}, env);
      assert(retval && "block operation expects return value.");
      return TerminatorResult(*retval);
    }

    llvm::errs() << "INTERPRETER ERROR: unknown terminator";
    llvm::errs() << "vvvv:unknown terminator:vvvv\n";
    op.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^^^^^\n";
    assert(false && "unknown terminator.");
    return TerminatorResult();
  }

  TerminatorResult interpretBlock(Block &block, Env &env) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting Block:--\n";
    llvm::errs().resetColor();
    block.print(llvm::errs());
    llvm::errs() << "\n";

    for (Operation &op : block) {
      if (op.hasTrait<OpTrait::IsTerminator>()) {
        return interpretTerminator(op, env);
      } else {
        interpretOperation(op, env);
      }
    }
    assert(false && "unreachable location in InterpretBlock");
  }

  llvm::Optional<InterpValue>
  interpretRegion(Region &r, ArrayRef<InterpValue> args, Env env) {
    Env regionEnv(env);

    if (r.getNumArguments() != args.size()) {
      InFlightDiagnostic diag = r.getContext()->getDiagEngine().emit(
          r.getLoc(), DiagnosticSeverity::Error);
      diag << "incorrect number of arguments. Given: |" << args.size() << "|."
           << "Expected: |" << r.getNumArguments() << "| \n";
      diag.report();
      assert(false && "unable to interpret region");
      exit(1);
    }

    for (int i = 0; i < (int)args.size(); ++i) {
      env.addNew(r.getArgument(i), args[i]);
    }

    Block *bbCur = &r.front();

    while (1) {
      TerminatorResult term = interpretBlock(*bbCur, env);
      switch (term.type) {
      case TerminatorResultType::ReturnValue:
        return {term.returnValue()};
      case TerminatorResultType::ReturnVoid:
        return {};
      case TerminatorResultType::Branch:
        bbCur = term.bbNext();
      }
    }
  }

  Optional<InterpValue> interpretPrimopNatRepr(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|NatRepr|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 1 && "printInt expects single argument");
    InterpValue v = args[0];
    assert(v.type == InterpValueType::I64 && "NatRepr expects int argument");
    return {InterpValue::s(std::to_string(v.i()))};

  };


  Optional<InterpValue> InterpretPrimopNatDecEq(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Nat.Eq|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue v = args[0], w = args[1];

    assert(v.type == InterpValueType::I64);
    assert(v.type == InterpValueType::I64);
  // case x_4 : obj of
  //  Bool.false →
  //  Bool.true →
    int tag = v.i() != w.i() ? 0 : 1;
    return {InterpValue::constructor(std::to_string(tag), {}) };
  };

  Optional<InterpValue> InterpretPrimopNatDecLt(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Nat.Lt|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue v = args[0], w = args[1];

    assert(v.type == InterpValueType::I64);
    assert(v.type == InterpValueType::I64);
    // case x_4 : obj of
    //  Bool.false →
    //  Bool.true →
    int tag = (v.i() < w.i()) == false ? 0 : 1; // true comes after false.
    return {InterpValue::constructor(std::to_string(tag), {}) };
  };


  Optional<InterpValue> InterpretPrimopNatSub(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Nat.Sub|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue v = args[0], w = args[1];

    assert(v.type == InterpValueType::I64);
    assert(v.type == InterpValueType::I64);
    return {InterpValue::i(v.i() - w.i()) };
  };

  Optional<InterpValue> InterpretPrimopNatAdd(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Nat.Add|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue v = args[0], w = args[1];

    assert(v.type == InterpValueType::I64);
    assert(v.type == InterpValueType::I64);
    return {InterpValue::i(v.i() + w.i()) };
  };
  Optional<InterpValue> InterpretPrimopNatMul(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Nat.Mul|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2 && "Nat.Eq expects single argument");
    InterpValue v = args[0], w = args[1];

    assert(v.type == InterpValueType::I64);
    assert(v.type == InterpValueType::I64);
    return {InterpValue::i(v.i() * w.i()) };
  };

  Optional<InterpValue> interpretPrimopStringPush(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|StringPush|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue s = args[0], c = args[1];
    assert(s.type == InterpValueType::String);
    assert(c.type == InterpValueType::I64);
    std::string out = s.s();
    out += char(c.i());
    return {InterpValue::s(out)};
  };

  Optional<InterpValue> interpretPrimopStringAppend(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|StringAppend|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue s1 = args[0], s2 = args[1];
    assert(s1.type == InterpValueType::String);
    assert(s2.type == InterpValueType::String);
    return {InterpValue::s(s1.s() + s2.s())};
  };

  Optional<InterpValue> interpretPrimopStringToNat(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|String.toNat!|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 1);
    InterpValue v = args[0];
    assert(v.type == InterpValueType::String);
    std::string s = v.s();
    return {InterpValue::i(atoi(s.c_str()))};
  };
  Optional<InterpValue> InterpretPrimopArrayEmpty(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Array.empty|--\n";
    llvm::errs().resetColor();


    assert(args.size() == 0);
    // create a 1D array with zero elements.
    return {InterpValue::mem(new MemRef({0}) ) };
  };

  Optional<InterpValue> InterpretPrimopArrayPush(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Array.push|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 3);
    InterpValue proof = args[0], arr = args[1], val = args[2];

    assert(proof.type == InterpValueType::Constructor);
    assert(proof.constructorTag() == G_ERASED_VALUE_TAG);

    assert(arr.type == InterpValueType::MemRef);
    arr.push1D(val);

    // this is quite nice, the arrays have value semantics in LEAN!
    return {arr};
  };

  Optional<InterpValue> InterpretPrimopArrayGet(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Array.get|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 4);
    InterpValue proof1 = args[0], proof2 = args[1], arr = args[2], ix = args[3];

    assert(proof1.type == InterpValueType::Constructor);
    assert(proof1.constructorTag() == G_ERASED_VALUE_TAG);

    assert(proof2.type == InterpValueType::Constructor);
    assert(proof2.constructorTag() == G_ERASED_VALUE_TAG);

    assert(arr.type == InterpValueType::MemRef);
    assert(ix.type == InterpValueType::I64);
    std::vector<int> ixs = {ix.i()};
    return arr.load(ixs);
  };

  Optional<InterpValue> InterpretPrimopArraySize(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|Array.size|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2);
    InterpValue proof = args[0], arr = args[1];

    assert(proof.type == InterpValueType::Constructor);
    assert(proof.constructorTag() == G_ERASED_VALUE_TAG);

    assert(arr.type == InterpValueType::MemRef);
    return InterpValue::i(arr.sizeOfDim(0));
  };




  // https://github.com/leanprover/lean4/blob/cc0712fc827fb0e60b0e00c875aaf2a715455c47/src/Init/System/IO.lean#L20
  // https://github.com/leanprover/lean4/blob/cc0712fc827fb0e60b0e00c875aaf2a715455c47/src/Init/System/IO.lean#L308
  Optional<InterpValue> interpretPrimopIOPrintln(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|IO.Println|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2 && "IO.Println expects two arguments");
    InterpValue s = args[0];
    assert(s.type == InterpValueType::String);
    std::string out = s.s();
    // vvv is this a hack? Maybe.
    llvm::outs() << out << "\n";
    return {buildRealWorld()}; // chain the world state (?)
  };




  void interpretPrimopPrintInt(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|printInt|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 1 && "printInt expects single argument");
    InterpValue v = args[0];
    assert(v.type == InterpValueType::I64 && "printInt expects int argument");
    // vvv is this a hack? Maybe.
    llvm::outs() << v.i() << "\n";
  };

  llvm::Optional<InterpValue> interpretFunction(std::string funcname,
                                                ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting function:|" << funcname.c_str() << "|--\n";
    llvm::errs().resetColor();

    if (funcname == "printInt") {
      interpretPrimopPrintInt(args);
      return {};
    }

    if (funcname == "Nat.repr") {
      return interpretPrimopNatRepr(args);
    }
    if (funcname == "Nat.decEq") {
      return InterpretPrimopNatDecEq(args);
    }
    if (funcname == "Nat.decLt") {
      return InterpretPrimopNatDecLt(args);
    }
    if (funcname == "Nat.sub") {
      return InterpretPrimopNatSub(args);
    }
    if (funcname == "Nat.add") {
      return InterpretPrimopNatAdd(args);
    }
    if (funcname == "Nat.mul") {
      return InterpretPrimopNatMul(args);
    }
    if (funcname == "String.push") {
      return interpretPrimopStringPush(args);
    }
    if (funcname == "String.append") {
      return interpretPrimopStringAppend(args);
    }

    if (funcname == "String.toNat!") {
      return interpretPrimopStringToNat(args);
    }
    if (funcname == "String.instInhabitedString") {
      // comes from | unionfind.lean
      llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
      llvm::errs() << "--interpreting primop:|String.instInhabitedString|--\n";
      llvm::errs().resetColor();
      // This is a wild guess of what "ought" to happen.
      return {InterpValue::constructor(G_ERASED_VALUE_TAG, {}) };
    }

    if (funcname == "List.head!._rarg._closed_3") {
      // HACK! I have no idea what this does
      // comes from | unionfind.lean
      llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
      llvm::errs() << "--interpreting primop:|List.head!._rarg._closed_3|--\n";
      llvm::errs().resetColor();
      // This is a wild guess of what "ought" to happen.
      return {InterpValue::constructor(G_ERASED_VALUE_TAG, {}) };

    }


    // vvv HACK: is this print v/s println?
    if (funcname == "IO.print._at.IO.println._spec_1" ||
        funcname == "IO.println._at.Lean.instEval._spec_1") {
      return interpretPrimopIOPrintln(args);
    }


    if (funcname == "Array.empty._closed_1") {
      return InterpretPrimopArrayEmpty(args);
    }
    if (funcname == "Array.push") {
      return InterpretPrimopArrayPush(args);
    }
    if (funcname == "Array.get!") {
      return InterpretPrimopArrayGet(args);
    }
    if (funcname == "Array.size") { // unionfind
      return InterpretPrimopArraySize(args);
    }

    if (funcname == "instInhabitedNat") {
      // comes from | unionfind.lean
      llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
      llvm::errs() << "--interpreting primop:|inhabitedNat|--\n";
      llvm::errs().resetColor();
      // This is a wild guess of what "ought" to happen.
      return {InterpValue::constructor(G_ERASED_VALUE_TAG, {}) };
    }




    // functions are isolated from above; create a fresh environment
    if (FuncOp haskfn = module.lookupSymbol<FuncOp>(funcname)) {
      return interpretRegion(haskfn.getRegion(), args, Env());
    }

    if (FuncOp fn = module.lookupSymbol<FuncOp>(funcname.c_str())) {
      return interpretRegion(fn.getRegion(), args, Env());
    }

    llvm::errs() << "UNABLE TO FIND FUNCTION |" << funcname << "|\n";
    assert(false && "unable to find function.");
  }

  // InterpValue interpretFunction(HaskFuncOp func, ArrayRef<InterpValue>
  // args)
  // {
  //   std::string funcName = func.getName().str();
  //   llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
  //   llvm::errs() << "--interpreting function:|" << funcName.c_str() <<
  //   "|--\n"; llvm::errs().resetColor();
  //   // functions are isolated from above; create a fresh environment.
  //   return interpretRegion(func.getRegion(), args, Env());
  // }

  InterpValue interpretLambda(HaskLambdaOp lam, ArrayRef<InterpValue> args) {
    // see [[NOTE: hacky lambda representation]]

    // bind captured variables.
    Env env;
    for (int i = 0; i < (int)lam.getNumOperands(); ++i) {
      env.addNew(lam.getOperand(i), args[i]);
    }
    // rest are parameters
    SmallVector<InterpValue, 4> params(args.begin() + lam.getNumOperands(),
                                       args.end());
    return *interpretRegion(lam.getRegion(), params, env);
  }

  Interpreter(ModuleOp module) : module(module){};

  InterpStats getStats() const { return stats; }

private:
  ModuleOp module;
  InterpStats stats;
};

struct LzInterpretPass : public Pass {
  LzInterpretPass() : Pass(mlir::TypeID::get<LzInterpretPass>()){};
  StringRef getName() const override { return "LzInterpretPass"; }
  Pass::Option<std::string> optionMode{
      *this, "mode", llvm::cl::desc("mode to run lz interpreter in: choose 'lz' or 'lambdapure'"), llvm::cl::init("lz")};

  Pass::ListOption<std::string> optionStdio{
      *this, "stdio", llvm::cl::desc("standard input"), llvm::cl::ZeroOrMore, llvm::cl::CommaSeparated};

  LzInterpretPass(const LzInterpretPass &other)
      : Pass(::mlir::TypeID::get<LzInterpretPass>()) {}

  std::unique_ptr<Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto newInst = std::make_unique<LzInterpretPass>(
        *static_cast<const LzInterpretPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::ModuleOp mod(getOperation());
    Interpreter I(mod);

    InterpValue val = [&]() {
      if (this->optionMode == "lz") {
        return *I.interpretFunction("main", {});
      } else {
        assert(this->optionMode == "lambdapure");

        // this is some kind of argv.
        // def main (x_1 : obj) (x_2 : obj) : obj :=
        //   case x_1 : obj of
        //    List.nil → ...
        //    List.cons →
        //      let x_5 : obj := proj[0] x_1;
        //      let x_6 : obj := proj[1] x_1;
        //      case x_6 : obj of
        // so, 0: nil; 1: cons. A cons cell is [value, rest-of-list].

        InterpValue argv = buildArgv(optionStdio);

        // HACK! this needs to be something like empty array..?
        // 0 = success, 1 = failure I think.
        // I have no idea what the value inside is supposed to represent.

        // def IO.println._at.main._spec_1 (x_1 : obj) (x_2 : obj) : obj :=
        //   let x_6 : obj := IO.print._at.IO.println._spec_1 x_5 x_2;
        //    ret x_6 <-(2) whatever println returns; I presume |argv|

        //                        vvv(0) |argv|?
        // def main (x_1 : obj) (x_2 : obj) : obj :=
        //   let x_5 : obj := IO.println._at.main._spec_1 x_4 x_2; <-(1) |argv|
        //   case x_5 : obj of <- (3) argv
        //   EStateM.Result.ok →
        //     let x_6 : obj := proj[1] x_5; <- (4) |argv| has two components.
        //   EStateM.Result.error →
        //     let x_8 : obj := proj[0] x_5;
        //     let x_9 : obj := proj[1] x_5;

        InterpValue realworld = buildRealWorld();
        return *I.interpretFunction("main", {argv, realworld});
      }
    }();
    InterpStats stats = I.getStats();
    llvm::outs() << val << "\n" << stats << "\n";
  }
};

std::unique_ptr<mlir::Pass> createLzInterpretPass() {
  return std::make_unique<LzInterpretPass>();
}

void registerLzInterpretPass() {
  //  mlir::PassPipelineRegistration
  ::mlir::registerPass("lz-interpret",
                       "Interpret lz IR and generate statistics of thunking.",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLzInterpretPass();
                       });
}
