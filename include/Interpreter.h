#pragma once
#include "./Runtime.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"

struct InterpValue;

enum class InterpValueType {
  I64,
  String,
  MemRef,
  ClosureTopLevel,
  ClosureLambda,
  Constructor,
  Ref,
  ThunkifiedValue,
  HpNode,         // heap node for grin.
  ConstructorTag, // constructor tag, reified for grin.
};

// we need the template nonsense to break the loop between `MemRef`
// and `InterpValue`.
template <typename T> struct MemRefT {
  using KeyTy = std::vector<int>;
  MemRefT() {}
  MemRefT(const KeyTy &dims) : dims(dims) {
    int size = 1;
    for (int d : dims) {
      assert(d >= 0 && "negative dimension illegal");
      llvm::errs() << d << " ";
      size *= d;
    }

    assert(size >= 0 && "negative size illegal");
    // TODO: mem.resize(size) CRASHES! WTF? Find out why and fix.
    for (int i = 0; i < size; ++i) {
      mem.push_back({});
    }
  }

  T load(const KeyTy &key) const {
    llvm::Optional<T> ov = mem[_idx(key)];
    assert(ov && "trying to load from index that has not been stored to!");
    return ov.getValue();
  }

  void store(const KeyTy &key, T v) {
    const int i = _idx(key);
    assert(i < (int)mem.size());
    mem[i] = llvm::Optional<T>(v);
  }

  int sizeOfDim(int i) {
    assert(i >= 0);
    assert(i < (int)dims.size());
    return dims[i];
  }

private:
  KeyTy dims;
  std::vector<llvm::Optional<T>> mem; // row-major storage

  int _idx(const KeyTy &key) const {
    int rank = dims.size();
    // rank = 0 a single cell.
    assert(rank >= 0 && "MemRef must have non-negative rank.");

    int idx = 0, stride = 1;
    for (int i = rank - 1; i >= 0; i--) {
      idx += stride * key[i];
      stride *= dims[i];
    }
    return idx;
  }
};

using MemRef = MemRefT<InterpValue>;

struct InterpValue {
  InterpValueType type;
  //============= String ======================//
  static InterpValue s(std::string s) {
    InterpValue v(InterpValueType::String);
    v.s_ = s;
    return v;
  }
  std::string s() const {
    assert(type == InterpValueType::String);
    return s_;
  }

  //============= I64 ======================//
  static InterpValue i(int i) {
    InterpValue v(InterpValueType::I64);
    v.i_ = i;
    return v;
  }
  int i() const {
    assert(type == InterpValueType::I64);
    return i_;
  }

  //============= MemRef ======================//
  static InterpValue mem(MemRef *mem) {
    InterpValue v(InterpValueType::MemRef);
    v.mem_ = mem;
    return v;
  }
  InterpValue load(MemRef::KeyTy key) const {
    assert(this->type == InterpValueType::MemRef);
    return mem_->load(key);
  }
  void store(MemRef::KeyTy key, InterpValue v) {
    assert(this->type == InterpValueType::MemRef);
    mem_->store(key, v);
  }

  int sizeOfDim(int i) {
    assert(this->type == InterpValueType::MemRef);
    return mem_->sizeOfDim(i);
  }

  //============= Ref ======================//
  static InterpValue ref(std::string tag) {
    InterpValue ref(InterpValueType::Ref);
    ref.s_ = tag;
    return ref;
  }
  std::string ref() const {
    assert(type == InterpValueType::Ref);
    return s_;
  }

  //============= ThunkifiedValue ======================//
  static InterpValue thunkifiedValue(InterpValue v) {
    InterpValue thunk(InterpValueType::ThunkifiedValue);
    thunk.vs_.push_back(v);
    return thunk;
  }
  InterpValue thunkifiedValue() const {
    assert(type == InterpValueType::ThunkifiedValue);
    return vs_[0];
  }

  //============= ClosureTopLevel ======================//
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

  //============= ClosureLampbda ======================//
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

  //===================== Constructor ==========================//
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
    assert(type == InterpValueType::Constructor ||
           type == InterpValueType::ConstructorTag);
    return s_;
  }

  std::vector<InterpValue> constructorArgs() const {
    assert(type == InterpValueType::Constructor);
    return vs_;
  }

  //============= HeapNode ======================//
  static InterpValue hpnode(InterpValue c) {
    // only boxed values can be stored on the heap!
    assert(c.type == InterpValueType::Constructor);
    InterpValue v(InterpValueType::HpNode);
    v.hpNodeValue = new InterpValue(c);
    return v;
  }
  InterpValue hpnodeLoad() const {
    assert(this->type == InterpValueType::HpNode);
    return *hpNodeValue;
  }
  void hpnodeUpdate(InterpValue c) {
    assert(this->type == InterpValueType::HpNode);
    assert(c.type == InterpValueType::Constructor);
    *this->hpNodeValue = c;
  }

  //============= Constructor Tag ======================//
  static InterpValue constructorTag(std::string tag) {
    InterpValue v(InterpValueType::ConstructorTag);
    v.s_ = tag;
    return v;
  }

  // getter already declared in constructorTag();

  int i_;
  MemRef *mem_;
  InterpValue *hpNodeValue; // interp value this heap node is pointing to. ugh.
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
std::pair<InterpValue, InterpStats> interpretModule(mlir::ModuleOp module, std::string entrypoint);

std::unique_ptr<mlir::Pass> createLzInterpretPass();
void registerLzInterpretPass();
