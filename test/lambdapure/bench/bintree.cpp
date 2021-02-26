// Lean compiler output
// Module: Test.minheap
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
lean_object* l_main___boxed__const__1;
lean_object* l_Tree_Inhabited;
lean_object* l_insert___main(lean_object*, lean_object*);
lean_object* l_insert(lean_object*, lean_object*);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* _init_l_Tree_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}
lean_object* l_insert___main(lean_object* x_1, lean_object* x_2) {
_start:
{
if (lean_obj_tag(x_2) == 0)
{
lean_object* x_3;
alloc_counter++;
x_3 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
lean_ctor_set(x_3, 2, x_2);
return x_3;
}
else
{
lean_object* x_4;
x_4 = lean_ctor_get(x_2, 1);
lean_inc(x_4);
if (lean_obj_tag(x_4) == 0)
{
lean_object* x_5;
x_5 = lean_ctor_get(x_2, 2);
lean_inc(x_5);
if (lean_obj_tag(x_5) == 0)
{
uint8_t x_6;
x_6 = !lean_is_exclusive(x_2);
// if (x_6 == 0)
if(false)
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; uint8_t x_10;
x_7 = lean_ctor_get(x_2, 0);
x_8 = lean_ctor_get(x_2, 2);
lean_dec(x_8);
x_9 = lean_ctor_get(x_2, 1);
lean_dec(x_9);
x_10 = lean_nat_dec_lt(x_7, x_1);
if (x_10 == 0)
{
lean_object* x_11;
lean_ctor_set(x_2, 1, x_5);
lean_ctor_set(x_2, 0, x_1);
alloc_counter++;
x_11 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_11, 0, x_7);
lean_ctor_set(x_11, 1, x_2);
lean_ctor_set(x_11, 2, x_5);
return x_11;
}
else
{
lean_object* x_12;
lean_ctor_set(x_2, 1, x_5);
lean_ctor_set(x_2, 0, x_1);
alloc_counter++;

x_12 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_12, 0, x_7);
lean_ctor_set(x_12, 1, x_5);
lean_ctor_set(x_12, 2, x_2);
return x_12;
}
}
else
{
lean_object* x_13; uint8_t x_14;
x_13 = lean_ctor_get(x_2, 0);
lean_inc(x_13);
lean_dec(x_2);
x_14 = lean_nat_dec_lt(x_13, x_1);
if (x_14 == 0)
{
lean_object* x_15; lean_object* x_16;
alloc_counter++;

x_15 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_15, 0, x_1);
lean_ctor_set(x_15, 1, x_5);
lean_ctor_set(x_15, 2, x_5);
alloc_counter++;

x_16 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_16, 0, x_13);
lean_ctor_set(x_16, 1, x_15);
lean_ctor_set(x_16, 2, x_5);
return x_16;
}
else
{
lean_object* x_17; lean_object* x_18;
alloc_counter++;

x_17 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_17, 0, x_1);
lean_ctor_set(x_17, 1, x_5);
lean_ctor_set(x_17, 2, x_5);
alloc_counter++;

x_18 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_18, 0, x_13);
lean_ctor_set(x_18, 1, x_5);
lean_ctor_set(x_18, 2, x_17);
return x_18;
}
}
}
else
{
uint8_t x_19;
x_19 = !lean_is_exclusive(x_2);
// if (x_19 == 0)

if(false)
{

lean_object* x_20; lean_object* x_21; lean_object* x_22; uint8_t x_23;
x_20 = lean_ctor_get(x_2, 0);
x_21 = lean_ctor_get(x_2, 2);
lean_dec(x_21);
x_22 = lean_ctor_get(x_2, 1);
lean_dec(x_22);
x_23 = lean_nat_dec_lt(x_1, x_20);
if (x_23 == 0)
{
lean_free_object(x_2);
lean_dec(x_20);
x_2 = x_5;
goto _start;
}
else
{
lean_object* x_25;
lean_ctor_set(x_2, 2, x_4);
lean_ctor_set(x_2, 0, x_1);
alloc_counter++;

x_25 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_25, 0, x_20);
lean_ctor_set(x_25, 1, x_2);
lean_ctor_set(x_25, 2, x_5);
return x_25;
}
}
else
{
lean_object* x_26; uint8_t x_27;
x_26 = lean_ctor_get(x_2, 0);
lean_inc(x_26);
lean_dec(x_2);
x_27 = lean_nat_dec_lt(x_1, x_26);
if (x_27 == 0)
{
lean_dec(x_26);
x_2 = x_5;
goto _start;
}
else
{
lean_object* x_29; lean_object* x_30;
alloc_counter++;

x_29 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_29, 0, x_1);
lean_ctor_set(x_29, 1, x_4);
lean_ctor_set(x_29, 2, x_4);
alloc_counter++;

x_30 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_30, 0, x_26);
lean_ctor_set(x_30, 1, x_29);
lean_ctor_set(x_30, 2, x_5);
return x_30;
}
}
}
}
else
{
lean_object* x_31;
x_31 = lean_ctor_get(x_2, 2);
lean_inc(x_31);
if (lean_obj_tag(x_31) == 0)
{
uint8_t x_32;
x_32 = !lean_is_exclusive(x_2);
// if (x_32 == 0)
if(false)
{

lean_object* x_33; lean_object* x_34; lean_object* x_35; uint8_t x_36;
x_33 = lean_ctor_get(x_2, 0);
x_34 = lean_ctor_get(x_2, 2);
lean_dec(x_34);
x_35 = lean_ctor_get(x_2, 1);
lean_dec(x_35);
x_36 = lean_nat_dec_lt(x_33, x_1);
if (x_36 == 0)
{
lean_free_object(x_2);
lean_dec(x_33);
x_2 = x_4;
goto _start;
}
else
{
lean_object* x_38;
lean_ctor_set(x_2, 1, x_31);
lean_ctor_set(x_2, 0, x_1);
alloc_counter++;

x_38 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_38, 0, x_33);
lean_ctor_set(x_38, 1, x_4);
lean_ctor_set(x_38, 2, x_2);
return x_38;
}
}
else
{
lean_object* x_39; uint8_t x_40;
x_39 = lean_ctor_get(x_2, 0);
lean_inc(x_39);
lean_dec(x_2);
x_40 = lean_nat_dec_lt(x_39, x_1);
if (x_40 == 0)
{
lean_dec(x_39);
x_2 = x_4;
goto _start;
}
else
{
lean_object* x_42; lean_object* x_43;
alloc_counter++;

x_42 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_42, 0, x_1);
lean_ctor_set(x_42, 1, x_31);
lean_ctor_set(x_42, 2, x_31);
alloc_counter++;

x_43 = lean_alloc_ctor(1, 3, 0);
lean_ctor_set(x_43, 0, x_39);
lean_ctor_set(x_43, 1, x_4);
lean_ctor_set(x_43, 2, x_42);
return x_43;
}
}
}
else
{
lean_object* x_44; uint8_t x_45;
x_44 = lean_ctor_get(x_2, 0);
lean_inc(x_44);
lean_dec(x_2);
x_45 = lean_nat_dec_lt(x_44, x_1);
lean_dec(x_44);
if (x_45 == 0)
{
lean_dec(x_31);
x_2 = x_4;
goto _start;
}
else
{
lean_dec(x_4);
x_2 = x_31;
goto _start;
}
}
}
}
}
}
lean_object* l_insert(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
x_3 = l_insert___main(x_1, x_2);
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
alloc_counter++;

x_4 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_4, 0, x_3);
lean_ctor_set(x_4, 1, x_2);
return x_4;
}
}
lean_object* initialize_Init_Default(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_Test_minheap(lean_object* w) {
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
res = initialize_Test_minheap(lean_io_mk_world());
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
lean_object* tree = _init_l_Tree_Inhabited();
srand(time(NULL));
int r;
int n = 5000;
for(int i = 0; i < n; ++i){
  r = rand() % 100000;
  tree = l_insert(lean_box(r),tree);
}
printf("alloc_counter: %d\n",alloc_counter );
}
#ifdef __cplusplus
}
#endif
