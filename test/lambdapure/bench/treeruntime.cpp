
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

#include <bits/stdc++.h>
#include <time.h>
#include <stdlib.h>

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
lean_object* l_main___boxed__const__1;
uint32_t l_UInt32_add(uint32_t, uint32_t);
lean_object* l_walk___main(lean_object*);
uint32_t l_UInt32_sub(uint32_t, uint32_t);
lean_object* l_make___boxed(lean_object*);
lean_object* l_Tree_Inhabited;
lean_object* l_make_x27___main___closed__1;
uint8_t l_UInt32_decEq(uint32_t, uint32_t);
lean_object* l_walk(lean_object*);
lean_object* l_swap(lean_object*);
lean_object* l_make_x27(uint32_t, uint32_t);
lean_object* l_make_x27___boxed(lean_object*, lean_object*);
lean_object* l_make(uint32_t);
lean_object* l_make_x27___main(uint32_t, uint32_t);
lean_object* l_make_x27___main___boxed(lean_object*, lean_object*);
lean_object* _init_l_Tree_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}
lean_object* _init_l_make_x27___main___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2;
x_1 = lean_box(0);
alloc_counter++;
x_2 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_2, 0, x_1);
lean_ctor_set(x_2, 1, x_1);
return x_2;
}
}
lean_object* l_make_x27___main(uint32_t x_1, uint32_t x_2) {
_start:
{
uint32_t x_3; uint8_t x_4;
x_3 = 0;
x_4 = x_2 == x_3;
if (x_4 == 0)
{
uint32_t x_5; uint32_t x_6; lean_object* x_7; uint32_t x_8; lean_object* x_9; lean_object* x_10;
x_5 = 1;
x_6 = x_2 - x_5;
x_7 = l_make_x27___main(x_1, x_6);
x_8 = x_1 + x_5;
x_9 = l_make_x27___main(x_8, x_6);
alloc_counter++;
x_10 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_10, 0, x_7);
lean_ctor_set(x_10, 1, x_9);
return x_10;
}
else
{
lean_object* x_11;
x_11 = l_make_x27___main___closed__1;
return x_11;
}
}
}
lean_object* l_make_x27___main___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint32_t x_3; uint32_t x_4; lean_object* x_5;
x_3 = lean_unbox_uint32(x_1);
lean_dec(x_1);
x_4 = lean_unbox_uint32(x_2);
lean_dec(x_2);
x_5 = l_make_x27___main(x_3, x_4);
return x_5;
}
}
lean_object* l_make_x27(uint32_t x_1, uint32_t x_2) {
_start:
{
lean_object* x_3;
x_3 = l_make_x27___main(x_1, x_2);
return x_3;
}
}
lean_object* l_make_x27___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint32_t x_3; uint32_t x_4; lean_object* x_5;
x_3 = lean_unbox_uint32(x_1);
lean_dec(x_1);
x_4 = lean_unbox_uint32(x_2);
lean_dec(x_2);
x_5 = l_make_x27(x_3, x_4);
return x_5;
}
}
lean_object* l_make(uint32_t x_1) {
_start:
{
lean_object* x_2;
x_2 = l_make_x27___main(x_1, x_1);
return x_2;
}
}
lean_object* l_make___boxed(lean_object* x_1) {
_start:
{
uint32_t x_2; lean_object* x_3;
x_2 = lean_unbox_uint32(x_1);
lean_dec(x_1);
x_3 = l_make(x_2);
return x_3;
}
}
lean_object* l_walk___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
return x_1;
}
else
{
uint8_t x_2;
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)

{
  printf("exclusive\n" );
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6;
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
lean_dec(x_4);
x_5 = l_walk___main(x_3);
x_6 = lean_box(0);
lean_ctor_set(x_1, 1, x_6);
lean_ctor_set(x_1, 0, x_5);
return x_1;
}
else
{
  printf("not exclusive\n" );

lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10;
x_7 = lean_ctor_get(x_1, 0);
lean_inc(x_7);
lean_dec(x_1);
x_8 = l_walk___main(x_7);
x_9 = lean_box(0);
alloc_counter++;
x_10 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_10, 0, x_8);
lean_ctor_set(x_10, 1, x_9);
return x_10;
}
}
}
}
lean_object* l_walk(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_walk___main(x_1);
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
uint8_t x_2;
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)
{
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
l_make_x27___main___closed__1 = _init_l_make_x27___main___closed__1();
lean_mark_persistent(l_make_x27___main___closed__1);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}


lean_object* swap_dot__main( lean_object* arg0){
int x_2 = lean_obj_tag(arg0);
switch(x_2){
case 0:
{
return arg0;
}
default:
{
  int e = lean_is_exclusive(arg0);
if(false){
// if(e){
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
alloc_counter++;
lean_object* x_22 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_22, 0, x_17);
lean_ctor_set(x_22, 1, x_19);
lean_inc(x_22);
lean_dec(arg0);
return x_22;
}
}
}
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
// struct timeval begin, end;

// gettimeofday(&begin, 0);
// clock_t begin = clock();
//
//

//
//
// clock_t end = clock();
// double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
// printf("%d\n", time_spent);
 // for(int i = 0; i < 10; i++){
 //   printf("%d\n",i );
 //   new_tree = swap_dot__main(tree);
 // }


// gettimeofday(&end, 0);
// long microseconds = end.tv_usec - begin.tv_usec;
// printf("%d\n",microseconds);
time_t start, end;
time(&start);
lean_object* tree = l_make(11);
lean_object* new_tree;
swap_dot__main(tree);
printf("alloc_counter:%d\n",alloc_counter );

// for(int i = 0; i < 100; i++){
//   printf("%d\n",i );
//   new_tree = swap_dot__main(tree);
// }
// ios_base::sync_with_stdio(false);
time(&end);

double time_taken = double(end - start);
printf("time:%d\n",time_taken );
}
#ifdef __cplusplus
}
#endif
