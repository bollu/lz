// Lean compiler output
// Module: const_fold
// Imports: Init
#include <lean/lean.h>
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
lean_object* l_Expr_appendAdd(lean_object*, lean_object*);
lean_object* l_Expr_appendAdd_match__1(lean_object*);
lean_object* l_Expr_mkExpr(lean_object*, lean_object*);
lean_object* _lean_main(lean_object*, lean_object*);
lean_object* l_Expr_toStringAux_match__1(lean_object*);
lean_object* l_Expr_toStringAux_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_string_append(lean_object*, lean_object*);
lean_object* l_Expr_appendMul(lean_object*, lean_object*);
lean_object* l_Expr_eval(lean_object*);
lean_object* l_main___boxed__const__1;
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_Expr_mkExpr_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_reassoc(lean_object*);
lean_object* l_Nat_repr(lean_object*);
extern lean_object* l_term___x2a_____closed__3;
lean_object* l_Expr_mkExpr___boxed(lean_object*, lean_object*);
lean_object* l_Expr_mkExpr_match__1___rarg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_size(lean_object*);
lean_object* l_Expr_mkExpr___closed__1;
lean_object* l_Expr_eval_match__1(lean_object*);
lean_object* l_Expr_constFolding_match__2___rarg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_main_match__1(lean_object*);
lean_object* l_Expr_constFolding_match__1(lean_object*);
lean_object* l_main_match__1___rarg(lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_appendAdd_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_appendMul_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*);
extern lean_object* l_Array_instToStringArray___rarg___closed__1;
lean_object* l_Expr_toStringAux(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* l_Expr_size___boxed(lean_object*);
lean_object* l_Expr_reassoc_match__1(lean_object*);
lean_object* l_Expr_eval___boxed(lean_object*);
lean_object* l_Expr_appendMul_match__1(lean_object*);
extern lean_object* l_prec_x28___x29___closed__7;
lean_object* l_IO_println___at_Lean_instEval___spec__1(lean_object*, lean_object*);
lean_object* l_Expr_reassoc___boxed(lean_object*);
extern lean_object* l_prec_x28___x29___closed__3;
lean_object* l_main___boxed__const__2;
lean_object* l_Expr_eval_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_constFolding_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* l_Expr_mkExpr_match__1(lean_object*);
lean_object* l_String_toNat_x21(lean_object*);
extern lean_object* l_Lean_Parser_Syntax_addPrec___closed__11;
lean_object* l_Expr_constFolding(lean_object*);
lean_object* l_Expr_constFolding_match__2(lean_object*);
lean_object* l_Expr_reassoc_match__1___rarg(lean_object*, lean_object*, lean_object*, lean_object*);
extern lean_object* l___private_Init_Data_Format_Basic_0__Std_Format_be___closed__1;
lean_object* l_Expr_mkExpr_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; uint8_t x_6; 
x_5 = lean_unsigned_to_nat(0u);
x_6 = lean_nat_dec_eq(x_1, x_5);
if (x_6 == 0)
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; 
lean_dec(x_3);
x_7 = lean_unsigned_to_nat(1u);
x_8 = lean_nat_sub(x_1, x_7);
x_9 = lean_apply_2(x_4, x_8, x_2);
return x_9;
}
else
{
lean_object* x_10; 
lean_dec(x_4);
x_10 = lean_apply_1(x_3, x_2);
return x_10;
}
}
}
lean_object* l_Expr_mkExpr_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_mkExpr_match__1___rarg___boxed), 4, 0);
return x_2;
}
}
lean_object* l_Expr_mkExpr_match__1___rarg___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_Expr_mkExpr_match__1___rarg(x_1, x_2, x_3, x_4);
lean_dec(x_1);
return x_5;
}
}
static lean_object* _init_l_Expr_mkExpr___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; 
x_1 = lean_unsigned_to_nat(1u);
x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* l_Expr_mkExpr(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; uint8_t x_4; 
x_3 = lean_unsigned_to_nat(0u);
x_4 = lean_nat_dec_eq(x_1, x_3);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; 
x_5 = lean_unsigned_to_nat(1u);
x_6 = lean_nat_sub(x_1, x_5);
x_7 = lean_nat_add(x_2, x_5);
x_8 = l_Expr_mkExpr(x_6, x_7);
x_9 = lean_nat_sub(x_2, x_5);
lean_dec(x_2);
x_10 = l_Expr_mkExpr(x_6, x_9);
lean_dec(x_6);
x_11 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_11, 0, x_8);
lean_ctor_set(x_11, 1, x_10);
return x_11;
}
else
{
uint8_t x_12; 
x_12 = lean_nat_dec_eq(x_2, x_3);
if (x_12 == 0)
{
lean_object* x_13; 
x_13 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_13, 0, x_2);
return x_13;
}
else
{
lean_object* x_14; 
lean_dec(x_2);
x_14 = l_Expr_mkExpr___closed__1;
return x_14;
}
}
}
}
lean_object* l_Expr_mkExpr___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Expr_mkExpr(x_1, x_2);
lean_dec(x_1);
return x_3;
}
}
lean_object* l_Expr_appendAdd_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
if (lean_obj_tag(x_1) == 2)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; 
lean_dec(x_4);
x_5 = lean_ctor_get(x_1, 0);
lean_inc(x_5);
x_6 = lean_ctor_get(x_1, 1);
lean_inc(x_6);
lean_dec(x_1);
x_7 = lean_apply_3(x_3, x_5, x_6, x_2);
return x_7;
}
else
{
lean_object* x_8; 
lean_dec(x_3);
x_8 = lean_apply_2(x_4, x_1, x_2);
return x_8;
}
}
}
lean_object* l_Expr_appendAdd_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_appendAdd_match__1___rarg), 4, 0);
return x_2;
}
}
lean_object* l_Expr_appendAdd(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_1) == 2)
{
uint8_t x_3; 
x_3 = !lean_is_exclusive(x_1);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_Expr_appendAdd(x_4, x_2);
lean_ctor_set(x_1, 1, x_5);
return x_1;
}
else
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_6 = lean_ctor_get(x_1, 0);
x_7 = lean_ctor_get(x_1, 1);
lean_inc(x_7);
lean_inc(x_6);
lean_dec(x_1);
x_8 = l_Expr_appendAdd(x_7, x_2);
x_9 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_9, 0, x_6);
lean_ctor_set(x_9, 1, x_8);
return x_9;
}
}
else
{
lean_object* x_10; 
x_10 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_10, 0, x_1);
lean_ctor_set(x_10, 1, x_2);
return x_10;
}
}
}
lean_object* l_Expr_appendMul_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
if (lean_obj_tag(x_1) == 3)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; 
lean_dec(x_4);
x_5 = lean_ctor_get(x_1, 0);
lean_inc(x_5);
x_6 = lean_ctor_get(x_1, 1);
lean_inc(x_6);
lean_dec(x_1);
x_7 = lean_apply_3(x_3, x_5, x_6, x_2);
return x_7;
}
else
{
lean_object* x_8; 
lean_dec(x_3);
x_8 = lean_apply_2(x_4, x_1, x_2);
return x_8;
}
}
}
lean_object* l_Expr_appendMul_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_appendMul_match__1___rarg), 4, 0);
return x_2;
}
}
lean_object* l_Expr_appendMul(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_1) == 3)
{
uint8_t x_3; 
x_3 = !lean_is_exclusive(x_1);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; 
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_Expr_appendMul(x_4, x_2);
lean_ctor_set(x_1, 1, x_5);
return x_1;
}
else
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; 
x_6 = lean_ctor_get(x_1, 0);
x_7 = lean_ctor_get(x_1, 1);
lean_inc(x_7);
lean_inc(x_6);
lean_dec(x_1);
x_8 = l_Expr_appendMul(x_7, x_2);
x_9 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_9, 0, x_6);
lean_ctor_set(x_9, 1, x_8);
return x_9;
}
}
else
{
lean_object* x_10; 
x_10 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_10, 0, x_1);
lean_ctor_set(x_10, 1, x_2);
return x_10;
}
}
}
lean_object* l_Expr_reassoc_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 2:
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; 
lean_dec(x_4);
lean_dec(x_3);
x_5 = lean_ctor_get(x_1, 0);
lean_inc(x_5);
x_6 = lean_ctor_get(x_1, 1);
lean_inc(x_6);
lean_dec(x_1);
x_7 = lean_apply_2(x_2, x_5, x_6);
return x_7;
}
case 3:
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; 
lean_dec(x_4);
lean_dec(x_2);
x_8 = lean_ctor_get(x_1, 0);
lean_inc(x_8);
x_9 = lean_ctor_get(x_1, 1);
lean_inc(x_9);
lean_dec(x_1);
x_10 = lean_apply_2(x_3, x_8, x_9);
return x_10;
}
default: 
{
lean_object* x_11; 
lean_dec(x_3);
lean_dec(x_2);
x_11 = lean_apply_1(x_4, x_1);
return x_11;
}
}
}
}
lean_object* l_Expr_reassoc_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_reassoc_match__1___rarg), 4, 0);
return x_2;
}
}
lean_object* l_Expr_reassoc(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 2:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_2 = lean_ctor_get(x_1, 0);
x_3 = lean_ctor_get(x_1, 1);
x_4 = l_Expr_reassoc(x_2);
x_5 = l_Expr_reassoc(x_3);
x_6 = l_Expr_appendAdd(x_4, x_5);
return x_6;
}
case 3:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; 
x_7 = lean_ctor_get(x_1, 0);
x_8 = lean_ctor_get(x_1, 1);
x_9 = l_Expr_reassoc(x_7);
x_10 = l_Expr_reassoc(x_8);
x_11 = l_Expr_appendMul(x_9, x_10);
return x_11;
}
default: 
{
lean_inc(x_1);
return x_1;
}
}
}
}
lean_object* l_Expr_reassoc___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Expr_reassoc(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_Expr_constFolding_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
if (lean_obj_tag(x_1) == 1)
{
switch (lean_obj_tag(x_2)) {
case 1:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
x_7 = lean_ctor_get(x_1, 0);
lean_inc(x_7);
lean_dec(x_1);
x_8 = lean_ctor_get(x_2, 0);
lean_inc(x_8);
lean_dec(x_2);
x_9 = lean_apply_2(x_3, x_7, x_8);
return x_9;
}
case 2:
{
lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; 
lean_dec(x_3);
x_10 = lean_ctor_get(x_1, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_2, 0);
lean_inc(x_11);
x_12 = lean_ctor_get(x_2, 1);
lean_inc(x_12);
if (lean_obj_tag(x_11) == 1)
{
lean_dec(x_6);
lean_dec(x_2);
lean_dec(x_1);
if (lean_obj_tag(x_12) == 1)
{
lean_object* x_18; lean_object* x_19; 
lean_dec(x_5);
x_18 = lean_ctor_get(x_12, 0);
lean_inc(x_18);
lean_dec(x_12);
x_19 = lean_apply_3(x_4, x_10, x_11, x_18);
return x_19;
}
else
{
lean_object* x_20; lean_object* x_21; 
lean_dec(x_4);
x_20 = lean_ctor_get(x_11, 0);
lean_inc(x_20);
lean_dec(x_11);
x_21 = lean_apply_3(x_5, x_10, x_20, x_12);
return x_21;
}
}
else
{
lean_object* x_22; 
lean_dec(x_5);
x_22 = lean_box(0);
x_13 = x_22;
goto block_17;
}
block_17:
{
lean_dec(x_13);
if (lean_obj_tag(x_12) == 1)
{
lean_object* x_14; lean_object* x_15; 
lean_dec(x_6);
lean_dec(x_2);
lean_dec(x_1);
x_14 = lean_ctor_get(x_12, 0);
lean_inc(x_14);
lean_dec(x_12);
x_15 = lean_apply_3(x_4, x_10, x_11, x_14);
return x_15;
}
else
{
lean_object* x_16; 
lean_dec(x_12);
lean_dec(x_11);
lean_dec(x_10);
lean_dec(x_4);
x_16 = lean_apply_2(x_6, x_1, x_2);
return x_16;
}
}
}
default: 
{
lean_object* x_23; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_23 = lean_apply_2(x_6, x_1, x_2);
return x_23;
}
}
}
else
{
lean_object* x_24; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_24 = lean_apply_2(x_6, x_1, x_2);
return x_24;
}
}
}
lean_object* l_Expr_constFolding_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_constFolding_match__1___rarg), 6, 0);
return x_2;
}
}
lean_object* l_Expr_constFolding_match__2___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
if (lean_obj_tag(x_1) == 1)
{
switch (lean_obj_tag(x_2)) {
case 1:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
x_7 = lean_ctor_get(x_1, 0);
lean_inc(x_7);
lean_dec(x_1);
x_8 = lean_ctor_get(x_2, 0);
lean_inc(x_8);
lean_dec(x_2);
x_9 = lean_apply_2(x_3, x_7, x_8);
return x_9;
}
case 3:
{
lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; 
lean_dec(x_3);
x_10 = lean_ctor_get(x_1, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_2, 0);
lean_inc(x_11);
x_12 = lean_ctor_get(x_2, 1);
lean_inc(x_12);
if (lean_obj_tag(x_11) == 1)
{
lean_dec(x_6);
lean_dec(x_2);
lean_dec(x_1);
if (lean_obj_tag(x_12) == 1)
{
lean_object* x_18; lean_object* x_19; 
lean_dec(x_5);
x_18 = lean_ctor_get(x_12, 0);
lean_inc(x_18);
lean_dec(x_12);
x_19 = lean_apply_3(x_4, x_10, x_11, x_18);
return x_19;
}
else
{
lean_object* x_20; lean_object* x_21; 
lean_dec(x_4);
x_20 = lean_ctor_get(x_11, 0);
lean_inc(x_20);
lean_dec(x_11);
x_21 = lean_apply_3(x_5, x_10, x_20, x_12);
return x_21;
}
}
else
{
lean_object* x_22; 
lean_dec(x_5);
x_22 = lean_box(0);
x_13 = x_22;
goto block_17;
}
block_17:
{
lean_dec(x_13);
if (lean_obj_tag(x_12) == 1)
{
lean_object* x_14; lean_object* x_15; 
lean_dec(x_6);
lean_dec(x_2);
lean_dec(x_1);
x_14 = lean_ctor_get(x_12, 0);
lean_inc(x_14);
lean_dec(x_12);
x_15 = lean_apply_3(x_4, x_10, x_11, x_14);
return x_15;
}
else
{
lean_object* x_16; 
lean_dec(x_12);
lean_dec(x_11);
lean_dec(x_10);
lean_dec(x_4);
x_16 = lean_apply_2(x_6, x_1, x_2);
return x_16;
}
}
}
default: 
{
lean_object* x_23; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_23 = lean_apply_2(x_6, x_1, x_2);
return x_23;
}
}
}
else
{
lean_object* x_24; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_24 = lean_apply_2(x_6, x_1, x_2);
return x_24;
}
}
}
lean_object* l_Expr_constFolding_match__2(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_constFolding_match__2___rarg), 6, 0);
return x_2;
}
}
lean_object* l_Expr_constFolding(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 2:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_2 = lean_ctor_get(x_1, 0);
lean_inc(x_2);
x_3 = lean_ctor_get(x_1, 1);
lean_inc(x_3);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_4 = x_1;
} else {
 lean_dec_ref(x_1);
 x_4 = lean_box(0);
}
x_5 = l_Expr_constFolding(x_2);
x_6 = l_Expr_constFolding(x_3);
if (lean_obj_tag(x_5) == 1)
{
switch (lean_obj_tag(x_6)) {
case 1:
{
lean_object* x_7; uint8_t x_8; 
lean_dec(x_4);
x_7 = lean_ctor_get(x_5, 0);
lean_inc(x_7);
lean_dec(x_5);
x_8 = !lean_is_exclusive(x_6);
if (x_8 == 0)
{
lean_object* x_9; lean_object* x_10; 
x_9 = lean_ctor_get(x_6, 0);
x_10 = lean_nat_add(x_7, x_9);
lean_dec(x_9);
lean_dec(x_7);
lean_ctor_set(x_6, 0, x_10);
return x_6;
}
else
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_11 = lean_ctor_get(x_6, 0);
lean_inc(x_11);
lean_dec(x_6);
x_12 = lean_nat_add(x_7, x_11);
lean_dec(x_11);
lean_dec(x_7);
x_13 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_13, 0, x_12);
return x_13;
}
}
case 2:
{
lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; 
x_14 = lean_ctor_get(x_5, 0);
lean_inc(x_14);
x_15 = lean_ctor_get(x_6, 0);
lean_inc(x_15);
x_16 = lean_ctor_get(x_6, 1);
lean_inc(x_16);
if (lean_obj_tag(x_15) == 1)
{
uint8_t x_42; 
lean_dec(x_5);
lean_dec(x_4);
x_42 = !lean_is_exclusive(x_6);
if (x_42 == 0)
{
lean_object* x_43; lean_object* x_44; 
x_43 = lean_ctor_get(x_6, 1);
lean_dec(x_43);
x_44 = lean_ctor_get(x_6, 0);
lean_dec(x_44);
if (lean_obj_tag(x_16) == 1)
{
uint8_t x_45; 
x_45 = !lean_is_exclusive(x_16);
if (x_45 == 0)
{
lean_object* x_46; lean_object* x_47; 
x_46 = lean_ctor_get(x_16, 0);
x_47 = lean_nat_add(x_14, x_46);
lean_dec(x_46);
lean_dec(x_14);
lean_ctor_set(x_16, 0, x_47);
lean_ctor_set(x_6, 1, x_15);
lean_ctor_set(x_6, 0, x_16);
return x_6;
}
else
{
lean_object* x_48; lean_object* x_49; lean_object* x_50; 
x_48 = lean_ctor_get(x_16, 0);
lean_inc(x_48);
lean_dec(x_16);
x_49 = lean_nat_add(x_14, x_48);
lean_dec(x_48);
lean_dec(x_14);
x_50 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_50, 0, x_49);
lean_ctor_set(x_6, 1, x_15);
lean_ctor_set(x_6, 0, x_50);
return x_6;
}
}
else
{
uint8_t x_51; 
x_51 = !lean_is_exclusive(x_15);
if (x_51 == 0)
{
lean_object* x_52; lean_object* x_53; 
x_52 = lean_ctor_get(x_15, 0);
x_53 = lean_nat_add(x_14, x_52);
lean_dec(x_52);
lean_dec(x_14);
lean_ctor_set(x_15, 0, x_53);
return x_6;
}
else
{
lean_object* x_54; lean_object* x_55; lean_object* x_56; 
x_54 = lean_ctor_get(x_15, 0);
lean_inc(x_54);
lean_dec(x_15);
x_55 = lean_nat_add(x_14, x_54);
lean_dec(x_54);
lean_dec(x_14);
x_56 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_56, 0, x_55);
lean_ctor_set(x_6, 0, x_56);
return x_6;
}
}
}
else
{
lean_dec(x_6);
if (lean_obj_tag(x_16) == 1)
{
lean_object* x_57; lean_object* x_58; lean_object* x_59; lean_object* x_60; lean_object* x_61; 
x_57 = lean_ctor_get(x_16, 0);
lean_inc(x_57);
if (lean_is_exclusive(x_16)) {
 lean_ctor_release(x_16, 0);
 x_58 = x_16;
} else {
 lean_dec_ref(x_16);
 x_58 = lean_box(0);
}
x_59 = lean_nat_add(x_14, x_57);
lean_dec(x_57);
lean_dec(x_14);
if (lean_is_scalar(x_58)) {
 x_60 = lean_alloc_ctor(1, 1, 0);
} else {
 x_60 = x_58;
}
lean_ctor_set(x_60, 0, x_59);
x_61 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_61, 0, x_60);
lean_ctor_set(x_61, 1, x_15);
return x_61;
}
else
{
lean_object* x_62; lean_object* x_63; lean_object* x_64; lean_object* x_65; lean_object* x_66; 
x_62 = lean_ctor_get(x_15, 0);
lean_inc(x_62);
if (lean_is_exclusive(x_15)) {
 lean_ctor_release(x_15, 0);
 x_63 = x_15;
} else {
 lean_dec_ref(x_15);
 x_63 = lean_box(0);
}
x_64 = lean_nat_add(x_14, x_62);
lean_dec(x_62);
lean_dec(x_14);
if (lean_is_scalar(x_63)) {
 x_65 = lean_alloc_ctor(1, 1, 0);
} else {
 x_65 = x_63;
}
lean_ctor_set(x_65, 0, x_64);
x_66 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_66, 0, x_65);
lean_ctor_set(x_66, 1, x_16);
return x_66;
}
}
}
else
{
lean_object* x_67; 
x_67 = lean_box(0);
x_17 = x_67;
goto block_41;
}
block_41:
{
lean_dec(x_17);
switch (lean_obj_tag(x_16)) {
case 0:
{
lean_object* x_18; 
lean_dec(x_16);
lean_dec(x_15);
lean_dec(x_14);
if (lean_is_scalar(x_4)) {
 x_18 = lean_alloc_ctor(2, 2, 0);
} else {
 x_18 = x_4;
}
lean_ctor_set(x_18, 0, x_5);
lean_ctor_set(x_18, 1, x_6);
return x_18;
}
case 1:
{
uint8_t x_19; 
lean_dec(x_5);
lean_dec(x_4);
x_19 = !lean_is_exclusive(x_6);
if (x_19 == 0)
{
lean_object* x_20; lean_object* x_21; uint8_t x_22; 
x_20 = lean_ctor_get(x_6, 1);
lean_dec(x_20);
x_21 = lean_ctor_get(x_6, 0);
lean_dec(x_21);
x_22 = !lean_is_exclusive(x_16);
if (x_22 == 0)
{
lean_object* x_23; lean_object* x_24; 
x_23 = lean_ctor_get(x_16, 0);
x_24 = lean_nat_add(x_14, x_23);
lean_dec(x_23);
lean_dec(x_14);
lean_ctor_set(x_16, 0, x_24);
lean_ctor_set(x_6, 1, x_15);
lean_ctor_set(x_6, 0, x_16);
return x_6;
}
else
{
lean_object* x_25; lean_object* x_26; lean_object* x_27; 
x_25 = lean_ctor_get(x_16, 0);
lean_inc(x_25);
lean_dec(x_16);
x_26 = lean_nat_add(x_14, x_25);
lean_dec(x_25);
lean_dec(x_14);
x_27 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_27, 0, x_26);
lean_ctor_set(x_6, 1, x_15);
lean_ctor_set(x_6, 0, x_27);
return x_6;
}
}
else
{
lean_object* x_28; lean_object* x_29; lean_object* x_30; lean_object* x_31; lean_object* x_32; 
lean_dec(x_6);
x_28 = lean_ctor_get(x_16, 0);
lean_inc(x_28);
if (lean_is_exclusive(x_16)) {
 lean_ctor_release(x_16, 0);
 x_29 = x_16;
} else {
 lean_dec_ref(x_16);
 x_29 = lean_box(0);
}
x_30 = lean_nat_add(x_14, x_28);
lean_dec(x_28);
lean_dec(x_14);
if (lean_is_scalar(x_29)) {
 x_31 = lean_alloc_ctor(1, 1, 0);
} else {
 x_31 = x_29;
}
lean_ctor_set(x_31, 0, x_30);
x_32 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_32, 0, x_31);
lean_ctor_set(x_32, 1, x_15);
return x_32;
}
}
case 2:
{
uint8_t x_33; 
lean_dec(x_15);
lean_dec(x_14);
lean_dec(x_4);
x_33 = !lean_is_exclusive(x_16);
if (x_33 == 0)
{
lean_object* x_34; lean_object* x_35; 
x_34 = lean_ctor_get(x_16, 1);
lean_dec(x_34);
x_35 = lean_ctor_get(x_16, 0);
lean_dec(x_35);
lean_ctor_set(x_16, 1, x_6);
lean_ctor_set(x_16, 0, x_5);
return x_16;
}
else
{
lean_object* x_36; 
lean_dec(x_16);
x_36 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_36, 0, x_5);
lean_ctor_set(x_36, 1, x_6);
return x_36;
}
}
default: 
{
uint8_t x_37; 
lean_dec(x_15);
lean_dec(x_14);
lean_dec(x_4);
x_37 = !lean_is_exclusive(x_16);
if (x_37 == 0)
{
lean_object* x_38; lean_object* x_39; 
x_38 = lean_ctor_get(x_16, 1);
lean_dec(x_38);
x_39 = lean_ctor_get(x_16, 0);
lean_dec(x_39);
lean_ctor_set_tag(x_16, 2);
lean_ctor_set(x_16, 1, x_6);
lean_ctor_set(x_16, 0, x_5);
return x_16;
}
else
{
lean_object* x_40; 
lean_dec(x_16);
x_40 = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(x_40, 0, x_5);
lean_ctor_set(x_40, 1, x_6);
return x_40;
}
}
}
}
}
default: 
{
lean_object* x_68; 
if (lean_is_scalar(x_4)) {
 x_68 = lean_alloc_ctor(2, 2, 0);
} else {
 x_68 = x_4;
}
lean_ctor_set(x_68, 0, x_5);
lean_ctor_set(x_68, 1, x_6);
return x_68;
}
}
}
else
{
lean_object* x_69; 
if (lean_is_scalar(x_4)) {
 x_69 = lean_alloc_ctor(2, 2, 0);
} else {
 x_69 = x_4;
}
lean_ctor_set(x_69, 0, x_5);
lean_ctor_set(x_69, 1, x_6);
return x_69;
}
}
case 3:
{
lean_object* x_70; lean_object* x_71; lean_object* x_72; lean_object* x_73; lean_object* x_74; 
x_70 = lean_ctor_get(x_1, 0);
lean_inc(x_70);
x_71 = lean_ctor_get(x_1, 1);
lean_inc(x_71);
if (lean_is_exclusive(x_1)) {
 lean_ctor_release(x_1, 0);
 lean_ctor_release(x_1, 1);
 x_72 = x_1;
} else {
 lean_dec_ref(x_1);
 x_72 = lean_box(0);
}
x_73 = l_Expr_constFolding(x_70);
x_74 = l_Expr_constFolding(x_71);
if (lean_obj_tag(x_73) == 1)
{
switch (lean_obj_tag(x_74)) {
case 1:
{
lean_object* x_75; uint8_t x_76; 
lean_dec(x_72);
x_75 = lean_ctor_get(x_73, 0);
lean_inc(x_75);
lean_dec(x_73);
x_76 = !lean_is_exclusive(x_74);
if (x_76 == 0)
{
lean_object* x_77; lean_object* x_78; 
x_77 = lean_ctor_get(x_74, 0);
x_78 = lean_nat_mul(x_75, x_77);
lean_dec(x_77);
lean_dec(x_75);
lean_ctor_set(x_74, 0, x_78);
return x_74;
}
else
{
lean_object* x_79; lean_object* x_80; lean_object* x_81; 
x_79 = lean_ctor_get(x_74, 0);
lean_inc(x_79);
lean_dec(x_74);
x_80 = lean_nat_mul(x_75, x_79);
lean_dec(x_79);
lean_dec(x_75);
x_81 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_81, 0, x_80);
return x_81;
}
}
case 3:
{
lean_object* x_82; lean_object* x_83; lean_object* x_84; lean_object* x_85; 
x_82 = lean_ctor_get(x_73, 0);
lean_inc(x_82);
x_83 = lean_ctor_get(x_74, 0);
lean_inc(x_83);
x_84 = lean_ctor_get(x_74, 1);
lean_inc(x_84);
if (lean_obj_tag(x_83) == 1)
{
uint8_t x_110; 
lean_dec(x_73);
lean_dec(x_72);
x_110 = !lean_is_exclusive(x_74);
if (x_110 == 0)
{
lean_object* x_111; lean_object* x_112; 
x_111 = lean_ctor_get(x_74, 1);
lean_dec(x_111);
x_112 = lean_ctor_get(x_74, 0);
lean_dec(x_112);
if (lean_obj_tag(x_84) == 1)
{
uint8_t x_113; 
x_113 = !lean_is_exclusive(x_84);
if (x_113 == 0)
{
lean_object* x_114; lean_object* x_115; 
x_114 = lean_ctor_get(x_84, 0);
x_115 = lean_nat_mul(x_82, x_114);
lean_dec(x_114);
lean_dec(x_82);
lean_ctor_set(x_84, 0, x_115);
lean_ctor_set(x_74, 1, x_83);
lean_ctor_set(x_74, 0, x_84);
return x_74;
}
else
{
lean_object* x_116; lean_object* x_117; lean_object* x_118; 
x_116 = lean_ctor_get(x_84, 0);
lean_inc(x_116);
lean_dec(x_84);
x_117 = lean_nat_mul(x_82, x_116);
lean_dec(x_116);
lean_dec(x_82);
x_118 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_118, 0, x_117);
lean_ctor_set(x_74, 1, x_83);
lean_ctor_set(x_74, 0, x_118);
return x_74;
}
}
else
{
uint8_t x_119; 
x_119 = !lean_is_exclusive(x_83);
if (x_119 == 0)
{
lean_object* x_120; lean_object* x_121; 
x_120 = lean_ctor_get(x_83, 0);
x_121 = lean_nat_mul(x_82, x_120);
lean_dec(x_120);
lean_dec(x_82);
lean_ctor_set(x_83, 0, x_121);
return x_74;
}
else
{
lean_object* x_122; lean_object* x_123; lean_object* x_124; 
x_122 = lean_ctor_get(x_83, 0);
lean_inc(x_122);
lean_dec(x_83);
x_123 = lean_nat_mul(x_82, x_122);
lean_dec(x_122);
lean_dec(x_82);
x_124 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_124, 0, x_123);
lean_ctor_set(x_74, 0, x_124);
return x_74;
}
}
}
else
{
lean_dec(x_74);
if (lean_obj_tag(x_84) == 1)
{
lean_object* x_125; lean_object* x_126; lean_object* x_127; lean_object* x_128; lean_object* x_129; 
x_125 = lean_ctor_get(x_84, 0);
lean_inc(x_125);
if (lean_is_exclusive(x_84)) {
 lean_ctor_release(x_84, 0);
 x_126 = x_84;
} else {
 lean_dec_ref(x_84);
 x_126 = lean_box(0);
}
x_127 = lean_nat_mul(x_82, x_125);
lean_dec(x_125);
lean_dec(x_82);
if (lean_is_scalar(x_126)) {
 x_128 = lean_alloc_ctor(1, 1, 0);
} else {
 x_128 = x_126;
}
lean_ctor_set(x_128, 0, x_127);
x_129 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_129, 0, x_128);
lean_ctor_set(x_129, 1, x_83);
return x_129;
}
else
{
lean_object* x_130; lean_object* x_131; lean_object* x_132; lean_object* x_133; lean_object* x_134; 
x_130 = lean_ctor_get(x_83, 0);
lean_inc(x_130);
if (lean_is_exclusive(x_83)) {
 lean_ctor_release(x_83, 0);
 x_131 = x_83;
} else {
 lean_dec_ref(x_83);
 x_131 = lean_box(0);
}
x_132 = lean_nat_mul(x_82, x_130);
lean_dec(x_130);
lean_dec(x_82);
if (lean_is_scalar(x_131)) {
 x_133 = lean_alloc_ctor(1, 1, 0);
} else {
 x_133 = x_131;
}
lean_ctor_set(x_133, 0, x_132);
x_134 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_134, 0, x_133);
lean_ctor_set(x_134, 1, x_84);
return x_134;
}
}
}
else
{
lean_object* x_135; 
x_135 = lean_box(0);
x_85 = x_135;
goto block_109;
}
block_109:
{
lean_dec(x_85);
switch (lean_obj_tag(x_84)) {
case 0:
{
lean_object* x_86; 
lean_dec(x_84);
lean_dec(x_83);
lean_dec(x_82);
if (lean_is_scalar(x_72)) {
 x_86 = lean_alloc_ctor(3, 2, 0);
} else {
 x_86 = x_72;
}
lean_ctor_set(x_86, 0, x_73);
lean_ctor_set(x_86, 1, x_74);
return x_86;
}
case 1:
{
uint8_t x_87; 
lean_dec(x_73);
lean_dec(x_72);
x_87 = !lean_is_exclusive(x_74);
if (x_87 == 0)
{
lean_object* x_88; lean_object* x_89; uint8_t x_90; 
x_88 = lean_ctor_get(x_74, 1);
lean_dec(x_88);
x_89 = lean_ctor_get(x_74, 0);
lean_dec(x_89);
x_90 = !lean_is_exclusive(x_84);
if (x_90 == 0)
{
lean_object* x_91; lean_object* x_92; 
x_91 = lean_ctor_get(x_84, 0);
x_92 = lean_nat_mul(x_82, x_91);
lean_dec(x_91);
lean_dec(x_82);
lean_ctor_set(x_84, 0, x_92);
lean_ctor_set(x_74, 1, x_83);
lean_ctor_set(x_74, 0, x_84);
return x_74;
}
else
{
lean_object* x_93; lean_object* x_94; lean_object* x_95; 
x_93 = lean_ctor_get(x_84, 0);
lean_inc(x_93);
lean_dec(x_84);
x_94 = lean_nat_mul(x_82, x_93);
lean_dec(x_93);
lean_dec(x_82);
x_95 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_95, 0, x_94);
lean_ctor_set(x_74, 1, x_83);
lean_ctor_set(x_74, 0, x_95);
return x_74;
}
}
else
{
lean_object* x_96; lean_object* x_97; lean_object* x_98; lean_object* x_99; lean_object* x_100; 
lean_dec(x_74);
x_96 = lean_ctor_get(x_84, 0);
lean_inc(x_96);
if (lean_is_exclusive(x_84)) {
 lean_ctor_release(x_84, 0);
 x_97 = x_84;
} else {
 lean_dec_ref(x_84);
 x_97 = lean_box(0);
}
x_98 = lean_nat_mul(x_82, x_96);
lean_dec(x_96);
lean_dec(x_82);
if (lean_is_scalar(x_97)) {
 x_99 = lean_alloc_ctor(1, 1, 0);
} else {
 x_99 = x_97;
}
lean_ctor_set(x_99, 0, x_98);
x_100 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_100, 0, x_99);
lean_ctor_set(x_100, 1, x_83);
return x_100;
}
}
case 2:
{
uint8_t x_101; 
lean_dec(x_83);
lean_dec(x_82);
lean_dec(x_72);
x_101 = !lean_is_exclusive(x_84);
if (x_101 == 0)
{
lean_object* x_102; lean_object* x_103; 
x_102 = lean_ctor_get(x_84, 1);
lean_dec(x_102);
x_103 = lean_ctor_get(x_84, 0);
lean_dec(x_103);
lean_ctor_set_tag(x_84, 3);
lean_ctor_set(x_84, 1, x_74);
lean_ctor_set(x_84, 0, x_73);
return x_84;
}
else
{
lean_object* x_104; 
lean_dec(x_84);
x_104 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_104, 0, x_73);
lean_ctor_set(x_104, 1, x_74);
return x_104;
}
}
default: 
{
uint8_t x_105; 
lean_dec(x_83);
lean_dec(x_82);
lean_dec(x_72);
x_105 = !lean_is_exclusive(x_84);
if (x_105 == 0)
{
lean_object* x_106; lean_object* x_107; 
x_106 = lean_ctor_get(x_84, 1);
lean_dec(x_106);
x_107 = lean_ctor_get(x_84, 0);
lean_dec(x_107);
lean_ctor_set(x_84, 1, x_74);
lean_ctor_set(x_84, 0, x_73);
return x_84;
}
else
{
lean_object* x_108; 
lean_dec(x_84);
x_108 = lean_alloc_ctor(3, 2, 0);
lean_ctor_set(x_108, 0, x_73);
lean_ctor_set(x_108, 1, x_74);
return x_108;
}
}
}
}
}
default: 
{
lean_object* x_136; 
if (lean_is_scalar(x_72)) {
 x_136 = lean_alloc_ctor(3, 2, 0);
} else {
 x_136 = x_72;
}
lean_ctor_set(x_136, 0, x_73);
lean_ctor_set(x_136, 1, x_74);
return x_136;
}
}
}
else
{
lean_object* x_137; 
if (lean_is_scalar(x_72)) {
 x_137 = lean_alloc_ctor(3, 2, 0);
} else {
 x_137 = x_72;
}
lean_ctor_set(x_137, 0, x_73);
lean_ctor_set(x_137, 1, x_74);
return x_137;
}
}
default: 
{
return x_1;
}
}
}
}
lean_object* l_Expr_size(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 2:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; 
x_2 = lean_ctor_get(x_1, 0);
x_3 = lean_ctor_get(x_1, 1);
x_4 = l_Expr_size(x_2);
x_5 = l_Expr_size(x_3);
x_6 = lean_nat_add(x_4, x_5);
lean_dec(x_5);
lean_dec(x_4);
x_7 = lean_unsigned_to_nat(1u);
x_8 = lean_nat_add(x_6, x_7);
lean_dec(x_6);
return x_8;
}
case 3:
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; 
x_9 = lean_ctor_get(x_1, 0);
x_10 = lean_ctor_get(x_1, 1);
x_11 = l_Expr_size(x_9);
x_12 = l_Expr_size(x_10);
x_13 = lean_nat_add(x_11, x_12);
lean_dec(x_12);
lean_dec(x_11);
x_14 = lean_unsigned_to_nat(1u);
x_15 = lean_nat_add(x_13, x_14);
lean_dec(x_13);
return x_15;
}
default: 
{
lean_object* x_16; 
x_16 = lean_unsigned_to_nat(1u);
return x_16;
}
}
}
}
lean_object* l_Expr_size___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Expr_size(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_Expr_toStringAux_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5, lean_object* x_6) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
lean_object* x_7; lean_object* x_8; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_4);
x_7 = lean_ctor_get(x_1, 0);
lean_inc(x_7);
lean_dec(x_1);
x_8 = lean_apply_2(x_3, x_7, x_2);
return x_8;
}
case 1:
{
lean_object* x_9; lean_object* x_10; 
lean_dec(x_6);
lean_dec(x_5);
lean_dec(x_3);
x_9 = lean_ctor_get(x_1, 0);
lean_inc(x_9);
lean_dec(x_1);
x_10 = lean_apply_2(x_4, x_9, x_2);
return x_10;
}
case 2:
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; 
lean_dec(x_6);
lean_dec(x_4);
lean_dec(x_3);
x_11 = lean_ctor_get(x_1, 0);
lean_inc(x_11);
x_12 = lean_ctor_get(x_1, 1);
lean_inc(x_12);
lean_dec(x_1);
x_13 = lean_apply_3(x_5, x_11, x_12, x_2);
return x_13;
}
default: 
{
lean_object* x_14; lean_object* x_15; lean_object* x_16; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_14 = lean_ctor_get(x_1, 0);
lean_inc(x_14);
x_15 = lean_ctor_get(x_1, 1);
lean_inc(x_15);
lean_dec(x_1);
x_16 = lean_apply_3(x_6, x_14, x_15, x_2);
return x_16;
}
}
}
}
lean_object* l_Expr_toStringAux_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_toStringAux_match__1___rarg), 6, 0);
return x_2;
}
}
lean_object* l_Expr_toStringAux(lean_object* x_1, lean_object* x_2) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; 
x_3 = lean_ctor_get(x_1, 0);
lean_inc(x_3);
lean_dec(x_1);
x_4 = l_Array_instToStringArray___rarg___closed__1;
x_5 = lean_string_append(x_2, x_4);
x_6 = l_Nat_repr(x_3);
x_7 = lean_string_append(x_5, x_6);
lean_dec(x_6);
return x_7;
}
case 1:
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; 
x_8 = lean_ctor_get(x_1, 0);
lean_inc(x_8);
lean_dec(x_1);
x_9 = l_Nat_repr(x_8);
x_10 = lean_string_append(x_2, x_9);
lean_dec(x_9);
return x_10;
}
case 2:
{
lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; lean_object* x_20; 
x_11 = lean_ctor_get(x_1, 0);
lean_inc(x_11);
x_12 = lean_ctor_get(x_1, 1);
lean_inc(x_12);
lean_dec(x_1);
x_13 = l_prec_x28___x29___closed__3;
x_14 = lean_string_append(x_2, x_13);
x_15 = l_Expr_toStringAux(x_11, x_14);
x_16 = l_Lean_Parser_Syntax_addPrec___closed__11;
x_17 = lean_string_append(x_15, x_16);
x_18 = l_Expr_toStringAux(x_12, x_17);
x_19 = l_prec_x28___x29___closed__7;
x_20 = lean_string_append(x_18, x_19);
return x_20;
}
default: 
{
lean_object* x_21; lean_object* x_22; lean_object* x_23; lean_object* x_24; lean_object* x_25; lean_object* x_26; lean_object* x_27; lean_object* x_28; lean_object* x_29; lean_object* x_30; 
x_21 = lean_ctor_get(x_1, 0);
lean_inc(x_21);
x_22 = lean_ctor_get(x_1, 1);
lean_inc(x_22);
lean_dec(x_1);
x_23 = l_prec_x28___x29___closed__3;
x_24 = lean_string_append(x_2, x_23);
x_25 = l_Expr_toStringAux(x_21, x_24);
x_26 = l_term___x2a_____closed__3;
x_27 = lean_string_append(x_25, x_26);
x_28 = l_Expr_toStringAux(x_22, x_27);
x_29 = l_prec_x28___x29___closed__7;
x_30 = lean_string_append(x_28, x_29);
return x_30;
}
}
}
}
lean_object* l_Expr_eval_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
lean_object* x_6; lean_object* x_7; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
x_6 = lean_ctor_get(x_1, 0);
lean_inc(x_6);
lean_dec(x_1);
x_7 = lean_apply_1(x_2, x_6);
return x_7;
}
case 1:
{
lean_object* x_8; lean_object* x_9; 
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_2);
x_8 = lean_ctor_get(x_1, 0);
lean_inc(x_8);
lean_dec(x_1);
x_9 = lean_apply_1(x_3, x_8);
return x_9;
}
case 2:
{
lean_object* x_10; lean_object* x_11; lean_object* x_12; 
lean_dec(x_5);
lean_dec(x_3);
lean_dec(x_2);
x_10 = lean_ctor_get(x_1, 0);
lean_inc(x_10);
x_11 = lean_ctor_get(x_1, 1);
lean_inc(x_11);
lean_dec(x_1);
x_12 = lean_apply_2(x_4, x_10, x_11);
return x_12;
}
default: 
{
lean_object* x_13; lean_object* x_14; lean_object* x_15; 
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_2);
x_13 = lean_ctor_get(x_1, 0);
lean_inc(x_13);
x_14 = lean_ctor_get(x_1, 1);
lean_inc(x_14);
lean_dec(x_1);
x_15 = lean_apply_2(x_5, x_13, x_14);
return x_15;
}
}
}
}
lean_object* l_Expr_eval_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Expr_eval_match__1___rarg), 5, 0);
return x_2;
}
}
lean_object* l_Expr_eval(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
lean_object* x_2; 
x_2 = lean_unsigned_to_nat(0u);
return x_2;
}
case 1:
{
lean_object* x_3; 
x_3 = lean_ctor_get(x_1, 0);
lean_inc(x_3);
return x_3;
}
case 2:
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; 
x_4 = lean_ctor_get(x_1, 0);
x_5 = lean_ctor_get(x_1, 1);
x_6 = l_Expr_eval(x_4);
x_7 = l_Expr_eval(x_5);
x_8 = lean_nat_add(x_6, x_7);
lean_dec(x_7);
lean_dec(x_6);
return x_8;
}
default: 
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; 
x_9 = lean_ctor_get(x_1, 0);
x_10 = lean_ctor_get(x_1, 1);
x_11 = l_Expr_eval(x_9);
x_12 = l_Expr_eval(x_10);
x_13 = lean_nat_mul(x_11, x_12);
lean_dec(x_12);
lean_dec(x_11);
return x_13;
}
}
}
}
lean_object* l_Expr_eval___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Expr_eval(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_main_match__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_4; 
lean_dec(x_2);
x_4 = lean_apply_1(x_3, x_1);
return x_4;
}
else
{
lean_object* x_5; 
x_5 = lean_ctor_get(x_1, 1);
lean_inc(x_5);
if (lean_obj_tag(x_5) == 0)
{
lean_object* x_6; lean_object* x_7; 
lean_dec(x_3);
x_6 = lean_ctor_get(x_1, 0);
lean_inc(x_6);
lean_dec(x_1);
x_7 = lean_apply_1(x_2, x_6);
return x_7;
}
else
{
lean_object* x_8; 
lean_dec(x_5);
lean_dec(x_2);
x_8 = lean_apply_1(x_3, x_1);
return x_8;
}
}
}
}
lean_object* l_main_match__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_main_match__1___rarg), 3, 0);
return x_2;
}
}
static lean_object* _init_l_main___boxed__const__1() {
_start:
{
uint32_t x_1; lean_object* x_2; 
x_1 = 1;
x_2 = lean_box_uint32(x_1);
return x_2;
}
}
static lean_object* _init_l_main___boxed__const__2() {
_start:
{
uint32_t x_1; lean_object* x_2; 
x_1 = 0;
x_2 = lean_box_uint32(x_1);
return x_2;
}
}
lean_object* _lean_main(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_3; lean_object* x_4; 
x_3 = l_main___boxed__const__1;
x_4 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_4, 0, x_3);
lean_ctor_set(x_4, 1, x_2);
return x_4;
}
else
{
lean_object* x_5; 
x_5 = lean_ctor_get(x_1, 1);
lean_inc(x_5);
if (lean_obj_tag(x_5) == 0)
{
lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; lean_object* x_17; lean_object* x_18; lean_object* x_19; 
x_6 = lean_ctor_get(x_1, 0);
lean_inc(x_6);
lean_dec(x_1);
x_7 = l_String_toNat_x21(x_6);
lean_dec(x_6);
x_8 = lean_unsigned_to_nat(1u);
x_9 = l_Expr_mkExpr(x_7, x_8);
lean_dec(x_7);
x_10 = l_Expr_eval(x_9);
x_11 = l_Expr_reassoc(x_9);
lean_dec(x_9);
x_12 = l_Expr_constFolding(x_11);
x_13 = l_Expr_eval(x_12);
lean_dec(x_12);
x_14 = l_Nat_repr(x_10);
x_15 = l___private_Init_Data_Format_Basic_0__Std_Format_be___closed__1;
x_16 = lean_string_append(x_14, x_15);
x_17 = l_Nat_repr(x_13);
x_18 = lean_string_append(x_16, x_17);
lean_dec(x_17);
x_19 = l_IO_println___at_Lean_instEval___spec__1(x_18, x_2);
if (lean_obj_tag(x_19) == 0)
{
uint8_t x_20; 
x_20 = !lean_is_exclusive(x_19);
if (x_20 == 0)
{
lean_object* x_21; lean_object* x_22; 
x_21 = lean_ctor_get(x_19, 0);
lean_dec(x_21);
x_22 = l_main___boxed__const__2;
lean_ctor_set(x_19, 0, x_22);
return x_19;
}
else
{
lean_object* x_23; lean_object* x_24; lean_object* x_25; 
x_23 = lean_ctor_get(x_19, 1);
lean_inc(x_23);
lean_dec(x_19);
x_24 = l_main___boxed__const__2;
x_25 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_25, 0, x_24);
lean_ctor_set(x_25, 1, x_23);
return x_25;
}
}
else
{
uint8_t x_26; 
x_26 = !lean_is_exclusive(x_19);
if (x_26 == 0)
{
return x_19;
}
else
{
lean_object* x_27; lean_object* x_28; lean_object* x_29; 
x_27 = lean_ctor_get(x_19, 0);
x_28 = lean_ctor_get(x_19, 1);
lean_inc(x_28);
lean_inc(x_27);
lean_dec(x_19);
x_29 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_29, 0, x_27);
lean_ctor_set(x_29, 1, x_28);
return x_29;
}
}
}
else
{
lean_object* x_30; lean_object* x_31; 
lean_dec(x_5);
lean_dec(x_1);
x_30 = l_main___boxed__const__1;
x_31 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_31, 0, x_30);
lean_ctor_set(x_31, 1, x_2);
return x_31;
}
}
}
}
lean_object* initialize_Init(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_const__fold(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_Expr_mkExpr___closed__1 = _init_l_Expr_mkExpr___closed__1();
lean_mark_persistent(l_Expr_mkExpr___closed__1);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
l_main___boxed__const__2 = _init_l_main___boxed__const__2();
lean_mark_persistent(l_main___boxed__const__2);
return lean_io_result_mk_ok(lean_box(0));
}
void lean_initialize_runtime_module();

  #if defined(WIN32) || defined(_WIN32)
  #include <windows.h>
  #endif

  int main(int argc, char ** argv) {
  #if defined(WIN32) || defined(_WIN32)
  SetErrorMode(SEM_FAILCRITICALERRORS);
  #endif
  lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_const__fold(lean_io_mk_world());
lean_io_mark_end_initialization();
if (lean_io_result_is_ok(res)) {
lean_dec_ref(res);
lean_init_task_manager();
in = lean_box(0);
int i = argc;
while (i > 1) {
 lean_object* n;
 i--;
 n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
 in = n;
}
res = _lean_main(in, lean_io_mk_world());
}
if (lean_io_result_is_ok(res)) {
  int ret = lean_unbox(lean_io_result_get_value(res));
  lean_dec_ref(res);
  return ret;
} else {
  lean_io_result_show_error(res);
  lean_dec_ref(res);
  return 1;
}
}
#ifdef __cplusplus
}
#endif
