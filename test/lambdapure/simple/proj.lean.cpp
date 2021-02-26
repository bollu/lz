// Lean compiler output
// Module: Test.proj
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
lean_object* _lean_main(lean_object*);
uint32_t l_check(lean_object*);
lean_object* l_main___boxed__const__1;
uint32_t l_UInt32_add(uint32_t, uint32_t);
lean_object* l_check___main___boxed(lean_object*);
lean_object* l_check___boxed(lean_object*);
uint32_t l_check___main(lean_object*);
uint32_t l_check___main(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
uint32_t x_2; 
x_2 = 0;
return x_2;
}
else
{
lean_object* x_3; lean_object* x_4; uint32_t x_5; uint32_t x_6; uint32_t x_7; uint32_t x_8; uint32_t x_9; 
x_3 = lean_ctor_get(x_1, 0);
x_4 = lean_ctor_get(x_1, 1);
x_5 = 1;
x_6 = l_check___main(x_3);
x_7 = x_5 + x_6;
x_8 = l_check___main(x_4);
x_9 = x_7 + x_8;
return x_9;
}
}
}
lean_object* l_check___main___boxed(lean_object* x_1) {
_start:
{
uint32_t x_2; lean_object* x_3; 
x_2 = l_check___main(x_1);
lean_dec(x_1);
x_3 = lean_box_uint32(x_2);
return x_3;
}
}
uint32_t l_check(lean_object* x_1) {
_start:
{
uint32_t x_2; 
x_2 = l_check___main(x_1);
return x_2;
}
}
lean_object* l_check___boxed(lean_object* x_1) {
_start:
{
uint32_t x_2; lean_object* x_3; 
x_2 = l_check(x_1);
lean_dec(x_1);
x_3 = lean_box_uint32(x_2);
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
lean_object* _lean_main(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3; 
x_2 = l_main___boxed__const__1;
x_3 = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(x_3, 0, x_2);
lean_ctor_set(x_3, 1, x_1);
return x_3;
}
}
lean_object* initialize_Init_Default(lean_object*);
static bool _G_initialized = false;
lean_object* initialize_Test_proj(lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_mk_io_result(lean_box(0));
_G_initialized = true;
res = initialize_Init_Default(lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_main___boxed__const__1 = _init_l_main___boxed__const__1();
lean_mark_persistent(l_main___boxed__const__1);
return lean_mk_io_result(lean_box(0));
}
void lean_initialize_runtime_module();
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
res = initialize_Test_proj(lean_io_mk_world());
lean_io_mark_end_initialization();
if (lean_io_result_is_ok(res)) {
lean_dec_ref(res);
lean_init_task_manager();
res = _lean_main(lean_io_mk_world());
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
