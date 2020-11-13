#include <stdio.h>
#include <functional>
#include <optional>
#include <tuple>
#include <assert.h>

using namespace std;; 
int g_count = 0;

struct Int {
  int v;
  Int(int v) : v(v) {
    printf("- building Int(%d): #%d\n", v, ++g_count);
  };

  operator int() { return v; }
};
int casedefault(Int s) {
  static int count = 0;
  return s.v;
}



template<typename T>
struct Thunk {
  Thunk(std::function<T()> lzf) : lzf(lzf) {
    printf("- thunking: #%d\n", ++g_count);
  }

  T v() {
    if(!cached) {
      printf("- forcing: #%d\n", ++g_count);
      cached = lzf();
    }
    assert(cached);
    return *cached;
  }

private:
  std::optional<T> cached;
  std::function<T()> lzf;
};


template<typename T>
T force(Thunk<T> thnk) { return thnk.v(); }

template<typename T>
Thunk<T> thunkify(T v) { return Thunk<T>([v]() { return v; }); }

template<typename R, typename... Args> 
Thunk<R> ap(std::function<R(Args...)> f, Args... args) { 
  return Thunk<R>([=]() { return f(args...); });
}

template<typename R, typename... Args> 
Thunk<R> ap(R(*f)(Args...), Args... args) { 
  return Thunk<R>([=]() { return f(args...); });
}

template<typename R, typename... Args> 
R apStrict(std::function<R(Args...)> f, Args... args) { 
  return f(args...); 
}

// function arguments and real arguments can be mismatched,
// since function can take a Force instead of a Thunk ?
template<typename R, typename... FArgs, typename... Args> 
R apStrict(R(*f)(FArgs...), Args... args) { 
  return f(args...);
}

// === Semantics I have in mind ===
struct Unit {};

// loop = loop
Unit loop() {
    Thunk<Unit> loopThunk = ap(loop);
    Unit ret = force(loopThunk);
    return ret;
}

// eg1. let x = loop in 42
int eg1() {
  Thunk<Unit> loopThunk = ap(loop);
  return Int(42);
}
// eg2. let !x = loop in #42
int eg2() {
  Thunk<Unit> loopThunk = ap(loop);
  Unit u = force(loopThunk);
  return Int(42);
}
// eg3. let !x = loop in x
Unit eg3() {
  Thunk<Unit> loopThunk = ap(loop);
  Unit u = force(loopThunk);
  return u;
}


Int eg1PureForce() {
  // This thunk is never used, eliminate it.
  // Thunk<Unit> loopThunk = ap(loop);
  return Int(42);
}

// eg2. let !x = loop in #42
Int eg2PureForce() {
  Thunk<Unit> loopThunk = ap(loop);
  // can REMOVE force! force is pure, and not involved in producing
  // the return value   vvvv
  // Unit u = force(loopThunk); 
  return Int(42);
}
// eg3. let !x = loop in x
Unit eg3PureForce() {
  Thunk<Unit> loopThunk = ap(loop);
  // CANNOT remove force, it's used to define the return value.
  Unit u = force(loopThunk);
  return u;
}

// === Will forever serveRequest be optimized out? ===

// https://haskell-code-explorer.mfix.io/package/ghc-prim-0.5.2.0/show/GHC/Prim_.hs#L3143
// -- | @State\#@ is the primitive, unlifted type of states.  It has
// --         one type parameter, thus @State\# RealWorld@, or @State\# s@,
// --         where s is a type variable. The only purpose of the type parameter
// --         is to keep different state threads separate.  It is represented by
// --         nothing at all. 
// data State# s
// -- | @RealWorld@ is deeply magical.  It is /primitive/, but it is not
// --         /unlifted/ (hence @ptrArg@).  We never manipulate values of type
// --         @RealWorld@; it\'s only used in the type system, to parameterise @State\#@. 
// data RealWorld
// newtype IO a = IO (State# RealWorld -> (# State# RealWorld, a #))
// forever a   = let a' = a *> a' in a'
// forever $ putStr "a\n";


// take pointers, let this be base class.
// Free monad encoding of IO.
template<typename T>
struct IO { virtual ~IO() {}; protected: IO () {}; };

template<typename T>
struct IOReturn : IO<T> { T t; IOReturn(T t) : t (t) {}; };

struct ServeRequest : public IO<Unit> {};

// >> 
template<typename T>
struct SeqIO  : public IO<T> {
    SeqIO(IO<Unit> *mu, IO<T> *mt) : mu(mu), mt(mt) {};
    IO<Unit> *mu;
    IO<T> *mt;
};

IO<Unit> *mainhs() {
    new IOReturn(Unit());
}

template<typename T>
T runIO(IO<T> *io) {
    if (IOReturn<T> *ret = dynamic_cast<IOReturn<T>*>(io)) {
        return ret->t;
    } if (SeqIO<T> *seq = dynamic_cast<SeqIO<T>*>(io)) {
        runIO(seq->mu);
        return runIO(seq->mt);
    }

}

// ===========================
struct RealWorld {};
template<typename T>
using IORealWorld = pair<T, RealWorld> (*) (RealWorld);

// >> 
template<typename B>
IORealWorld<B> seqIO(IORealWorld<Unit> ioa, IORealWorld<B> iob) {
    return [ioa, iob](RealWorld rw) {
        rw = ioa(rw).second; // take new real world
        rw = iob(rw); // take new real world
        return rw;
    };
}

template<typename A, typename B>
IORealWorld<B> forever(IORealWorld<A> ioa) {
    return [ioa](RealWorld rw) {
        return seqIO(ioa, forever(ioa))(rw); // state token is returned
    };
}
// main() is supposed to return the state token. We cannot eliminate any
// computation that *produces* the state token.

int main () {
    runIO(mainhs());
    return 0;
}
