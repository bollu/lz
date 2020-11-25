#pragma once
#include "./Runtime.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"

enum class InterpValueType {
  I64,
  ClosureTopLevel,
  ClosureLambda,
  Constructor,
  Ref,
  ThunkifiedValue,
};
struct InterpValue {
  InterpValueType type;

  int i() const {
    assert(type == InterpValueType::I64);
    return i_;
  }

  std::string ref() const {
    assert(type == InterpValueType::Ref);
    return s_;
  }

  static InterpValue i(int i) {
    InterpValue v(InterpValueType::I64);
    v.i_ = i;
    return v;
  }

  static InterpValue thunkifiedValue(InterpValue v) {
    InterpValue thunk(InterpValueType::ThunkifiedValue);
    thunk.vs_.push_back(v);
    return thunk;
  }

  InterpValue thunkifiedValue() const {
    assert(type == InterpValueType::ThunkifiedValue);
    return vs_[0];
  }

  static InterpValue ref(std::string tag) {
    InterpValue ref(InterpValueType::Ref);
    ref.s_ = tag;
    return ref;
  }
  static InterpValue closureTopLevel(InterpValue fn,
                                     std::vector<InterpValue> args) {
    InterpValue closure(InterpValueType::ClosureTopLevel);
    closure.vs_.push_back(fn);
    closure.vs_.insert(closure.vs_.end(), args.begin(), args.end());
    return closure;
  }

  InterpValue closureTopLevelFn() const {
    assert(type == InterpValueType::ClosureTopLevel);
    return vs_[0];
  }

  int closureTopLevelNumArgs() const {
    assert(type == InterpValueType::ClosureTopLevel);
    return vs_.size() - 1;
  }

  InterpValue closureArg(int i) const {
    assert(type == InterpValueType::ClosureTopLevel);
    assert(i >= 0);
    assert(i < closureTopLevelNumArgs());
    return vs_[1 + i];
  }

  std::vector<InterpValue>::const_iterator closureArgBegin() const {
    assert(type == InterpValueType::ClosureTopLevel);
    return vs_.begin() + 1;
  }

  std::vector<InterpValue>::const_iterator closureArgEnd() const {
    assert(type == InterpValueType::ClosureTopLevel);
    return vs_.end();
  }
  static InterpValue closureLambda(mlir::standalone::HaskLambdaOp lam,
                                   std::vector<InterpValue> args) {
    InterpValue closure(InterpValueType::ClosureLambda);
    closure.vs_.insert(closure.vs_.end(), args.begin(), args.end());
    closure.lam = lam;
    return closure;
  }

  mlir::standalone::HaskLambdaOp closureLambdaLam() const {
    assert(type == InterpValueType::ClosureLambda);
    return lam;
  }
  int closureLambdaNumArguments() const {
    assert(type == InterpValueType::ClosureLambda);
    return vs_.size();
  }

  InterpValue closureLambdaArgument(int i) const {
    assert(type == InterpValueType::ClosureLambda);
    return vs_[i];
  }
  std::vector<InterpValue> closureLambdaArguments() const {
    assert(type == InterpValueType::ClosureLambda);
    return vs_;
  }

  static InterpValue constructor(std::string tag, std::vector<InterpValue> vs) {
    InterpValue cons(InterpValueType::Constructor);
    cons.s_ = tag;
    cons.vs_ = vs;
    return cons;
  }

  int constructorNumArgs() const {
    assert(type == InterpValueType::Constructor);
    return vs_.size();
  }

  InterpValue constructorArg(int i) const {
    assert(type == InterpValueType::Constructor);
    assert(i >= 0);
    assert(i < constructorNumArgs());
    return vs_[i];
  }

  std::vector<InterpValue>::const_iterator constructorArgBegin() const {
    assert(type == InterpValueType::Constructor);
    return vs_.begin();
  }

  std::vector<InterpValue>::const_iterator constructorArgEnd() const {
    assert(type == InterpValueType::Constructor);
    return vs_.end();
  }

  std::string constructorTag() const {
    assert(type == InterpValueType::Constructor);
    return s_;
  }

  std::vector<InterpValue> constructorArgs() const {
    assert(type == InterpValueType::Constructor);
    return vs_;
  }

  int i_;
  std::vector<InterpValue> vs_;
  std::string s_;
  mlir::standalone::HaskLambdaOp lam; // ugh
private:
  InterpValue(InterpValueType type) : type(type){};
};

struct InterpStats {
  // number of times a thunk has been created
  int num_thunkify_calls = 0;
  // number of times a thunk has been forced
  int num_force_calls = 0;
  // number of times stuff has been constructed
  int num_construct_calls = 0;
};

llvm::raw_ostream &operator<<(llvm::raw_ostream &o, const InterpStats &s);
llvm::raw_ostream &operator<<(llvm::raw_ostream &o, const InterpValue &v);

// interpret a module, and interpret the result as an integer. print it out.
std::pair<InterpValue, InterpStats> interpretModule(mlir::ModuleOp module);
