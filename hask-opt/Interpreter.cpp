#include "Interpreter.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/StandardTypes.h"
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
  void addNew(mlir::Value k, InterpValue v) {
    assert(!find(k));
    insert(k, v);
  }

  InterpValue lookup(mlir::Location loc, mlir::Value k) {
    // DiagnosticEngine &diagEngine = k.getContext()->getDiagEngine();
    auto it = find(k);
    if (!it) {
      InterpreterError err(loc);
      llvm::errs() << "unable to find key: |";
      k.print(llvm::errs());
      llvm::errs() << "|\n";
      llvm::errs() << "owning block:\n";
      k.getParentBlock()->print(llvm::errs());
      llvm::errs() << "owning op:\n";
      k.getParentBlock()->getParentOp()->print(llvm::errs());

      llvm::errs() << "\n";
      err << "unable to find key";
      assert(false && "unable to find key in the interpreter");
    }
    return it.getValue();
  }

private:
  Optional<InterpValue> find(mlir::Value k) {
    for (auto it : env) {
      if (it.first == k) {
        return {it.second};
      }
    }
    return {};
  }
  void insert(mlir::Value k, InterpValue v) {
    env.push_back(std::make_pair(k, v));
  }
  // you have got to be fucking kidding me. Value doesn't have a < operator?
  std::vector<std::pair<mlir::Value, InterpValue>> env;
};

enum class TerminatorResultType { Branch, Return };
struct TerminatorResult {
  const TerminatorResultType type;

  TerminatorResult(Block *bbNext)
      : type(TerminatorResultType::Branch), bbNext_(bbNext) {}
  TerminatorResult(InterpValue returnValue)
      : type(TerminatorResultType::Return), returnValue_(returnValue) {}

  InterpValue returnValue() {
    assert(type == TerminatorResultType::Return);
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
  // dispatch the correct interpret function.
  void interpretOperation(Operation &op, Env &env) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting operation:--\n";
    llvm::errs().resetColor();

    op.print(llvm::errs());
    fprintf(stderr, "\n");
    fflush(stdout);

    if (MakeI64Op mi64 = dyn_cast<MakeI64Op>(op)) {
      env.addNew(mi64.getResult(), InterpValue::i(mi64.getValue().getInt()));
      return;
    }

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

    if (TransmuteOp transmute = dyn_cast<TransmuteOp>(op)) {
      env.addNew(transmute.getResult(),
                 env.lookup(transmute.getLoc(), transmute.getOperand()));
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
                   interpretFunction(scrutineefn.ref(), args));
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
                   interpretRegion(case_.getAltRHS(i),
                                   scrutinee.constructorArgs(), env));
        return;
      }

      llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
      assert(case_.getDefaultAltIndex() && "neither match, nor default");
      llvm::errs() << __FUNCTION__ << ":" << __LINE__ << "\n";
      env.addNew(case_,
                 interpretRegion(case_.getAltRHS(*case_.getDefaultAltIndex()),
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
        llvm::errs() << "caseInt.getDefaultAltIndex(): "
                     << caseInt.getDefaultAltIndex() << "\n";

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
        env.addNew(caseInt, interpretRegion(caseInt.getAltRHS(i), {}, env));
        return;
      }

      assert(caseInt.getDefaultAltIndex() && "neither match, nor default");
      env.addNew(caseInt, interpretRegion(caseInt.getDefaultRHS(), {}, env));
      return;
    }

    if (DefaultCaseOp default_ = dyn_cast<DefaultCaseOp>(op)) {
      // TODO: check that this has only 1 constructor!
      InterpValue scrutinee =
          env.lookup(default_.getLoc(), default_.getScrutinee());
      assert(scrutinee.type == InterpValueType::Constructor);
      assert(scrutinee.constructorTag() == default_.getConstructorTag());
      assert(scrutinee.constructorNumArgs() == 1);
      env.addNew(default_.getResult(), scrutinee.constructorArg(0));
      return;
    }

    if (HaskPrimopSubOp sub = dyn_cast<HaskPrimopSubOp>(op)) {
      InterpValue a = env.lookup(sub.getLoc(), sub.getOperand(0));
      InterpValue b = env.lookup(sub.getLoc(), sub.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(sub.getResult(), InterpValue::i(a.i() - b.i()));
      return;
    }

    if (SubIOp sub = dyn_cast<SubIOp>(op)) {
      InterpValue a = env.lookup(sub.getLoc(), sub.getOperand(0));
      InterpValue b = env.lookup(sub.getLoc(), sub.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(sub.getResult(), InterpValue::i(a.i() - b.i()));
      return;
    }
    if (MulIOp mul = dyn_cast<MulIOp>(op)) {
      InterpValue a = env.lookup(mul.getLoc(), mul.getOperand(0));
      InterpValue b = env.lookup(mul.getLoc(), mul.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(mul.getResult(), InterpValue::i(a.i() * b.i()));
      return;
    }

    if (HaskPrimopAddOp add = dyn_cast<HaskPrimopAddOp>(op)) {
      InterpValue a = env.lookup(add.getLoc(), add.getOperand(0));
      InterpValue b = env.lookup(add.getLoc(), add.getOperand(1));
      assert(a.type == InterpValueType::I64);
      assert(b.type == InterpValueType::I64);
      env.addNew(add.getResult(), InterpValue::i(a.i() + b.i()));
      return;
    }

    if (ApEagerOp ap = dyn_cast<ApEagerOp>(op)) {
      InterpValue fnval = env.lookup(ap.getLoc(), ap.getFn());
      assert(fnval.type == InterpValueType::Ref);

      std::vector<InterpValue> args;
      for (int i = 0; i < ap.getNumFnArguments(); ++i) {
        args.push_back(env.lookup(ap.getLoc(), ap.getFnArgument(i)));
      }
      env.addNew(ap.getResult(), interpretFunction(fnval.ref(), args));
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

    InterpreterError err(op.getLoc());
    err << "INTERPRETER ERROR: unknown operation: |" << op << "|\n";
  };

  TerminatorResult interpretTerminator(Operation &op, Env &env) {
    if (ReturnOp ret = dyn_cast<ReturnOp>(op)) {
      return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand(0)));
    } else if (HaskReturnOp ret = dyn_cast<HaskReturnOp>(op)) {
      // TODO: we assume we have only one return value
      return TerminatorResult(env.lookup(ret.getLoc(), ret.getOperand()));
    } else {
      InterpreterError err(op.getLoc());
      err << "unknown terminator: |" << op << "|\n";
    }
    assert(false && "unreachable");
  }

  TerminatorResult interpretBlock(Block &block, Env &env) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting Block:--\n";
    llvm::errs().resetColor();
    block.print(llvm::errs());
    llvm::errs() << "\n";

    for (Operation &op : block) {
      if (op.isKnownNonTerminator()) {
        interpretOperation(op, env);
      } else if (op.isKnownTerminator()) {
        return interpretTerminator(op, env);
      }
    }
    assert(false && "unreachable location in InterpretBlock");
  }

  InterpValue interpretRegion(Region &r, ArrayRef<InterpValue> args, Env env) {
    Env regionEnv(env);

    if (r.getNumArguments() != args.size()) {
      InFlightDiagnostic diag = r.getContext()->getDiagEngine().emit(
          r.getLoc(), DiagnosticSeverity::Error);
      diag << "incorrect number of arguments. Given: |" << args.size() << "|\n";
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
      case TerminatorResultType::Return:
        return term.returnValue();
      case TerminatorResultType::Branch:
        bbCur = term.bbNext();
      }
    }
  }

  InterpValue interpretFunction(std::string funcname,
                                ArrayRef<InterpValue> args) {
    llvm::errs().changeColor(llvm::raw_fd_ostream::GREEN);
    llvm::errs() << "--interpreting function:|" << funcname.c_str() << "|--\n";
    llvm::errs().resetColor();

    // functions are isolated from above; create a fresh environment
    if (FuncOp haskfn = module.lookupSymbol<FuncOp>(funcname)) {
      return interpretRegion(haskfn.getRegion(), args, Env());
    }

    if (FuncOp fn = module.lookupSymbol<FuncOp>(funcname.c_str())) {
      return interpretRegion(fn.getRegion(), args, Env());
    }

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
    return interpretRegion(lam.getRegion(), params, env);
  }

  Interpreter(ModuleOp module) : module(module){};

  InterpStats getStats() const { return stats; }

private:
  ModuleOp module;
  InterpStats stats;
};

// interpret a module, and interpret the result as an integer. print it out.
std::pair<InterpValue, InterpStats> interpretModule(ModuleOp module) {
  Interpreter I(module);
  InterpValue val = I.interpretFunction("main", {});
  return {val, I.getStats()};
};

struct LzInterpretPass : public Pass {
  LzInterpretPass() : Pass(mlir::TypeID::get<LzInterpretPass>()){};
  StringRef getName() const override { return "LzInterpretPass"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst = std::make_unique<LzInterpretPass>(
        *static_cast<const LzInterpretPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }

  void runOnOperation() override {
    mlir::ModuleOp mod(getOperation());
    std::pair<InterpValue, InterpStats> out = interpretModule(mod);
    llvm::outs() << out.first << "\n" << out.second << "\n";
  }
};

std::unique_ptr<mlir::Pass> createLzInterpretPass() {
  return std::make_unique<LzInterpretPass>();
}

void registerLzInterpretPass() {
  ::mlir::registerPass("lz-interpret",
                       "Interpret lz IR and generate statistics of thunking.",
                       []() -> std::unique_ptr<::mlir::Pass> {
                         return createLzInterpretPass();
                       });
}
