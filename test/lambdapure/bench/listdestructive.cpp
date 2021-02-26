// Lean compiler output
// Module: Test.list
// Imports: Init.Default
#include <time.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>


#include <time.h>
#include <stdlib.h>

// #include "runtime/lean.h"
// #include "lean.h"
#include "lean/lean.h"
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
int list_size = 200;
lean_object* l_IO_println___at_main___spec__1(lean_object*, lean_object*);
lean_object* l_sum(lean_object*);
lean_object* l_sum___main___boxed(lean_object*);
lean_object* lean_io_prim_put_str(lean_object*, lean_object*);
lean_object* l_main___closed__2;
lean_object* _lean_main(lean_object*, lean_object*);
lean_object* l_main___closed__3;
lean_object* l_main___boxed__const__1;
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* l_main___closed__4;
lean_object* l_sum___boxed(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* l_main___closed__1;
lean_object* l_IO_print___at_main___spec__2(lean_object*, lean_object*);
lean_object* l_Nat_repr(lean_object*);
extern lean_object* l_IO_println___rarg___closed__1;
lean_object* l_map(lean_object*, lean_object*);
lean_object* l_add__one___boxed(lean_object*);
lean_object* l_map___main(lean_object*, lean_object*);
lean_object* l_make_x27(lean_object*, lean_object*);
lean_object* l_add__one(lean_object*);
lean_object* l_make_x27___boxed(lean_object*, lean_object*);
lean_object* l_make(lean_object*);
lean_object* l_L_Inhabited;
lean_object* l_make_x27___main(lean_object*, lean_object*);
lean_object* l_sum___main(lean_object*);
lean_object* l_make_x27___main___boxed(lean_object*, lean_object*);

lean_object* l_filter___main(lean_object* x_1) {
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
// if (x_2 == 0)
if(false)
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; uint8_t x_6;
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = lean_unsigned_to_nat(5u);
x_6 = lean_nat_dec_lt(x_5, x_3);
if (x_6 == 0)
{
lean_object* x_7;
x_7 = l_filter___main(x_4);
lean_ctor_set(x_1, 1, x_7);
return x_1;
}
else
{
lean_free_object(x_1);
lean_dec(x_3);
x_1 = x_4;
goto _start;
}
}
else
{
lean_object* x_9; lean_object* x_10; lean_object* x_11; uint8_t x_12;
x_9 = lean_ctor_get(x_1, 0);
x_10 = lean_ctor_get(x_1, 1);
lean_inc(x_10);
lean_inc(x_9);
lean_dec(x_1);
x_11 = lean_unsigned_to_nat(5u);
x_12 = lean_unbox(x_9) % 2;
if (x_12 == 0)
{
lean_object* x_13; lean_object* x_14;
x_13 = l_filter___main(x_10);
alloc_counter++;
x_14 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_14, 0, x_9);
lean_ctor_set(x_14, 1, x_13);
return x_14;
}
else
{
lean_dec(x_9);
x_1 = x_10;
goto _start;
}
}
}
}
}


lean_object* filter_dot__main( lean_object* arg0){
int x_2 = lean_obj_tag(arg0);
switch(x_2){
case 0:
{
return arg0;
}
default:
{
lean_object* x_5 = lean_ctor_get(arg0, 0);
lean_object* x_6 = lean_ctor_get(arg0, 1);
lean_object* x_7 = lean_box(5);
lean_inc(x_7);
lean_inc(x_5);
int x_10 = lean_unbox(x_5) % 2;
switch(x_10){
case 0:
{
// if(false){
// printf("got here1\n" );

if(lean_is_exclusive(arg0)){
  printf("exlcusive\n" );
  // lean_dec(x_6);
  lean_object* x_13 = filter_dot__main(x_6);
  lean_ctor_set(arg0, 0, x_5);
  lean_ctor_set(arg0, 1, x_13);
  return arg0;
}else{

  lean_inc(x_6);
  lean_object* x_13 = filter_dot__main(x_6);
  lean_inc(x_5);
  lean_inc(x_13);
  alloc_counter++;
  lean_object* x_16 = lean_alloc_ctor(1,2,0);
  lean_ctor_set(x_16, 0, x_5);
  lean_ctor_set(x_16, 1, x_13);
  lean_inc(x_16);
  lean_dec(arg0);
  return x_16;
}
}
default:
{
lean_inc(x_6);
lean_object* x_23 = filter_dot__main(x_6);
lean_inc(x_23);
lean_dec(arg0);
return x_23;
}
}
}
}
}


lean_object* l_map___main(lean_object* x_1, lean_object* x_2) {
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
lean_object* x_4; lean_object* x_5; lean_object* x_6; lean_object* x_7;
x_4 = lean_ctor_get(x_2, 0);
x_5 = lean_ctor_get(x_2, 1);
lean_inc(x_1);
x_6 = lean_apply_1(x_1, x_4);
x_7 = l_map___main(x_1, x_5);
lean_ctor_set(x_2, 1, x_7);
lean_ctor_set(x_2, 0, x_6);
return x_2;
}
else
{
lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12;
x_8 = lean_ctor_get(x_2, 0);
x_9 = lean_ctor_get(x_2, 1);
lean_inc(x_9);
lean_inc(x_8);
lean_dec(x_2);
lean_inc(x_1);
x_10 = lean_apply_1(x_1, x_8);
x_11 = l_map___main(x_1, x_9);
x_12 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_12, 0, x_10);
lean_ctor_set(x_12, 1, x_11);
return x_12;
}
}
}
}


lean_object* map_dot__main( lean_object* arg0, lean_object* arg1){
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
  printf("exlcusive\n");
lean_object* x_7 = lean_ctor_get(arg1, 0);
lean_object* x_8 = lean_ctor_get(arg1, 1);
lean_object* x_9 = lean_apply_1(arg0, x_7);
lean_inc(arg0);
lean_object* x_11 = map_dot__main(arg0, x_8);
lean_object* x_12 = arg1;
lean_ctor_set(x_12, 0, x_9);
lean_ctor_set(x_12, 1, x_11);
return x_12;
}else{
lean_object* x_16 = lean_ctor_get(arg1, 0);
lean_object* x_17 = lean_ctor_get(arg1, 1);
lean_inc(x_16);
lean_object* x_19 = lean_apply_1(arg0, x_16);
lean_inc(arg0);
lean_inc(x_17);
lean_object* x_22 = map_dot__main(arg0, x_17);
lean_inc(x_19);
lean_inc(x_22);
lean_object* x_25 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_25, 0, x_19);
lean_ctor_set(x_25, 1, x_22);
lean_inc(x_25);
lean_dec(arg1);
return x_25;
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

lean_object* _init_l_L_Inhabited() {
_start:
{
lean_object* x_1;
x_1 = lean_box(0);
return x_1;
}
}

lean_object* l_map(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
x_3 = l_map___main(x_1, x_2);
return x_3;
}
}
lean_object* l_add__one(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3;
x_2 = lean_unsigned_to_nat(1u);
x_3 = lean_nat_add(x_1, x_2);
return x_3;
}
}
lean_object* l_add__one___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_add__one(x_1);
lean_dec(x_1);
return x_2;
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
lean_object* l_sum___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_2;
x_2 = lean_unsigned_to_nat(0u);
return x_2;
}
else
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6;
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_sum___main(x_4);
x_6 = lean_nat_add(x_3, x_5);
lean_dec(x_5);
return x_6;
}
}
}
lean_object* l_sum___main___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_sum___main(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_sum(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_sum___main(x_1);
return x_2;
}
}
lean_object* l_sum___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_sum(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* l_IO_print___at_main___spec__2(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4;
x_3 = l_Nat_repr(x_1);
x_4 = lean_io_prim_put_str(x_3, x_2);
lean_dec(x_3);
return x_4;
}
}
lean_object* l_IO_println___at_main___spec__1(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3;
x_3 = l_IO_print___at_main___spec__2(x_1, x_2);
if (lean_obj_tag(x_3) == 0)
{
lean_object* x_4; lean_object* x_5; lean_object* x_6;
x_4 = lean_ctor_get(x_3, 1);
lean_inc(x_4);
lean_dec(x_3);
x_5 = l_IO_println___rarg___closed__1;
x_6 = lean_io_prim_put_str(x_5, x_4);
return x_6;
}
else
{
uint8_t x_7;
x_7 = !lean_is_exclusive(x_3);
if (x_7 == 0)
{
return x_3;
}
else
{
lean_object* x_8; lean_object* x_9; lean_object* x_10;
x_8 = lean_ctor_get(x_3, 0);
x_9 = lean_ctor_get(x_3, 1);
lean_inc(x_9);
lean_inc(x_8);
lean_dec(x_3);
alloc_counter++;

x_10 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_10, 0, x_8);
lean_ctor_set(x_10, 1, x_9);
return x_10;
}
}
}
}
lean_object* _init_l_main___closed__1() {
_start:
{
lean_object* x_1; lean_object* x_2;
x_1 = lean_unsigned_to_nat(list_size);
x_2 = l_make_x27___main(x_1, x_1);
return x_2;
}
}
lean_object* _init_l_main___closed__2() {
_start:
{
lean_object* x_1;
x_1 = lean_alloc_closure((void*)(l_add__one___boxed), 1, 0);
return x_1;
}
}
lean_object* _init_l_main___closed__3() {
_start:
{
lean_object* x_1; lean_object* x_2; lean_object* x_3;
x_1 = l_main___closed__2;
x_2 = l_main___closed__1;
x_3 = l_map___main(x_1, x_2);
return x_3;
}
}
lean_object* _init_l_main___closed__4() {
_start:
{
lean_object* x_1; lean_object* x_2;
x_1 = l_main___closed__3;
x_2 = l_sum___main(x_1);
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
x_3 = l_main___closed__4;
x_4 = l_IO_println___at_main___spec__1(x_3, x_2);
if (lean_obj_tag(x_4) == 0)
{
uint8_t x_5;
x_5 = !lean_is_exclusive(x_4);
if (x_5 == 0)
{
lean_object* x_6; lean_object* x_7;
x_6 = lean_ctor_get(x_4, 0);
lean_dec(x_6);
x_7 = l_main___boxed__const__1;
lean_ctor_set(x_4, 0, x_7);
return x_4;
}
else
{
lean_object* x_8; lean_object* x_9; lean_object* x_10;
x_8 = lean_ctor_get(x_4, 1);
lean_inc(x_8);
lean_dec(x_4);
x_9 = l_main___boxed__const__1;
alloc_counter++;

x_10 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_10, 0, x_9);
lean_ctor_set(x_10, 1, x_8);
return x_10;
}
}
else
{
uint8_t x_11;
x_11 = !lean_is_exclusive(x_4);
if (x_11 == 0)
{
return x_4;
}
else
{
lean_object* x_12; lean_object* x_13; lean_object* x_14;
x_12 = lean_ctor_get(x_4, 0);
x_13 = lean_ctor_get(x_4, 1);
lean_inc(x_13);
lean_inc(x_12);
lean_dec(x_4);
alloc_counter++;

x_14 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_14, 0, x_12);
lean_ctor_set(x_14, 1, x_13);
return x_14;
}
}
}
}
lean_object* initialize_Init_Default(lean_object*);
static bool _G_initialized = false;


// bollu| lean_object* initialize_Test_list(lean_object* w) {
// bollu| lean_object * res;
// bollu| if (_G_initialized) return lean_mk_io_result(lean_box(0));
// bollu| _G_initialized = true;
// bollu| res = initialize_Init_Default(lean_io_mk_world());
// bollu| if (lean_io_result_is_error(res)) return res;
// bollu| lean_dec_ref(res);
// bollu| l_L_Inhabited = _init_l_L_Inhabited();
// bollu| lean_mark_persistent(l_L_Inhabited);
// bollu| l_main___closed__1 = _init_l_main___closed__1();
// bollu| lean_mark_persistent(l_main___closed__1);
// bollu| l_main___closed__2 = _init_l_main___closed__2();
// bollu| lean_mark_persistent(l_main___closed__2);
// bollu| l_main___closed__3 = _init_l_main___closed__3();
// bollu| lean_mark_persistent(l_main___closed__3);
// bollu| l_main___closed__4 = _init_l_main___closed__4();
// bollu| lean_mark_persistent(l_main___closed__4);
// bollu| l_main___boxed__const__1 = _init_l_main___boxed__const__1();
// bollu| lean_mark_persistent(l_main___boxed__const__1);
// bollu| return lean_mk_io_result(lean_box(0));
// bollu| }
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_initialize_runtime_module();
lean_io_mark_end_initialization();

// lean_object * og_list = l_make(lean_box(5000));
// lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
// lean_object* new_list = l_map___main(closure,og_list);
// printf("%d\n",alloc_counter );
// printf("%d\n",l_sum(new_list) );

// srand(time(NULL));   // Initialization, should only be called once.
// int r = rand();      // Returns a pseudo-random integer between 0 and RAND_MAX.
//
//
// lean_object * og_list = l_make(lean_box(10));
lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
//
//
// struct timeval begin, end;
// gettimeofday(&begin, 0);
//
//
// lean_object* new_list;
// lean_object* sum;
// // for(int i = 0; i < 10; i++){
//   new_list = map_dot__main(closure,og_list);
//   sum = l_sum(new_list);
// // }
// int n = lean_unbox(sum);
// gettimeofday(&end, 0);
//
// long microseconds = end.tv_usec - begin.tv_usec;
// // printf("%d\n",microseconds);
// printf("%d\n",n );



//filter
lean_object * og_list = l_make(lean_box(5000));
lean_object* new_list;
struct timeval begin, end;
gettimeofday(&begin, 0);
new_list = l_filter___main(og_list);
// new_list = map_dot__main(closure,og_list);

printf("alloc_counter : %d\n",alloc_counter );
// for(int i = 0; i < 1000; ++i){
// new_list = l_filter___main(og_list);
// }

gettimeofday(&end, 0);


long microseconds = end.tv_usec - begin.tv_usec;

printf("%d\n",microseconds);

// for(int i = 0; i < 10000; ++i){
//
// }

// clock_t start, end;
// double cpu_time_used;
// start = clock();
//
// lean_object* new_list;
// // new_list = l_map___main(closure,og_list);
//
//
//
// lean_object* sum;
// // sum = l_sum(new_list);

//
//
// end = clock();
//
// // cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
// // printf("Time taken = %d\n",cpu_time_used);
// printf("cpu cycles: %f\n", ((double)(end - start)/500));
//  printf("start = %d, end = %d\n", start, end);

// printf()

// clock_t start, end;
//  start = clock();
//  int c;
//  for (int i = 0; i < 100; i++) {
//      for (int j = 0; j < (1<<30); j++) {
//          c++;
//      }
//  }
//  end = clock();

}
#ifdef __cplusplus
}
#endif
