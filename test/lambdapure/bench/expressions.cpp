// Lean compiler output
// Module: Test.expressions
// Imports: Init.Default
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
int alloc_counter = 0;
lean_object* _lean_main(lean_object*, lean_object*);
lean_object* l_const__fold(lean_object*);
lean_object* l_Expr_Inhabited___closed__1;
lean_object* l_mkExpr(lean_object*);
lean_object* l_main___boxed__const__1;
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_Expr_Inhabited;
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* l_mkExpr___main(lean_object*);
lean_object* _init_l_Expr_Inhabited___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2;
x_1 = lean_unsigned_to_nat(0u);
alloc_counter++;

x_2 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
lean_object* _init_l_Expr_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = l_Expr_Inhabited___closed__1;
return x_1;
}
}
lean_object* l_mkExpr___main(lean_object* x_1) {
_start:
{
lean_object* x_2; uint8_t x_3;
x_2 = lean_unsigned_to_nat(0u);
x_3 = lean_nat_dec_eq(x_1, x_2);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8;
lean_inc(x_1);
alloc_counter++;

x_4 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_4, 0, x_1);
x_5 = lean_unsigned_to_nat(1u);
x_6 = lean_nat_sub(x_1, x_5);
lean_dec(x_1);
x_7 = l_mkExpr___main(x_6);
alloc_counter++;

x_8 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_8, 0, x_4);
lean_ctor_set(x_8, 1, x_7);
return x_8;
}
else
{
lean_object* x_9;
lean_dec(x_1);
x_9 = l_Expr_Inhabited___closed__1;
return x_9;
}
}
}
lean_object* l_mkExpr(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_mkExpr___main(x_1);
return x_2;
}
}
lean_object* l_const__fold(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
return x_1;
}
case 1:
{
lean_object* x_2;
x_2 = lean_ctor_get(x_1, 0);
lean_inc(x_2);
if (lean_obj_tag(x_2) == 0)
{
lean_object* x_3;
x_3 = lean_ctor_get(x_1, 1);
lean_inc(x_3);
if (lean_obj_tag(x_3) == 0)
{
lean_object* x_4; uint8_t x_5;
lean_dec(x_1);
x_4 = lean_ctor_get(x_2, 0);
lean_inc(x_4);
lean_dec(x_2);
x_5 = !lean_is_exclusive(x_3);
if (x_5 == 0)
// if(false)
{
  printf("exlcusive\n" );

lean_object* x_6; lean_object* x_7;
x_6 = lean_ctor_get(x_3, 0);
x_7 = lean_nat_add(x_4, x_6);
lean_dec(x_6);
lean_dec(x_4);
lean_ctor_set(x_3, 0, x_7);
return x_3;
}
else
{
printf("not-exlcusive\n" );

lean_object* x_8; lean_object* x_9; lean_object* x_10;
x_8 = lean_ctor_get(x_3, 0);
lean_inc(x_8);
lean_dec(x_3);
x_9 = lean_nat_add(x_4, x_8);
lean_dec(x_8);
lean_dec(x_4);
alloc_counter++;
x_10 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_10, 0, x_9);
return x_10;
}
}
else
{
lean_dec(x_3);
lean_dec(x_2);
return x_1;
}
}
else
{
lean_dec(x_2);
return x_1;
}
}
default:
{
lean_object* x_11;
x_11 = lean_ctor_get(x_1, 0);
lean_inc(x_11);
if (lean_obj_tag(x_11) == 0)
{
lean_object* x_12;
x_12 = lean_ctor_get(x_1, 1);
lean_inc(x_12);
if (lean_obj_tag(x_12) == 0)
{
lean_object* x_13; uint8_t x_14;
lean_dec(x_1);
x_13 = lean_ctor_get(x_11, 0);
lean_inc(x_13);
lean_dec(x_11);
x_14 = !lean_is_exclusive(x_12);
if (x_14 == 0)
{
lean_object* x_15; lean_object* x_16;
x_15 = lean_ctor_get(x_12, 0);
x_16 = lean_nat_mul(x_13, x_15);
lean_dec(x_15);
lean_dec(x_13);
lean_ctor_set(x_12, 0, x_16);
return x_12;
}
else
{
lean_object* x_17; lean_object* x_18; lean_object* x_19;
x_17 = lean_ctor_get(x_12, 0);
lean_inc(x_17);
lean_dec(x_12);
x_18 = lean_nat_mul(x_13, x_17);
lean_dec(x_17);
lean_dec(x_13);
alloc_counter++;

x_19 = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(x_19, 0, x_18);
return x_19;
}
}
else
{
lean_dec(x_12);
lean_dec(x_11);
return x_1;
}
}
else
{
lean_dec(x_11);
return x_1;
}
}
}
}
}
lean_object* _init_l_main___boxed__const__1() {
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
lean_object* x_3; lean_object* x_4;
lean_dec(x_1);
x_3 = l_main___boxed__const__1;
alloc_counter++;

x_4 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_4, 0, x_3);
lean_ctor_set(x_4, 1, x_2);
return x_4;
}
}
lean_object* initialize_Init_Default(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_Test_expressions(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Default(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_Expr_Inhabited___closed__1 = _init_l_Expr_Inhabited___closed__1();
lean_mark_persistent(l_Expr_Inhabited___closed__1);
l_Expr_Inhabited = _init_l_Expr_Inhabited();
lean_mark_persistent(l_Expr_Inhabited);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_expressions(lean_io_mk_world());
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
lean_object* expr = l_mkExpr(lean_box(10));
lean_object* folded = l_const__fold(expr);
printf("%d\n",alloc_counter );
}
#ifdef __cplusplus
}
#endif
