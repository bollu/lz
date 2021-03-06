#pragma once
#include <assert.h>
#include <stdio.h>
#include <string.h>

extern "C" {

static const int MAX_CLOSURE_ARGS = 10;
typedef struct {
  void *p, *q;
  int r;
  void *s, *t;
} I64Memref;
typedef struct {
  int n;
  void *fn;
  void *args[MAX_CLOSURE_ARGS];
} Closure;

char *getPronouncableNum(size_t N);
char *getPronouncablePtr(void *N);

void *__attribute__((used))
mkClosure_capture0_args2(void *fn, void *a, void *b);
void *__attribute__((used)) mkClosure_capture0_args1(void *fn, void *a);
void *__attribute__((used)) mkClosure_capture0_args0(void *fn);
void *identity(void *v);
void *__attribute__((used)) mkClosure_thunkify(void *v);

void *__attribute__((used)) boxMemref(void *v);

typedef void *(*FnZeroArgs)();
typedef void *(*FnOneArg)(void *);
typedef void *(*FnTwoArgs)(void *, void *);

void *__attribute__((used)) evalClosure(void *closure_voidptr);

static const int MAX_CONSTRUCTOR_ARGS = 2;
typedef struct {
  const char *tag; // inefficient!
  int n;
  void *args[MAX_CONSTRUCTOR_ARGS];
} Constructor;

void *__attribute__((used)) mkConstructor0(const char *tag);
void *__attribute__((used)) mkConstructor1(const char *tag, void *a);
void *__attribute__((used)) mkConstructor2(const char *tag, void *a, void *b);
void *extractConstructorArg(void *cptr, int i);
int isConstructorTagEq(void *cptr, const char *tag);
void printInt(int i);
void printConstructor(void *v, const char *fmt);
} // end extern C
