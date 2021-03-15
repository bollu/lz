#include "Interpreter.h"
#include "GRIN/GRINOps.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "llvm/Support/Casting.h"
#include <map>

using namespace mlir;
using namespace standalone;
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
      assert(scrutinee.type == InterpValueType::ThunkifiedValue ||
             scrutinee.type == InterpValueType::ClosureTopLevel ||
             scrutinee.type == InterpValueType::ClosureLambda);
      if (scrutinee.type == InterpValueType::ThunkifiedValue) {
        env.addNew(force.getResult(), scrutinee.thunkifiedValue());
        return;
      } else if (scrutinee.type == InterpValueType::ClosureLambda) {
        // see [[NOTE: hacky lambda representation]]
        env.addNew(force.getResult(),
                   interpretLambda(scrutinee.closureLambdaLam(),
                                   scrutinee.closureLambdaArguments()));
        return;
      } else {
        assert(scrutinee.type == InterpValueType::ClosureTopLevel);
        InterpValue scrutineefn = scrutinee.closureTopLevelFn();
        assert(scrutineefn.type == InterpValueType::Ref);
        std::vector<InterpValue> args(scrutinee.closureArgBegin(),
                                      scrutinee.closureArgEnd());
        env.addNew(force.getResult(),
                   *interpretFunction(scrutineefn.ref(), args));
        return;
      }
      assert(false && "unreachable");
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
      int ix = pi.getIndex(); // recall that ix is 1-indexed.
      env.addNew(pi.getResult(), constructor.constructorArg(ix - 1));
      return;
    }

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

    InterpreterError err(op.getLoc());
    err << "INTERPRETER ERROR: unknown terminator";
    llvm::errs() << "---uknown terminator:---\n";
    op.print(llvm::errs(), mlir::OpPrintingFlags().printGenericOpForm());
    llvm::errs() << "\n^^^\n";
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

  Optional<InterpValue> interpretPrimopStringPush(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|StringPush|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2 && "StringPush expects two arguments");
    InterpValue s = args[0], c = args[1];
    assert(s.type == InterpValueType::String);
    assert(c.type == InterpValueType::I64);
    std::string out = s.s();
    out += char(c.i());
    return {InterpValue::s(out)};

  };

  Optional<InterpValue> interpretPrimopIOPrintln(ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting primop:|IO.Println|--\n";
    llvm::errs().resetColor();

    assert(args.size() == 2 && "IO.Println expects two arguments");
    InterpValue s = args[0], argv = args[1];
    assert(s.type == InterpValueType::String);
    std::string out = s.s();
    // vvv is this a hack? Maybe.
    llvm::outs() << out << "\n";
    return {argv}; // chain the world state (?)
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

    if (funcname == "Nat_dot_repr") {
      return interpretPrimopNatRepr(args);
    }

    if (funcname == "String_dot_push") {
      return interpretPrimopStringPush(args);
    }
    // vvv HACK: is this print v/s println?
    if (funcname == "IO_dot_print_dot__at_dot_IO_dot_println_dot__spec_1" ||
        funcname == "IO_dot_println_dot__at_dot_Lean_dot_instEval_dot__spec_1") {
      return interpretPrimopIOPrintln(args);
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
        InterpValue argc = InterpValue::i(0);

        // HACK! this needs to be something like empty array..?
        // 1 = success, 0 = failure I think.
        // I have no idea what the value inside is supposed to represent.
        InterpValue argv = InterpValue::constructor("1", {InterpValue::i(420)});
        return *I.interpretFunction("_lean_main", {argc, argv});
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
