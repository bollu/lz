// Lean compiler output
// Module: Test.sort
// Imports: Init.Default
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>


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
lean_object* l_sort(lean_object*);
lean_object* l_isSorted___boxed(lean_object*);
lean_object* l_mkList;
lean_object* l_main___boxed__const__1;
uint8_t l_isSorted(lean_object*);
lean_object* l_addElement(lean_object*, lean_object*);
lean_object* l_isSorted___main___boxed(lean_object*);
lean_object* l_sort___main(lean_object*);
lean_object* l_mkList___closed__1;
uint8_t l_isSorted___main(lean_object*);
lean_object* l_L_Inhabited;
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);


lean_object* l_make_x27___main(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; uint8_t x_4;
x_3 = lean_unsigned_to_nat(0u);
x_4 = lean_nat_dec_eq(x_2, x_3);
if (x_4 == 0)
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9;
x_5 = lean_nat_sub(x_1, x_2);
x_6 = lean_unsigned_to_nat(1u);
x_7 = lean_nat_sub(x_2, x_6);
x_8 = l_make_x27___main(x_1, x_7);
lean_dec(x_7);
alloc_counter++;

x_9 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_9, 0, x_5);
lean_ctor_set(x_9, 1, x_8);
return x_9;
}
else
{
lean_object* x_10; lean_object* x_11;
x_10 = lean_box(0);
alloc_counter++;

x_11 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_11, 0, x_1);
lean_ctor_set(x_11, 1, x_10);
return x_11;
}
}
}
lean_object* l_make_x27___main___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
x_3 = l_make_x27___main(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
lean_object* l_make_x27(lean_object* x_1, lean_object* x_2) {
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
lean_object* x_3;
x_3 = l_make_x27(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
lean_object* l_make(lean_object* x_1) {
_start:
{
lean_object* x_2;
lean_inc(x_1);
x_2 = l_make_x27___main(x_1, x_1);
lean_dec(x_1);
return x_2;
}
}

lean_object* _init_l_L_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}
lean_object* l_addElement(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
alloc_counter++;

x_3 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
lean_object* _init_l_mkList___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3;
x_1 = lean_unsigned_to_nat(1u);
x_2 = lean_box(0);
alloc_counter++;

x_3 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
lean_object* _init_l_mkList() {
_start:
{
lean_object* x_1;
x_1 = l_mkList___closed__1;
return x_1;
}
}
uint8_t l_isSorted___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
uint8_t x_2;
x_2 = 1;
return x_2;
}
else
{
lean_object* x_3;
x_3 = lean_ctor_get(x_1, 1);
if (lean_obj_tag(x_3) == 0)
{
uint8_t x_4;
x_4 = 1;
return x_4;
}
else
{
lean_object* x_5; lean_object* x_6; uint8_t x_7;
x_5 = lean_ctor_get(x_1, 0);
x_6 = lean_ctor_get(x_3, 0);
x_7 = lean_nat_dec_lt(x_5, x_6);
if (x_7 == 0)
{
uint8_t x_8;
x_8 = 0;
return x_8;
}
else
{
x_1 = x_3;
goto _start;
}
}
}
}
}
lean_object* l_isSorted___main___boxed(lean_object* x_1) {
_start:
{
uint8_t x_2; lean_object* x_3;
x_2 = l_isSorted___main(x_1);
lean_dec(x_1);
x_3 = lean_box(x_2);
return x_3;
}
}
uint8_t l_isSorted(lean_object* x_1) {
_start:
{
uint8_t x_2;
x_2 = l_isSorted___main(x_1);
return x_2;
}
}
lean_object* l_isSorted___boxed(lean_object* x_1) {
_start:
{
uint8_t x_2; lean_object* x_3;
x_2 = l_isSorted(x_1);
lean_dec(x_1);
x_3 = lean_box(x_2);
return x_3;
}
}
lean_object* l_sort___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
return x_1;
}
else
{
lean_object* x_2;
x_2 = lean_ctor_get(x_1, 1);
lean_inc(x_2);
if (lean_obj_tag(x_2) == 0)
{
return x_1;
}
else
{
uint8_t x_3;
x_3 = !lean_is_exclusive(x_1);
if (x_3 == 0)
// if (false)
{
lean_object* x_4; lean_object* x_5; uint8_t x_6;
x_4 = lean_ctor_get(x_1, 0);
x_5 = lean_ctor_get(x_1, 1);
lean_dec(x_5);
x_6 = !lean_is_exclusive(x_2);
if (x_6 == 0)
// if (false)
{
lean_object* x_7; lean_object* x_8; uint8_t x_9;
x_7 = lean_ctor_get(x_2, 0);
x_8 = lean_ctor_get(x_2, 1);
x_9 = lean_nat_dec_lt(x_7, x_4);
if (x_9 == 0)
{
lean_object* x_10;
x_10 = l_sort___main(x_8);
lean_ctor_set(x_2, 1, x_10);
return x_1;
}
else
{
lean_object* x_11;
x_11 = l_sort___main(x_8);
lean_ctor_set(x_2, 1, x_11);
lean_ctor_set(x_2, 0, x_4);
lean_ctor_set(x_1, 0, x_7);
return x_1;
}
}
else
{
lean_object* x_12; lean_object* x_13; uint8_t x_14;
x_12 = lean_ctor_get(x_2, 0);
x_13 = lean_ctor_get(x_2, 1);
lean_inc(x_13);
lean_inc(x_12);
lean_dec(x_2);
x_14 = lean_nat_dec_lt(x_12, x_4);
if (x_14 == 0)
{
lean_object* x_15; lean_object* x_16;
x_15 = l_sort___main(x_13);
alloc_counter++;

x_16 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_16, 0, x_12);
lean_ctor_set(x_16, 1, x_15);
lean_ctor_set(x_1, 1, x_16);
return x_1;
}
else
{
lean_object* x_17; lean_object* x_18;
x_17 = l_sort___main(x_13);
alloc_counter++;

x_18 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_18, 0, x_4);
lean_ctor_set(x_18, 1, x_17);
lean_ctor_set(x_1, 1, x_18);
lean_ctor_set(x_1, 0, x_12);
return x_1;
}
}
}
else
{
lean_object* x_19; lean_object* x_20; lean_object* x_21; lean_object* x_22; uint8_t x_23;
x_19 = lean_ctor_get(x_1, 0);
lean_inc(x_19);
lean_dec(x_1);
x_20 = lean_ctor_get(x_2, 0);
lean_inc(x_20);
x_21 = lean_ctor_get(x_2, 1);
lean_inc(x_21);
if (lean_is_exclusive(x_2)) {
 lean_ctor_release(x_2, 0);
 lean_ctor_release(x_2, 1);
 x_22 = x_2;
} else {
 lean_dec_ref(x_2);
 x_22 = lean_box(0);
}
x_23 = lean_nat_dec_lt(x_20, x_19);
if (x_23 == 0)
{
lean_object* x_24; lean_object* x_25; lean_object* x_26;
x_24 = l_sort___main(x_21);
if (lean_is_scalar(x_22)) {
  alloc_counter++;

 x_25 = lean_alloc_ctor(1, 2, 0);
} else {
 x_25 = x_22;
}
lean_ctor_set(x_25, 0, x_20);
lean_ctor_set(x_25, 1, x_24);
alloc_counter++;

x_26 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_26, 0, x_19);
lean_ctor_set(x_26, 1, x_25);
return x_26;
}
else
{
lean_object* x_27; lean_object* x_28; lean_object* x_29;
x_27 = l_sort___main(x_21);
if (lean_is_scalar(x_22)) {
  alloc_counter++;

 x_28 = lean_alloc_ctor(1, 2, 0);
} else {
 x_28 = x_22;
}
lean_ctor_set(x_28, 0, x_19);
lean_ctor_set(x_28, 1, x_27);
alloc_counter++;

x_29 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_29, 0, x_20);
lean_ctor_set(x_29, 1, x_28);
return x_29;
}
}
}
}
}
}
lean_object* l_sort(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_sort___main(x_1);
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
lean_object* initialize_Test_sort(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Default(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_L_Inhabited = _init_l_L_Inhabited();
lean_mark_persistent(l_L_Inhabited);
l_mkList___closed__1 = _init_l_mkList___closed__1();
lean_mark_persistent(l_mkList___closed__1);
l_mkList = _init_l_mkList();
lean_mark_persistent(l_mkList);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_sort(lean_io_mk_world());
lean_io_mark_end_initialization();
if (lean_io_result_is_ok(res)) {
lean_dec_ref(res);
lean_init_task_manager();
in = lean_box(0);
int i = argc;
while (i > 1) {
 lean_object* n;
 i--;
 alloc_counter++;

 n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
 in = n;
}
res = _lean_main(in, lean_io_mk_world());
}


// srand(time(NULL));
// int r;
// lean_object *list = l_mkList;
// for (int i = 0; i < 1000;++i){
//    r = rand() % 1000;
//    l_addElement(lean_box(r),list);
// }
int n = 10000;
lean_object *list = l_make(lean_box(n));
lean_object* sorted_list = list;
for(int i = 0; i < n; ++i){
  sorted_list = l_sort(sorted_list);
}
// int s = lean_obj_tag(sorted);
printf("%d\n",alloc_counter);
}
#ifdef __cplusplus
}
#endif
