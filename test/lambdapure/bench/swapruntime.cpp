// Lean compiler output
// Module: Test.bintree
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
int alloc_counter = 0;
lean_object* _lean_main(lean_object*, lean_object*);
lean_object* l_swap___main(lean_object*);
lean_object* l_makeTreeWithDepth(lean_object*);
lean_object* l_main___boxed__const__1;
lean_object* l_make___main(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_make___boxed(lean_object*);
lean_object* l_Tree_Inhabited;
lean_object* l_make___main___boxed(lean_object*);
lean_object* l_swap(lean_object*);
lean_object* l_makeTreeWithDepth___boxed(lean_object*);
lean_object* l_make(lean_object*);
lean_object* _init_l_Tree_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}


lean_object* cut_dot__main( lean_object* arg0){
int x_34 = lean_obj_tag(arg0);
switch(x_34){
case 0:
{
return arg0;
}
case 1:
{
if(lean_is_exclusive(arg0)){
lean_object* x_38 = lean_ctor_get(arg0, 0);
lean_object* x_39 = cut_dot__main(x_38);
lean_object* x_40 = arg0;
lean_ctor_set(x_40, 0, x_39);
lean_ctor_set_tag(arg0,2);
return x_40;
}else{
lean_object* x_43 = lean_ctor_get(arg0, 0);
lean_inc(x_43);
lean_object* x_45 = cut_dot__main(x_43);
lean_inc(x_45);
lean_object* x_47 = lean_alloc_ctor(2,1,0);
lean_ctor_set(x_47, 0, x_45);
lean_inc(x_47);
lean_dec(arg0);
return x_47;
}
}
default:
{
return arg0;
}
}
}

lean_object* swap_dot__main( lean_object* arg0){
int x_2 = lean_obj_tag(arg0);
switch(x_2){
case 0:
{
return arg0;
}
case 1:
{
if(lean_is_exclusive(arg0)){
lean_object* x_6 = lean_ctor_get(arg0, 0);
lean_object* x_7 = lean_ctor_get(arg0, 1);
lean_object* x_8 = swap_dot__main(x_7);
lean_object* x_9 = swap_dot__main(x_6);
lean_object* x_10 = arg0;
lean_ctor_set(x_10, 0, x_8);
lean_ctor_set(x_10, 1, x_9);
return x_10;
}else{
lean_object* x_14 = lean_ctor_get(arg0, 0);
lean_object* x_15 = lean_ctor_get(arg0, 1);
lean_inc(x_15);
lean_object* x_17 = swap_dot__main(x_15);
lean_inc(x_14);
lean_object* x_19 = swap_dot__main(x_14);
lean_inc(x_17);
lean_inc(x_19);
lean_object* x_22 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_22, 0, x_17);
lean_ctor_set(x_22, 1, x_19);
lean_inc(x_22);
lean_dec(arg0);
return x_22;
}
}
default:
{
return arg0;
}
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
lean_dec(x_5);
lean_inc(x_6);
alloc_counter++;

x_7 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_7, 0, x_6);
lean_ctor_set(x_7, 1, x_6);
return x_7;
}
else
{
lean_object* x_8;
x_8 = lean_box(0);
return x_8;
}
}
}
lean_object* l_make___main___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_make___main(x_1);
lean_dec(x_1);
return x_2;
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
lean_object* l_make___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_make(x_1);
lean_dec(x_1);
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
lean_object* l_makeTreeWithDepth___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_makeTreeWithDepth(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_swap___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
return x_1;
}
else
{
printf("got to swap\n" );
uint8_t x_2;
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)
{
printf("exclusive\n" );
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6;
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_swap___main(x_4);
x_6 = l_swap___main(x_3);
lean_ctor_set(x_1, 1, x_6);
lean_ctor_set(x_1, 0, x_5);
return x_1;
}
else
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11;
x_7 = lean_ctor_get(x_1, 0);
x_8 = lean_ctor_get(x_1, 1);
lean_inc(x_8);
lean_inc(x_7);
lean_dec(x_1);
x_9 = l_swap___main(x_8);
x_10 = l_swap___main(x_7);
alloc_counter++;

x_11 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_11, 0, x_9);
lean_ctor_set(x_11, 1, x_10);
return x_11;
}
}
}
}
lean_object* l_swap(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_swap___main(x_1);
return x_2;
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
lean_object* initialize_Test_bintree(lean_object* w) {
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
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_bintree(lean_io_mk_world());
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

// lean_object* tree = l_makeTreeWithDepth___boxed(lean_box(20));
// // lean_object* new_tree = swap_dot__main(tree);
// lean_object* new_tree = cut_dot__main(tree);

printf("alloc_counter: %d\n", alloc_counter);

struct timeval begin, end;
gettimeofday(&begin, 0);
lean_object* tree = l_makeTreeWithDepth___boxed(lean_box(100));
// lean_object* new_tree = swap_dot__main(tree);
lean_object* new_tree = cut_dot__main(tree);
//
// for(int i = 0 ; i < 1000; ++i){
//   new_tree = swap_dot__main(new_tree);
// }
gettimeofday(&end, 0);
long microseconds = end.tv_usec - begin.tv_usec;
//
printf("runtime : %d\n",microseconds/1000);

}
#ifdef __cplusplus
}
#endif
