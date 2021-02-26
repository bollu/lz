// Lean compiler output
// Module: Test.cut
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
lean_object* l_main___boxed__const__1;
uint32_t l_UInt32_add(uint32_t, uint32_t);
uint32_t l_UInt32_sub(uint32_t, uint32_t);
lean_object* l_make___boxed(lean_object*);
lean_object* l_cut___main(lean_object*);
lean_object* l_Tree_Inhabited;
lean_object* l_make_x27___main___closed__1;
lean_object* l_cut(lean_object*);
uint8_t l_UInt32_decEq(uint32_t, uint32_t);
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
x_2 = lean_alloc_ctor(2, 3, 0);
lean_ctor_set(x_2, 0, x_1);
lean_ctor_set(x_2, 1, x_1);
lean_ctor_set(x_2, 2, x_1);
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
uint32_t x_5; uint32_t x_6; lean_object* x_7; uint32_t x_8; lean_object* x_9; uint32_t x_10; uint32_t x_11; lean_object* x_12; lean_object* x_13;
x_5 = 1;
x_6 = x_2 - x_5;
x_7 = l_make_x27___main(x_1, x_6);
x_8 = x_1 + x_5;
x_9 = l_make_x27___main(x_8, x_6);
x_10 = 100000;
x_11 = x_10 - x_1;
x_12 = l_make_x27___main(x_11, x_6);
x_13 = lean_alloc_ctor(2, 3, 0);
lean_ctor_set(x_13, 0, x_7);
lean_ctor_set(x_13, 1, x_9);
lean_ctor_set(x_13, 2, x_12);
return x_13;
}
else
{
lean_object* x_14;
x_14 = l_make_x27___main___closed__1;
return x_14;
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
lean_object* l_cut___main(lean_object* x_1) {
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
lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6;
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = l_cut___main(x_3);
x_6 = l_cut___main(x_4);
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
x_9 = l_cut___main(x_7);
x_10 = l_cut___main(x_8);
alloc_counter++;
x_11 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_11, 0, x_9);
lean_ctor_set(x_11, 1, x_10);
return x_11;
}
}
default:
{
lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11;

int e  = !lean_is_exclusive(x_1);
if(e){
  printf("excl\n" );
  lean_ctor_set_tag(x_1,1);
  x_7 = lean_ctor_get(x_1, 0);
  x_8 = lean_ctor_get(x_1, 1);
  x_9 = l_cut___main(x_7);
  x_10 = l_cut___main(x_8);
  lean_ctor_set(x_1, 0, x_9);
  lean_ctor_set(x_1, 1, x_10);
  return x_1;
}else {
  printf("not\n" );
  lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16;
  x_12 = lean_ctor_get(x_1, 0);
  lean_inc(x_12);
  x_13 = lean_ctor_get(x_1, 1);
  lean_inc(x_13);
  lean_dec(x_1);
  x_14 = l_cut___main(x_12);
  x_15 = l_cut___main(x_13);
  alloc_counter++;
  x_16 = lean_alloc_ctor(1, 2, 0);
  lean_ctor_set(x_16, 0, x_14);
  lean_ctor_set(x_16, 1, x_15);
  return x_16;
}
}
}
}
}
lean_object* l_cut(lean_object* x_1) {
_start:
{
lean_object* x_2;
x_2 = l_cut___main(x_1);
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
lean_object* initialize_Test_cut(lean_object* w) {
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
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_cut(lean_io_mk_world());
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

lean_object* tree = l_make(3);
lean_object* new_tree =  l_cut(tree);

printf("%d\n",alloc_counter );
}
#ifdef __cplusplus
}
#endif
