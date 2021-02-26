// Lean compiler output
// Module: Test.treemap
// Imports: Init.Default
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

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
lean_object* _lean_main(lean_object*, lean_object*);
lean_object* l_mapTree___main(lean_object*, lean_object*);
lean_object* l_makeTreeWithDepth(lean_object*);
lean_object* l_main___boxed__const__1;
lean_object* l_make___main(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_Tree_Inhabited;
lean_object* l_mapTree(lean_object*, lean_object*);
lean_object* l_make(lean_object*);
lean_object* _init_l_Tree_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}
lean_object* l_make___main(lean_object* x_1) {
_start:
{
lean_object* x_2; uint8_t x_3;
x_2 = lean_unsigned_to_nat(0u);
x_3 = lean_nat_dec_eq(x_1, x_2);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7;
x_4 = lean_unsigned_to_nat(1u);
x_5 = lean_nat_sub(x_1, x_4);
x_6 = l_make___main(x_5);
lean_inc(x_6);
x_7 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_7, 0, x_1);
lean_ctor_set(x_7, 1, x_6);
lean_ctor_set(x_7, 2, x_6);
return x_7;
}
else
{
lean_object* x_8;
lean_dec(x_1);
x_8 = lean_box(0);
return x_8;
}
}
}
lean_object* l_make(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_make___main(x_1);
return x_2;
}
}
lean_object* l_makeTreeWithDepth(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_make___main(x_1);
return x_2;
}
}
lean_object* l_mapTree___main(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
lean_dec(x_1);
return x_2;
}
else
{
uint8_t x_3;
x_3 = !lean_is_exclusive(x_2);
if (x_3 == 0)
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9;
x_4 = lean_ctor_get(x_2, 0);
printf("exlcusive%d\n", lean_unbox(x_4));
x_5 = lean_ctor_get(x_2, 1);
lean_dec_ref(x_5);
x_6 = lean_ctor_get(x_2, 2);
lean_inc(x_1);
x_7 = lean_apply_1(x_1, x_4);
lean_inc(x_1);
x_8 = l_mapTree___main(x_1, x_5);
// x_9 = l_mapTree___main(x_1, x_6);
lean_ctor_set(x_2, 2, x_9);
lean_ctor_set(x_2, 1, x_8);
lean_ctor_set(x_2, 0, x_7);
return x_2;
}
else
{
lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16;
x_10 = lean_ctor_get(x_2, 0);
printf("not exlcusive%d\n", lean_unbox(x_10));

x_11 = lean_ctor_get(x_2, 1);
x_12 = lean_ctor_get(x_2, 2);
lean_inc(x_12);
lean_inc(x_11);
lean_inc(x_10);
lean_dec(x_2);
lean_inc(x_1);
x_13 = lean_apply_1(x_1, x_10);
lean_inc(x_1);
x_14 = l_mapTree___main(x_1, x_11);
x_15 = l_mapTree___main(x_1, x_12);
x_16 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_16, 0, x_13);
lean_ctor_set(x_16, 1, x_14);
lean_ctor_set(x_16, 2, x_15);
return x_16;
}
}
}
}
lean_object* l_mapTree(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
x_3 = l_mapTree___main(x_1, x_2);
return x_3;
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
x_4 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_4, 0, x_3);
lean_ctor_set(x_4, 1, x_2);
return x_4;
}
}
lean_object* initialize_Init_Default(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_Test_treemap(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Default(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_Tree_Inhabited = _init_l_Tree_Inhabited();
lean_mark_persistent(l_Tree_Inhabited);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}
lean_object* mapTree_dot__main( lean_object* arg0, lean_object* arg1){
int x_2 = lean_obj_tag(arg1);
switch(x_2){
case 0:
{
lean_dec(arg0);
return arg1;
}
default:
{
if(lean_is_exclusive(arg1)){
lean_object* x_7 = lean_ctor_get(arg1, 0);
lean_object* x_8 = lean_ctor_get(arg1, 1);
lean_object* x_9 = lean_ctor_get(arg1, 2);
lean_object* x_10 = lean_apply_1(arg0, x_7);
lean_inc(arg0);
lean_object* x_12 = mapTree_dot__main(arg0, x_8);
lean_inc(arg0);
lean_object* x_14 = mapTree_dot__main(arg0, x_9);
lean_object* x_15 = arg1;
lean_ctor_set(x_15, 0, x_10);
lean_ctor_set(x_15, 1, x_12);
lean_ctor_set(x_15, 2, x_14);
return x_15;
}else{
lean_object* x_20 = lean_ctor_get(arg1, 0);
lean_object* x_21 = lean_ctor_get(arg1, 1);
lean_object* x_22 = lean_ctor_get(arg1, 2);
lean_inc(x_20);
lean_object* x_24 = lean_apply_1(arg0, x_20);
lean_inc(arg0);
lean_inc(x_21);
lean_object* x_27 = mapTree_dot__main(arg0, x_21);
lean_inc(arg0);
lean_inc(x_22);
lean_object* x_30 = mapTree_dot__main(arg0, x_22);
lean_inc(x_24);
lean_inc(x_27);
lean_inc(x_30);
lean_object* x_34 = lean_alloc_ctor(1,3,0);
lean_ctor_set(x_34, 0, x_24);
lean_ctor_set(x_34, 1, x_27);
lean_ctor_set(x_34, 2, x_30);
lean_dec(arg1);
return x_34;
}
}
}
}
lean_object* add_one(lean_object* x_1) {
lean_object* x_2; lean_object* x_3;
x_2 = lean_unsigned_to_nat(1u);
x_3 = lean_nat_add(x_1, x_2);
return x_3;
}

void lean_initialize_runtime_module();


int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_treemap(lean_io_mk_world());
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



lean_object* tree = l_makeTreeWithDepth(lean_box(3));
lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
// lea
lean_object* new_tree;
new_tree = l_mapTree___main(closure, tree);


}
#ifdef __cplusplus
}
#endif
