#include "Runtime.h"
#include <stdlib.h>

extern "C" {
#define DEBUG_LOG                                                              \
  if (1) {                                                                     \
    DEBUG_INDENT();                                                            \
    fprintf(stderr, "%s ", __FUNCTION__);                                      \
  }

#ifndef NODEBUG

static int DEBUG_STACK_DEPTH = 0;
void DEBUG_INDENT();

void DEBUG_PUSH_STACK();
void DEBUG_POP_STACK();
void DEBUG_INDENT() {
  for (int i = 0; i < DEBUG_STACK_DEPTH; ++i) {
    fputs("  ⋮", stderr);
  }
}

void DEBUG_PUSH_STACK() { DEBUG_STACK_DEPTH++; }
void DEBUG_POP_STACK() { DEBUG_STACK_DEPTH--; }

char *getPronouncableNum(size_t N) {
  const char *cs = "bcdfghjklmnpqrstvwxzy";
  const char *vs = "aeiou";

  size_t ncs = strlen(cs);
  size_t nvs = strlen(vs);

  char buf[1024];
  char *out = buf;
  int i = 0;
  while (N > 0) {
    const size_t icur = N % (ncs * nvs);
    *out++ = cs[icur % ncs];
    *out++ = vs[(icur / ncs) % nvs];
    N /= ncs * nvs;
    if (N > 0 && !(++i % 2)) {
      *out++ = '-';
    }
  }
  *out = 0;
  return strdup(buf);
};

char *getPronouncablePtr(void *N) { return getPronouncableNum((size_t)N); }

#endif // NODEBUG

void *__attribute__((used, always_inline))
mkClosure_capture0_args2(void *fn, void *a, void *b) {
  Closure *data = (Closure *)malloc(sizeof(Closure));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p:%s, %p:%s, %p:%s) -> %10p:%s\n", fn,
          getPronouncablePtr(fn), a, getPronouncablePtr(a), b,
          getPronouncablePtr(b), data, getPronouncablePtr(data));
#endif
  data->n = 2;
  data->fn = fn;
  data->args[0] = a;
  data->args[1] = b;
  return (void *)data;
}

void *__attribute__((used, always_inline)) __attribute__((always_inline))
mkClosure_capture0_args1(void *fn, void *a) {
  Closure *data = (Closure *)malloc(sizeof(Closure));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p:%s, %p:%s) -> %10p:%s\n", fn, getPronouncablePtr(fn), a,
          getPronouncablePtr(a), data, getPronouncablePtr(data));
#endif
  data->n = 1;
  data->fn = fn;
  data->args[0] = a;
  return (void *)data;
}

void *__attribute__((used, always_inline)) mkClosure_capture0_args0(void *fn) {
  Closure *data = (Closure *)malloc(sizeof(Closure));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p:%s) -> %p:%s\n", fn, getPronouncablePtr(fn), data,
          getPronouncablePtr(data));
#endif
  data->n = 0;
  data->fn = fn;
  return (void *)data;
}

void *identity(void *v) { return v; }

void *__attribute__((used, always_inline, always_inline))
mkClosure_thunkify(void *v) {
  Closure *data = (Closure *)malloc(sizeof(Closure));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p) -> %p\n", v, data);
#endif
  data->n = 1;
  data->fn = (void *)identity;
  data->args[0] = v;
  return (void *)data;
}

typedef void *(*FnZeroArgs)();
typedef void *(*FnOneArg)(void *);
typedef void *(*FnTwoArgs)(void *, void *);

void *__attribute__((used, always_inline)) evalClosure(void *closure_voidptr) {
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p:%s)\n", closure_voidptr,
          getPronouncablePtr(closure_voidptr));
  DEBUG_PUSH_STACK();
#endif
  Closure *c = (Closure *)closure_voidptr;
  assert(c->n >= 0 && c->n <= 3);
  void *ret = NULL;
  if (c->n == 0) {
    FnZeroArgs f = (FnZeroArgs)(c->fn);
    ret = f();
  } else if (c->n == 1) {
    FnOneArg f = (FnOneArg)(c->fn);
    ret = f(c->args[0]);
  } else if (c->n == 2) {
    FnTwoArgs f = (FnTwoArgs)(c->fn);
    ret = f(c->args[0], c->args[1]);
  } else {
    assert(0 && "unhandled function arity");
  }
#ifndef NODEBUG
  DEBUG_POP_STACK();
  DEBUG_INDENT();
  fprintf(stderr, "=>%10p:%s\n", ret, getPronouncablePtr(ret));
#endif
  return ret;
};

void *__attribute__((used, always_inline)) mkConstructor0(const char *tag) {
  Constructor *c = (Constructor *)malloc(sizeof(Constructor));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%s) -> %p:%s\n", tag, c, getPronouncablePtr(c));
#endif
  c->n = 0;
  c->tag = tag;
  return c;
};

void *__attribute__((used, always_inline))
mkConstructor1(const char *__restrict__ tag, void *__restrict__ a) {
  Constructor *c = (Constructor *)malloc(sizeof(Constructor));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%s, %p) -> %p:%s\n", tag, a, c, getPronouncablePtr(c));
#endif
  c->tag = tag;
  c->n = 1;
  c->args[0] = a;
  return c;
};

void *__attribute__((used, always_inline))
mkConstructor2(const char *__restrict__ tag, void *__restrict__ a,
               void *__restrict__ b) {
  Constructor *c = (Constructor *)malloc(sizeof(Constructor));
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%s, %p, %p) -> %p\n", tag, a, b, c);
#endif
  c->tag = tag;
  c->n = 2;
  c->args[0] = a;
  c->args[1] = b;
  return c;
};

void *extractConstructorArg(void *__restrict__ cptr, int i) {
  Constructor *c = (Constructor *)cptr;
  void *v = c->args[i];
  assert(i < c->n);
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "%p %d -> %p:%s\n", cptr, i, v, getPronouncablePtr(v));
#endif
  return v;
}

int isConstructorTagEq(void *__restrict__ cptr, const char *tag) {
  Constructor *c = (Constructor *)cptr;
  const int eq = !strcmp(c->tag, tag);
#ifndef NODEBUG
  DEBUG_LOG;
  fprintf(stderr, "(%p:%s, %s) -> %d\n", cptr, c->tag, tag, eq);
#endif
  return eq;
}

void printInt(int i) { printf("%d\n", i); }

const char *printConstructorGo(void *v, const char *fmt) {
  if (fmt[0] == 'i') {
    printf("%d", (int)((size_t)v));
    return fmt + 1;
  } else {
    assert(fmt[0] == '(');
    fmt++;

    Constructor *c = (Constructor *)v;
    printf("%s(", c->tag);
    assert(c->n <= 2 && "too many values in constructor");
    for (int i = 0; i < c->n; ++i) {
      fmt = printConstructorGo(c->args[i], fmt);
    }
    assert(fmt[0] == ')');
    fmt++;
    printf(")");
    return fmt;
  }
};

void printConstructor(void *v, const char *fmt) {
  fmt = printConstructorGo(v, fmt);
  assert(fmt[0] == 0 && "did not consume format string entirely!");
  printf("\n");
}

I64Memref *unboxI64Memref(void *v) {
  I64Memref *mem = (I64Memref *)malloc(sizeof(I64Memref));
  mem->p = mem->q = mem->s = mem->t = 0;
  mem->r = 42;
  return mem;
}
} // end extern C
