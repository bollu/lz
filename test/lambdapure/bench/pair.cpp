// Lean compiler output
// Module: Test.pair
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
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_fold(lean_object*);
lean_object* l_fold___main(lean_object*);
lean_object* l_make_x27(lean_object*, lean_object*);
lean_object* l_make_x27___boxed(lean_object*, lean_object*);
lean_object* l_make(lean_object*);
lean_object* l_L_Inhabited;
lean_object* l_make_x27___main(lean_object*, lean_object*);
lean_object* l_make_x27___main___boxed(lean_object*, lean_object*);
lean_object* fold_dot__main( lean_object* arg0){
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
lean_object* x_8 = fold_dot__main(x_7);
lean_object* x_9 = arg0;
lean_ctor_set(x_9, 0, x_6);
lean_ctor_set(x_9, 1, x_8);
lean_dec(x_6);
return x_9;
}else{
lean_object* x_14 = lean_ctor_get(arg0, 0);
lean_object* x_15 = lean_ctor_get(arg0, 1);
lean_inc(x_15);
lean_object* x_17 = fold_dot__main(x_15);
lean_inc(x_14);
lean_inc(x_17);
alloc_counter++;

lean_object* x_20 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_20, 0, x_14);
lean_ctor_set(x_20, 1, x_17);
lean_inc(x_20);
lean_dec(arg0);
return x_20;
}
}
default:
{
if(lean_is_exclusive(arg0)){
  // if (false){
lean_object* x_27 = lean_ctor_get(arg0, 0);
lean_object* x_28 = lean_ctor_get(arg0, 1);
lean_object* x_29 = lean_ctor_get(arg0, 2);
lean_object* x_30 = lean_nat_add(x_27, x_28);
lean_object* x_31 = fold_dot__main(x_29);
lean_object* x_32 = arg0;
lean_ctor_set(x_32, 0, x_30);
lean_ctor_set(x_32, 1, x_31);
return x_32;
}else{
lean_object* x_36 = lean_ctor_get(arg0, 0);
lean_object* x_37 = lean_ctor_get(arg0, 1);
lean_object* x_38 = lean_ctor_get(arg0, 2);
lean_inc(x_36);
lean_inc(x_37);
lean_object* x_41 = lean_nat_add(x_36, x_37);
lean_inc(x_38);
lean_object* x_43 = fold_dot__main(x_38);
lean_inc(x_41);
lean_inc(x_43);
alloc_counter++;

lean_object* x_46 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_46, 0, x_41);
lean_ctor_set(x_46, 1, x_43);
lean_inc(x_46);
lean_dec(arg0);
return x_46;
}
}
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
lean_inc(x_5);
alloc_counter++;
x_9 = lean_alloc_ctor(2, 3, 0);
lean_ctor_set(x_9, 0, x_5);
lean_ctor_set(x_9, 1, x_5);
lean_ctor_set(x_9, 2, x_8);
return x_9;
}
else
{
lean_object* x_10; lean_object* x_11;
x_10 = lean_box(0);
lean_inc(x_1);
alloc_counter++;

x_11 = lean_alloc_ctor(2, 3, 0);
lean_ctor_set(x_11, 0, x_1);
lean_ctor_set(x_11, 1, x_1);
lean_ctor_set(x_11, 2, x_10);
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
lean_object* l_fold___main(lean_object* x_1) {
_start:
{
switch (lean_obj_tag(x_1)) {
case 0:
{
return x_1;
}
case 1:
{
uint8_t x_2;
x_2 = !lean_is_exclusive(x_1);
if (x_2 == 0)
{
lean_object* x_3; lean_object* x_4;
x_3 = lean_ctor_get(x_1, 1);
x_4 = l_fold___main(x_3);
lean_ctor_set(x_1, 1, x_4);
return x_1;
}
else
{
lean_object* x_5; lean_object* x_6; lean_object* x_7; lean_object* x_8;
x_5 = lean_ctor_get(x_1, 0);
x_6 = lean_ctor_get(x_1, 1);
lean_inc(x_6);
lean_inc(x_5);
lean_dec(x_1);
x_7 = l_fold___main(x_6);
alloc_counter++;

x_8 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_8, 0, x_5);
lean_ctor_set(x_8, 1, x_7);
return x_8;
}
}
default:
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14;
x_9 = lean_ctor_get(x_1, 0);
lean_inc(x_9);
x_10 = lean_ctor_get(x_1, 1);
lean_inc(x_10);
x_11 = lean_ctor_get(x_1, 2);
lean_inc(x_11);
lean_dec(x_1);
x_12 = lean_nat_add(x_9, x_10);
lean_dec(x_10);
lean_dec(x_9);
x_13 = l_fold___main(x_11);
alloc_counter++;

x_14 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_14, 0, x_12);
lean_ctor_set(x_14, 1, x_13);
return x_14;
}
}
}
}
lean_object* l_fold(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_fold___main(x_1);
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
lean_object* initialize_Test_pair(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Default(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_L_Inhabited = _init_l_L_Inhabited();
lean_mark_persistent(l_L_Inhabited);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_pair(lean_io_mk_world());
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
lean_object* list= l_make(lean_box(10000000));
lean_object * new_list;
new_list = fold_dot__main(list);
printf("%d\n",alloc_counter );
struct timeval begin, end;
gettimeofday(&begin, 0);

long microseconds = end.tv_usec - begin.tv_usec;
int sum = 0;
for(int i = 0; i < 1000; ++i){
  sum  += i;
new_list = fold_dot__main(list);
}
printf("%d\n",sum );

// printf("%d\n",microseconds);

// gettimeofday(&end, 0);

}
#ifdef __cplusplus
}
#endif
