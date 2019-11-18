// Lean compiler output
// Module: Init.Lean.Meta.LevelDefEq
// Imports: Init.Lean.Meta.Basic
#include "runtime/lean.h"
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8;
uint8_t l_Lean_Name_beq___main(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main___boxed(lean_object*, lean_object*);
extern lean_object* l_Array_empty___closed__1;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3;
lean_object* l_Lean_mkLevelMax(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_13__restore___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Level_normalize___main(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6;
lean_object* l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg(lean_object*);
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Meta_mkFreshLevelMVarId___rarg(lean_object*);
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4(lean_object*, lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux(uint8_t, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1;
uint8_t l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Nat_repr(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
extern lean_object* l_PersistentArray_empty___closed__3;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep(lean_object*, lean_object*);
lean_object* l_PersistentArray_push___rarg(lean_object*, lean_object*);
lean_object* l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2(lean_object*, uint8_t, lean_object*, lean_object*);
lean_object* l_Lean_Meta_isReadOnlyLevelMVar(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Meta_assignLevelMVar(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(lean_object*, uint8_t, lean_object*, lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___boxed(lean_object*);
uint8_t l_Lean_Level_isSucc(lean_object*);
lean_object* l_Lean_Level_dec___main(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_name_mk_string(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(lean_object*, lean_object*, lean_object*);
uint8_t l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* l_Lean_Meta_try(lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1;
uint8_t l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(lean_object*, lean_object*);
lean_object* lean_array_push(lean_object*, lean_object*);
uint8_t l_List_isEmpty___rarg(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5;
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Level_mvarId_x21(lean_object*);
uint8_t l_Lean_Level_occurs___main(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___boxed(lean_object*, lean_object*);
extern lean_object* l_Lean_SimpleMonadTracerAdapter_isTracingEnabledFor___rarg___lambda__1___closed__2;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___boxed(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(uint8_t, lean_object*, lean_object*);
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3(lean_object*, lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7;
lean_object* l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Meta_instantiateLevelMVars(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed(lean_object*);
lean_object* l_Lean_Meta_isLevelDefEq___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___boxed(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___boxed(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_13__restore(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l___private_Init_Lean_Trace_4__checkTraceOptionAux___main(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_Meta_isLevelDefEq(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7;
lean_object* lean_array_get_size(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
lean_object* l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1___boxed(lean_object*, lean_object*, lean_object*);
lean_object* lean_array_fget(lean_object*, lean_object*);
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5(lean_object*, lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1;
lean_object* l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3;
uint8_t lean_level_eq(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___boxed(lean_object*);
uint8_t l_Lean_MetavarContext_hasAssignableLevelMVar___main(lean_object*, lean_object*);
uint8_t l_Lean_Level_isMVar(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(lean_object*, lean_object*, lean_object*);
lean_object* l_Lean_mkLevelMVar(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___boxed(lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2;
lean_object* l_Lean_Name_append___main(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax___boxed(lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(lean_object*);
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(uint8_t, lean_object*, lean_object*);
lean_object* l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
uint8_t l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
if (lean_obj_tag(x_2) == 2)
{
lean_object* x_8; lean_object* x_9; uint8_t x_10; 
x_8 = lean_ctor_get(x_2, 0);
x_9 = lean_ctor_get(x_2, 1);
x_10 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(x_1, x_8);
if (x_10 == 0)
{
x_2 = x_9;
goto _start;
}
else
{
uint8_t x_12; 
x_12 = 1;
return x_12;
}
}
else
{
lean_object* x_13; 
x_13 = lean_box(0);
x_3 = x_13;
goto block_7;
}
block_7:
{
uint8_t x_4; 
lean_dec(x_3);
x_4 = lean_level_eq(x_2, x_1);
if (x_4 == 0)
{
uint8_t x_5; 
x_5 = l_Lean_Level_occurs___main(x_1, x_2);
return x_5;
}
else
{
uint8_t x_6; 
x_6 = 0;
return x_6;
}
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
uint8_t l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; 
x_3 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(x_1, x_2);
return x_3;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
uint8_t l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 2)
{
lean_object* x_3; lean_object* x_4; uint8_t x_5; 
x_3 = lean_ctor_get(x_2, 0);
x_4 = lean_ctor_get(x_2, 1);
x_5 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(x_1, x_3);
if (x_5 == 0)
{
uint8_t x_6; 
x_6 = l___private_Init_Lean_Meta_LevelDefEq_1__strictOccursMaxAux___main(x_1, x_4);
return x_6;
}
else
{
uint8_t x_7; 
x_7 = 1;
return x_7;
}
}
else
{
uint8_t x_8; 
x_8 = 0;
return x_8;
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
switch (lean_obj_tag(x_2)) {
case 2:
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_4 = lean_ctor_get(x_2, 0);
lean_inc(x_4);
x_5 = lean_ctor_get(x_2, 1);
lean_inc(x_5);
lean_dec(x_2);
x_6 = l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(x_1, x_4, x_3);
x_2 = x_5;
x_3 = x_6;
goto _start;
}
case 5:
{
lean_object* x_8; uint8_t x_9; 
x_8 = lean_ctor_get(x_2, 0);
lean_inc(x_8);
x_9 = l_Lean_Name_beq___main(x_8, x_1);
lean_dec(x_8);
if (x_9 == 0)
{
lean_object* x_10; 
x_10 = l_Lean_mkLevelMax(x_3, x_2);
return x_10;
}
else
{
lean_dec(x_2);
return x_3;
}
}
default: 
{
lean_object* x_11; 
x_11 = l_Lean_mkLevelMax(x_3, x_2);
return x_11;
}
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(x_1, x_2, x_3);
lean_dec(x_1);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(x_1, x_2, x_3);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff(x_1, x_2, x_3);
lean_dec(x_1);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_4 = l_Lean_Meta_mkFreshLevelMVarId___rarg(x_3);
x_5 = lean_ctor_get(x_4, 0);
lean_inc(x_5);
x_6 = lean_ctor_get(x_4, 1);
lean_inc(x_6);
lean_dec(x_4);
lean_inc(x_5);
x_7 = l_Lean_mkLevelMVar(x_5);
x_8 = l___private_Init_Lean_Meta_LevelDefEq_3__mkMaxArgsDiff___main(x_5, x_1, x_7);
x_9 = l_Lean_Meta_assignLevelMVar(x_5, x_8, x_2, x_6);
return x_9;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg___boxed), 3, 0);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(x_1, x_2, x_3);
lean_dec(x_2);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_6 = lean_ctor_get(x_4, 5);
x_7 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_7, 0, x_1);
lean_ctor_set(x_7, 1, x_2);
x_8 = l_PersistentArray_push___rarg(x_6, x_7);
lean_ctor_set(x_4, 5, x_8);
x_9 = lean_box(0);
x_10 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_10, 0, x_9);
lean_ctor_set(x_10, 1, x_4);
return x_10;
}
else
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_21; 
x_11 = lean_ctor_get(x_4, 0);
x_12 = lean_ctor_get(x_4, 1);
x_13 = lean_ctor_get(x_4, 2);
x_14 = lean_ctor_get(x_4, 3);
x_15 = lean_ctor_get(x_4, 4);
x_16 = lean_ctor_get(x_4, 5);
lean_inc(x_16);
lean_inc(x_15);
lean_inc(x_14);
lean_inc(x_13);
lean_inc(x_12);
lean_inc(x_11);
lean_dec(x_4);
x_17 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_17, 0, x_1);
lean_ctor_set(x_17, 1, x_2);
x_18 = l_PersistentArray_push___rarg(x_16, x_17);
x_19 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_19, 0, x_11);
lean_ctor_set(x_19, 1, x_12);
lean_ctor_set(x_19, 2, x_13);
lean_ctor_set(x_19, 3, x_14);
lean_ctor_set(x_19, 4, x_15);
lean_ctor_set(x_19, 5, x_18);
x_20 = lean_box(0);
x_21 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_21, 0, x_20);
lean_ctor_set(x_21, 1, x_19);
return x_21;
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
if (lean_obj_tag(x_1) == 5)
{
lean_object* x_5; lean_object* x_6; 
x_5 = lean_ctor_get(x_1, 0);
lean_inc(x_5);
x_6 = l_Lean_Meta_isReadOnlyLevelMVar(x_5, x_3, x_4);
if (lean_obj_tag(x_6) == 0)
{
lean_object* x_7; uint8_t x_8; 
x_7 = lean_ctor_get(x_6, 0);
lean_inc(x_7);
x_8 = lean_unbox(x_7);
lean_dec(x_7);
if (x_8 == 0)
{
uint8_t x_9; 
x_9 = !lean_is_exclusive(x_6);
if (x_9 == 0)
{
lean_object* x_10; uint8_t x_11; 
x_10 = lean_ctor_get(x_6, 0);
lean_dec(x_10);
x_11 = l_Lean_Level_occurs___main(x_1, x_2);
if (x_11 == 0)
{
uint8_t x_12; lean_object* x_13; 
lean_dec(x_1);
x_12 = 0;
x_13 = lean_box(x_12);
lean_ctor_set(x_6, 0, x_13);
return x_6;
}
else
{
uint8_t x_14; 
x_14 = l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax(x_1, x_2);
lean_dec(x_1);
if (x_14 == 0)
{
uint8_t x_15; lean_object* x_16; 
x_15 = 1;
x_16 = lean_box(x_15);
lean_ctor_set(x_6, 0, x_16);
return x_6;
}
else
{
uint8_t x_17; lean_object* x_18; 
x_17 = 2;
x_18 = lean_box(x_17);
lean_ctor_set(x_6, 0, x_18);
return x_6;
}
}
}
else
{
lean_object* x_19; uint8_t x_20; 
x_19 = lean_ctor_get(x_6, 1);
lean_inc(x_19);
lean_dec(x_6);
x_20 = l_Lean_Level_occurs___main(x_1, x_2);
if (x_20 == 0)
{
uint8_t x_21; lean_object* x_22; lean_object* x_23; 
lean_dec(x_1);
x_21 = 0;
x_22 = lean_box(x_21);
x_23 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_23, 0, x_22);
lean_ctor_set(x_23, 1, x_19);
return x_23;
}
else
{
uint8_t x_24; 
x_24 = l___private_Init_Lean_Meta_LevelDefEq_2__strictOccursMax(x_1, x_2);
lean_dec(x_1);
if (x_24 == 0)
{
uint8_t x_25; lean_object* x_26; lean_object* x_27; 
x_25 = 1;
x_26 = lean_box(x_25);
x_27 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_27, 0, x_26);
lean_ctor_set(x_27, 1, x_19);
return x_27;
}
else
{
uint8_t x_28; lean_object* x_29; lean_object* x_30; 
x_28 = 2;
x_29 = lean_box(x_28);
x_30 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_30, 0, x_29);
lean_ctor_set(x_30, 1, x_19);
return x_30;
}
}
}
}
else
{
uint8_t x_31; 
lean_dec(x_1);
x_31 = !lean_is_exclusive(x_6);
if (x_31 == 0)
{
lean_object* x_32; uint8_t x_33; lean_object* x_34; 
x_32 = lean_ctor_get(x_6, 0);
lean_dec(x_32);
x_33 = 2;
x_34 = lean_box(x_33);
lean_ctor_set(x_6, 0, x_34);
return x_6;
}
else
{
lean_object* x_35; uint8_t x_36; lean_object* x_37; lean_object* x_38; 
x_35 = lean_ctor_get(x_6, 1);
lean_inc(x_35);
lean_dec(x_6);
x_36 = 2;
x_37 = lean_box(x_36);
x_38 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_38, 0, x_37);
lean_ctor_set(x_38, 1, x_35);
return x_38;
}
}
}
else
{
uint8_t x_39; 
lean_dec(x_1);
x_39 = !lean_is_exclusive(x_6);
if (x_39 == 0)
{
return x_6;
}
else
{
lean_object* x_40; lean_object* x_41; lean_object* x_42; 
x_40 = lean_ctor_get(x_6, 0);
x_41 = lean_ctor_get(x_6, 1);
lean_inc(x_41);
lean_inc(x_40);
lean_dec(x_6);
x_42 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_42, 0, x_40);
lean_ctor_set(x_42, 1, x_41);
return x_42;
}
}
}
else
{
uint8_t x_43; lean_object* x_44; lean_object* x_45; 
lean_dec(x_1);
x_43 = 2;
x_44 = lean_box(x_43);
x_45 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_45, 0, x_44);
lean_ctor_set(x_45, 1, x_4);
return x_45;
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(x_1, x_2, x_3, x_4);
lean_dec(x_3);
lean_dec(x_2);
return x_5;
}
}
lean_object* l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; lean_object* x_5; uint8_t x_6; 
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_ctor_get(x_4, 0);
x_6 = l_List_isEmpty___rarg(x_5);
if (x_6 == 0)
{
uint8_t x_7; lean_object* x_8; lean_object* x_9; 
x_7 = l___private_Init_Lean_Trace_4__checkTraceOptionAux___main(x_5, x_1);
x_8 = lean_box(x_7);
x_9 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_9, 0, x_8);
lean_ctor_set(x_9, 1, x_3);
return x_9;
}
else
{
uint8_t x_10; lean_object* x_11; lean_object* x_12; 
x_10 = 0;
x_11 = lean_box(x_10);
x_12 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_12, 0, x_11);
lean_ctor_set(x_12, 1, x_3);
return x_12;
}
}
}
lean_object* l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; uint8_t x_7; 
x_6 = lean_ctor_get(x_4, 4);
x_7 = !lean_is_exclusive(x_6);
if (x_7 == 0)
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; 
x_8 = lean_ctor_get(x_6, 0);
x_9 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_9, 0, x_1);
lean_ctor_set(x_9, 1, x_2);
x_10 = lean_array_push(x_8, x_9);
lean_ctor_set(x_6, 0, x_10);
x_11 = lean_box(0);
x_12 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_12, 0, x_11);
lean_ctor_set(x_12, 1, x_4);
return x_12;
}
else
{
uint8_t x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; 
x_13 = lean_ctor_get_uint8(x_6, sizeof(void*)*1);
x_14 = lean_ctor_get(x_6, 0);
lean_inc(x_14);
lean_dec(x_6);
x_15 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_15, 0, x_1);
lean_ctor_set(x_15, 1, x_2);
x_16 = lean_array_push(x_14, x_15);
x_17 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_17, 0, x_16);
lean_ctor_set_uint8(x_17, sizeof(void*)*1, x_13);
lean_ctor_set(x_4, 4, x_17);
x_18 = lean_box(0);
x_19 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_19, 0, x_18);
lean_ctor_set(x_19, 1, x_4);
return x_19;
}
}
else
{
lean_object* x_20; lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; uint8_t x_26; lean_object* x_27; lean_object* x_28; lean_object* x_29; lean_object* x_30; lean_object* x_31; lean_object* x_32; lean_object* x_33; lean_object* x_34; 
x_20 = lean_ctor_get(x_4, 4);
x_21 = lean_ctor_get(x_4, 0);
x_22 = lean_ctor_get(x_4, 1);
x_23 = lean_ctor_get(x_4, 2);
x_24 = lean_ctor_get(x_4, 3);
x_25 = lean_ctor_get(x_4, 5);
lean_inc(x_25);
lean_inc(x_20);
lean_inc(x_24);
lean_inc(x_23);
lean_inc(x_22);
lean_inc(x_21);
lean_dec(x_4);
x_26 = lean_ctor_get_uint8(x_20, sizeof(void*)*1);
x_27 = lean_ctor_get(x_20, 0);
lean_inc(x_27);
if (lean_is_exclusive(x_20)) {
 lean_ctor_release(x_20, 0);
 x_28 = x_20;
} else {
 lean_dec_ref(x_20);
 x_28 = lean_box(0);
}
x_29 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_29, 0, x_1);
lean_ctor_set(x_29, 1, x_2);
x_30 = lean_array_push(x_27, x_29);
if (lean_is_scalar(x_28)) {
 x_31 = lean_alloc_ctor(0, 1, 1);
} else {
 x_31 = x_28;
}
lean_ctor_set(x_31, 0, x_30);
lean_ctor_set_uint8(x_31, sizeof(void*)*1, x_26);
x_32 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_32, 0, x_21);
lean_ctor_set(x_32, 1, x_22);
lean_ctor_set(x_32, 2, x_23);
lean_ctor_set(x_32, 3, x_24);
lean_ctor_set(x_32, 4, x_31);
lean_ctor_set(x_32, 5, x_25);
x_33 = lean_box(0);
x_34 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_34, 0, x_33);
lean_ctor_set(x_34, 1, x_32);
return x_34;
}
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("type_context");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = lean_box(0);
x_2 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1;
x_3 = lean_name_mk_string(x_1, x_2);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("level_is_def_eq");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3;
x_3 = lean_name_mk_string(x_1, x_2);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_Lean_SimpleMonadTracerAdapter_isTracingEnabledFor___rarg___lambda__1___closed__2;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_3 = l_Lean_Name_append___main(x_1, x_2);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string(" =?= ");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6;
x_2 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; lean_object* x_317; 
if (lean_obj_tag(x_1) == 1)
{
if (lean_obj_tag(x_2) == 1)
{
lean_object* x_339; lean_object* x_340; 
x_339 = lean_ctor_get(x_1, 0);
lean_inc(x_339);
lean_dec(x_1);
x_340 = lean_ctor_get(x_2, 0);
lean_inc(x_340);
lean_dec(x_2);
x_1 = x_339;
x_2 = x_340;
goto _start;
}
else
{
lean_object* x_342; 
x_342 = lean_box(0);
x_317 = x_342;
goto block_338;
}
}
else
{
lean_object* x_343; 
x_343 = lean_box(0);
x_317 = x_343;
goto block_338;
}
block_316:
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; uint8_t x_11; 
lean_inc(x_1);
x_6 = l_Lean_Meta_instantiateLevelMVars(x_1, x_3, x_5);
x_7 = lean_ctor_get(x_6, 0);
lean_inc(x_7);
x_8 = lean_ctor_get(x_6, 1);
lean_inc(x_8);
lean_dec(x_6);
x_9 = l_Lean_Level_normalize___main(x_7);
lean_dec(x_7);
lean_inc(x_2);
x_10 = l_Lean_Meta_instantiateLevelMVars(x_2, x_3, x_8);
x_11 = !lean_is_exclusive(x_10);
if (x_11 == 0)
{
lean_object* x_12; lean_object* x_13; lean_object* x_14; uint8_t x_15; 
x_12 = lean_ctor_get(x_10, 0);
x_13 = lean_ctor_get(x_10, 1);
x_14 = l_Lean_Level_normalize___main(x_12);
lean_dec(x_12);
x_15 = lean_level_eq(x_1, x_9);
if (x_15 == 0)
{
lean_free_object(x_10);
lean_dec(x_2);
lean_dec(x_1);
x_1 = x_9;
x_2 = x_14;
x_4 = x_13;
goto _start;
}
else
{
uint8_t x_17; 
x_17 = lean_level_eq(x_2, x_14);
if (x_17 == 0)
{
lean_free_object(x_10);
lean_dec(x_2);
lean_dec(x_1);
x_1 = x_9;
x_2 = x_14;
x_4 = x_13;
goto _start;
}
else
{
lean_object* x_19; lean_object* x_20; uint8_t x_196; 
lean_dec(x_14);
lean_dec(x_9);
x_19 = lean_ctor_get(x_13, 1);
lean_inc(x_19);
x_196 = l_Lean_MetavarContext_hasAssignableLevelMVar___main(x_19, x_1);
if (x_196 == 0)
{
uint8_t x_197; 
x_197 = l_Lean_MetavarContext_hasAssignableLevelMVar___main(x_19, x_2);
lean_dec(x_19);
if (x_197 == 0)
{
uint8_t x_198; lean_object* x_199; 
lean_dec(x_2);
lean_dec(x_1);
x_198 = 0;
x_199 = lean_box(x_198);
lean_ctor_set(x_10, 0, x_199);
return x_10;
}
else
{
lean_object* x_200; 
lean_free_object(x_10);
x_200 = lean_box(0);
x_20 = x_200;
goto block_195;
}
}
else
{
lean_object* x_201; 
lean_dec(x_19);
lean_free_object(x_10);
x_201 = lean_box(0);
x_20 = x_201;
goto block_195;
}
block_195:
{
lean_object* x_21; 
lean_dec(x_20);
lean_inc(x_1);
x_21 = l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(x_1, x_2, x_3, x_13);
if (lean_obj_tag(x_21) == 0)
{
lean_object* x_22; uint8_t x_23; 
x_22 = lean_ctor_get(x_21, 0);
lean_inc(x_22);
x_23 = lean_unbox(x_22);
lean_dec(x_22);
switch (x_23) {
case 0:
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; uint8_t x_27; 
x_24 = lean_ctor_get(x_21, 1);
lean_inc(x_24);
lean_dec(x_21);
x_25 = l_Lean_Level_mvarId_x21(x_1);
lean_dec(x_1);
x_26 = l_Lean_Meta_assignLevelMVar(x_25, x_2, x_3, x_24);
x_27 = !lean_is_exclusive(x_26);
if (x_27 == 0)
{
lean_object* x_28; uint8_t x_29; lean_object* x_30; 
x_28 = lean_ctor_get(x_26, 0);
lean_dec(x_28);
x_29 = 1;
x_30 = lean_box(x_29);
lean_ctor_set(x_26, 0, x_30);
return x_26;
}
else
{
lean_object* x_31; uint8_t x_32; lean_object* x_33; lean_object* x_34; 
x_31 = lean_ctor_get(x_26, 1);
lean_inc(x_31);
lean_dec(x_26);
x_32 = 1;
x_33 = lean_box(x_32);
x_34 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_34, 0, x_33);
lean_ctor_set(x_34, 1, x_31);
return x_34;
}
}
case 1:
{
lean_object* x_35; lean_object* x_36; uint8_t x_37; 
lean_dec(x_1);
x_35 = lean_ctor_get(x_21, 1);
lean_inc(x_35);
lean_dec(x_21);
x_36 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(x_2, x_3, x_35);
x_37 = !lean_is_exclusive(x_36);
if (x_37 == 0)
{
lean_object* x_38; uint8_t x_39; lean_object* x_40; 
x_38 = lean_ctor_get(x_36, 0);
lean_dec(x_38);
x_39 = 1;
x_40 = lean_box(x_39);
lean_ctor_set(x_36, 0, x_40);
return x_36;
}
else
{
lean_object* x_41; uint8_t x_42; lean_object* x_43; lean_object* x_44; 
x_41 = lean_ctor_get(x_36, 1);
lean_inc(x_41);
lean_dec(x_36);
x_42 = 1;
x_43 = lean_box(x_42);
x_44 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_44, 0, x_43);
lean_ctor_set(x_44, 1, x_41);
return x_44;
}
}
default: 
{
lean_object* x_45; lean_object* x_46; 
x_45 = lean_ctor_get(x_21, 1);
lean_inc(x_45);
lean_dec(x_21);
lean_inc(x_2);
x_46 = l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(x_2, x_1, x_3, x_45);
if (lean_obj_tag(x_46) == 0)
{
lean_object* x_47; uint8_t x_48; 
x_47 = lean_ctor_get(x_46, 0);
lean_inc(x_47);
x_48 = lean_unbox(x_47);
lean_dec(x_47);
switch (x_48) {
case 0:
{
lean_object* x_49; lean_object* x_50; lean_object* x_51; uint8_t x_52; 
x_49 = lean_ctor_get(x_46, 1);
lean_inc(x_49);
lean_dec(x_46);
x_50 = l_Lean_Level_mvarId_x21(x_2);
lean_dec(x_2);
x_51 = l_Lean_Meta_assignLevelMVar(x_50, x_1, x_3, x_49);
x_52 = !lean_is_exclusive(x_51);
if (x_52 == 0)
{
lean_object* x_53; uint8_t x_54; lean_object* x_55; 
x_53 = lean_ctor_get(x_51, 0);
lean_dec(x_53);
x_54 = 1;
x_55 = lean_box(x_54);
lean_ctor_set(x_51, 0, x_55);
return x_51;
}
else
{
lean_object* x_56; uint8_t x_57; lean_object* x_58; lean_object* x_59; 
x_56 = lean_ctor_get(x_51, 1);
lean_inc(x_56);
lean_dec(x_51);
x_57 = 1;
x_58 = lean_box(x_57);
x_59 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_59, 0, x_58);
lean_ctor_set(x_59, 1, x_56);
return x_59;
}
}
case 1:
{
lean_object* x_60; lean_object* x_61; uint8_t x_62; 
lean_dec(x_2);
x_60 = lean_ctor_get(x_46, 1);
lean_inc(x_60);
lean_dec(x_46);
x_61 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(x_1, x_3, x_60);
x_62 = !lean_is_exclusive(x_61);
if (x_62 == 0)
{
lean_object* x_63; uint8_t x_64; lean_object* x_65; 
x_63 = lean_ctor_get(x_61, 0);
lean_dec(x_63);
x_64 = 1;
x_65 = lean_box(x_64);
lean_ctor_set(x_61, 0, x_65);
return x_61;
}
else
{
lean_object* x_66; uint8_t x_67; lean_object* x_68; lean_object* x_69; 
x_66 = lean_ctor_get(x_61, 1);
lean_inc(x_66);
lean_dec(x_61);
x_67 = 1;
x_68 = lean_box(x_67);
x_69 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_69, 0, x_68);
lean_ctor_set(x_69, 1, x_66);
return x_69;
}
}
default: 
{
uint8_t x_70; 
x_70 = !lean_is_exclusive(x_46);
if (x_70 == 0)
{
lean_object* x_71; lean_object* x_72; uint8_t x_73; 
x_71 = lean_ctor_get(x_46, 1);
x_72 = lean_ctor_get(x_46, 0);
lean_dec(x_72);
x_73 = l_Lean_Level_isMVar(x_1);
if (x_73 == 0)
{
uint8_t x_74; 
x_74 = l_Lean_Level_isMVar(x_2);
if (x_74 == 0)
{
uint8_t x_75; 
lean_free_object(x_46);
x_75 = l_Lean_Level_isSucc(x_1);
if (x_75 == 0)
{
uint8_t x_76; 
x_76 = l_Lean_Level_isSucc(x_2);
if (x_76 == 0)
{
lean_object* x_77; uint8_t x_78; 
x_77 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_71);
x_78 = !lean_is_exclusive(x_77);
if (x_78 == 0)
{
lean_object* x_79; uint8_t x_80; lean_object* x_81; 
x_79 = lean_ctor_get(x_77, 0);
lean_dec(x_79);
x_80 = 1;
x_81 = lean_box(x_80);
lean_ctor_set(x_77, 0, x_81);
return x_77;
}
else
{
lean_object* x_82; uint8_t x_83; lean_object* x_84; lean_object* x_85; 
x_82 = lean_ctor_get(x_77, 1);
lean_inc(x_82);
lean_dec(x_77);
x_83 = 1;
x_84 = lean_box(x_83);
x_85 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_85, 0, x_84);
lean_ctor_set(x_85, 1, x_82);
return x_85;
}
}
else
{
lean_object* x_86; 
x_86 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_86) == 0)
{
lean_object* x_87; uint8_t x_88; 
x_87 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_71);
x_88 = !lean_is_exclusive(x_87);
if (x_88 == 0)
{
lean_object* x_89; uint8_t x_90; lean_object* x_91; 
x_89 = lean_ctor_get(x_87, 0);
lean_dec(x_89);
x_90 = 1;
x_91 = lean_box(x_90);
lean_ctor_set(x_87, 0, x_91);
return x_87;
}
else
{
lean_object* x_92; uint8_t x_93; lean_object* x_94; lean_object* x_95; 
x_92 = lean_ctor_get(x_87, 1);
lean_inc(x_92);
lean_dec(x_87);
x_93 = 1;
x_94 = lean_box(x_93);
x_95 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_95, 0, x_94);
lean_ctor_set(x_95, 1, x_92);
return x_95;
}
}
else
{
lean_object* x_96; lean_object* x_97; 
x_96 = lean_ctor_get(x_86, 0);
lean_inc(x_96);
lean_dec(x_86);
x_97 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_97) == 0)
{
lean_object* x_98; uint8_t x_99; 
lean_dec(x_96);
x_98 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_71);
x_99 = !lean_is_exclusive(x_98);
if (x_99 == 0)
{
lean_object* x_100; uint8_t x_101; lean_object* x_102; 
x_100 = lean_ctor_get(x_98, 0);
lean_dec(x_100);
x_101 = 1;
x_102 = lean_box(x_101);
lean_ctor_set(x_98, 0, x_102);
return x_98;
}
else
{
lean_object* x_103; uint8_t x_104; lean_object* x_105; lean_object* x_106; 
x_103 = lean_ctor_get(x_98, 1);
lean_inc(x_103);
lean_dec(x_98);
x_104 = 1;
x_105 = lean_box(x_104);
x_106 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_106, 0, x_105);
lean_ctor_set(x_106, 1, x_103);
return x_106;
}
}
else
{
lean_object* x_107; 
lean_dec(x_2);
lean_dec(x_1);
x_107 = lean_ctor_get(x_97, 0);
lean_inc(x_107);
lean_dec(x_97);
x_1 = x_96;
x_2 = x_107;
x_4 = x_71;
goto _start;
}
}
}
}
else
{
lean_object* x_109; 
x_109 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_109) == 0)
{
lean_object* x_110; uint8_t x_111; 
x_110 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_71);
x_111 = !lean_is_exclusive(x_110);
if (x_111 == 0)
{
lean_object* x_112; uint8_t x_113; lean_object* x_114; 
x_112 = lean_ctor_get(x_110, 0);
lean_dec(x_112);
x_113 = 1;
x_114 = lean_box(x_113);
lean_ctor_set(x_110, 0, x_114);
return x_110;
}
else
{
lean_object* x_115; uint8_t x_116; lean_object* x_117; lean_object* x_118; 
x_115 = lean_ctor_get(x_110, 1);
lean_inc(x_115);
lean_dec(x_110);
x_116 = 1;
x_117 = lean_box(x_116);
x_118 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_118, 0, x_117);
lean_ctor_set(x_118, 1, x_115);
return x_118;
}
}
else
{
lean_object* x_119; lean_object* x_120; 
x_119 = lean_ctor_get(x_109, 0);
lean_inc(x_119);
lean_dec(x_109);
x_120 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_120) == 0)
{
lean_object* x_121; uint8_t x_122; 
lean_dec(x_119);
x_121 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_71);
x_122 = !lean_is_exclusive(x_121);
if (x_122 == 0)
{
lean_object* x_123; uint8_t x_124; lean_object* x_125; 
x_123 = lean_ctor_get(x_121, 0);
lean_dec(x_123);
x_124 = 1;
x_125 = lean_box(x_124);
lean_ctor_set(x_121, 0, x_125);
return x_121;
}
else
{
lean_object* x_126; uint8_t x_127; lean_object* x_128; lean_object* x_129; 
x_126 = lean_ctor_get(x_121, 1);
lean_inc(x_126);
lean_dec(x_121);
x_127 = 1;
x_128 = lean_box(x_127);
x_129 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_129, 0, x_128);
lean_ctor_set(x_129, 1, x_126);
return x_129;
}
}
else
{
lean_object* x_130; 
lean_dec(x_2);
lean_dec(x_1);
x_130 = lean_ctor_get(x_120, 0);
lean_inc(x_130);
lean_dec(x_120);
x_1 = x_119;
x_2 = x_130;
x_4 = x_71;
goto _start;
}
}
}
}
else
{
uint8_t x_132; lean_object* x_133; 
lean_dec(x_2);
lean_dec(x_1);
x_132 = 0;
x_133 = lean_box(x_132);
lean_ctor_set(x_46, 0, x_133);
return x_46;
}
}
else
{
uint8_t x_134; lean_object* x_135; 
lean_dec(x_2);
lean_dec(x_1);
x_134 = 0;
x_135 = lean_box(x_134);
lean_ctor_set(x_46, 0, x_135);
return x_46;
}
}
else
{
lean_object* x_136; uint8_t x_137; 
x_136 = lean_ctor_get(x_46, 1);
lean_inc(x_136);
lean_dec(x_46);
x_137 = l_Lean_Level_isMVar(x_1);
if (x_137 == 0)
{
uint8_t x_138; 
x_138 = l_Lean_Level_isMVar(x_2);
if (x_138 == 0)
{
uint8_t x_139; 
x_139 = l_Lean_Level_isSucc(x_1);
if (x_139 == 0)
{
uint8_t x_140; 
x_140 = l_Lean_Level_isSucc(x_2);
if (x_140 == 0)
{
lean_object* x_141; lean_object* x_142; lean_object* x_143; uint8_t x_144; lean_object* x_145; lean_object* x_146; 
x_141 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_136);
x_142 = lean_ctor_get(x_141, 1);
lean_inc(x_142);
if (lean_is_exclusive(x_141)) {
 lean_ctor_release(x_141, 0);
 lean_ctor_release(x_141, 1);
 x_143 = x_141;
} else {
 lean_dec_ref(x_141);
 x_143 = lean_box(0);
}
x_144 = 1;
x_145 = lean_box(x_144);
if (lean_is_scalar(x_143)) {
 x_146 = lean_alloc_ctor(0, 2, 0);
} else {
 x_146 = x_143;
}
lean_ctor_set(x_146, 0, x_145);
lean_ctor_set(x_146, 1, x_142);
return x_146;
}
else
{
lean_object* x_147; 
x_147 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_147) == 0)
{
lean_object* x_148; lean_object* x_149; lean_object* x_150; uint8_t x_151; lean_object* x_152; lean_object* x_153; 
x_148 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_136);
x_149 = lean_ctor_get(x_148, 1);
lean_inc(x_149);
if (lean_is_exclusive(x_148)) {
 lean_ctor_release(x_148, 0);
 lean_ctor_release(x_148, 1);
 x_150 = x_148;
} else {
 lean_dec_ref(x_148);
 x_150 = lean_box(0);
}
x_151 = 1;
x_152 = lean_box(x_151);
if (lean_is_scalar(x_150)) {
 x_153 = lean_alloc_ctor(0, 2, 0);
} else {
 x_153 = x_150;
}
lean_ctor_set(x_153, 0, x_152);
lean_ctor_set(x_153, 1, x_149);
return x_153;
}
else
{
lean_object* x_154; lean_object* x_155; 
x_154 = lean_ctor_get(x_147, 0);
lean_inc(x_154);
lean_dec(x_147);
x_155 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_155) == 0)
{
lean_object* x_156; lean_object* x_157; lean_object* x_158; uint8_t x_159; lean_object* x_160; lean_object* x_161; 
lean_dec(x_154);
x_156 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_136);
x_157 = lean_ctor_get(x_156, 1);
lean_inc(x_157);
if (lean_is_exclusive(x_156)) {
 lean_ctor_release(x_156, 0);
 lean_ctor_release(x_156, 1);
 x_158 = x_156;
} else {
 lean_dec_ref(x_156);
 x_158 = lean_box(0);
}
x_159 = 1;
x_160 = lean_box(x_159);
if (lean_is_scalar(x_158)) {
 x_161 = lean_alloc_ctor(0, 2, 0);
} else {
 x_161 = x_158;
}
lean_ctor_set(x_161, 0, x_160);
lean_ctor_set(x_161, 1, x_157);
return x_161;
}
else
{
lean_object* x_162; 
lean_dec(x_2);
lean_dec(x_1);
x_162 = lean_ctor_get(x_155, 0);
lean_inc(x_162);
lean_dec(x_155);
x_1 = x_154;
x_2 = x_162;
x_4 = x_136;
goto _start;
}
}
}
}
else
{
lean_object* x_164; 
x_164 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_164) == 0)
{
lean_object* x_165; lean_object* x_166; lean_object* x_167; uint8_t x_168; lean_object* x_169; lean_object* x_170; 
x_165 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_136);
x_166 = lean_ctor_get(x_165, 1);
lean_inc(x_166);
if (lean_is_exclusive(x_165)) {
 lean_ctor_release(x_165, 0);
 lean_ctor_release(x_165, 1);
 x_167 = x_165;
} else {
 lean_dec_ref(x_165);
 x_167 = lean_box(0);
}
x_168 = 1;
x_169 = lean_box(x_168);
if (lean_is_scalar(x_167)) {
 x_170 = lean_alloc_ctor(0, 2, 0);
} else {
 x_170 = x_167;
}
lean_ctor_set(x_170, 0, x_169);
lean_ctor_set(x_170, 1, x_166);
return x_170;
}
else
{
lean_object* x_171; lean_object* x_172; 
x_171 = lean_ctor_get(x_164, 0);
lean_inc(x_171);
lean_dec(x_164);
x_172 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_172) == 0)
{
lean_object* x_173; lean_object* x_174; lean_object* x_175; uint8_t x_176; lean_object* x_177; lean_object* x_178; 
lean_dec(x_171);
x_173 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_136);
x_174 = lean_ctor_get(x_173, 1);
lean_inc(x_174);
if (lean_is_exclusive(x_173)) {
 lean_ctor_release(x_173, 0);
 lean_ctor_release(x_173, 1);
 x_175 = x_173;
} else {
 lean_dec_ref(x_173);
 x_175 = lean_box(0);
}
x_176 = 1;
x_177 = lean_box(x_176);
if (lean_is_scalar(x_175)) {
 x_178 = lean_alloc_ctor(0, 2, 0);
} else {
 x_178 = x_175;
}
lean_ctor_set(x_178, 0, x_177);
lean_ctor_set(x_178, 1, x_174);
return x_178;
}
else
{
lean_object* x_179; 
lean_dec(x_2);
lean_dec(x_1);
x_179 = lean_ctor_get(x_172, 0);
lean_inc(x_179);
lean_dec(x_172);
x_1 = x_171;
x_2 = x_179;
x_4 = x_136;
goto _start;
}
}
}
}
else
{
uint8_t x_181; lean_object* x_182; lean_object* x_183; 
lean_dec(x_2);
lean_dec(x_1);
x_181 = 0;
x_182 = lean_box(x_181);
x_183 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_183, 0, x_182);
lean_ctor_set(x_183, 1, x_136);
return x_183;
}
}
else
{
uint8_t x_184; lean_object* x_185; lean_object* x_186; 
lean_dec(x_2);
lean_dec(x_1);
x_184 = 0;
x_185 = lean_box(x_184);
x_186 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_186, 0, x_185);
lean_ctor_set(x_186, 1, x_136);
return x_186;
}
}
}
}
}
else
{
uint8_t x_187; 
lean_dec(x_2);
lean_dec(x_1);
x_187 = !lean_is_exclusive(x_46);
if (x_187 == 0)
{
return x_46;
}
else
{
lean_object* x_188; lean_object* x_189; lean_object* x_190; 
x_188 = lean_ctor_get(x_46, 0);
x_189 = lean_ctor_get(x_46, 1);
lean_inc(x_189);
lean_inc(x_188);
lean_dec(x_46);
x_190 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_190, 0, x_188);
lean_ctor_set(x_190, 1, x_189);
return x_190;
}
}
}
}
}
else
{
uint8_t x_191; 
lean_dec(x_2);
lean_dec(x_1);
x_191 = !lean_is_exclusive(x_21);
if (x_191 == 0)
{
return x_21;
}
else
{
lean_object* x_192; lean_object* x_193; lean_object* x_194; 
x_192 = lean_ctor_get(x_21, 0);
x_193 = lean_ctor_get(x_21, 1);
lean_inc(x_193);
lean_inc(x_192);
lean_dec(x_21);
x_194 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_194, 0, x_192);
lean_ctor_set(x_194, 1, x_193);
return x_194;
}
}
}
}
}
}
else
{
lean_object* x_202; lean_object* x_203; lean_object* x_204; uint8_t x_205; 
x_202 = lean_ctor_get(x_10, 0);
x_203 = lean_ctor_get(x_10, 1);
lean_inc(x_203);
lean_inc(x_202);
lean_dec(x_10);
x_204 = l_Lean_Level_normalize___main(x_202);
lean_dec(x_202);
x_205 = lean_level_eq(x_1, x_9);
if (x_205 == 0)
{
lean_dec(x_2);
lean_dec(x_1);
x_1 = x_9;
x_2 = x_204;
x_4 = x_203;
goto _start;
}
else
{
uint8_t x_207; 
x_207 = lean_level_eq(x_2, x_204);
if (x_207 == 0)
{
lean_dec(x_2);
lean_dec(x_1);
x_1 = x_9;
x_2 = x_204;
x_4 = x_203;
goto _start;
}
else
{
lean_object* x_209; lean_object* x_210; uint8_t x_309; 
lean_dec(x_204);
lean_dec(x_9);
x_209 = lean_ctor_get(x_203, 1);
lean_inc(x_209);
x_309 = l_Lean_MetavarContext_hasAssignableLevelMVar___main(x_209, x_1);
if (x_309 == 0)
{
uint8_t x_310; 
x_310 = l_Lean_MetavarContext_hasAssignableLevelMVar___main(x_209, x_2);
lean_dec(x_209);
if (x_310 == 0)
{
uint8_t x_311; lean_object* x_312; lean_object* x_313; 
lean_dec(x_2);
lean_dec(x_1);
x_311 = 0;
x_312 = lean_box(x_311);
x_313 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_313, 0, x_312);
lean_ctor_set(x_313, 1, x_203);
return x_313;
}
else
{
lean_object* x_314; 
x_314 = lean_box(0);
x_210 = x_314;
goto block_308;
}
}
else
{
lean_object* x_315; 
lean_dec(x_209);
x_315 = lean_box(0);
x_210 = x_315;
goto block_308;
}
block_308:
{
lean_object* x_211; 
lean_dec(x_210);
lean_inc(x_1);
x_211 = l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(x_1, x_2, x_3, x_203);
if (lean_obj_tag(x_211) == 0)
{
lean_object* x_212; uint8_t x_213; 
x_212 = lean_ctor_get(x_211, 0);
lean_inc(x_212);
x_213 = lean_unbox(x_212);
lean_dec(x_212);
switch (x_213) {
case 0:
{
lean_object* x_214; lean_object* x_215; lean_object* x_216; lean_object* x_217; lean_object* x_218; uint8_t x_219; lean_object* x_220; lean_object* x_221; 
x_214 = lean_ctor_get(x_211, 1);
lean_inc(x_214);
lean_dec(x_211);
x_215 = l_Lean_Level_mvarId_x21(x_1);
lean_dec(x_1);
x_216 = l_Lean_Meta_assignLevelMVar(x_215, x_2, x_3, x_214);
x_217 = lean_ctor_get(x_216, 1);
lean_inc(x_217);
if (lean_is_exclusive(x_216)) {
 lean_ctor_release(x_216, 0);
 lean_ctor_release(x_216, 1);
 x_218 = x_216;
} else {
 lean_dec_ref(x_216);
 x_218 = lean_box(0);
}
x_219 = 1;
x_220 = lean_box(x_219);
if (lean_is_scalar(x_218)) {
 x_221 = lean_alloc_ctor(0, 2, 0);
} else {
 x_221 = x_218;
}
lean_ctor_set(x_221, 0, x_220);
lean_ctor_set(x_221, 1, x_217);
return x_221;
}
case 1:
{
lean_object* x_222; lean_object* x_223; lean_object* x_224; lean_object* x_225; uint8_t x_226; lean_object* x_227; lean_object* x_228; 
lean_dec(x_1);
x_222 = lean_ctor_get(x_211, 1);
lean_inc(x_222);
lean_dec(x_211);
x_223 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(x_2, x_3, x_222);
x_224 = lean_ctor_get(x_223, 1);
lean_inc(x_224);
if (lean_is_exclusive(x_223)) {
 lean_ctor_release(x_223, 0);
 lean_ctor_release(x_223, 1);
 x_225 = x_223;
} else {
 lean_dec_ref(x_223);
 x_225 = lean_box(0);
}
x_226 = 1;
x_227 = lean_box(x_226);
if (lean_is_scalar(x_225)) {
 x_228 = lean_alloc_ctor(0, 2, 0);
} else {
 x_228 = x_225;
}
lean_ctor_set(x_228, 0, x_227);
lean_ctor_set(x_228, 1, x_224);
return x_228;
}
default: 
{
lean_object* x_229; lean_object* x_230; 
x_229 = lean_ctor_get(x_211, 1);
lean_inc(x_229);
lean_dec(x_211);
lean_inc(x_2);
x_230 = l___private_Init_Lean_Meta_LevelDefEq_6__getLevelConstraintKind(x_2, x_1, x_3, x_229);
if (lean_obj_tag(x_230) == 0)
{
lean_object* x_231; uint8_t x_232; 
x_231 = lean_ctor_get(x_230, 0);
lean_inc(x_231);
x_232 = lean_unbox(x_231);
lean_dec(x_231);
switch (x_232) {
case 0:
{
lean_object* x_233; lean_object* x_234; lean_object* x_235; lean_object* x_236; lean_object* x_237; uint8_t x_238; lean_object* x_239; lean_object* x_240; 
x_233 = lean_ctor_get(x_230, 1);
lean_inc(x_233);
lean_dec(x_230);
x_234 = l_Lean_Level_mvarId_x21(x_2);
lean_dec(x_2);
x_235 = l_Lean_Meta_assignLevelMVar(x_234, x_1, x_3, x_233);
x_236 = lean_ctor_get(x_235, 1);
lean_inc(x_236);
if (lean_is_exclusive(x_235)) {
 lean_ctor_release(x_235, 0);
 lean_ctor_release(x_235, 1);
 x_237 = x_235;
} else {
 lean_dec_ref(x_235);
 x_237 = lean_box(0);
}
x_238 = 1;
x_239 = lean_box(x_238);
if (lean_is_scalar(x_237)) {
 x_240 = lean_alloc_ctor(0, 2, 0);
} else {
 x_240 = x_237;
}
lean_ctor_set(x_240, 0, x_239);
lean_ctor_set(x_240, 1, x_236);
return x_240;
}
case 1:
{
lean_object* x_241; lean_object* x_242; lean_object* x_243; lean_object* x_244; uint8_t x_245; lean_object* x_246; lean_object* x_247; 
lean_dec(x_2);
x_241 = lean_ctor_get(x_230, 1);
lean_inc(x_241);
lean_dec(x_230);
x_242 = l___private_Init_Lean_Meta_LevelDefEq_4__solveSelfMax___rarg(x_1, x_3, x_241);
x_243 = lean_ctor_get(x_242, 1);
lean_inc(x_243);
if (lean_is_exclusive(x_242)) {
 lean_ctor_release(x_242, 0);
 lean_ctor_release(x_242, 1);
 x_244 = x_242;
} else {
 lean_dec_ref(x_242);
 x_244 = lean_box(0);
}
x_245 = 1;
x_246 = lean_box(x_245);
if (lean_is_scalar(x_244)) {
 x_247 = lean_alloc_ctor(0, 2, 0);
} else {
 x_247 = x_244;
}
lean_ctor_set(x_247, 0, x_246);
lean_ctor_set(x_247, 1, x_243);
return x_247;
}
default: 
{
lean_object* x_248; lean_object* x_249; uint8_t x_250; 
x_248 = lean_ctor_get(x_230, 1);
lean_inc(x_248);
if (lean_is_exclusive(x_230)) {
 lean_ctor_release(x_230, 0);
 lean_ctor_release(x_230, 1);
 x_249 = x_230;
} else {
 lean_dec_ref(x_230);
 x_249 = lean_box(0);
}
x_250 = l_Lean_Level_isMVar(x_1);
if (x_250 == 0)
{
uint8_t x_251; 
x_251 = l_Lean_Level_isMVar(x_2);
if (x_251 == 0)
{
uint8_t x_252; 
lean_dec(x_249);
x_252 = l_Lean_Level_isSucc(x_1);
if (x_252 == 0)
{
uint8_t x_253; 
x_253 = l_Lean_Level_isSucc(x_2);
if (x_253 == 0)
{
lean_object* x_254; lean_object* x_255; lean_object* x_256; uint8_t x_257; lean_object* x_258; lean_object* x_259; 
x_254 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_248);
x_255 = lean_ctor_get(x_254, 1);
lean_inc(x_255);
if (lean_is_exclusive(x_254)) {
 lean_ctor_release(x_254, 0);
 lean_ctor_release(x_254, 1);
 x_256 = x_254;
} else {
 lean_dec_ref(x_254);
 x_256 = lean_box(0);
}
x_257 = 1;
x_258 = lean_box(x_257);
if (lean_is_scalar(x_256)) {
 x_259 = lean_alloc_ctor(0, 2, 0);
} else {
 x_259 = x_256;
}
lean_ctor_set(x_259, 0, x_258);
lean_ctor_set(x_259, 1, x_255);
return x_259;
}
else
{
lean_object* x_260; 
x_260 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_260) == 0)
{
lean_object* x_261; lean_object* x_262; lean_object* x_263; uint8_t x_264; lean_object* x_265; lean_object* x_266; 
x_261 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_248);
x_262 = lean_ctor_get(x_261, 1);
lean_inc(x_262);
if (lean_is_exclusive(x_261)) {
 lean_ctor_release(x_261, 0);
 lean_ctor_release(x_261, 1);
 x_263 = x_261;
} else {
 lean_dec_ref(x_261);
 x_263 = lean_box(0);
}
x_264 = 1;
x_265 = lean_box(x_264);
if (lean_is_scalar(x_263)) {
 x_266 = lean_alloc_ctor(0, 2, 0);
} else {
 x_266 = x_263;
}
lean_ctor_set(x_266, 0, x_265);
lean_ctor_set(x_266, 1, x_262);
return x_266;
}
else
{
lean_object* x_267; lean_object* x_268; 
x_267 = lean_ctor_get(x_260, 0);
lean_inc(x_267);
lean_dec(x_260);
x_268 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_268) == 0)
{
lean_object* x_269; lean_object* x_270; lean_object* x_271; uint8_t x_272; lean_object* x_273; lean_object* x_274; 
lean_dec(x_267);
x_269 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_248);
x_270 = lean_ctor_get(x_269, 1);
lean_inc(x_270);
if (lean_is_exclusive(x_269)) {
 lean_ctor_release(x_269, 0);
 lean_ctor_release(x_269, 1);
 x_271 = x_269;
} else {
 lean_dec_ref(x_269);
 x_271 = lean_box(0);
}
x_272 = 1;
x_273 = lean_box(x_272);
if (lean_is_scalar(x_271)) {
 x_274 = lean_alloc_ctor(0, 2, 0);
} else {
 x_274 = x_271;
}
lean_ctor_set(x_274, 0, x_273);
lean_ctor_set(x_274, 1, x_270);
return x_274;
}
else
{
lean_object* x_275; 
lean_dec(x_2);
lean_dec(x_1);
x_275 = lean_ctor_get(x_268, 0);
lean_inc(x_275);
lean_dec(x_268);
x_1 = x_267;
x_2 = x_275;
x_4 = x_248;
goto _start;
}
}
}
}
else
{
lean_object* x_277; 
x_277 = l_Lean_Level_dec___main(x_1);
if (lean_obj_tag(x_277) == 0)
{
lean_object* x_278; lean_object* x_279; lean_object* x_280; uint8_t x_281; lean_object* x_282; lean_object* x_283; 
x_278 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_248);
x_279 = lean_ctor_get(x_278, 1);
lean_inc(x_279);
if (lean_is_exclusive(x_278)) {
 lean_ctor_release(x_278, 0);
 lean_ctor_release(x_278, 1);
 x_280 = x_278;
} else {
 lean_dec_ref(x_278);
 x_280 = lean_box(0);
}
x_281 = 1;
x_282 = lean_box(x_281);
if (lean_is_scalar(x_280)) {
 x_283 = lean_alloc_ctor(0, 2, 0);
} else {
 x_283 = x_280;
}
lean_ctor_set(x_283, 0, x_282);
lean_ctor_set(x_283, 1, x_279);
return x_283;
}
else
{
lean_object* x_284; lean_object* x_285; 
x_284 = lean_ctor_get(x_277, 0);
lean_inc(x_284);
lean_dec(x_277);
x_285 = l_Lean_Level_dec___main(x_2);
if (lean_obj_tag(x_285) == 0)
{
lean_object* x_286; lean_object* x_287; lean_object* x_288; uint8_t x_289; lean_object* x_290; lean_object* x_291; 
lean_dec(x_284);
x_286 = l___private_Init_Lean_Meta_LevelDefEq_5__postponeIsLevelDefEq(x_1, x_2, x_3, x_248);
x_287 = lean_ctor_get(x_286, 1);
lean_inc(x_287);
if (lean_is_exclusive(x_286)) {
 lean_ctor_release(x_286, 0);
 lean_ctor_release(x_286, 1);
 x_288 = x_286;
} else {
 lean_dec_ref(x_286);
 x_288 = lean_box(0);
}
x_289 = 1;
x_290 = lean_box(x_289);
if (lean_is_scalar(x_288)) {
 x_291 = lean_alloc_ctor(0, 2, 0);
} else {
 x_291 = x_288;
}
lean_ctor_set(x_291, 0, x_290);
lean_ctor_set(x_291, 1, x_287);
return x_291;
}
else
{
lean_object* x_292; 
lean_dec(x_2);
lean_dec(x_1);
x_292 = lean_ctor_get(x_285, 0);
lean_inc(x_292);
lean_dec(x_285);
x_1 = x_284;
x_2 = x_292;
x_4 = x_248;
goto _start;
}
}
}
}
else
{
uint8_t x_294; lean_object* x_295; lean_object* x_296; 
lean_dec(x_2);
lean_dec(x_1);
x_294 = 0;
x_295 = lean_box(x_294);
if (lean_is_scalar(x_249)) {
 x_296 = lean_alloc_ctor(0, 2, 0);
} else {
 x_296 = x_249;
}
lean_ctor_set(x_296, 0, x_295);
lean_ctor_set(x_296, 1, x_248);
return x_296;
}
}
else
{
uint8_t x_297; lean_object* x_298; lean_object* x_299; 
lean_dec(x_2);
lean_dec(x_1);
x_297 = 0;
x_298 = lean_box(x_297);
if (lean_is_scalar(x_249)) {
 x_299 = lean_alloc_ctor(0, 2, 0);
} else {
 x_299 = x_249;
}
lean_ctor_set(x_299, 0, x_298);
lean_ctor_set(x_299, 1, x_248);
return x_299;
}
}
}
}
else
{
lean_object* x_300; lean_object* x_301; lean_object* x_302; lean_object* x_303; 
lean_dec(x_2);
lean_dec(x_1);
x_300 = lean_ctor_get(x_230, 0);
lean_inc(x_300);
x_301 = lean_ctor_get(x_230, 1);
lean_inc(x_301);
if (lean_is_exclusive(x_230)) {
 lean_ctor_release(x_230, 0);
 lean_ctor_release(x_230, 1);
 x_302 = x_230;
} else {
 lean_dec_ref(x_230);
 x_302 = lean_box(0);
}
if (lean_is_scalar(x_302)) {
 x_303 = lean_alloc_ctor(1, 2, 0);
} else {
 x_303 = x_302;
}
lean_ctor_set(x_303, 0, x_300);
lean_ctor_set(x_303, 1, x_301);
return x_303;
}
}
}
}
else
{
lean_object* x_304; lean_object* x_305; lean_object* x_306; lean_object* x_307; 
lean_dec(x_2);
lean_dec(x_1);
x_304 = lean_ctor_get(x_211, 0);
lean_inc(x_304);
x_305 = lean_ctor_get(x_211, 1);
lean_inc(x_305);
if (lean_is_exclusive(x_211)) {
 lean_ctor_release(x_211, 0);
 lean_ctor_release(x_211, 1);
 x_306 = x_211;
} else {
 lean_dec_ref(x_211);
 x_306 = lean_box(0);
}
if (lean_is_scalar(x_306)) {
 x_307 = lean_alloc_ctor(1, 2, 0);
} else {
 x_307 = x_306;
}
lean_ctor_set(x_307, 0, x_304);
lean_ctor_set(x_307, 1, x_305);
return x_307;
}
}
}
}
}
}
block_338:
{
uint8_t x_318; 
lean_dec(x_317);
x_318 = lean_level_eq(x_1, x_2);
if (x_318 == 0)
{
lean_object* x_319; uint8_t x_320; 
x_319 = lean_ctor_get(x_4, 4);
lean_inc(x_319);
x_320 = lean_ctor_get_uint8(x_319, sizeof(void*)*1);
lean_dec(x_319);
if (x_320 == 0)
{
x_5 = x_4;
goto block_316;
}
else
{
lean_object* x_321; lean_object* x_322; lean_object* x_323; uint8_t x_324; 
x_321 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_322 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_321, x_3, x_4);
x_323 = lean_ctor_get(x_322, 0);
lean_inc(x_323);
x_324 = lean_unbox(x_323);
lean_dec(x_323);
if (x_324 == 0)
{
lean_object* x_325; 
x_325 = lean_ctor_get(x_322, 1);
lean_inc(x_325);
lean_dec(x_322);
x_5 = x_325;
goto block_316;
}
else
{
lean_object* x_326; lean_object* x_327; lean_object* x_328; lean_object* x_329; lean_object* x_330; lean_object* x_331; lean_object* x_332; lean_object* x_333; lean_object* x_334; 
x_326 = lean_ctor_get(x_322, 1);
lean_inc(x_326);
lean_dec(x_322);
lean_inc(x_1);
x_327 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_327, 0, x_1);
x_328 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8;
x_329 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_329, 0, x_327);
lean_ctor_set(x_329, 1, x_328);
lean_inc(x_2);
x_330 = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(x_330, 0, x_2);
x_331 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_331, 0, x_329);
lean_ctor_set(x_331, 1, x_330);
x_332 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_333 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_332, x_331, x_3, x_326);
x_334 = lean_ctor_get(x_333, 1);
lean_inc(x_334);
lean_dec(x_333);
x_5 = x_334;
goto block_316;
}
}
}
else
{
uint8_t x_335; lean_object* x_336; lean_object* x_337; 
lean_dec(x_2);
lean_dec(x_1);
x_335 = 1;
x_336 = lean_box(x_335);
x_337 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_337, 0, x_336);
lean_ctor_set(x_337, 1, x_4);
return x_337;
}
}
}
}
lean_object* l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_1, x_2, x_3);
lean_dec(x_2);
lean_dec(x_1);
return x_4;
}
}
lean_object* l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_1, x_2, x_3, x_4);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; 
x_2 = lean_ctor_get(x_1, 5);
lean_inc(x_2);
x_3 = lean_ctor_get(x_2, 2);
lean_inc(x_3);
lean_dec(x_2);
x_4 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_4, 0, x_3);
lean_ctor_set(x_4, 1, x_1);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg), 1, 0);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(lean_object* x_1) {
_start:
{
uint8_t x_2; 
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; 
x_3 = lean_ctor_get(x_1, 5);
x_4 = l_PersistentArray_empty___closed__3;
lean_ctor_set(x_1, 5, x_4);
x_5 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_5, 0, x_3);
lean_ctor_set(x_5, 1, x_1);
return x_5;
}
else
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; 
x_6 = lean_ctor_get(x_1, 0);
x_7 = lean_ctor_get(x_1, 1);
x_8 = lean_ctor_get(x_1, 2);
x_9 = lean_ctor_get(x_1, 3);
x_10 = lean_ctor_get(x_1, 4);
x_11 = lean_ctor_get(x_1, 5);
lean_inc(x_11);
lean_inc(x_10);
lean_inc(x_9);
lean_inc(x_8);
lean_inc(x_7);
lean_inc(x_6);
lean_dec(x_1);
x_12 = l_PersistentArray_empty___closed__3;
x_13 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_13, 0, x_6);
lean_ctor_set(x_13, 1, x_7);
lean_ctor_set(x_13, 2, x_8);
lean_ctor_set(x_13, 3, x_9);
lean_ctor_set(x_13, 4, x_10);
lean_ctor_set(x_13, 5, x_12);
x_14 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_14, 0, x_11);
lean_ctor_set(x_14, 1, x_13);
return x_14;
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg), 1, 0);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3(lean_object* x_1, lean_object* x_2, lean_object* x_3, uint8_t x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; uint8_t x_8; 
x_7 = lean_array_get_size(x_2);
x_8 = lean_nat_dec_lt(x_3, x_7);
lean_dec(x_7);
if (x_8 == 0)
{
lean_object* x_9; lean_object* x_10; 
lean_dec(x_3);
x_9 = lean_box(x_4);
x_10 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_10, 0, x_9);
lean_ctor_set(x_10, 1, x_6);
return x_10;
}
else
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; 
x_11 = lean_array_fget(x_2, x_3);
x_12 = lean_unsigned_to_nat(1u);
x_13 = lean_nat_add(x_3, x_12);
lean_dec(x_3);
x_14 = l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2(x_11, x_4, x_5, x_6);
lean_dec(x_11);
if (lean_obj_tag(x_14) == 0)
{
lean_object* x_15; lean_object* x_16; uint8_t x_17; 
x_15 = lean_ctor_get(x_14, 0);
lean_inc(x_15);
x_16 = lean_ctor_get(x_14, 1);
lean_inc(x_16);
lean_dec(x_14);
x_17 = lean_unbox(x_15);
lean_dec(x_15);
x_3 = x_13;
x_4 = x_17;
x_6 = x_16;
goto _start;
}
else
{
uint8_t x_19; 
lean_dec(x_13);
x_19 = !lean_is_exclusive(x_14);
if (x_19 == 0)
{
return x_14;
}
else
{
lean_object* x_20; lean_object* x_21; lean_object* x_22; 
x_20 = lean_ctor_get(x_14, 0);
x_21 = lean_ctor_get(x_14, 1);
lean_inc(x_21);
lean_inc(x_20);
lean_dec(x_14);
x_22 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_22, 0, x_20);
lean_ctor_set(x_22, 1, x_21);
return x_22;
}
}
}
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4(lean_object* x_1, lean_object* x_2, lean_object* x_3, uint8_t x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; uint8_t x_8; 
x_7 = lean_array_get_size(x_2);
x_8 = lean_nat_dec_lt(x_3, x_7);
lean_dec(x_7);
if (x_8 == 0)
{
lean_object* x_9; lean_object* x_10; 
lean_dec(x_3);
x_9 = lean_box(x_4);
x_10 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_10, 0, x_9);
lean_ctor_set(x_10, 1, x_6);
return x_10;
}
else
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_11 = lean_array_fget(x_2, x_3);
x_12 = lean_unsigned_to_nat(1u);
x_13 = lean_nat_add(x_3, x_12);
lean_dec(x_3);
if (x_4 == 0)
{
uint8_t x_14; 
lean_dec(x_11);
x_14 = 0;
x_3 = x_13;
x_4 = x_14;
goto _start;
}
else
{
lean_object* x_16; lean_object* x_17; lean_object* x_18; 
x_16 = lean_ctor_get(x_11, 0);
lean_inc(x_16);
x_17 = lean_ctor_get(x_11, 1);
lean_inc(x_17);
lean_dec(x_11);
x_18 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_16, x_17, x_5, x_6);
if (lean_obj_tag(x_18) == 0)
{
lean_object* x_19; lean_object* x_20; uint8_t x_21; 
x_19 = lean_ctor_get(x_18, 0);
lean_inc(x_19);
x_20 = lean_ctor_get(x_18, 1);
lean_inc(x_20);
lean_dec(x_18);
x_21 = lean_unbox(x_19);
lean_dec(x_19);
x_3 = x_13;
x_4 = x_21;
x_6 = x_20;
goto _start;
}
else
{
uint8_t x_23; 
lean_dec(x_13);
x_23 = !lean_is_exclusive(x_18);
if (x_23 == 0)
{
return x_18;
}
else
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; 
x_24 = lean_ctor_get(x_18, 0);
x_25 = lean_ctor_get(x_18, 1);
lean_inc(x_25);
lean_inc(x_24);
lean_dec(x_18);
x_26 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_26, 0, x_24);
lean_ctor_set(x_26, 1, x_25);
return x_26;
}
}
}
}
}
}
lean_object* l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2(lean_object* x_1, uint8_t x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; 
x_5 = lean_ctor_get(x_1, 0);
x_6 = lean_unsigned_to_nat(0u);
x_7 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3(x_5, x_5, x_6, x_2, x_3, x_4);
return x_7;
}
else
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_8 = lean_ctor_get(x_1, 0);
x_9 = lean_unsigned_to_nat(0u);
x_10 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4(x_8, x_8, x_9, x_2, x_3, x_4);
return x_10;
}
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5(lean_object* x_1, lean_object* x_2, lean_object* x_3, uint8_t x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
lean_object* x_7; uint8_t x_8; 
x_7 = lean_array_get_size(x_2);
x_8 = lean_nat_dec_lt(x_3, x_7);
lean_dec(x_7);
if (x_8 == 0)
{
lean_object* x_9; lean_object* x_10; 
lean_dec(x_3);
x_9 = lean_box(x_4);
x_10 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_10, 0, x_9);
lean_ctor_set(x_10, 1, x_6);
return x_10;
}
else
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_11 = lean_array_fget(x_2, x_3);
x_12 = lean_unsigned_to_nat(1u);
x_13 = lean_nat_add(x_3, x_12);
lean_dec(x_3);
if (x_4 == 0)
{
uint8_t x_14; 
lean_dec(x_11);
x_14 = 0;
x_3 = x_13;
x_4 = x_14;
goto _start;
}
else
{
lean_object* x_16; lean_object* x_17; lean_object* x_18; 
x_16 = lean_ctor_get(x_11, 0);
lean_inc(x_16);
x_17 = lean_ctor_get(x_11, 1);
lean_inc(x_17);
lean_dec(x_11);
x_18 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_16, x_17, x_5, x_6);
if (lean_obj_tag(x_18) == 0)
{
lean_object* x_19; lean_object* x_20; uint8_t x_21; 
x_19 = lean_ctor_get(x_18, 0);
lean_inc(x_19);
x_20 = lean_ctor_get(x_18, 1);
lean_inc(x_20);
lean_dec(x_18);
x_21 = lean_unbox(x_19);
lean_dec(x_19);
x_3 = x_13;
x_4 = x_21;
x_6 = x_20;
goto _start;
}
else
{
uint8_t x_23; 
lean_dec(x_13);
x_23 = !lean_is_exclusive(x_18);
if (x_23 == 0)
{
return x_18;
}
else
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; 
x_24 = lean_ctor_get(x_18, 0);
x_25 = lean_ctor_get(x_18, 1);
lean_inc(x_25);
lean_inc(x_24);
lean_dec(x_18);
x_26 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_26, 0, x_24);
lean_ctor_set(x_26, 1, x_25);
return x_26;
}
}
}
}
}
}
lean_object* l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(lean_object* x_1, uint8_t x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; lean_object* x_6; 
x_5 = lean_ctor_get(x_1, 0);
x_6 = l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2(x_5, x_2, x_3, x_4);
if (lean_obj_tag(x_6) == 0)
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; uint8_t x_11; lean_object* x_12; 
x_7 = lean_ctor_get(x_6, 0);
lean_inc(x_7);
x_8 = lean_ctor_get(x_6, 1);
lean_inc(x_8);
lean_dec(x_6);
x_9 = lean_ctor_get(x_1, 1);
x_10 = lean_unsigned_to_nat(0u);
x_11 = lean_unbox(x_7);
lean_dec(x_7);
x_12 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5(x_1, x_9, x_10, x_11, x_3, x_8);
return x_12;
}
else
{
uint8_t x_13; 
x_13 = !lean_is_exclusive(x_6);
if (x_13 == 0)
{
return x_6;
}
else
{
lean_object* x_14; lean_object* x_15; lean_object* x_16; 
x_14 = lean_ctor_get(x_6, 0);
x_15 = lean_ctor_get(x_6, 1);
lean_inc(x_15);
lean_inc(x_14);
lean_dec(x_6);
x_16 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_16, 0, x_14);
lean_ctor_set(x_16, 1, x_15);
return x_16;
}
}
}
}
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg(lean_object* x_1) {
_start:
{
uint8_t x_2; 
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)
{
lean_object* x_3; uint8_t x_4; 
x_3 = lean_ctor_get(x_1, 4);
x_4 = !lean_is_exclusive(x_3);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; 
x_5 = lean_ctor_get(x_3, 0);
x_6 = l_Array_empty___closed__1;
lean_ctor_set(x_3, 0, x_6);
x_7 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_7, 0, x_5);
lean_ctor_set(x_7, 1, x_1);
return x_7;
}
else
{
uint8_t x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; 
x_8 = lean_ctor_get_uint8(x_3, sizeof(void*)*1);
x_9 = lean_ctor_get(x_3, 0);
lean_inc(x_9);
lean_dec(x_3);
x_10 = l_Array_empty___closed__1;
x_11 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_11, 0, x_10);
lean_ctor_set_uint8(x_11, sizeof(void*)*1, x_8);
lean_ctor_set(x_1, 4, x_11);
x_12 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_12, 0, x_9);
lean_ctor_set(x_12, 1, x_1);
return x_12;
}
}
else
{
lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; uint8_t x_19; lean_object* x_20; lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; 
x_13 = lean_ctor_get(x_1, 4);
x_14 = lean_ctor_get(x_1, 0);
x_15 = lean_ctor_get(x_1, 1);
x_16 = lean_ctor_get(x_1, 2);
x_17 = lean_ctor_get(x_1, 3);
x_18 = lean_ctor_get(x_1, 5);
lean_inc(x_18);
lean_inc(x_13);
lean_inc(x_17);
lean_inc(x_16);
lean_inc(x_15);
lean_inc(x_14);
lean_dec(x_1);
x_19 = lean_ctor_get_uint8(x_13, sizeof(void*)*1);
x_20 = lean_ctor_get(x_13, 0);
lean_inc(x_20);
if (lean_is_exclusive(x_13)) {
 lean_ctor_release(x_13, 0);
 x_21 = x_13;
} else {
 lean_dec_ref(x_13);
 x_21 = lean_box(0);
}
x_22 = l_Array_empty___closed__1;
if (lean_is_scalar(x_21)) {
 x_23 = lean_alloc_ctor(0, 1, 1);
} else {
 x_23 = x_21;
}
lean_ctor_set(x_23, 0, x_22);
lean_ctor_set_uint8(x_23, sizeof(void*)*1, x_19);
x_24 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_24, 0, x_14);
lean_ctor_set(x_24, 1, x_15);
lean_ctor_set(x_24, 2, x_16);
lean_ctor_set(x_24, 3, x_17);
lean_ctor_set(x_24, 4, x_23);
lean_ctor_set(x_24, 5, x_18);
x_25 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_25, 0, x_20);
lean_ctor_set(x_25, 1, x_24);
return x_25;
}
}
}
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg), 1, 0);
return x_2;
}
}
lean_object* l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; uint8_t x_7; 
x_6 = lean_ctor_get(x_4, 4);
x_7 = !lean_is_exclusive(x_6);
if (x_7 == 0)
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_8 = lean_ctor_get(x_6, 0);
x_9 = lean_alloc_ctor(9, 1, 0);
lean_ctor_set(x_9, 0, x_8);
x_10 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_10, 0, x_2);
lean_ctor_set(x_10, 1, x_9);
x_11 = lean_array_push(x_1, x_10);
lean_ctor_set(x_6, 0, x_11);
x_12 = lean_box(0);
x_13 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_13, 0, x_12);
lean_ctor_set(x_13, 1, x_4);
return x_13;
}
else
{
uint8_t x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; lean_object* x_21; 
x_14 = lean_ctor_get_uint8(x_6, sizeof(void*)*1);
x_15 = lean_ctor_get(x_6, 0);
lean_inc(x_15);
lean_dec(x_6);
x_16 = lean_alloc_ctor(9, 1, 0);
lean_ctor_set(x_16, 0, x_15);
x_17 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_17, 0, x_2);
lean_ctor_set(x_17, 1, x_16);
x_18 = lean_array_push(x_1, x_17);
x_19 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_19, 0, x_18);
lean_ctor_set_uint8(x_19, sizeof(void*)*1, x_14);
lean_ctor_set(x_4, 4, x_19);
x_20 = lean_box(0);
x_21 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_21, 0, x_20);
lean_ctor_set(x_21, 1, x_4);
return x_21;
}
}
else
{
lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; uint8_t x_28; lean_object* x_29; lean_object* x_30; lean_object* x_31; lean_object* x_32; lean_object* x_33; lean_object* x_34; lean_object* x_35; lean_object* x_36; lean_object* x_37; 
x_22 = lean_ctor_get(x_4, 4);
x_23 = lean_ctor_get(x_4, 0);
x_24 = lean_ctor_get(x_4, 1);
x_25 = lean_ctor_get(x_4, 2);
x_26 = lean_ctor_get(x_4, 3);
x_27 = lean_ctor_get(x_4, 5);
lean_inc(x_27);
lean_inc(x_22);
lean_inc(x_26);
lean_inc(x_25);
lean_inc(x_24);
lean_inc(x_23);
lean_dec(x_4);
x_28 = lean_ctor_get_uint8(x_22, sizeof(void*)*1);
x_29 = lean_ctor_get(x_22, 0);
lean_inc(x_29);
if (lean_is_exclusive(x_22)) {
 lean_ctor_release(x_22, 0);
 x_30 = x_22;
} else {
 lean_dec_ref(x_22);
 x_30 = lean_box(0);
}
x_31 = lean_alloc_ctor(9, 1, 0);
lean_ctor_set(x_31, 0, x_29);
x_32 = lean_alloc_ctor(8, 2, 0);
lean_ctor_set(x_32, 0, x_2);
lean_ctor_set(x_32, 1, x_31);
x_33 = lean_array_push(x_1, x_32);
if (lean_is_scalar(x_30)) {
 x_34 = lean_alloc_ctor(0, 1, 1);
} else {
 x_34 = x_30;
}
lean_ctor_set(x_34, 0, x_33);
lean_ctor_set_uint8(x_34, sizeof(void*)*1, x_28);
x_35 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_35, 0, x_23);
lean_ctor_set(x_35, 1, x_24);
lean_ctor_set(x_35, 2, x_25);
lean_ctor_set(x_35, 3, x_26);
lean_ctor_set(x_35, 4, x_34);
lean_ctor_set(x_35, 5, x_27);
x_36 = lean_box(0);
x_37 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_37, 0, x_36);
lean_ctor_set(x_37, 1, x_35);
return x_37;
}
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("postponed_step");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1;
x_3 = lean_name_mk_string(x_1, x_2);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_Lean_SimpleMonadTracerAdapter_isTracingEnabledFor___rarg___lambda__1___closed__2;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2;
x_3 = l_Lean_Name_append___main(x_1, x_2);
return x_3;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; lean_object* x_192; uint8_t x_193; 
x_192 = lean_ctor_get(x_2, 4);
lean_inc(x_192);
x_193 = lean_ctor_get_uint8(x_192, sizeof(void*)*1);
lean_dec(x_192);
if (x_193 == 0)
{
uint8_t x_194; 
x_194 = 0;
x_3 = x_194;
x_4 = x_2;
goto block_191;
}
else
{
lean_object* x_195; lean_object* x_196; lean_object* x_197; lean_object* x_198; uint8_t x_199; 
x_195 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3;
x_196 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_195, x_1, x_2);
x_197 = lean_ctor_get(x_196, 0);
lean_inc(x_197);
x_198 = lean_ctor_get(x_196, 1);
lean_inc(x_198);
lean_dec(x_196);
x_199 = lean_unbox(x_197);
lean_dec(x_197);
x_3 = x_199;
x_4 = x_198;
goto block_191;
}
block_191:
{
if (x_3 == 0)
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; uint8_t x_7; 
x_6 = lean_ctor_get(x_4, 4);
x_7 = !lean_is_exclusive(x_6);
if (x_7 == 0)
{
uint8_t x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; 
x_8 = 1;
lean_ctor_set_uint8(x_6, sizeof(void*)*1, x_8);
x_9 = l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(x_4);
x_10 = lean_ctor_get(x_9, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_9, 1);
lean_inc(x_11);
lean_dec(x_9);
x_12 = l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(x_10, x_8, x_1, x_11);
lean_dec(x_10);
if (lean_obj_tag(x_12) == 0)
{
lean_object* x_13; lean_object* x_14; uint8_t x_15; 
x_13 = lean_ctor_get(x_12, 1);
lean_inc(x_13);
x_14 = lean_ctor_get(x_13, 4);
lean_inc(x_14);
x_15 = !lean_is_exclusive(x_12);
if (x_15 == 0)
{
lean_object* x_16; uint8_t x_17; 
x_16 = lean_ctor_get(x_12, 1);
lean_dec(x_16);
x_17 = !lean_is_exclusive(x_13);
if (x_17 == 0)
{
lean_object* x_18; uint8_t x_19; 
x_18 = lean_ctor_get(x_13, 4);
lean_dec(x_18);
x_19 = !lean_is_exclusive(x_14);
if (x_19 == 0)
{
uint8_t x_20; 
x_20 = 0;
lean_ctor_set_uint8(x_14, sizeof(void*)*1, x_20);
return x_12;
}
else
{
lean_object* x_21; uint8_t x_22; lean_object* x_23; 
x_21 = lean_ctor_get(x_14, 0);
lean_inc(x_21);
lean_dec(x_14);
x_22 = 0;
x_23 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_23, 0, x_21);
lean_ctor_set_uint8(x_23, sizeof(void*)*1, x_22);
lean_ctor_set(x_13, 4, x_23);
return x_12;
}
}
else
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; lean_object* x_29; lean_object* x_30; uint8_t x_31; lean_object* x_32; lean_object* x_33; 
x_24 = lean_ctor_get(x_13, 0);
x_25 = lean_ctor_get(x_13, 1);
x_26 = lean_ctor_get(x_13, 2);
x_27 = lean_ctor_get(x_13, 3);
x_28 = lean_ctor_get(x_13, 5);
lean_inc(x_28);
lean_inc(x_27);
lean_inc(x_26);
lean_inc(x_25);
lean_inc(x_24);
lean_dec(x_13);
x_29 = lean_ctor_get(x_14, 0);
lean_inc(x_29);
if (lean_is_exclusive(x_14)) {
 lean_ctor_release(x_14, 0);
 x_30 = x_14;
} else {
 lean_dec_ref(x_14);
 x_30 = lean_box(0);
}
x_31 = 0;
if (lean_is_scalar(x_30)) {
 x_32 = lean_alloc_ctor(0, 1, 1);
} else {
 x_32 = x_30;
}
lean_ctor_set(x_32, 0, x_29);
lean_ctor_set_uint8(x_32, sizeof(void*)*1, x_31);
x_33 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_33, 0, x_24);
lean_ctor_set(x_33, 1, x_25);
lean_ctor_set(x_33, 2, x_26);
lean_ctor_set(x_33, 3, x_27);
lean_ctor_set(x_33, 4, x_32);
lean_ctor_set(x_33, 5, x_28);
lean_ctor_set(x_12, 1, x_33);
return x_12;
}
}
else
{
lean_object* x_34; lean_object* x_35; lean_object* x_36; lean_object* x_37; lean_object* x_38; lean_object* x_39; lean_object* x_40; lean_object* x_41; lean_object* x_42; uint8_t x_43; lean_object* x_44; lean_object* x_45; lean_object* x_46; 
x_34 = lean_ctor_get(x_12, 0);
lean_inc(x_34);
lean_dec(x_12);
x_35 = lean_ctor_get(x_13, 0);
lean_inc(x_35);
x_36 = lean_ctor_get(x_13, 1);
lean_inc(x_36);
x_37 = lean_ctor_get(x_13, 2);
lean_inc(x_37);
x_38 = lean_ctor_get(x_13, 3);
lean_inc(x_38);
x_39 = lean_ctor_get(x_13, 5);
lean_inc(x_39);
if (lean_is_exclusive(x_13)) {
 lean_ctor_release(x_13, 0);
 lean_ctor_release(x_13, 1);
 lean_ctor_release(x_13, 2);
 lean_ctor_release(x_13, 3);
 lean_ctor_release(x_13, 4);
 lean_ctor_release(x_13, 5);
 x_40 = x_13;
} else {
 lean_dec_ref(x_13);
 x_40 = lean_box(0);
}
x_41 = lean_ctor_get(x_14, 0);
lean_inc(x_41);
if (lean_is_exclusive(x_14)) {
 lean_ctor_release(x_14, 0);
 x_42 = x_14;
} else {
 lean_dec_ref(x_14);
 x_42 = lean_box(0);
}
x_43 = 0;
if (lean_is_scalar(x_42)) {
 x_44 = lean_alloc_ctor(0, 1, 1);
} else {
 x_44 = x_42;
}
lean_ctor_set(x_44, 0, x_41);
lean_ctor_set_uint8(x_44, sizeof(void*)*1, x_43);
if (lean_is_scalar(x_40)) {
 x_45 = lean_alloc_ctor(0, 6, 0);
} else {
 x_45 = x_40;
}
lean_ctor_set(x_45, 0, x_35);
lean_ctor_set(x_45, 1, x_36);
lean_ctor_set(x_45, 2, x_37);
lean_ctor_set(x_45, 3, x_38);
lean_ctor_set(x_45, 4, x_44);
lean_ctor_set(x_45, 5, x_39);
x_46 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_46, 0, x_34);
lean_ctor_set(x_46, 1, x_45);
return x_46;
}
}
else
{
lean_object* x_47; lean_object* x_48; uint8_t x_49; 
x_47 = lean_ctor_get(x_12, 1);
lean_inc(x_47);
x_48 = lean_ctor_get(x_47, 4);
lean_inc(x_48);
x_49 = !lean_is_exclusive(x_12);
if (x_49 == 0)
{
lean_object* x_50; uint8_t x_51; 
x_50 = lean_ctor_get(x_12, 1);
lean_dec(x_50);
x_51 = !lean_is_exclusive(x_47);
if (x_51 == 0)
{
lean_object* x_52; uint8_t x_53; 
x_52 = lean_ctor_get(x_47, 4);
lean_dec(x_52);
x_53 = !lean_is_exclusive(x_48);
if (x_53 == 0)
{
uint8_t x_54; 
x_54 = 0;
lean_ctor_set_uint8(x_48, sizeof(void*)*1, x_54);
return x_12;
}
else
{
lean_object* x_55; uint8_t x_56; lean_object* x_57; 
x_55 = lean_ctor_get(x_48, 0);
lean_inc(x_55);
lean_dec(x_48);
x_56 = 0;
x_57 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_57, 0, x_55);
lean_ctor_set_uint8(x_57, sizeof(void*)*1, x_56);
lean_ctor_set(x_47, 4, x_57);
return x_12;
}
}
else
{
lean_object* x_58; lean_object* x_59; lean_object* x_60; lean_object* x_61; lean_object* x_62; lean_object* x_63; lean_object* x_64; uint8_t x_65; lean_object* x_66; lean_object* x_67; 
x_58 = lean_ctor_get(x_47, 0);
x_59 = lean_ctor_get(x_47, 1);
x_60 = lean_ctor_get(x_47, 2);
x_61 = lean_ctor_get(x_47, 3);
x_62 = lean_ctor_get(x_47, 5);
lean_inc(x_62);
lean_inc(x_61);
lean_inc(x_60);
lean_inc(x_59);
lean_inc(x_58);
lean_dec(x_47);
x_63 = lean_ctor_get(x_48, 0);
lean_inc(x_63);
if (lean_is_exclusive(x_48)) {
 lean_ctor_release(x_48, 0);
 x_64 = x_48;
} else {
 lean_dec_ref(x_48);
 x_64 = lean_box(0);
}
x_65 = 0;
if (lean_is_scalar(x_64)) {
 x_66 = lean_alloc_ctor(0, 1, 1);
} else {
 x_66 = x_64;
}
lean_ctor_set(x_66, 0, x_63);
lean_ctor_set_uint8(x_66, sizeof(void*)*1, x_65);
x_67 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_67, 0, x_58);
lean_ctor_set(x_67, 1, x_59);
lean_ctor_set(x_67, 2, x_60);
lean_ctor_set(x_67, 3, x_61);
lean_ctor_set(x_67, 4, x_66);
lean_ctor_set(x_67, 5, x_62);
lean_ctor_set(x_12, 1, x_67);
return x_12;
}
}
else
{
lean_object* x_68; lean_object* x_69; lean_object* x_70; lean_object* x_71; lean_object* x_72; lean_object* x_73; lean_object* x_74; lean_object* x_75; lean_object* x_76; uint8_t x_77; lean_object* x_78; lean_object* x_79; lean_object* x_80; 
x_68 = lean_ctor_get(x_12, 0);
lean_inc(x_68);
lean_dec(x_12);
x_69 = lean_ctor_get(x_47, 0);
lean_inc(x_69);
x_70 = lean_ctor_get(x_47, 1);
lean_inc(x_70);
x_71 = lean_ctor_get(x_47, 2);
lean_inc(x_71);
x_72 = lean_ctor_get(x_47, 3);
lean_inc(x_72);
x_73 = lean_ctor_get(x_47, 5);
lean_inc(x_73);
if (lean_is_exclusive(x_47)) {
 lean_ctor_release(x_47, 0);
 lean_ctor_release(x_47, 1);
 lean_ctor_release(x_47, 2);
 lean_ctor_release(x_47, 3);
 lean_ctor_release(x_47, 4);
 lean_ctor_release(x_47, 5);
 x_74 = x_47;
} else {
 lean_dec_ref(x_47);
 x_74 = lean_box(0);
}
x_75 = lean_ctor_get(x_48, 0);
lean_inc(x_75);
if (lean_is_exclusive(x_48)) {
 lean_ctor_release(x_48, 0);
 x_76 = x_48;
} else {
 lean_dec_ref(x_48);
 x_76 = lean_box(0);
}
x_77 = 0;
if (lean_is_scalar(x_76)) {
 x_78 = lean_alloc_ctor(0, 1, 1);
} else {
 x_78 = x_76;
}
lean_ctor_set(x_78, 0, x_75);
lean_ctor_set_uint8(x_78, sizeof(void*)*1, x_77);
if (lean_is_scalar(x_74)) {
 x_79 = lean_alloc_ctor(0, 6, 0);
} else {
 x_79 = x_74;
}
lean_ctor_set(x_79, 0, x_69);
lean_ctor_set(x_79, 1, x_70);
lean_ctor_set(x_79, 2, x_71);
lean_ctor_set(x_79, 3, x_72);
lean_ctor_set(x_79, 4, x_78);
lean_ctor_set(x_79, 5, x_73);
x_80 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_80, 0, x_68);
lean_ctor_set(x_80, 1, x_79);
return x_80;
}
}
}
else
{
lean_object* x_81; uint8_t x_82; lean_object* x_83; lean_object* x_84; lean_object* x_85; lean_object* x_86; lean_object* x_87; 
x_81 = lean_ctor_get(x_6, 0);
lean_inc(x_81);
lean_dec(x_6);
x_82 = 1;
x_83 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_83, 0, x_81);
lean_ctor_set_uint8(x_83, sizeof(void*)*1, x_82);
lean_ctor_set(x_4, 4, x_83);
x_84 = l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(x_4);
x_85 = lean_ctor_get(x_84, 0);
lean_inc(x_85);
x_86 = lean_ctor_get(x_84, 1);
lean_inc(x_86);
lean_dec(x_84);
x_87 = l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(x_85, x_82, x_1, x_86);
lean_dec(x_85);
if (lean_obj_tag(x_87) == 0)
{
lean_object* x_88; lean_object* x_89; lean_object* x_90; lean_object* x_91; lean_object* x_92; lean_object* x_93; lean_object* x_94; lean_object* x_95; lean_object* x_96; lean_object* x_97; lean_object* x_98; lean_object* x_99; uint8_t x_100; lean_object* x_101; lean_object* x_102; lean_object* x_103; 
x_88 = lean_ctor_get(x_87, 1);
lean_inc(x_88);
x_89 = lean_ctor_get(x_88, 4);
lean_inc(x_89);
x_90 = lean_ctor_get(x_87, 0);
lean_inc(x_90);
if (lean_is_exclusive(x_87)) {
 lean_ctor_release(x_87, 0);
 lean_ctor_release(x_87, 1);
 x_91 = x_87;
} else {
 lean_dec_ref(x_87);
 x_91 = lean_box(0);
}
x_92 = lean_ctor_get(x_88, 0);
lean_inc(x_92);
x_93 = lean_ctor_get(x_88, 1);
lean_inc(x_93);
x_94 = lean_ctor_get(x_88, 2);
lean_inc(x_94);
x_95 = lean_ctor_get(x_88, 3);
lean_inc(x_95);
x_96 = lean_ctor_get(x_88, 5);
lean_inc(x_96);
if (lean_is_exclusive(x_88)) {
 lean_ctor_release(x_88, 0);
 lean_ctor_release(x_88, 1);
 lean_ctor_release(x_88, 2);
 lean_ctor_release(x_88, 3);
 lean_ctor_release(x_88, 4);
 lean_ctor_release(x_88, 5);
 x_97 = x_88;
} else {
 lean_dec_ref(x_88);
 x_97 = lean_box(0);
}
x_98 = lean_ctor_get(x_89, 0);
lean_inc(x_98);
if (lean_is_exclusive(x_89)) {
 lean_ctor_release(x_89, 0);
 x_99 = x_89;
} else {
 lean_dec_ref(x_89);
 x_99 = lean_box(0);
}
x_100 = 0;
if (lean_is_scalar(x_99)) {
 x_101 = lean_alloc_ctor(0, 1, 1);
} else {
 x_101 = x_99;
}
lean_ctor_set(x_101, 0, x_98);
lean_ctor_set_uint8(x_101, sizeof(void*)*1, x_100);
if (lean_is_scalar(x_97)) {
 x_102 = lean_alloc_ctor(0, 6, 0);
} else {
 x_102 = x_97;
}
lean_ctor_set(x_102, 0, x_92);
lean_ctor_set(x_102, 1, x_93);
lean_ctor_set(x_102, 2, x_94);
lean_ctor_set(x_102, 3, x_95);
lean_ctor_set(x_102, 4, x_101);
lean_ctor_set(x_102, 5, x_96);
if (lean_is_scalar(x_91)) {
 x_103 = lean_alloc_ctor(0, 2, 0);
} else {
 x_103 = x_91;
}
lean_ctor_set(x_103, 0, x_90);
lean_ctor_set(x_103, 1, x_102);
return x_103;
}
else
{
lean_object* x_104; lean_object* x_105; lean_object* x_106; lean_object* x_107; lean_object* x_108; lean_object* x_109; lean_object* x_110; lean_object* x_111; lean_object* x_112; lean_object* x_113; lean_object* x_114; lean_object* x_115; uint8_t x_116; lean_object* x_117; lean_object* x_118; lean_object* x_119; 
x_104 = lean_ctor_get(x_87, 1);
lean_inc(x_104);
x_105 = lean_ctor_get(x_104, 4);
lean_inc(x_105);
x_106 = lean_ctor_get(x_87, 0);
lean_inc(x_106);
if (lean_is_exclusive(x_87)) {
 lean_ctor_release(x_87, 0);
 lean_ctor_release(x_87, 1);
 x_107 = x_87;
} else {
 lean_dec_ref(x_87);
 x_107 = lean_box(0);
}
x_108 = lean_ctor_get(x_104, 0);
lean_inc(x_108);
x_109 = lean_ctor_get(x_104, 1);
lean_inc(x_109);
x_110 = lean_ctor_get(x_104, 2);
lean_inc(x_110);
x_111 = lean_ctor_get(x_104, 3);
lean_inc(x_111);
x_112 = lean_ctor_get(x_104, 5);
lean_inc(x_112);
if (lean_is_exclusive(x_104)) {
 lean_ctor_release(x_104, 0);
 lean_ctor_release(x_104, 1);
 lean_ctor_release(x_104, 2);
 lean_ctor_release(x_104, 3);
 lean_ctor_release(x_104, 4);
 lean_ctor_release(x_104, 5);
 x_113 = x_104;
} else {
 lean_dec_ref(x_104);
 x_113 = lean_box(0);
}
x_114 = lean_ctor_get(x_105, 0);
lean_inc(x_114);
if (lean_is_exclusive(x_105)) {
 lean_ctor_release(x_105, 0);
 x_115 = x_105;
} else {
 lean_dec_ref(x_105);
 x_115 = lean_box(0);
}
x_116 = 0;
if (lean_is_scalar(x_115)) {
 x_117 = lean_alloc_ctor(0, 1, 1);
} else {
 x_117 = x_115;
}
lean_ctor_set(x_117, 0, x_114);
lean_ctor_set_uint8(x_117, sizeof(void*)*1, x_116);
if (lean_is_scalar(x_113)) {
 x_118 = lean_alloc_ctor(0, 6, 0);
} else {
 x_118 = x_113;
}
lean_ctor_set(x_118, 0, x_108);
lean_ctor_set(x_118, 1, x_109);
lean_ctor_set(x_118, 2, x_110);
lean_ctor_set(x_118, 3, x_111);
lean_ctor_set(x_118, 4, x_117);
lean_ctor_set(x_118, 5, x_112);
if (lean_is_scalar(x_107)) {
 x_119 = lean_alloc_ctor(1, 2, 0);
} else {
 x_119 = x_107;
}
lean_ctor_set(x_119, 0, x_106);
lean_ctor_set(x_119, 1, x_118);
return x_119;
}
}
}
else
{
lean_object* x_120; lean_object* x_121; lean_object* x_122; lean_object* x_123; lean_object* x_124; lean_object* x_125; lean_object* x_126; lean_object* x_127; uint8_t x_128; lean_object* x_129; lean_object* x_130; lean_object* x_131; lean_object* x_132; lean_object* x_133; lean_object* x_134; 
x_120 = lean_ctor_get(x_4, 4);
x_121 = lean_ctor_get(x_4, 0);
x_122 = lean_ctor_get(x_4, 1);
x_123 = lean_ctor_get(x_4, 2);
x_124 = lean_ctor_get(x_4, 3);
x_125 = lean_ctor_get(x_4, 5);
lean_inc(x_125);
lean_inc(x_120);
lean_inc(x_124);
lean_inc(x_123);
lean_inc(x_122);
lean_inc(x_121);
lean_dec(x_4);
x_126 = lean_ctor_get(x_120, 0);
lean_inc(x_126);
if (lean_is_exclusive(x_120)) {
 lean_ctor_release(x_120, 0);
 x_127 = x_120;
} else {
 lean_dec_ref(x_120);
 x_127 = lean_box(0);
}
x_128 = 1;
if (lean_is_scalar(x_127)) {
 x_129 = lean_alloc_ctor(0, 1, 1);
} else {
 x_129 = x_127;
}
lean_ctor_set(x_129, 0, x_126);
lean_ctor_set_uint8(x_129, sizeof(void*)*1, x_128);
x_130 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_130, 0, x_121);
lean_ctor_set(x_130, 1, x_122);
lean_ctor_set(x_130, 2, x_123);
lean_ctor_set(x_130, 3, x_124);
lean_ctor_set(x_130, 4, x_129);
lean_ctor_set(x_130, 5, x_125);
x_131 = l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(x_130);
x_132 = lean_ctor_get(x_131, 0);
lean_inc(x_132);
x_133 = lean_ctor_get(x_131, 1);
lean_inc(x_133);
lean_dec(x_131);
x_134 = l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(x_132, x_128, x_1, x_133);
lean_dec(x_132);
if (lean_obj_tag(x_134) == 0)
{
lean_object* x_135; lean_object* x_136; lean_object* x_137; lean_object* x_138; lean_object* x_139; lean_object* x_140; lean_object* x_141; lean_object* x_142; lean_object* x_143; lean_object* x_144; lean_object* x_145; lean_object* x_146; uint8_t x_147; lean_object* x_148; lean_object* x_149; lean_object* x_150; 
x_135 = lean_ctor_get(x_134, 1);
lean_inc(x_135);
x_136 = lean_ctor_get(x_135, 4);
lean_inc(x_136);
x_137 = lean_ctor_get(x_134, 0);
lean_inc(x_137);
if (lean_is_exclusive(x_134)) {
 lean_ctor_release(x_134, 0);
 lean_ctor_release(x_134, 1);
 x_138 = x_134;
} else {
 lean_dec_ref(x_134);
 x_138 = lean_box(0);
}
x_139 = lean_ctor_get(x_135, 0);
lean_inc(x_139);
x_140 = lean_ctor_get(x_135, 1);
lean_inc(x_140);
x_141 = lean_ctor_get(x_135, 2);
lean_inc(x_141);
x_142 = lean_ctor_get(x_135, 3);
lean_inc(x_142);
x_143 = lean_ctor_get(x_135, 5);
lean_inc(x_143);
if (lean_is_exclusive(x_135)) {
 lean_ctor_release(x_135, 0);
 lean_ctor_release(x_135, 1);
 lean_ctor_release(x_135, 2);
 lean_ctor_release(x_135, 3);
 lean_ctor_release(x_135, 4);
 lean_ctor_release(x_135, 5);
 x_144 = x_135;
} else {
 lean_dec_ref(x_135);
 x_144 = lean_box(0);
}
x_145 = lean_ctor_get(x_136, 0);
lean_inc(x_145);
if (lean_is_exclusive(x_136)) {
 lean_ctor_release(x_136, 0);
 x_146 = x_136;
} else {
 lean_dec_ref(x_136);
 x_146 = lean_box(0);
}
x_147 = 0;
if (lean_is_scalar(x_146)) {
 x_148 = lean_alloc_ctor(0, 1, 1);
} else {
 x_148 = x_146;
}
lean_ctor_set(x_148, 0, x_145);
lean_ctor_set_uint8(x_148, sizeof(void*)*1, x_147);
if (lean_is_scalar(x_144)) {
 x_149 = lean_alloc_ctor(0, 6, 0);
} else {
 x_149 = x_144;
}
lean_ctor_set(x_149, 0, x_139);
lean_ctor_set(x_149, 1, x_140);
lean_ctor_set(x_149, 2, x_141);
lean_ctor_set(x_149, 3, x_142);
lean_ctor_set(x_149, 4, x_148);
lean_ctor_set(x_149, 5, x_143);
if (lean_is_scalar(x_138)) {
 x_150 = lean_alloc_ctor(0, 2, 0);
} else {
 x_150 = x_138;
}
lean_ctor_set(x_150, 0, x_137);
lean_ctor_set(x_150, 1, x_149);
return x_150;
}
else
{
lean_object* x_151; lean_object* x_152; lean_object* x_153; lean_object* x_154; lean_object* x_155; lean_object* x_156; lean_object* x_157; lean_object* x_158; lean_object* x_159; lean_object* x_160; lean_object* x_161; lean_object* x_162; uint8_t x_163; lean_object* x_164; lean_object* x_165; lean_object* x_166; 
x_151 = lean_ctor_get(x_134, 1);
lean_inc(x_151);
x_152 = lean_ctor_get(x_151, 4);
lean_inc(x_152);
x_153 = lean_ctor_get(x_134, 0);
lean_inc(x_153);
if (lean_is_exclusive(x_134)) {
 lean_ctor_release(x_134, 0);
 lean_ctor_release(x_134, 1);
 x_154 = x_134;
} else {
 lean_dec_ref(x_134);
 x_154 = lean_box(0);
}
x_155 = lean_ctor_get(x_151, 0);
lean_inc(x_155);
x_156 = lean_ctor_get(x_151, 1);
lean_inc(x_156);
x_157 = lean_ctor_get(x_151, 2);
lean_inc(x_157);
x_158 = lean_ctor_get(x_151, 3);
lean_inc(x_158);
x_159 = lean_ctor_get(x_151, 5);
lean_inc(x_159);
if (lean_is_exclusive(x_151)) {
 lean_ctor_release(x_151, 0);
 lean_ctor_release(x_151, 1);
 lean_ctor_release(x_151, 2);
 lean_ctor_release(x_151, 3);
 lean_ctor_release(x_151, 4);
 lean_ctor_release(x_151, 5);
 x_160 = x_151;
} else {
 lean_dec_ref(x_151);
 x_160 = lean_box(0);
}
x_161 = lean_ctor_get(x_152, 0);
lean_inc(x_161);
if (lean_is_exclusive(x_152)) {
 lean_ctor_release(x_152, 0);
 x_162 = x_152;
} else {
 lean_dec_ref(x_152);
 x_162 = lean_box(0);
}
x_163 = 0;
if (lean_is_scalar(x_162)) {
 x_164 = lean_alloc_ctor(0, 1, 1);
} else {
 x_164 = x_162;
}
lean_ctor_set(x_164, 0, x_161);
lean_ctor_set_uint8(x_164, sizeof(void*)*1, x_163);
if (lean_is_scalar(x_160)) {
 x_165 = lean_alloc_ctor(0, 6, 0);
} else {
 x_165 = x_160;
}
lean_ctor_set(x_165, 0, x_155);
lean_ctor_set(x_165, 1, x_156);
lean_ctor_set(x_165, 2, x_157);
lean_ctor_set(x_165, 3, x_158);
lean_ctor_set(x_165, 4, x_164);
lean_ctor_set(x_165, 5, x_159);
if (lean_is_scalar(x_154)) {
 x_166 = lean_alloc_ctor(1, 2, 0);
} else {
 x_166 = x_154;
}
lean_ctor_set(x_166, 0, x_153);
lean_ctor_set(x_166, 1, x_165);
return x_166;
}
}
}
else
{
lean_object* x_167; lean_object* x_168; lean_object* x_169; lean_object* x_170; lean_object* x_171; lean_object* x_172; uint8_t x_173; lean_object* x_174; 
x_167 = l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg(x_4);
x_168 = lean_ctor_get(x_167, 0);
lean_inc(x_168);
x_169 = lean_ctor_get(x_167, 1);
lean_inc(x_169);
lean_dec(x_167);
x_170 = l___private_Init_Lean_Meta_LevelDefEq_9__getResetPostponed___rarg(x_169);
x_171 = lean_ctor_get(x_170, 0);
lean_inc(x_171);
x_172 = lean_ctor_get(x_170, 1);
lean_inc(x_172);
lean_dec(x_170);
x_173 = 1;
x_174 = l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(x_171, x_173, x_1, x_172);
lean_dec(x_171);
if (lean_obj_tag(x_174) == 0)
{
lean_object* x_175; lean_object* x_176; lean_object* x_177; lean_object* x_178; uint8_t x_179; 
x_175 = lean_ctor_get(x_174, 0);
lean_inc(x_175);
x_176 = lean_ctor_get(x_174, 1);
lean_inc(x_176);
lean_dec(x_174);
x_177 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2;
x_178 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_168, x_177, x_1, x_176);
x_179 = !lean_is_exclusive(x_178);
if (x_179 == 0)
{
lean_object* x_180; 
x_180 = lean_ctor_get(x_178, 0);
lean_dec(x_180);
lean_ctor_set(x_178, 0, x_175);
return x_178;
}
else
{
lean_object* x_181; lean_object* x_182; 
x_181 = lean_ctor_get(x_178, 1);
lean_inc(x_181);
lean_dec(x_178);
x_182 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_182, 0, x_175);
lean_ctor_set(x_182, 1, x_181);
return x_182;
}
}
else
{
lean_object* x_183; lean_object* x_184; lean_object* x_185; lean_object* x_186; uint8_t x_187; 
x_183 = lean_ctor_get(x_174, 0);
lean_inc(x_183);
x_184 = lean_ctor_get(x_174, 1);
lean_inc(x_184);
lean_dec(x_174);
x_185 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2;
x_186 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_168, x_185, x_1, x_184);
x_187 = !lean_is_exclusive(x_186);
if (x_187 == 0)
{
lean_object* x_188; 
x_188 = lean_ctor_get(x_186, 0);
lean_dec(x_188);
lean_ctor_set_tag(x_186, 1);
lean_ctor_set(x_186, 0, x_183);
return x_186;
}
else
{
lean_object* x_189; lean_object* x_190; 
x_189 = lean_ctor_get(x_186, 1);
lean_inc(x_189);
lean_dec(x_186);
x_190 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_190, 0, x_183);
lean_ctor_set(x_190, 1, x_189);
return x_190;
}
}
}
}
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
uint8_t x_7; lean_object* x_8; 
x_7 = lean_unbox(x_4);
lean_dec(x_4);
x_8 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__3(x_1, x_2, x_3, x_7, x_5, x_6);
lean_dec(x_5);
lean_dec(x_2);
lean_dec(x_1);
return x_8;
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
uint8_t x_7; lean_object* x_8; 
x_7 = lean_unbox(x_4);
lean_dec(x_4);
x_8 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__4(x_1, x_2, x_3, x_7, x_5, x_6);
lean_dec(x_5);
lean_dec(x_2);
lean_dec(x_1);
return x_8;
}
}
lean_object* l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; lean_object* x_6; 
x_5 = lean_unbox(x_2);
lean_dec(x_2);
x_6 = l_PersistentArray_foldlMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__2(x_1, x_5, x_3, x_4);
lean_dec(x_3);
lean_dec(x_1);
return x_6;
}
}
lean_object* l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
uint8_t x_7; lean_object* x_8; 
x_7 = lean_unbox(x_4);
lean_dec(x_4);
x_8 = l_Array_iterateMAux___main___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__5(x_1, x_2, x_3, x_7, x_5, x_6);
lean_dec(x_5);
lean_dec(x_2);
lean_dec(x_1);
return x_8;
}
}
lean_object* l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; lean_object* x_6; 
x_5 = lean_unbox(x_2);
lean_dec(x_2);
x_6 = l_PersistentArray_foldlM___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__1(x_1, x_5, x_3, x_4);
lean_dec(x_3);
lean_dec(x_1);
return x_6;
}
}
lean_object* l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep(x_1, x_2);
lean_dec(x_1);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("no progress solving pending is-def-eq level constraints");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1;
x_2 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("processing #");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4;
x_2 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string(" postponed is-def-eq level constraints");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7;
x_2 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8;
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(uint8_t x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; uint8_t x_5; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(x_3);
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; uint8_t x_9; 
x_6 = lean_ctor_get(x_4, 0);
x_7 = lean_ctor_get(x_4, 1);
x_8 = lean_unsigned_to_nat(0u);
x_9 = lean_nat_dec_eq(x_6, x_8);
if (x_9 == 0)
{
lean_object* x_10; lean_object* x_84; uint8_t x_85; 
lean_free_object(x_4);
x_84 = lean_ctor_get(x_7, 4);
lean_inc(x_84);
x_85 = lean_ctor_get_uint8(x_84, sizeof(void*)*1);
lean_dec(x_84);
if (x_85 == 0)
{
x_10 = x_7;
goto block_83;
}
else
{
lean_object* x_86; lean_object* x_87; lean_object* x_88; uint8_t x_89; 
x_86 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_87 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_86, x_2, x_7);
x_88 = lean_ctor_get(x_87, 0);
lean_inc(x_88);
x_89 = lean_unbox(x_88);
lean_dec(x_88);
if (x_89 == 0)
{
lean_object* x_90; 
x_90 = lean_ctor_get(x_87, 1);
lean_inc(x_90);
lean_dec(x_87);
x_10 = x_90;
goto block_83;
}
else
{
lean_object* x_91; lean_object* x_92; lean_object* x_93; lean_object* x_94; lean_object* x_95; lean_object* x_96; lean_object* x_97; lean_object* x_98; lean_object* x_99; lean_object* x_100; lean_object* x_101; 
x_91 = lean_ctor_get(x_87, 1);
lean_inc(x_91);
lean_dec(x_87);
lean_inc(x_6);
x_92 = l_Nat_repr(x_6);
x_93 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_93, 0, x_92);
x_94 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_94, 0, x_93);
x_95 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6;
x_96 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_96, 0, x_95);
lean_ctor_set(x_96, 1, x_94);
x_97 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9;
x_98 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_98, 0, x_96);
lean_ctor_set(x_98, 1, x_97);
x_99 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_100 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_99, x_98, x_2, x_91);
x_101 = lean_ctor_get(x_100, 1);
lean_inc(x_101);
lean_dec(x_100);
x_10 = x_101;
goto block_83;
}
}
block_83:
{
lean_object* x_11; 
x_11 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep(x_2, x_10);
if (lean_obj_tag(x_11) == 0)
{
lean_object* x_12; uint8_t x_13; 
x_12 = lean_ctor_get(x_11, 0);
lean_inc(x_12);
x_13 = lean_unbox(x_12);
if (x_13 == 0)
{
uint8_t x_14; 
lean_dec(x_6);
x_14 = !lean_is_exclusive(x_11);
if (x_14 == 0)
{
lean_object* x_15; 
x_15 = lean_ctor_get(x_11, 0);
lean_dec(x_15);
return x_11;
}
else
{
lean_object* x_16; lean_object* x_17; 
x_16 = lean_ctor_get(x_11, 1);
lean_inc(x_16);
lean_dec(x_11);
x_17 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_17, 0, x_12);
lean_ctor_set(x_17, 1, x_16);
return x_17;
}
}
else
{
lean_object* x_18; lean_object* x_19; uint8_t x_20; 
lean_dec(x_12);
x_18 = lean_ctor_get(x_11, 1);
lean_inc(x_18);
lean_dec(x_11);
x_19 = l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(x_18);
x_20 = !lean_is_exclusive(x_19);
if (x_20 == 0)
{
lean_object* x_21; lean_object* x_22; uint8_t x_23; 
x_21 = lean_ctor_get(x_19, 0);
x_22 = lean_ctor_get(x_19, 1);
x_23 = lean_nat_dec_eq(x_21, x_8);
if (x_23 == 0)
{
uint8_t x_24; 
x_24 = lean_nat_dec_lt(x_21, x_6);
lean_dec(x_6);
lean_dec(x_21);
if (x_24 == 0)
{
lean_object* x_25; uint8_t x_26; 
x_25 = lean_ctor_get(x_22, 4);
lean_inc(x_25);
x_26 = lean_ctor_get_uint8(x_25, sizeof(void*)*1);
lean_dec(x_25);
if (x_26 == 0)
{
lean_object* x_27; 
x_27 = lean_box(x_1);
lean_ctor_set(x_19, 0, x_27);
return x_19;
}
else
{
lean_object* x_28; lean_object* x_29; lean_object* x_30; uint8_t x_31; 
lean_free_object(x_19);
x_28 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_29 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_28, x_2, x_22);
x_30 = lean_ctor_get(x_29, 0);
lean_inc(x_30);
x_31 = lean_unbox(x_30);
lean_dec(x_30);
if (x_31 == 0)
{
uint8_t x_32; 
x_32 = !lean_is_exclusive(x_29);
if (x_32 == 0)
{
lean_object* x_33; lean_object* x_34; 
x_33 = lean_ctor_get(x_29, 0);
lean_dec(x_33);
x_34 = lean_box(x_1);
lean_ctor_set(x_29, 0, x_34);
return x_29;
}
else
{
lean_object* x_35; lean_object* x_36; lean_object* x_37; 
x_35 = lean_ctor_get(x_29, 1);
lean_inc(x_35);
lean_dec(x_29);
x_36 = lean_box(x_1);
x_37 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_37, 0, x_36);
lean_ctor_set(x_37, 1, x_35);
return x_37;
}
}
else
{
lean_object* x_38; lean_object* x_39; lean_object* x_40; lean_object* x_41; uint8_t x_42; 
x_38 = lean_ctor_get(x_29, 1);
lean_inc(x_38);
lean_dec(x_29);
x_39 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_40 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3;
x_41 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_39, x_40, x_2, x_38);
x_42 = !lean_is_exclusive(x_41);
if (x_42 == 0)
{
lean_object* x_43; lean_object* x_44; 
x_43 = lean_ctor_get(x_41, 0);
lean_dec(x_43);
x_44 = lean_box(x_1);
lean_ctor_set(x_41, 0, x_44);
return x_41;
}
else
{
lean_object* x_45; lean_object* x_46; lean_object* x_47; 
x_45 = lean_ctor_get(x_41, 1);
lean_inc(x_45);
lean_dec(x_41);
x_46 = lean_box(x_1);
x_47 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_47, 0, x_46);
lean_ctor_set(x_47, 1, x_45);
return x_47;
}
}
}
}
else
{
lean_free_object(x_19);
x_3 = x_22;
goto _start;
}
}
else
{
uint8_t x_49; lean_object* x_50; 
lean_dec(x_21);
lean_dec(x_6);
x_49 = 1;
x_50 = lean_box(x_49);
lean_ctor_set(x_19, 0, x_50);
return x_19;
}
}
else
{
lean_object* x_51; lean_object* x_52; uint8_t x_53; 
x_51 = lean_ctor_get(x_19, 0);
x_52 = lean_ctor_get(x_19, 1);
lean_inc(x_52);
lean_inc(x_51);
lean_dec(x_19);
x_53 = lean_nat_dec_eq(x_51, x_8);
if (x_53 == 0)
{
uint8_t x_54; 
x_54 = lean_nat_dec_lt(x_51, x_6);
lean_dec(x_6);
lean_dec(x_51);
if (x_54 == 0)
{
lean_object* x_55; uint8_t x_56; 
x_55 = lean_ctor_get(x_52, 4);
lean_inc(x_55);
x_56 = lean_ctor_get_uint8(x_55, sizeof(void*)*1);
lean_dec(x_55);
if (x_56 == 0)
{
lean_object* x_57; lean_object* x_58; 
x_57 = lean_box(x_1);
x_58 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_58, 0, x_57);
lean_ctor_set(x_58, 1, x_52);
return x_58;
}
else
{
lean_object* x_59; lean_object* x_60; lean_object* x_61; uint8_t x_62; 
x_59 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_60 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_59, x_2, x_52);
x_61 = lean_ctor_get(x_60, 0);
lean_inc(x_61);
x_62 = lean_unbox(x_61);
lean_dec(x_61);
if (x_62 == 0)
{
lean_object* x_63; lean_object* x_64; lean_object* x_65; lean_object* x_66; 
x_63 = lean_ctor_get(x_60, 1);
lean_inc(x_63);
if (lean_is_exclusive(x_60)) {
 lean_ctor_release(x_60, 0);
 lean_ctor_release(x_60, 1);
 x_64 = x_60;
} else {
 lean_dec_ref(x_60);
 x_64 = lean_box(0);
}
x_65 = lean_box(x_1);
if (lean_is_scalar(x_64)) {
 x_66 = lean_alloc_ctor(0, 2, 0);
} else {
 x_66 = x_64;
}
lean_ctor_set(x_66, 0, x_65);
lean_ctor_set(x_66, 1, x_63);
return x_66;
}
else
{
lean_object* x_67; lean_object* x_68; lean_object* x_69; lean_object* x_70; lean_object* x_71; lean_object* x_72; lean_object* x_73; lean_object* x_74; 
x_67 = lean_ctor_get(x_60, 1);
lean_inc(x_67);
lean_dec(x_60);
x_68 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_69 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3;
x_70 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_68, x_69, x_2, x_67);
x_71 = lean_ctor_get(x_70, 1);
lean_inc(x_71);
if (lean_is_exclusive(x_70)) {
 lean_ctor_release(x_70, 0);
 lean_ctor_release(x_70, 1);
 x_72 = x_70;
} else {
 lean_dec_ref(x_70);
 x_72 = lean_box(0);
}
x_73 = lean_box(x_1);
if (lean_is_scalar(x_72)) {
 x_74 = lean_alloc_ctor(0, 2, 0);
} else {
 x_74 = x_72;
}
lean_ctor_set(x_74, 0, x_73);
lean_ctor_set(x_74, 1, x_71);
return x_74;
}
}
}
else
{
x_3 = x_52;
goto _start;
}
}
else
{
uint8_t x_76; lean_object* x_77; lean_object* x_78; 
lean_dec(x_51);
lean_dec(x_6);
x_76 = 1;
x_77 = lean_box(x_76);
x_78 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_78, 0, x_77);
lean_ctor_set(x_78, 1, x_52);
return x_78;
}
}
}
}
else
{
uint8_t x_79; 
lean_dec(x_6);
x_79 = !lean_is_exclusive(x_11);
if (x_79 == 0)
{
return x_11;
}
else
{
lean_object* x_80; lean_object* x_81; lean_object* x_82; 
x_80 = lean_ctor_get(x_11, 0);
x_81 = lean_ctor_get(x_11, 1);
lean_inc(x_81);
lean_inc(x_80);
lean_dec(x_11);
x_82 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_82, 0, x_80);
lean_ctor_set(x_82, 1, x_81);
return x_82;
}
}
}
}
else
{
uint8_t x_102; lean_object* x_103; 
lean_dec(x_6);
x_102 = 1;
x_103 = lean_box(x_102);
lean_ctor_set(x_4, 0, x_103);
return x_4;
}
}
else
{
lean_object* x_104; lean_object* x_105; lean_object* x_106; uint8_t x_107; 
x_104 = lean_ctor_get(x_4, 0);
x_105 = lean_ctor_get(x_4, 1);
lean_inc(x_105);
lean_inc(x_104);
lean_dec(x_4);
x_106 = lean_unsigned_to_nat(0u);
x_107 = lean_nat_dec_eq(x_104, x_106);
if (x_107 == 0)
{
lean_object* x_108; lean_object* x_151; uint8_t x_152; 
x_151 = lean_ctor_get(x_105, 4);
lean_inc(x_151);
x_152 = lean_ctor_get_uint8(x_151, sizeof(void*)*1);
lean_dec(x_151);
if (x_152 == 0)
{
x_108 = x_105;
goto block_150;
}
else
{
lean_object* x_153; lean_object* x_154; lean_object* x_155; uint8_t x_156; 
x_153 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_154 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_153, x_2, x_105);
x_155 = lean_ctor_get(x_154, 0);
lean_inc(x_155);
x_156 = lean_unbox(x_155);
lean_dec(x_155);
if (x_156 == 0)
{
lean_object* x_157; 
x_157 = lean_ctor_get(x_154, 1);
lean_inc(x_157);
lean_dec(x_154);
x_108 = x_157;
goto block_150;
}
else
{
lean_object* x_158; lean_object* x_159; lean_object* x_160; lean_object* x_161; lean_object* x_162; lean_object* x_163; lean_object* x_164; lean_object* x_165; lean_object* x_166; lean_object* x_167; lean_object* x_168; 
x_158 = lean_ctor_get(x_154, 1);
lean_inc(x_158);
lean_dec(x_154);
lean_inc(x_104);
x_159 = l_Nat_repr(x_104);
x_160 = lean_alloc_ctor(2, 1, 0);
lean_ctor_set(x_160, 0, x_159);
x_161 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_161, 0, x_160);
x_162 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6;
x_163 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_163, 0, x_162);
lean_ctor_set(x_163, 1, x_161);
x_164 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9;
x_165 = lean_alloc_ctor(7, 2, 0);
lean_ctor_set(x_165, 0, x_163);
lean_ctor_set(x_165, 1, x_164);
x_166 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_167 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_166, x_165, x_2, x_158);
x_168 = lean_ctor_get(x_167, 1);
lean_inc(x_168);
lean_dec(x_167);
x_108 = x_168;
goto block_150;
}
}
block_150:
{
lean_object* x_109; 
x_109 = l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep(x_2, x_108);
if (lean_obj_tag(x_109) == 0)
{
lean_object* x_110; uint8_t x_111; 
x_110 = lean_ctor_get(x_109, 0);
lean_inc(x_110);
x_111 = lean_unbox(x_110);
if (x_111 == 0)
{
lean_object* x_112; lean_object* x_113; lean_object* x_114; 
lean_dec(x_104);
x_112 = lean_ctor_get(x_109, 1);
lean_inc(x_112);
if (lean_is_exclusive(x_109)) {
 lean_ctor_release(x_109, 0);
 lean_ctor_release(x_109, 1);
 x_113 = x_109;
} else {
 lean_dec_ref(x_109);
 x_113 = lean_box(0);
}
if (lean_is_scalar(x_113)) {
 x_114 = lean_alloc_ctor(0, 2, 0);
} else {
 x_114 = x_113;
}
lean_ctor_set(x_114, 0, x_110);
lean_ctor_set(x_114, 1, x_112);
return x_114;
}
else
{
lean_object* x_115; lean_object* x_116; lean_object* x_117; lean_object* x_118; lean_object* x_119; uint8_t x_120; 
lean_dec(x_110);
x_115 = lean_ctor_get(x_109, 1);
lean_inc(x_115);
lean_dec(x_109);
x_116 = l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(x_115);
x_117 = lean_ctor_get(x_116, 0);
lean_inc(x_117);
x_118 = lean_ctor_get(x_116, 1);
lean_inc(x_118);
if (lean_is_exclusive(x_116)) {
 lean_ctor_release(x_116, 0);
 lean_ctor_release(x_116, 1);
 x_119 = x_116;
} else {
 lean_dec_ref(x_116);
 x_119 = lean_box(0);
}
x_120 = lean_nat_dec_eq(x_117, x_106);
if (x_120 == 0)
{
uint8_t x_121; 
x_121 = lean_nat_dec_lt(x_117, x_104);
lean_dec(x_104);
lean_dec(x_117);
if (x_121 == 0)
{
lean_object* x_122; uint8_t x_123; 
x_122 = lean_ctor_get(x_118, 4);
lean_inc(x_122);
x_123 = lean_ctor_get_uint8(x_122, sizeof(void*)*1);
lean_dec(x_122);
if (x_123 == 0)
{
lean_object* x_124; lean_object* x_125; 
x_124 = lean_box(x_1);
if (lean_is_scalar(x_119)) {
 x_125 = lean_alloc_ctor(0, 2, 0);
} else {
 x_125 = x_119;
}
lean_ctor_set(x_125, 0, x_124);
lean_ctor_set(x_125, 1, x_118);
return x_125;
}
else
{
lean_object* x_126; lean_object* x_127; lean_object* x_128; uint8_t x_129; 
lean_dec(x_119);
x_126 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5;
x_127 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_126, x_2, x_118);
x_128 = lean_ctor_get(x_127, 0);
lean_inc(x_128);
x_129 = lean_unbox(x_128);
lean_dec(x_128);
if (x_129 == 0)
{
lean_object* x_130; lean_object* x_131; lean_object* x_132; lean_object* x_133; 
x_130 = lean_ctor_get(x_127, 1);
lean_inc(x_130);
if (lean_is_exclusive(x_127)) {
 lean_ctor_release(x_127, 0);
 lean_ctor_release(x_127, 1);
 x_131 = x_127;
} else {
 lean_dec_ref(x_127);
 x_131 = lean_box(0);
}
x_132 = lean_box(x_1);
if (lean_is_scalar(x_131)) {
 x_133 = lean_alloc_ctor(0, 2, 0);
} else {
 x_133 = x_131;
}
lean_ctor_set(x_133, 0, x_132);
lean_ctor_set(x_133, 1, x_130);
return x_133;
}
else
{
lean_object* x_134; lean_object* x_135; lean_object* x_136; lean_object* x_137; lean_object* x_138; lean_object* x_139; lean_object* x_140; lean_object* x_141; 
x_134 = lean_ctor_get(x_127, 1);
lean_inc(x_134);
lean_dec(x_127);
x_135 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_136 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3;
x_137 = l___private_Init_Lean_Trace_3__addTrace___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__2(x_135, x_136, x_2, x_134);
x_138 = lean_ctor_get(x_137, 1);
lean_inc(x_138);
if (lean_is_exclusive(x_137)) {
 lean_ctor_release(x_137, 0);
 lean_ctor_release(x_137, 1);
 x_139 = x_137;
} else {
 lean_dec_ref(x_137);
 x_139 = lean_box(0);
}
x_140 = lean_box(x_1);
if (lean_is_scalar(x_139)) {
 x_141 = lean_alloc_ctor(0, 2, 0);
} else {
 x_141 = x_139;
}
lean_ctor_set(x_141, 0, x_140);
lean_ctor_set(x_141, 1, x_138);
return x_141;
}
}
}
else
{
lean_dec(x_119);
x_3 = x_118;
goto _start;
}
}
else
{
uint8_t x_143; lean_object* x_144; lean_object* x_145; 
lean_dec(x_117);
lean_dec(x_104);
x_143 = 1;
x_144 = lean_box(x_143);
if (lean_is_scalar(x_119)) {
 x_145 = lean_alloc_ctor(0, 2, 0);
} else {
 x_145 = x_119;
}
lean_ctor_set(x_145, 0, x_144);
lean_ctor_set(x_145, 1, x_118);
return x_145;
}
}
}
else
{
lean_object* x_146; lean_object* x_147; lean_object* x_148; lean_object* x_149; 
lean_dec(x_104);
x_146 = lean_ctor_get(x_109, 0);
lean_inc(x_146);
x_147 = lean_ctor_get(x_109, 1);
lean_inc(x_147);
if (lean_is_exclusive(x_109)) {
 lean_ctor_release(x_109, 0);
 lean_ctor_release(x_109, 1);
 x_148 = x_109;
} else {
 lean_dec_ref(x_109);
 x_148 = lean_box(0);
}
if (lean_is_scalar(x_148)) {
 x_149 = lean_alloc_ctor(1, 2, 0);
} else {
 x_149 = x_148;
}
lean_ctor_set(x_149, 0, x_146);
lean_ctor_set(x_149, 1, x_147);
return x_149;
}
}
}
else
{
uint8_t x_169; lean_object* x_170; lean_object* x_171; 
lean_dec(x_104);
x_169 = 1;
x_170 = lean_box(x_169);
x_171 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_171, 0, x_170);
lean_ctor_set(x_171, 1, x_105);
return x_171;
}
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; lean_object* x_5; 
x_4 = lean_unbox(x_1);
lean_dec(x_1);
x_5 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_4, x_2, x_3);
lean_dec(x_2);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux(uint8_t x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_3);
return x_4;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; lean_object* x_5; 
x_4 = lean_unbox(x_1);
lean_dec(x_1);
x_5 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux(x_4, x_2, x_3);
lean_dec(x_2);
return x_5;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string("postponed");
return x_1;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1;
x_3 = lean_name_mk_string(x_1, x_2);
return x_3;
}
}
lean_object* _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3; 
x_1 = l_Lean_SimpleMonadTracerAdapter_isTracingEnabledFor___rarg___lambda__1___closed__2;
x_2 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
x_3 = l_Lean_Name_append___main(x_1, x_2);
return x_3;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(uint8_t x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; uint8_t x_5; 
x_4 = l___private_Init_Lean_Meta_LevelDefEq_8__getNumPostponed___rarg(x_3);
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; uint8_t x_9; 
x_6 = lean_ctor_get(x_4, 0);
x_7 = lean_ctor_get(x_4, 1);
x_8 = lean_unsigned_to_nat(0u);
x_9 = lean_nat_dec_eq(x_6, x_8);
lean_dec(x_6);
if (x_9 == 0)
{
uint8_t x_10; lean_object* x_11; lean_object* x_186; uint8_t x_187; 
lean_free_object(x_4);
x_186 = lean_ctor_get(x_7, 4);
lean_inc(x_186);
x_187 = lean_ctor_get_uint8(x_186, sizeof(void*)*1);
lean_dec(x_186);
if (x_187 == 0)
{
uint8_t x_188; 
x_188 = 0;
x_10 = x_188;
x_11 = x_7;
goto block_185;
}
else
{
lean_object* x_189; lean_object* x_190; lean_object* x_191; lean_object* x_192; uint8_t x_193; 
x_189 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3;
x_190 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_189, x_2, x_7);
x_191 = lean_ctor_get(x_190, 0);
lean_inc(x_191);
x_192 = lean_ctor_get(x_190, 1);
lean_inc(x_192);
lean_dec(x_190);
x_193 = lean_unbox(x_191);
lean_dec(x_191);
x_10 = x_193;
x_11 = x_192;
goto block_185;
}
block_185:
{
if (x_10 == 0)
{
uint8_t x_12; 
x_12 = !lean_is_exclusive(x_11);
if (x_12 == 0)
{
lean_object* x_13; uint8_t x_14; 
x_13 = lean_ctor_get(x_11, 4);
x_14 = !lean_is_exclusive(x_13);
if (x_14 == 0)
{
uint8_t x_15; lean_object* x_16; 
x_15 = 1;
lean_ctor_set_uint8(x_13, sizeof(void*)*1, x_15);
x_16 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_11);
if (lean_obj_tag(x_16) == 0)
{
lean_object* x_17; lean_object* x_18; uint8_t x_19; 
x_17 = lean_ctor_get(x_16, 1);
lean_inc(x_17);
x_18 = lean_ctor_get(x_17, 4);
lean_inc(x_18);
x_19 = !lean_is_exclusive(x_16);
if (x_19 == 0)
{
lean_object* x_20; uint8_t x_21; 
x_20 = lean_ctor_get(x_16, 1);
lean_dec(x_20);
x_21 = !lean_is_exclusive(x_17);
if (x_21 == 0)
{
lean_object* x_22; uint8_t x_23; 
x_22 = lean_ctor_get(x_17, 4);
lean_dec(x_22);
x_23 = !lean_is_exclusive(x_18);
if (x_23 == 0)
{
uint8_t x_24; 
x_24 = 0;
lean_ctor_set_uint8(x_18, sizeof(void*)*1, x_24);
return x_16;
}
else
{
lean_object* x_25; uint8_t x_26; lean_object* x_27; 
x_25 = lean_ctor_get(x_18, 0);
lean_inc(x_25);
lean_dec(x_18);
x_26 = 0;
x_27 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_27, 0, x_25);
lean_ctor_set_uint8(x_27, sizeof(void*)*1, x_26);
lean_ctor_set(x_17, 4, x_27);
return x_16;
}
}
else
{
lean_object* x_28; lean_object* x_29; lean_object* x_30; lean_object* x_31; lean_object* x_32; lean_object* x_33; lean_object* x_34; uint8_t x_35; lean_object* x_36; lean_object* x_37; 
x_28 = lean_ctor_get(x_17, 0);
x_29 = lean_ctor_get(x_17, 1);
x_30 = lean_ctor_get(x_17, 2);
x_31 = lean_ctor_get(x_17, 3);
x_32 = lean_ctor_get(x_17, 5);
lean_inc(x_32);
lean_inc(x_31);
lean_inc(x_30);
lean_inc(x_29);
lean_inc(x_28);
lean_dec(x_17);
x_33 = lean_ctor_get(x_18, 0);
lean_inc(x_33);
if (lean_is_exclusive(x_18)) {
 lean_ctor_release(x_18, 0);
 x_34 = x_18;
} else {
 lean_dec_ref(x_18);
 x_34 = lean_box(0);
}
x_35 = 0;
if (lean_is_scalar(x_34)) {
 x_36 = lean_alloc_ctor(0, 1, 1);
} else {
 x_36 = x_34;
}
lean_ctor_set(x_36, 0, x_33);
lean_ctor_set_uint8(x_36, sizeof(void*)*1, x_35);
x_37 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_37, 0, x_28);
lean_ctor_set(x_37, 1, x_29);
lean_ctor_set(x_37, 2, x_30);
lean_ctor_set(x_37, 3, x_31);
lean_ctor_set(x_37, 4, x_36);
lean_ctor_set(x_37, 5, x_32);
lean_ctor_set(x_16, 1, x_37);
return x_16;
}
}
else
{
lean_object* x_38; lean_object* x_39; lean_object* x_40; lean_object* x_41; lean_object* x_42; lean_object* x_43; lean_object* x_44; lean_object* x_45; lean_object* x_46; uint8_t x_47; lean_object* x_48; lean_object* x_49; lean_object* x_50; 
x_38 = lean_ctor_get(x_16, 0);
lean_inc(x_38);
lean_dec(x_16);
x_39 = lean_ctor_get(x_17, 0);
lean_inc(x_39);
x_40 = lean_ctor_get(x_17, 1);
lean_inc(x_40);
x_41 = lean_ctor_get(x_17, 2);
lean_inc(x_41);
x_42 = lean_ctor_get(x_17, 3);
lean_inc(x_42);
x_43 = lean_ctor_get(x_17, 5);
lean_inc(x_43);
if (lean_is_exclusive(x_17)) {
 lean_ctor_release(x_17, 0);
 lean_ctor_release(x_17, 1);
 lean_ctor_release(x_17, 2);
 lean_ctor_release(x_17, 3);
 lean_ctor_release(x_17, 4);
 lean_ctor_release(x_17, 5);
 x_44 = x_17;
} else {
 lean_dec_ref(x_17);
 x_44 = lean_box(0);
}
x_45 = lean_ctor_get(x_18, 0);
lean_inc(x_45);
if (lean_is_exclusive(x_18)) {
 lean_ctor_release(x_18, 0);
 x_46 = x_18;
} else {
 lean_dec_ref(x_18);
 x_46 = lean_box(0);
}
x_47 = 0;
if (lean_is_scalar(x_46)) {
 x_48 = lean_alloc_ctor(0, 1, 1);
} else {
 x_48 = x_46;
}
lean_ctor_set(x_48, 0, x_45);
lean_ctor_set_uint8(x_48, sizeof(void*)*1, x_47);
if (lean_is_scalar(x_44)) {
 x_49 = lean_alloc_ctor(0, 6, 0);
} else {
 x_49 = x_44;
}
lean_ctor_set(x_49, 0, x_39);
lean_ctor_set(x_49, 1, x_40);
lean_ctor_set(x_49, 2, x_41);
lean_ctor_set(x_49, 3, x_42);
lean_ctor_set(x_49, 4, x_48);
lean_ctor_set(x_49, 5, x_43);
x_50 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_50, 0, x_38);
lean_ctor_set(x_50, 1, x_49);
return x_50;
}
}
else
{
lean_object* x_51; lean_object* x_52; uint8_t x_53; 
x_51 = lean_ctor_get(x_16, 1);
lean_inc(x_51);
x_52 = lean_ctor_get(x_51, 4);
lean_inc(x_52);
x_53 = !lean_is_exclusive(x_16);
if (x_53 == 0)
{
lean_object* x_54; uint8_t x_55; 
x_54 = lean_ctor_get(x_16, 1);
lean_dec(x_54);
x_55 = !lean_is_exclusive(x_51);
if (x_55 == 0)
{
lean_object* x_56; uint8_t x_57; 
x_56 = lean_ctor_get(x_51, 4);
lean_dec(x_56);
x_57 = !lean_is_exclusive(x_52);
if (x_57 == 0)
{
uint8_t x_58; 
x_58 = 0;
lean_ctor_set_uint8(x_52, sizeof(void*)*1, x_58);
return x_16;
}
else
{
lean_object* x_59; uint8_t x_60; lean_object* x_61; 
x_59 = lean_ctor_get(x_52, 0);
lean_inc(x_59);
lean_dec(x_52);
x_60 = 0;
x_61 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_61, 0, x_59);
lean_ctor_set_uint8(x_61, sizeof(void*)*1, x_60);
lean_ctor_set(x_51, 4, x_61);
return x_16;
}
}
else
{
lean_object* x_62; lean_object* x_63; lean_object* x_64; lean_object* x_65; lean_object* x_66; lean_object* x_67; lean_object* x_68; uint8_t x_69; lean_object* x_70; lean_object* x_71; 
x_62 = lean_ctor_get(x_51, 0);
x_63 = lean_ctor_get(x_51, 1);
x_64 = lean_ctor_get(x_51, 2);
x_65 = lean_ctor_get(x_51, 3);
x_66 = lean_ctor_get(x_51, 5);
lean_inc(x_66);
lean_inc(x_65);
lean_inc(x_64);
lean_inc(x_63);
lean_inc(x_62);
lean_dec(x_51);
x_67 = lean_ctor_get(x_52, 0);
lean_inc(x_67);
if (lean_is_exclusive(x_52)) {
 lean_ctor_release(x_52, 0);
 x_68 = x_52;
} else {
 lean_dec_ref(x_52);
 x_68 = lean_box(0);
}
x_69 = 0;
if (lean_is_scalar(x_68)) {
 x_70 = lean_alloc_ctor(0, 1, 1);
} else {
 x_70 = x_68;
}
lean_ctor_set(x_70, 0, x_67);
lean_ctor_set_uint8(x_70, sizeof(void*)*1, x_69);
x_71 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_71, 0, x_62);
lean_ctor_set(x_71, 1, x_63);
lean_ctor_set(x_71, 2, x_64);
lean_ctor_set(x_71, 3, x_65);
lean_ctor_set(x_71, 4, x_70);
lean_ctor_set(x_71, 5, x_66);
lean_ctor_set(x_16, 1, x_71);
return x_16;
}
}
else
{
lean_object* x_72; lean_object* x_73; lean_object* x_74; lean_object* x_75; lean_object* x_76; lean_object* x_77; lean_object* x_78; lean_object* x_79; lean_object* x_80; uint8_t x_81; lean_object* x_82; lean_object* x_83; lean_object* x_84; 
x_72 = lean_ctor_get(x_16, 0);
lean_inc(x_72);
lean_dec(x_16);
x_73 = lean_ctor_get(x_51, 0);
lean_inc(x_73);
x_74 = lean_ctor_get(x_51, 1);
lean_inc(x_74);
x_75 = lean_ctor_get(x_51, 2);
lean_inc(x_75);
x_76 = lean_ctor_get(x_51, 3);
lean_inc(x_76);
x_77 = lean_ctor_get(x_51, 5);
lean_inc(x_77);
if (lean_is_exclusive(x_51)) {
 lean_ctor_release(x_51, 0);
 lean_ctor_release(x_51, 1);
 lean_ctor_release(x_51, 2);
 lean_ctor_release(x_51, 3);
 lean_ctor_release(x_51, 4);
 lean_ctor_release(x_51, 5);
 x_78 = x_51;
} else {
 lean_dec_ref(x_51);
 x_78 = lean_box(0);
}
x_79 = lean_ctor_get(x_52, 0);
lean_inc(x_79);
if (lean_is_exclusive(x_52)) {
 lean_ctor_release(x_52, 0);
 x_80 = x_52;
} else {
 lean_dec_ref(x_52);
 x_80 = lean_box(0);
}
x_81 = 0;
if (lean_is_scalar(x_80)) {
 x_82 = lean_alloc_ctor(0, 1, 1);
} else {
 x_82 = x_80;
}
lean_ctor_set(x_82, 0, x_79);
lean_ctor_set_uint8(x_82, sizeof(void*)*1, x_81);
if (lean_is_scalar(x_78)) {
 x_83 = lean_alloc_ctor(0, 6, 0);
} else {
 x_83 = x_78;
}
lean_ctor_set(x_83, 0, x_73);
lean_ctor_set(x_83, 1, x_74);
lean_ctor_set(x_83, 2, x_75);
lean_ctor_set(x_83, 3, x_76);
lean_ctor_set(x_83, 4, x_82);
lean_ctor_set(x_83, 5, x_77);
x_84 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_84, 0, x_72);
lean_ctor_set(x_84, 1, x_83);
return x_84;
}
}
}
else
{
lean_object* x_85; uint8_t x_86; lean_object* x_87; lean_object* x_88; 
x_85 = lean_ctor_get(x_13, 0);
lean_inc(x_85);
lean_dec(x_13);
x_86 = 1;
x_87 = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(x_87, 0, x_85);
lean_ctor_set_uint8(x_87, sizeof(void*)*1, x_86);
lean_ctor_set(x_11, 4, x_87);
x_88 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_11);
if (lean_obj_tag(x_88) == 0)
{
lean_object* x_89; lean_object* x_90; lean_object* x_91; lean_object* x_92; lean_object* x_93; lean_object* x_94; lean_object* x_95; lean_object* x_96; lean_object* x_97; lean_object* x_98; lean_object* x_99; lean_object* x_100; uint8_t x_101; lean_object* x_102; lean_object* x_103; lean_object* x_104; 
x_89 = lean_ctor_get(x_88, 1);
lean_inc(x_89);
x_90 = lean_ctor_get(x_89, 4);
lean_inc(x_90);
x_91 = lean_ctor_get(x_88, 0);
lean_inc(x_91);
if (lean_is_exclusive(x_88)) {
 lean_ctor_release(x_88, 0);
 lean_ctor_release(x_88, 1);
 x_92 = x_88;
} else {
 lean_dec_ref(x_88);
 x_92 = lean_box(0);
}
x_93 = lean_ctor_get(x_89, 0);
lean_inc(x_93);
x_94 = lean_ctor_get(x_89, 1);
lean_inc(x_94);
x_95 = lean_ctor_get(x_89, 2);
lean_inc(x_95);
x_96 = lean_ctor_get(x_89, 3);
lean_inc(x_96);
x_97 = lean_ctor_get(x_89, 5);
lean_inc(x_97);
if (lean_is_exclusive(x_89)) {
 lean_ctor_release(x_89, 0);
 lean_ctor_release(x_89, 1);
 lean_ctor_release(x_89, 2);
 lean_ctor_release(x_89, 3);
 lean_ctor_release(x_89, 4);
 lean_ctor_release(x_89, 5);
 x_98 = x_89;
} else {
 lean_dec_ref(x_89);
 x_98 = lean_box(0);
}
x_99 = lean_ctor_get(x_90, 0);
lean_inc(x_99);
if (lean_is_exclusive(x_90)) {
 lean_ctor_release(x_90, 0);
 x_100 = x_90;
} else {
 lean_dec_ref(x_90);
 x_100 = lean_box(0);
}
x_101 = 0;
if (lean_is_scalar(x_100)) {
 x_102 = lean_alloc_ctor(0, 1, 1);
} else {
 x_102 = x_100;
}
lean_ctor_set(x_102, 0, x_99);
lean_ctor_set_uint8(x_102, sizeof(void*)*1, x_101);
if (lean_is_scalar(x_98)) {
 x_103 = lean_alloc_ctor(0, 6, 0);
} else {
 x_103 = x_98;
}
lean_ctor_set(x_103, 0, x_93);
lean_ctor_set(x_103, 1, x_94);
lean_ctor_set(x_103, 2, x_95);
lean_ctor_set(x_103, 3, x_96);
lean_ctor_set(x_103, 4, x_102);
lean_ctor_set(x_103, 5, x_97);
if (lean_is_scalar(x_92)) {
 x_104 = lean_alloc_ctor(0, 2, 0);
} else {
 x_104 = x_92;
}
lean_ctor_set(x_104, 0, x_91);
lean_ctor_set(x_104, 1, x_103);
return x_104;
}
else
{
lean_object* x_105; lean_object* x_106; lean_object* x_107; lean_object* x_108; lean_object* x_109; lean_object* x_110; lean_object* x_111; lean_object* x_112; lean_object* x_113; lean_object* x_114; lean_object* x_115; lean_object* x_116; uint8_t x_117; lean_object* x_118; lean_object* x_119; lean_object* x_120; 
x_105 = lean_ctor_get(x_88, 1);
lean_inc(x_105);
x_106 = lean_ctor_get(x_105, 4);
lean_inc(x_106);
x_107 = lean_ctor_get(x_88, 0);
lean_inc(x_107);
if (lean_is_exclusive(x_88)) {
 lean_ctor_release(x_88, 0);
 lean_ctor_release(x_88, 1);
 x_108 = x_88;
} else {
 lean_dec_ref(x_88);
 x_108 = lean_box(0);
}
x_109 = lean_ctor_get(x_105, 0);
lean_inc(x_109);
x_110 = lean_ctor_get(x_105, 1);
lean_inc(x_110);
x_111 = lean_ctor_get(x_105, 2);
lean_inc(x_111);
x_112 = lean_ctor_get(x_105, 3);
lean_inc(x_112);
x_113 = lean_ctor_get(x_105, 5);
lean_inc(x_113);
if (lean_is_exclusive(x_105)) {
 lean_ctor_release(x_105, 0);
 lean_ctor_release(x_105, 1);
 lean_ctor_release(x_105, 2);
 lean_ctor_release(x_105, 3);
 lean_ctor_release(x_105, 4);
 lean_ctor_release(x_105, 5);
 x_114 = x_105;
} else {
 lean_dec_ref(x_105);
 x_114 = lean_box(0);
}
x_115 = lean_ctor_get(x_106, 0);
lean_inc(x_115);
if (lean_is_exclusive(x_106)) {
 lean_ctor_release(x_106, 0);
 x_116 = x_106;
} else {
 lean_dec_ref(x_106);
 x_116 = lean_box(0);
}
x_117 = 0;
if (lean_is_scalar(x_116)) {
 x_118 = lean_alloc_ctor(0, 1, 1);
} else {
 x_118 = x_116;
}
lean_ctor_set(x_118, 0, x_115);
lean_ctor_set_uint8(x_118, sizeof(void*)*1, x_117);
if (lean_is_scalar(x_114)) {
 x_119 = lean_alloc_ctor(0, 6, 0);
} else {
 x_119 = x_114;
}
lean_ctor_set(x_119, 0, x_109);
lean_ctor_set(x_119, 1, x_110);
lean_ctor_set(x_119, 2, x_111);
lean_ctor_set(x_119, 3, x_112);
lean_ctor_set(x_119, 4, x_118);
lean_ctor_set(x_119, 5, x_113);
if (lean_is_scalar(x_108)) {
 x_120 = lean_alloc_ctor(1, 2, 0);
} else {
 x_120 = x_108;
}
lean_ctor_set(x_120, 0, x_107);
lean_ctor_set(x_120, 1, x_119);
return x_120;
}
}
}
else
{
lean_object* x_121; lean_object* x_122; lean_object* x_123; lean_object* x_124; lean_object* x_125; lean_object* x_126; lean_object* x_127; lean_object* x_128; uint8_t x_129; lean_object* x_130; lean_object* x_131; lean_object* x_132; 
x_121 = lean_ctor_get(x_11, 4);
x_122 = lean_ctor_get(x_11, 0);
x_123 = lean_ctor_get(x_11, 1);
x_124 = lean_ctor_get(x_11, 2);
x_125 = lean_ctor_get(x_11, 3);
x_126 = lean_ctor_get(x_11, 5);
lean_inc(x_126);
lean_inc(x_121);
lean_inc(x_125);
lean_inc(x_124);
lean_inc(x_123);
lean_inc(x_122);
lean_dec(x_11);
x_127 = lean_ctor_get(x_121, 0);
lean_inc(x_127);
if (lean_is_exclusive(x_121)) {
 lean_ctor_release(x_121, 0);
 x_128 = x_121;
} else {
 lean_dec_ref(x_121);
 x_128 = lean_box(0);
}
x_129 = 1;
if (lean_is_scalar(x_128)) {
 x_130 = lean_alloc_ctor(0, 1, 1);
} else {
 x_130 = x_128;
}
lean_ctor_set(x_130, 0, x_127);
lean_ctor_set_uint8(x_130, sizeof(void*)*1, x_129);
x_131 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_131, 0, x_122);
lean_ctor_set(x_131, 1, x_123);
lean_ctor_set(x_131, 2, x_124);
lean_ctor_set(x_131, 3, x_125);
lean_ctor_set(x_131, 4, x_130);
lean_ctor_set(x_131, 5, x_126);
x_132 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_131);
if (lean_obj_tag(x_132) == 0)
{
lean_object* x_133; lean_object* x_134; lean_object* x_135; lean_object* x_136; lean_object* x_137; lean_object* x_138; lean_object* x_139; lean_object* x_140; lean_object* x_141; lean_object* x_142; lean_object* x_143; lean_object* x_144; uint8_t x_145; lean_object* x_146; lean_object* x_147; lean_object* x_148; 
x_133 = lean_ctor_get(x_132, 1);
lean_inc(x_133);
x_134 = lean_ctor_get(x_133, 4);
lean_inc(x_134);
x_135 = lean_ctor_get(x_132, 0);
lean_inc(x_135);
if (lean_is_exclusive(x_132)) {
 lean_ctor_release(x_132, 0);
 lean_ctor_release(x_132, 1);
 x_136 = x_132;
} else {
 lean_dec_ref(x_132);
 x_136 = lean_box(0);
}
x_137 = lean_ctor_get(x_133, 0);
lean_inc(x_137);
x_138 = lean_ctor_get(x_133, 1);
lean_inc(x_138);
x_139 = lean_ctor_get(x_133, 2);
lean_inc(x_139);
x_140 = lean_ctor_get(x_133, 3);
lean_inc(x_140);
x_141 = lean_ctor_get(x_133, 5);
lean_inc(x_141);
if (lean_is_exclusive(x_133)) {
 lean_ctor_release(x_133, 0);
 lean_ctor_release(x_133, 1);
 lean_ctor_release(x_133, 2);
 lean_ctor_release(x_133, 3);
 lean_ctor_release(x_133, 4);
 lean_ctor_release(x_133, 5);
 x_142 = x_133;
} else {
 lean_dec_ref(x_133);
 x_142 = lean_box(0);
}
x_143 = lean_ctor_get(x_134, 0);
lean_inc(x_143);
if (lean_is_exclusive(x_134)) {
 lean_ctor_release(x_134, 0);
 x_144 = x_134;
} else {
 lean_dec_ref(x_134);
 x_144 = lean_box(0);
}
x_145 = 0;
if (lean_is_scalar(x_144)) {
 x_146 = lean_alloc_ctor(0, 1, 1);
} else {
 x_146 = x_144;
}
lean_ctor_set(x_146, 0, x_143);
lean_ctor_set_uint8(x_146, sizeof(void*)*1, x_145);
if (lean_is_scalar(x_142)) {
 x_147 = lean_alloc_ctor(0, 6, 0);
} else {
 x_147 = x_142;
}
lean_ctor_set(x_147, 0, x_137);
lean_ctor_set(x_147, 1, x_138);
lean_ctor_set(x_147, 2, x_139);
lean_ctor_set(x_147, 3, x_140);
lean_ctor_set(x_147, 4, x_146);
lean_ctor_set(x_147, 5, x_141);
if (lean_is_scalar(x_136)) {
 x_148 = lean_alloc_ctor(0, 2, 0);
} else {
 x_148 = x_136;
}
lean_ctor_set(x_148, 0, x_135);
lean_ctor_set(x_148, 1, x_147);
return x_148;
}
else
{
lean_object* x_149; lean_object* x_150; lean_object* x_151; lean_object* x_152; lean_object* x_153; lean_object* x_154; lean_object* x_155; lean_object* x_156; lean_object* x_157; lean_object* x_158; lean_object* x_159; lean_object* x_160; uint8_t x_161; lean_object* x_162; lean_object* x_163; lean_object* x_164; 
x_149 = lean_ctor_get(x_132, 1);
lean_inc(x_149);
x_150 = lean_ctor_get(x_149, 4);
lean_inc(x_150);
x_151 = lean_ctor_get(x_132, 0);
lean_inc(x_151);
if (lean_is_exclusive(x_132)) {
 lean_ctor_release(x_132, 0);
 lean_ctor_release(x_132, 1);
 x_152 = x_132;
} else {
 lean_dec_ref(x_132);
 x_152 = lean_box(0);
}
x_153 = lean_ctor_get(x_149, 0);
lean_inc(x_153);
x_154 = lean_ctor_get(x_149, 1);
lean_inc(x_154);
x_155 = lean_ctor_get(x_149, 2);
lean_inc(x_155);
x_156 = lean_ctor_get(x_149, 3);
lean_inc(x_156);
x_157 = lean_ctor_get(x_149, 5);
lean_inc(x_157);
if (lean_is_exclusive(x_149)) {
 lean_ctor_release(x_149, 0);
 lean_ctor_release(x_149, 1);
 lean_ctor_release(x_149, 2);
 lean_ctor_release(x_149, 3);
 lean_ctor_release(x_149, 4);
 lean_ctor_release(x_149, 5);
 x_158 = x_149;
} else {
 lean_dec_ref(x_149);
 x_158 = lean_box(0);
}
x_159 = lean_ctor_get(x_150, 0);
lean_inc(x_159);
if (lean_is_exclusive(x_150)) {
 lean_ctor_release(x_150, 0);
 x_160 = x_150;
} else {
 lean_dec_ref(x_150);
 x_160 = lean_box(0);
}
x_161 = 0;
if (lean_is_scalar(x_160)) {
 x_162 = lean_alloc_ctor(0, 1, 1);
} else {
 x_162 = x_160;
}
lean_ctor_set(x_162, 0, x_159);
lean_ctor_set_uint8(x_162, sizeof(void*)*1, x_161);
if (lean_is_scalar(x_158)) {
 x_163 = lean_alloc_ctor(0, 6, 0);
} else {
 x_163 = x_158;
}
lean_ctor_set(x_163, 0, x_153);
lean_ctor_set(x_163, 1, x_154);
lean_ctor_set(x_163, 2, x_155);
lean_ctor_set(x_163, 3, x_156);
lean_ctor_set(x_163, 4, x_162);
lean_ctor_set(x_163, 5, x_157);
if (lean_is_scalar(x_152)) {
 x_164 = lean_alloc_ctor(1, 2, 0);
} else {
 x_164 = x_152;
}
lean_ctor_set(x_164, 0, x_151);
lean_ctor_set(x_164, 1, x_163);
return x_164;
}
}
}
else
{
lean_object* x_165; lean_object* x_166; lean_object* x_167; lean_object* x_168; 
x_165 = l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg(x_11);
x_166 = lean_ctor_get(x_165, 0);
lean_inc(x_166);
x_167 = lean_ctor_get(x_165, 1);
lean_inc(x_167);
lean_dec(x_165);
x_168 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_167);
if (lean_obj_tag(x_168) == 0)
{
lean_object* x_169; lean_object* x_170; lean_object* x_171; lean_object* x_172; uint8_t x_173; 
x_169 = lean_ctor_get(x_168, 0);
lean_inc(x_169);
x_170 = lean_ctor_get(x_168, 1);
lean_inc(x_170);
lean_dec(x_168);
x_171 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
x_172 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_166, x_171, x_2, x_170);
x_173 = !lean_is_exclusive(x_172);
if (x_173 == 0)
{
lean_object* x_174; 
x_174 = lean_ctor_get(x_172, 0);
lean_dec(x_174);
lean_ctor_set(x_172, 0, x_169);
return x_172;
}
else
{
lean_object* x_175; lean_object* x_176; 
x_175 = lean_ctor_get(x_172, 1);
lean_inc(x_175);
lean_dec(x_172);
x_176 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_176, 0, x_169);
lean_ctor_set(x_176, 1, x_175);
return x_176;
}
}
else
{
lean_object* x_177; lean_object* x_178; lean_object* x_179; lean_object* x_180; uint8_t x_181; 
x_177 = lean_ctor_get(x_168, 0);
lean_inc(x_177);
x_178 = lean_ctor_get(x_168, 1);
lean_inc(x_178);
lean_dec(x_168);
x_179 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
x_180 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_166, x_179, x_2, x_178);
x_181 = !lean_is_exclusive(x_180);
if (x_181 == 0)
{
lean_object* x_182; 
x_182 = lean_ctor_get(x_180, 0);
lean_dec(x_182);
lean_ctor_set_tag(x_180, 1);
lean_ctor_set(x_180, 0, x_177);
return x_180;
}
else
{
lean_object* x_183; lean_object* x_184; 
x_183 = lean_ctor_get(x_180, 1);
lean_inc(x_183);
lean_dec(x_180);
x_184 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_184, 0, x_177);
lean_ctor_set(x_184, 1, x_183);
return x_184;
}
}
}
}
}
else
{
uint8_t x_194; lean_object* x_195; 
x_194 = 1;
x_195 = lean_box(x_194);
lean_ctor_set(x_4, 0, x_195);
return x_4;
}
}
else
{
lean_object* x_196; lean_object* x_197; lean_object* x_198; uint8_t x_199; 
x_196 = lean_ctor_get(x_4, 0);
x_197 = lean_ctor_get(x_4, 1);
lean_inc(x_197);
lean_inc(x_196);
lean_dec(x_4);
x_198 = lean_unsigned_to_nat(0u);
x_199 = lean_nat_dec_eq(x_196, x_198);
lean_dec(x_196);
if (x_199 == 0)
{
uint8_t x_200; lean_object* x_201; lean_object* x_266; uint8_t x_267; 
x_266 = lean_ctor_get(x_197, 4);
lean_inc(x_266);
x_267 = lean_ctor_get_uint8(x_266, sizeof(void*)*1);
lean_dec(x_266);
if (x_267 == 0)
{
uint8_t x_268; 
x_268 = 0;
x_200 = x_268;
x_201 = x_197;
goto block_265;
}
else
{
lean_object* x_269; lean_object* x_270; lean_object* x_271; lean_object* x_272; uint8_t x_273; 
x_269 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3;
x_270 = l___private_Init_Lean_Trace_5__checkTraceOption___at___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___spec__1(x_269, x_2, x_197);
x_271 = lean_ctor_get(x_270, 0);
lean_inc(x_271);
x_272 = lean_ctor_get(x_270, 1);
lean_inc(x_272);
lean_dec(x_270);
x_273 = lean_unbox(x_271);
lean_dec(x_271);
x_200 = x_273;
x_201 = x_272;
goto block_265;
}
block_265:
{
if (x_200 == 0)
{
lean_object* x_202; lean_object* x_203; lean_object* x_204; lean_object* x_205; lean_object* x_206; lean_object* x_207; lean_object* x_208; lean_object* x_209; lean_object* x_210; uint8_t x_211; lean_object* x_212; lean_object* x_213; lean_object* x_214; 
x_202 = lean_ctor_get(x_201, 4);
lean_inc(x_202);
x_203 = lean_ctor_get(x_201, 0);
lean_inc(x_203);
x_204 = lean_ctor_get(x_201, 1);
lean_inc(x_204);
x_205 = lean_ctor_get(x_201, 2);
lean_inc(x_205);
x_206 = lean_ctor_get(x_201, 3);
lean_inc(x_206);
x_207 = lean_ctor_get(x_201, 5);
lean_inc(x_207);
if (lean_is_exclusive(x_201)) {
 lean_ctor_release(x_201, 0);
 lean_ctor_release(x_201, 1);
 lean_ctor_release(x_201, 2);
 lean_ctor_release(x_201, 3);
 lean_ctor_release(x_201, 4);
 lean_ctor_release(x_201, 5);
 x_208 = x_201;
} else {
 lean_dec_ref(x_201);
 x_208 = lean_box(0);
}
x_209 = lean_ctor_get(x_202, 0);
lean_inc(x_209);
if (lean_is_exclusive(x_202)) {
 lean_ctor_release(x_202, 0);
 x_210 = x_202;
} else {
 lean_dec_ref(x_202);
 x_210 = lean_box(0);
}
x_211 = 1;
if (lean_is_scalar(x_210)) {
 x_212 = lean_alloc_ctor(0, 1, 1);
} else {
 x_212 = x_210;
}
lean_ctor_set(x_212, 0, x_209);
lean_ctor_set_uint8(x_212, sizeof(void*)*1, x_211);
if (lean_is_scalar(x_208)) {
 x_213 = lean_alloc_ctor(0, 6, 0);
} else {
 x_213 = x_208;
}
lean_ctor_set(x_213, 0, x_203);
lean_ctor_set(x_213, 1, x_204);
lean_ctor_set(x_213, 2, x_205);
lean_ctor_set(x_213, 3, x_206);
lean_ctor_set(x_213, 4, x_212);
lean_ctor_set(x_213, 5, x_207);
x_214 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_213);
if (lean_obj_tag(x_214) == 0)
{
lean_object* x_215; lean_object* x_216; lean_object* x_217; lean_object* x_218; lean_object* x_219; lean_object* x_220; lean_object* x_221; lean_object* x_222; lean_object* x_223; lean_object* x_224; lean_object* x_225; lean_object* x_226; uint8_t x_227; lean_object* x_228; lean_object* x_229; lean_object* x_230; 
x_215 = lean_ctor_get(x_214, 1);
lean_inc(x_215);
x_216 = lean_ctor_get(x_215, 4);
lean_inc(x_216);
x_217 = lean_ctor_get(x_214, 0);
lean_inc(x_217);
if (lean_is_exclusive(x_214)) {
 lean_ctor_release(x_214, 0);
 lean_ctor_release(x_214, 1);
 x_218 = x_214;
} else {
 lean_dec_ref(x_214);
 x_218 = lean_box(0);
}
x_219 = lean_ctor_get(x_215, 0);
lean_inc(x_219);
x_220 = lean_ctor_get(x_215, 1);
lean_inc(x_220);
x_221 = lean_ctor_get(x_215, 2);
lean_inc(x_221);
x_222 = lean_ctor_get(x_215, 3);
lean_inc(x_222);
x_223 = lean_ctor_get(x_215, 5);
lean_inc(x_223);
if (lean_is_exclusive(x_215)) {
 lean_ctor_release(x_215, 0);
 lean_ctor_release(x_215, 1);
 lean_ctor_release(x_215, 2);
 lean_ctor_release(x_215, 3);
 lean_ctor_release(x_215, 4);
 lean_ctor_release(x_215, 5);
 x_224 = x_215;
} else {
 lean_dec_ref(x_215);
 x_224 = lean_box(0);
}
x_225 = lean_ctor_get(x_216, 0);
lean_inc(x_225);
if (lean_is_exclusive(x_216)) {
 lean_ctor_release(x_216, 0);
 x_226 = x_216;
} else {
 lean_dec_ref(x_216);
 x_226 = lean_box(0);
}
x_227 = 0;
if (lean_is_scalar(x_226)) {
 x_228 = lean_alloc_ctor(0, 1, 1);
} else {
 x_228 = x_226;
}
lean_ctor_set(x_228, 0, x_225);
lean_ctor_set_uint8(x_228, sizeof(void*)*1, x_227);
if (lean_is_scalar(x_224)) {
 x_229 = lean_alloc_ctor(0, 6, 0);
} else {
 x_229 = x_224;
}
lean_ctor_set(x_229, 0, x_219);
lean_ctor_set(x_229, 1, x_220);
lean_ctor_set(x_229, 2, x_221);
lean_ctor_set(x_229, 3, x_222);
lean_ctor_set(x_229, 4, x_228);
lean_ctor_set(x_229, 5, x_223);
if (lean_is_scalar(x_218)) {
 x_230 = lean_alloc_ctor(0, 2, 0);
} else {
 x_230 = x_218;
}
lean_ctor_set(x_230, 0, x_217);
lean_ctor_set(x_230, 1, x_229);
return x_230;
}
else
{
lean_object* x_231; lean_object* x_232; lean_object* x_233; lean_object* x_234; lean_object* x_235; lean_object* x_236; lean_object* x_237; lean_object* x_238; lean_object* x_239; lean_object* x_240; lean_object* x_241; lean_object* x_242; uint8_t x_243; lean_object* x_244; lean_object* x_245; lean_object* x_246; 
x_231 = lean_ctor_get(x_214, 1);
lean_inc(x_231);
x_232 = lean_ctor_get(x_231, 4);
lean_inc(x_232);
x_233 = lean_ctor_get(x_214, 0);
lean_inc(x_233);
if (lean_is_exclusive(x_214)) {
 lean_ctor_release(x_214, 0);
 lean_ctor_release(x_214, 1);
 x_234 = x_214;
} else {
 lean_dec_ref(x_214);
 x_234 = lean_box(0);
}
x_235 = lean_ctor_get(x_231, 0);
lean_inc(x_235);
x_236 = lean_ctor_get(x_231, 1);
lean_inc(x_236);
x_237 = lean_ctor_get(x_231, 2);
lean_inc(x_237);
x_238 = lean_ctor_get(x_231, 3);
lean_inc(x_238);
x_239 = lean_ctor_get(x_231, 5);
lean_inc(x_239);
if (lean_is_exclusive(x_231)) {
 lean_ctor_release(x_231, 0);
 lean_ctor_release(x_231, 1);
 lean_ctor_release(x_231, 2);
 lean_ctor_release(x_231, 3);
 lean_ctor_release(x_231, 4);
 lean_ctor_release(x_231, 5);
 x_240 = x_231;
} else {
 lean_dec_ref(x_231);
 x_240 = lean_box(0);
}
x_241 = lean_ctor_get(x_232, 0);
lean_inc(x_241);
if (lean_is_exclusive(x_232)) {
 lean_ctor_release(x_232, 0);
 x_242 = x_232;
} else {
 lean_dec_ref(x_232);
 x_242 = lean_box(0);
}
x_243 = 0;
if (lean_is_scalar(x_242)) {
 x_244 = lean_alloc_ctor(0, 1, 1);
} else {
 x_244 = x_242;
}
lean_ctor_set(x_244, 0, x_241);
lean_ctor_set_uint8(x_244, sizeof(void*)*1, x_243);
if (lean_is_scalar(x_240)) {
 x_245 = lean_alloc_ctor(0, 6, 0);
} else {
 x_245 = x_240;
}
lean_ctor_set(x_245, 0, x_235);
lean_ctor_set(x_245, 1, x_236);
lean_ctor_set(x_245, 2, x_237);
lean_ctor_set(x_245, 3, x_238);
lean_ctor_set(x_245, 4, x_244);
lean_ctor_set(x_245, 5, x_239);
if (lean_is_scalar(x_234)) {
 x_246 = lean_alloc_ctor(1, 2, 0);
} else {
 x_246 = x_234;
}
lean_ctor_set(x_246, 0, x_233);
lean_ctor_set(x_246, 1, x_245);
return x_246;
}
}
else
{
lean_object* x_247; lean_object* x_248; lean_object* x_249; lean_object* x_250; 
x_247 = l___private_Init_Lean_Trace_2__getResetTraces___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__6___rarg(x_201);
x_248 = lean_ctor_get(x_247, 0);
lean_inc(x_248);
x_249 = lean_ctor_get(x_247, 1);
lean_inc(x_249);
lean_dec(x_247);
x_250 = l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main(x_1, x_2, x_249);
if (lean_obj_tag(x_250) == 0)
{
lean_object* x_251; lean_object* x_252; lean_object* x_253; lean_object* x_254; lean_object* x_255; lean_object* x_256; lean_object* x_257; 
x_251 = lean_ctor_get(x_250, 0);
lean_inc(x_251);
x_252 = lean_ctor_get(x_250, 1);
lean_inc(x_252);
lean_dec(x_250);
x_253 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
x_254 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_248, x_253, x_2, x_252);
x_255 = lean_ctor_get(x_254, 1);
lean_inc(x_255);
if (lean_is_exclusive(x_254)) {
 lean_ctor_release(x_254, 0);
 lean_ctor_release(x_254, 1);
 x_256 = x_254;
} else {
 lean_dec_ref(x_254);
 x_256 = lean_box(0);
}
if (lean_is_scalar(x_256)) {
 x_257 = lean_alloc_ctor(0, 2, 0);
} else {
 x_257 = x_256;
}
lean_ctor_set(x_257, 0, x_251);
lean_ctor_set(x_257, 1, x_255);
return x_257;
}
else
{
lean_object* x_258; lean_object* x_259; lean_object* x_260; lean_object* x_261; lean_object* x_262; lean_object* x_263; lean_object* x_264; 
x_258 = lean_ctor_get(x_250, 0);
lean_inc(x_258);
x_259 = lean_ctor_get(x_250, 1);
lean_inc(x_259);
lean_dec(x_250);
x_260 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2;
x_261 = l___private_Init_Lean_Trace_1__addNode___at___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___spec__7(x_248, x_260, x_2, x_259);
x_262 = lean_ctor_get(x_261, 1);
lean_inc(x_262);
if (lean_is_exclusive(x_261)) {
 lean_ctor_release(x_261, 0);
 lean_ctor_release(x_261, 1);
 x_263 = x_261;
} else {
 lean_dec_ref(x_261);
 x_263 = lean_box(0);
}
if (lean_is_scalar(x_263)) {
 x_264 = lean_alloc_ctor(1, 2, 0);
} else {
 x_264 = x_263;
 lean_ctor_set_tag(x_264, 1);
}
lean_ctor_set(x_264, 0, x_258);
lean_ctor_set(x_264, 1, x_262);
return x_264;
}
}
}
}
else
{
uint8_t x_274; lean_object* x_275; lean_object* x_276; 
x_274 = 1;
x_275 = lean_box(x_274);
x_276 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_276, 0, x_275);
lean_ctor_set(x_276, 1, x_197);
return x_276;
}
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; lean_object* x_5; 
x_4 = lean_unbox(x_1);
lean_dec(x_1);
x_5 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_4, x_2, x_3);
lean_dec(x_2);
return x_5;
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_13__restore(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
uint8_t x_6; 
x_6 = !lean_is_exclusive(x_5);
if (x_6 == 0)
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; 
x_7 = lean_ctor_get(x_5, 5);
lean_dec(x_7);
x_8 = lean_ctor_get(x_5, 1);
lean_dec(x_8);
x_9 = lean_ctor_get(x_5, 0);
lean_dec(x_9);
lean_ctor_set(x_5, 5, x_3);
lean_ctor_set(x_5, 1, x_2);
lean_ctor_set(x_5, 0, x_1);
x_10 = lean_box(0);
x_11 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_11, 0, x_10);
lean_ctor_set(x_11, 1, x_5);
return x_11;
}
else
{
lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; 
x_12 = lean_ctor_get(x_5, 2);
x_13 = lean_ctor_get(x_5, 3);
x_14 = lean_ctor_get(x_5, 4);
lean_inc(x_14);
lean_inc(x_13);
lean_inc(x_12);
lean_dec(x_5);
x_15 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_15, 0, x_1);
lean_ctor_set(x_15, 1, x_2);
lean_ctor_set(x_15, 2, x_12);
lean_ctor_set(x_15, 3, x_13);
lean_ctor_set(x_15, 4, x_14);
lean_ctor_set(x_15, 5, x_3);
x_16 = lean_box(0);
x_17 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_17, 0, x_16);
lean_ctor_set(x_17, 1, x_15);
return x_17;
}
}
}
lean_object* l___private_Init_Lean_Meta_LevelDefEq_13__restore___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_6; 
x_6 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_1, x_2, x_3, x_4, x_5);
lean_dec(x_4);
return x_6;
}
}
lean_object* l_Lean_Meta_try(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; 
x_4 = !lean_is_exclusive(x_3);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_17; 
x_5 = lean_ctor_get(x_3, 0);
x_6 = lean_ctor_get(x_3, 1);
x_7 = lean_ctor_get(x_3, 5);
x_8 = l_PersistentArray_empty___closed__3;
lean_inc(x_6);
lean_inc(x_5);
lean_ctor_set(x_3, 5, x_8);
lean_inc(x_2);
x_17 = lean_apply_2(x_1, x_2, x_3);
if (lean_obj_tag(x_17) == 0)
{
lean_object* x_18; uint8_t x_19; 
x_18 = lean_ctor_get(x_17, 0);
lean_inc(x_18);
x_19 = lean_unbox(x_18);
if (x_19 == 0)
{
lean_object* x_20; lean_object* x_21; uint8_t x_22; 
x_20 = lean_ctor_get(x_17, 1);
lean_inc(x_20);
lean_dec(x_17);
x_21 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_5, x_6, x_7, x_2, x_20);
lean_dec(x_2);
x_22 = !lean_is_exclusive(x_21);
if (x_22 == 0)
{
lean_object* x_23; 
x_23 = lean_ctor_get(x_21, 0);
lean_dec(x_23);
lean_ctor_set(x_21, 0, x_18);
return x_21;
}
else
{
lean_object* x_24; lean_object* x_25; 
x_24 = lean_ctor_get(x_21, 1);
lean_inc(x_24);
lean_dec(x_21);
x_25 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_25, 0, x_18);
lean_ctor_set(x_25, 1, x_24);
return x_25;
}
}
else
{
lean_object* x_26; uint8_t x_27; lean_object* x_28; 
lean_dec(x_18);
x_26 = lean_ctor_get(x_17, 1);
lean_inc(x_26);
lean_dec(x_17);
x_27 = 0;
x_28 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_27, x_2, x_26);
if (lean_obj_tag(x_28) == 0)
{
lean_object* x_29; uint8_t x_30; 
x_29 = lean_ctor_get(x_28, 0);
lean_inc(x_29);
x_30 = lean_unbox(x_29);
if (x_30 == 0)
{
lean_object* x_31; lean_object* x_32; uint8_t x_33; 
x_31 = lean_ctor_get(x_28, 1);
lean_inc(x_31);
lean_dec(x_28);
x_32 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_5, x_6, x_7, x_2, x_31);
lean_dec(x_2);
x_33 = !lean_is_exclusive(x_32);
if (x_33 == 0)
{
lean_object* x_34; 
x_34 = lean_ctor_get(x_32, 0);
lean_dec(x_34);
lean_ctor_set(x_32, 0, x_29);
return x_32;
}
else
{
lean_object* x_35; lean_object* x_36; 
x_35 = lean_ctor_get(x_32, 1);
lean_inc(x_35);
lean_dec(x_32);
x_36 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_36, 0, x_29);
lean_ctor_set(x_36, 1, x_35);
return x_36;
}
}
else
{
uint8_t x_37; 
lean_dec(x_7);
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_2);
x_37 = !lean_is_exclusive(x_28);
if (x_37 == 0)
{
lean_object* x_38; 
x_38 = lean_ctor_get(x_28, 0);
lean_dec(x_38);
return x_28;
}
else
{
lean_object* x_39; lean_object* x_40; 
x_39 = lean_ctor_get(x_28, 1);
lean_inc(x_39);
lean_dec(x_28);
x_40 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_40, 0, x_29);
lean_ctor_set(x_40, 1, x_39);
return x_40;
}
}
}
else
{
lean_object* x_41; lean_object* x_42; 
x_41 = lean_ctor_get(x_28, 0);
lean_inc(x_41);
x_42 = lean_ctor_get(x_28, 1);
lean_inc(x_42);
lean_dec(x_28);
x_9 = x_41;
x_10 = x_42;
goto block_16;
}
}
}
else
{
lean_object* x_43; lean_object* x_44; 
x_43 = lean_ctor_get(x_17, 0);
lean_inc(x_43);
x_44 = lean_ctor_get(x_17, 1);
lean_inc(x_44);
lean_dec(x_17);
x_9 = x_43;
x_10 = x_44;
goto block_16;
}
block_16:
{
lean_object* x_11; uint8_t x_12; 
x_11 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_5, x_6, x_7, x_2, x_10);
lean_dec(x_2);
x_12 = !lean_is_exclusive(x_11);
if (x_12 == 0)
{
lean_object* x_13; 
x_13 = lean_ctor_get(x_11, 0);
lean_dec(x_13);
lean_ctor_set_tag(x_11, 1);
lean_ctor_set(x_11, 0, x_9);
return x_11;
}
else
{
lean_object* x_14; lean_object* x_15; 
x_14 = lean_ctor_get(x_11, 1);
lean_inc(x_14);
lean_dec(x_11);
x_15 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_15, 0, x_9);
lean_ctor_set(x_15, 1, x_14);
return x_15;
}
}
}
else
{
lean_object* x_45; lean_object* x_46; lean_object* x_47; lean_object* x_48; lean_object* x_49; lean_object* x_50; lean_object* x_51; lean_object* x_52; lean_object* x_53; lean_object* x_54; lean_object* x_60; 
x_45 = lean_ctor_get(x_3, 0);
x_46 = lean_ctor_get(x_3, 1);
x_47 = lean_ctor_get(x_3, 2);
x_48 = lean_ctor_get(x_3, 3);
x_49 = lean_ctor_get(x_3, 4);
x_50 = lean_ctor_get(x_3, 5);
lean_inc(x_50);
lean_inc(x_49);
lean_inc(x_48);
lean_inc(x_47);
lean_inc(x_46);
lean_inc(x_45);
lean_dec(x_3);
x_51 = l_PersistentArray_empty___closed__3;
lean_inc(x_46);
lean_inc(x_45);
x_52 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_52, 0, x_45);
lean_ctor_set(x_52, 1, x_46);
lean_ctor_set(x_52, 2, x_47);
lean_ctor_set(x_52, 3, x_48);
lean_ctor_set(x_52, 4, x_49);
lean_ctor_set(x_52, 5, x_51);
lean_inc(x_2);
x_60 = lean_apply_2(x_1, x_2, x_52);
if (lean_obj_tag(x_60) == 0)
{
lean_object* x_61; uint8_t x_62; 
x_61 = lean_ctor_get(x_60, 0);
lean_inc(x_61);
x_62 = lean_unbox(x_61);
if (x_62 == 0)
{
lean_object* x_63; lean_object* x_64; lean_object* x_65; lean_object* x_66; lean_object* x_67; 
x_63 = lean_ctor_get(x_60, 1);
lean_inc(x_63);
lean_dec(x_60);
x_64 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_45, x_46, x_50, x_2, x_63);
lean_dec(x_2);
x_65 = lean_ctor_get(x_64, 1);
lean_inc(x_65);
if (lean_is_exclusive(x_64)) {
 lean_ctor_release(x_64, 0);
 lean_ctor_release(x_64, 1);
 x_66 = x_64;
} else {
 lean_dec_ref(x_64);
 x_66 = lean_box(0);
}
if (lean_is_scalar(x_66)) {
 x_67 = lean_alloc_ctor(0, 2, 0);
} else {
 x_67 = x_66;
}
lean_ctor_set(x_67, 0, x_61);
lean_ctor_set(x_67, 1, x_65);
return x_67;
}
else
{
lean_object* x_68; uint8_t x_69; lean_object* x_70; 
lean_dec(x_61);
x_68 = lean_ctor_get(x_60, 1);
lean_inc(x_68);
lean_dec(x_60);
x_69 = 0;
x_70 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_69, x_2, x_68);
if (lean_obj_tag(x_70) == 0)
{
lean_object* x_71; uint8_t x_72; 
x_71 = lean_ctor_get(x_70, 0);
lean_inc(x_71);
x_72 = lean_unbox(x_71);
if (x_72 == 0)
{
lean_object* x_73; lean_object* x_74; lean_object* x_75; lean_object* x_76; lean_object* x_77; 
x_73 = lean_ctor_get(x_70, 1);
lean_inc(x_73);
lean_dec(x_70);
x_74 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_45, x_46, x_50, x_2, x_73);
lean_dec(x_2);
x_75 = lean_ctor_get(x_74, 1);
lean_inc(x_75);
if (lean_is_exclusive(x_74)) {
 lean_ctor_release(x_74, 0);
 lean_ctor_release(x_74, 1);
 x_76 = x_74;
} else {
 lean_dec_ref(x_74);
 x_76 = lean_box(0);
}
if (lean_is_scalar(x_76)) {
 x_77 = lean_alloc_ctor(0, 2, 0);
} else {
 x_77 = x_76;
}
lean_ctor_set(x_77, 0, x_71);
lean_ctor_set(x_77, 1, x_75);
return x_77;
}
else
{
lean_object* x_78; lean_object* x_79; lean_object* x_80; 
lean_dec(x_50);
lean_dec(x_46);
lean_dec(x_45);
lean_dec(x_2);
x_78 = lean_ctor_get(x_70, 1);
lean_inc(x_78);
if (lean_is_exclusive(x_70)) {
 lean_ctor_release(x_70, 0);
 lean_ctor_release(x_70, 1);
 x_79 = x_70;
} else {
 lean_dec_ref(x_70);
 x_79 = lean_box(0);
}
if (lean_is_scalar(x_79)) {
 x_80 = lean_alloc_ctor(0, 2, 0);
} else {
 x_80 = x_79;
}
lean_ctor_set(x_80, 0, x_71);
lean_ctor_set(x_80, 1, x_78);
return x_80;
}
}
else
{
lean_object* x_81; lean_object* x_82; 
x_81 = lean_ctor_get(x_70, 0);
lean_inc(x_81);
x_82 = lean_ctor_get(x_70, 1);
lean_inc(x_82);
lean_dec(x_70);
x_53 = x_81;
x_54 = x_82;
goto block_59;
}
}
}
else
{
lean_object* x_83; lean_object* x_84; 
x_83 = lean_ctor_get(x_60, 0);
lean_inc(x_83);
x_84 = lean_ctor_get(x_60, 1);
lean_inc(x_84);
lean_dec(x_60);
x_53 = x_83;
x_54 = x_84;
goto block_59;
}
block_59:
{
lean_object* x_55; lean_object* x_56; lean_object* x_57; lean_object* x_58; 
x_55 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_45, x_46, x_50, x_2, x_54);
lean_dec(x_2);
x_56 = lean_ctor_get(x_55, 1);
lean_inc(x_56);
if (lean_is_exclusive(x_55)) {
 lean_ctor_release(x_55, 0);
 lean_ctor_release(x_55, 1);
 x_57 = x_55;
} else {
 lean_dec_ref(x_55);
 x_57 = lean_box(0);
}
if (lean_is_scalar(x_57)) {
 x_58 = lean_alloc_ctor(1, 2, 0);
} else {
 x_58 = x_57;
 lean_ctor_set_tag(x_58, 1);
}
lean_ctor_set(x_58, 0, x_53);
lean_ctor_set(x_58, 1, x_56);
return x_58;
}
}
}
}
lean_object* l_Lean_Meta_isLevelDefEq(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; 
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; uint8_t x_18; lean_object* x_19; lean_object* x_44; 
x_6 = lean_ctor_get(x_4, 0);
x_7 = lean_ctor_get(x_4, 1);
x_8 = lean_ctor_get(x_4, 5);
x_9 = l_PersistentArray_empty___closed__3;
lean_inc(x_7);
lean_inc(x_6);
lean_ctor_set(x_4, 5, x_9);
x_44 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_1, x_2, x_3, x_4);
if (lean_obj_tag(x_44) == 0)
{
lean_object* x_45; uint8_t x_46; 
x_45 = lean_ctor_get(x_44, 0);
lean_inc(x_45);
x_46 = lean_unbox(x_45);
lean_dec(x_45);
if (x_46 == 0)
{
lean_object* x_47; uint8_t x_48; 
x_47 = lean_ctor_get(x_44, 1);
lean_inc(x_47);
lean_dec(x_44);
x_48 = 0;
x_18 = x_48;
x_19 = x_47;
goto block_43;
}
else
{
lean_object* x_49; uint8_t x_50; lean_object* x_51; 
x_49 = lean_ctor_get(x_44, 1);
lean_inc(x_49);
lean_dec(x_44);
x_50 = 0;
x_51 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_50, x_3, x_49);
if (lean_obj_tag(x_51) == 0)
{
lean_object* x_52; lean_object* x_53; uint8_t x_54; 
x_52 = lean_ctor_get(x_51, 0);
lean_inc(x_52);
x_53 = lean_ctor_get(x_51, 1);
lean_inc(x_53);
lean_dec(x_51);
x_54 = lean_unbox(x_52);
lean_dec(x_52);
x_18 = x_54;
x_19 = x_53;
goto block_43;
}
else
{
lean_object* x_55; lean_object* x_56; 
x_55 = lean_ctor_get(x_51, 0);
lean_inc(x_55);
x_56 = lean_ctor_get(x_51, 1);
lean_inc(x_56);
lean_dec(x_51);
x_10 = x_55;
x_11 = x_56;
goto block_17;
}
}
}
else
{
lean_object* x_57; lean_object* x_58; 
x_57 = lean_ctor_get(x_44, 0);
lean_inc(x_57);
x_58 = lean_ctor_get(x_44, 1);
lean_inc(x_58);
lean_dec(x_44);
x_10 = x_57;
x_11 = x_58;
goto block_17;
}
block_17:
{
lean_object* x_12; uint8_t x_13; 
x_12 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_6, x_7, x_8, x_3, x_11);
x_13 = !lean_is_exclusive(x_12);
if (x_13 == 0)
{
lean_object* x_14; 
x_14 = lean_ctor_get(x_12, 0);
lean_dec(x_14);
lean_ctor_set_tag(x_12, 1);
lean_ctor_set(x_12, 0, x_10);
return x_12;
}
else
{
lean_object* x_15; lean_object* x_16; 
x_15 = lean_ctor_get(x_12, 1);
lean_inc(x_15);
lean_dec(x_12);
x_16 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_16, 0, x_10);
lean_ctor_set(x_16, 1, x_15);
return x_16;
}
}
block_43:
{
if (x_18 == 0)
{
lean_object* x_20; uint8_t x_21; 
x_20 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_6, x_7, x_8, x_3, x_19);
x_21 = !lean_is_exclusive(x_20);
if (x_21 == 0)
{
lean_object* x_22; lean_object* x_23; 
x_22 = lean_ctor_get(x_20, 0);
lean_dec(x_22);
x_23 = lean_box(x_18);
lean_ctor_set(x_20, 0, x_23);
return x_20;
}
else
{
lean_object* x_24; lean_object* x_25; lean_object* x_26; 
x_24 = lean_ctor_get(x_20, 1);
lean_inc(x_24);
lean_dec(x_20);
x_25 = lean_box(x_18);
x_26 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_26, 0, x_25);
lean_ctor_set(x_26, 1, x_24);
return x_26;
}
}
else
{
uint8_t x_27; lean_object* x_28; 
x_27 = 0;
x_28 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_27, x_3, x_19);
if (lean_obj_tag(x_28) == 0)
{
lean_object* x_29; uint8_t x_30; 
x_29 = lean_ctor_get(x_28, 0);
lean_inc(x_29);
x_30 = lean_unbox(x_29);
if (x_30 == 0)
{
lean_object* x_31; lean_object* x_32; uint8_t x_33; 
x_31 = lean_ctor_get(x_28, 1);
lean_inc(x_31);
lean_dec(x_28);
x_32 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_6, x_7, x_8, x_3, x_31);
x_33 = !lean_is_exclusive(x_32);
if (x_33 == 0)
{
lean_object* x_34; 
x_34 = lean_ctor_get(x_32, 0);
lean_dec(x_34);
lean_ctor_set(x_32, 0, x_29);
return x_32;
}
else
{
lean_object* x_35; lean_object* x_36; 
x_35 = lean_ctor_get(x_32, 1);
lean_inc(x_35);
lean_dec(x_32);
x_36 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_36, 0, x_29);
lean_ctor_set(x_36, 1, x_35);
return x_36;
}
}
else
{
uint8_t x_37; 
lean_dec(x_8);
lean_dec(x_7);
lean_dec(x_6);
x_37 = !lean_is_exclusive(x_28);
if (x_37 == 0)
{
lean_object* x_38; 
x_38 = lean_ctor_get(x_28, 0);
lean_dec(x_38);
return x_28;
}
else
{
lean_object* x_39; lean_object* x_40; 
x_39 = lean_ctor_get(x_28, 1);
lean_inc(x_39);
lean_dec(x_28);
x_40 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_40, 0, x_29);
lean_ctor_set(x_40, 1, x_39);
return x_40;
}
}
}
else
{
lean_object* x_41; lean_object* x_42; 
x_41 = lean_ctor_get(x_28, 0);
lean_inc(x_41);
x_42 = lean_ctor_get(x_28, 1);
lean_inc(x_42);
lean_dec(x_28);
x_10 = x_41;
x_11 = x_42;
goto block_17;
}
}
}
}
else
{
lean_object* x_59; lean_object* x_60; lean_object* x_61; lean_object* x_62; lean_object* x_63; lean_object* x_64; lean_object* x_65; lean_object* x_66; lean_object* x_67; lean_object* x_68; uint8_t x_74; lean_object* x_75; lean_object* x_96; 
x_59 = lean_ctor_get(x_4, 0);
x_60 = lean_ctor_get(x_4, 1);
x_61 = lean_ctor_get(x_4, 2);
x_62 = lean_ctor_get(x_4, 3);
x_63 = lean_ctor_get(x_4, 4);
x_64 = lean_ctor_get(x_4, 5);
lean_inc(x_64);
lean_inc(x_63);
lean_inc(x_62);
lean_inc(x_61);
lean_inc(x_60);
lean_inc(x_59);
lean_dec(x_4);
x_65 = l_PersistentArray_empty___closed__3;
lean_inc(x_60);
lean_inc(x_59);
x_66 = lean_alloc_ctor(0, 6, 0);
lean_ctor_set(x_66, 0, x_59);
lean_ctor_set(x_66, 1, x_60);
lean_ctor_set(x_66, 2, x_61);
lean_ctor_set(x_66, 3, x_62);
lean_ctor_set(x_66, 4, x_63);
lean_ctor_set(x_66, 5, x_65);
x_96 = l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main(x_1, x_2, x_3, x_66);
if (lean_obj_tag(x_96) == 0)
{
lean_object* x_97; uint8_t x_98; 
x_97 = lean_ctor_get(x_96, 0);
lean_inc(x_97);
x_98 = lean_unbox(x_97);
lean_dec(x_97);
if (x_98 == 0)
{
lean_object* x_99; uint8_t x_100; 
x_99 = lean_ctor_get(x_96, 1);
lean_inc(x_99);
lean_dec(x_96);
x_100 = 0;
x_74 = x_100;
x_75 = x_99;
goto block_95;
}
else
{
lean_object* x_101; uint8_t x_102; lean_object* x_103; 
x_101 = lean_ctor_get(x_96, 1);
lean_inc(x_101);
lean_dec(x_96);
x_102 = 0;
x_103 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_102, x_3, x_101);
if (lean_obj_tag(x_103) == 0)
{
lean_object* x_104; lean_object* x_105; uint8_t x_106; 
x_104 = lean_ctor_get(x_103, 0);
lean_inc(x_104);
x_105 = lean_ctor_get(x_103, 1);
lean_inc(x_105);
lean_dec(x_103);
x_106 = lean_unbox(x_104);
lean_dec(x_104);
x_74 = x_106;
x_75 = x_105;
goto block_95;
}
else
{
lean_object* x_107; lean_object* x_108; 
x_107 = lean_ctor_get(x_103, 0);
lean_inc(x_107);
x_108 = lean_ctor_get(x_103, 1);
lean_inc(x_108);
lean_dec(x_103);
x_67 = x_107;
x_68 = x_108;
goto block_73;
}
}
}
else
{
lean_object* x_109; lean_object* x_110; 
x_109 = lean_ctor_get(x_96, 0);
lean_inc(x_109);
x_110 = lean_ctor_get(x_96, 1);
lean_inc(x_110);
lean_dec(x_96);
x_67 = x_109;
x_68 = x_110;
goto block_73;
}
block_73:
{
lean_object* x_69; lean_object* x_70; lean_object* x_71; lean_object* x_72; 
x_69 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_59, x_60, x_64, x_3, x_68);
x_70 = lean_ctor_get(x_69, 1);
lean_inc(x_70);
if (lean_is_exclusive(x_69)) {
 lean_ctor_release(x_69, 0);
 lean_ctor_release(x_69, 1);
 x_71 = x_69;
} else {
 lean_dec_ref(x_69);
 x_71 = lean_box(0);
}
if (lean_is_scalar(x_71)) {
 x_72 = lean_alloc_ctor(1, 2, 0);
} else {
 x_72 = x_71;
 lean_ctor_set_tag(x_72, 1);
}
lean_ctor_set(x_72, 0, x_67);
lean_ctor_set(x_72, 1, x_70);
return x_72;
}
block_95:
{
if (x_74 == 0)
{
lean_object* x_76; lean_object* x_77; lean_object* x_78; lean_object* x_79; lean_object* x_80; 
x_76 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_59, x_60, x_64, x_3, x_75);
x_77 = lean_ctor_get(x_76, 1);
lean_inc(x_77);
if (lean_is_exclusive(x_76)) {
 lean_ctor_release(x_76, 0);
 lean_ctor_release(x_76, 1);
 x_78 = x_76;
} else {
 lean_dec_ref(x_76);
 x_78 = lean_box(0);
}
x_79 = lean_box(x_74);
if (lean_is_scalar(x_78)) {
 x_80 = lean_alloc_ctor(0, 2, 0);
} else {
 x_80 = x_78;
}
lean_ctor_set(x_80, 0, x_79);
lean_ctor_set(x_80, 1, x_77);
return x_80;
}
else
{
uint8_t x_81; lean_object* x_82; 
x_81 = 0;
x_82 = l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed(x_81, x_3, x_75);
if (lean_obj_tag(x_82) == 0)
{
lean_object* x_83; uint8_t x_84; 
x_83 = lean_ctor_get(x_82, 0);
lean_inc(x_83);
x_84 = lean_unbox(x_83);
if (x_84 == 0)
{
lean_object* x_85; lean_object* x_86; lean_object* x_87; lean_object* x_88; lean_object* x_89; 
x_85 = lean_ctor_get(x_82, 1);
lean_inc(x_85);
lean_dec(x_82);
x_86 = l___private_Init_Lean_Meta_LevelDefEq_13__restore(x_59, x_60, x_64, x_3, x_85);
x_87 = lean_ctor_get(x_86, 1);
lean_inc(x_87);
if (lean_is_exclusive(x_86)) {
 lean_ctor_release(x_86, 0);
 lean_ctor_release(x_86, 1);
 x_88 = x_86;
} else {
 lean_dec_ref(x_86);
 x_88 = lean_box(0);
}
if (lean_is_scalar(x_88)) {
 x_89 = lean_alloc_ctor(0, 2, 0);
} else {
 x_89 = x_88;
}
lean_ctor_set(x_89, 0, x_83);
lean_ctor_set(x_89, 1, x_87);
return x_89;
}
else
{
lean_object* x_90; lean_object* x_91; lean_object* x_92; 
lean_dec(x_64);
lean_dec(x_60);
lean_dec(x_59);
x_90 = lean_ctor_get(x_82, 1);
lean_inc(x_90);
if (lean_is_exclusive(x_82)) {
 lean_ctor_release(x_82, 0);
 lean_ctor_release(x_82, 1);
 x_91 = x_82;
} else {
 lean_dec_ref(x_82);
 x_91 = lean_box(0);
}
if (lean_is_scalar(x_91)) {
 x_92 = lean_alloc_ctor(0, 2, 0);
} else {
 x_92 = x_91;
}
lean_ctor_set(x_92, 0, x_83);
lean_ctor_set(x_92, 1, x_90);
return x_92;
}
}
else
{
lean_object* x_93; lean_object* x_94; 
x_93 = lean_ctor_get(x_82, 0);
lean_inc(x_93);
x_94 = lean_ctor_get(x_82, 1);
lean_inc(x_94);
lean_dec(x_82);
x_67 = x_93;
x_68 = x_94;
goto block_73;
}
}
}
}
}
}
lean_object* l_Lean_Meta_isLevelDefEq___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_Lean_Meta_isLevelDefEq(x_1, x_2, x_3, x_4);
lean_dec(x_3);
return x_5;
}
}
lean_object* initialize_Init_Lean_Meta_Basic(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_Init_Lean_Meta_LevelDefEq(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Lean_Meta_Basic(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__1);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__2);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__3);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__4);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__5);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__6);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__7);
l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8 = _init_l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_7__isLevelDefEqAux___main___closed__8);
l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1 = _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__1);
l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2 = _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__2);
l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3 = _init_l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_10__processPostponedStep___closed__3);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__1);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__2);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__3);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__4);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__5);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__6);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__7);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__8);
l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9 = _init_l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_11__processPostponedAux___main___closed__9);
l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1 = _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__1);
l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2 = _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__2);
l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3 = _init_l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3();
lean_mark_persistent(l___private_Init_Lean_Meta_LevelDefEq_12__processPostponed___closed__3);
return lean_mk_io_result(lean_box(0));
}
#ifdef __cplusplus
}
#endif
