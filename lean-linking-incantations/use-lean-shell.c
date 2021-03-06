// Lean compiler output
// Module: main-print
// Imports: Init
#include <stdint.h>
typedef enum bool { false=0, true=1} bool;
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
    
typedef struct lean_object lean_object;
void lean_io_mark_end_initialization();
lean_object *lean_string_push(lean_object *, uint32_t);
int lean_io_result_is_ok(lean_object *);
void lean_dec_ref(lean_object *);
void lean_init_task_manage(lean_object *);
void lean_init_task_manager();
lean_object *lean_unsigned_to_nat(unsigned);
lean_object *lean_box(int i);
lean_object *lean_io_result_mk_ok(lean_object *o);
int lean_unbox(lean_object *o);
lean_object *lean_io_mk_world();
bool lean_io_result_is_error(lean_object *);
void lean_io_result_show_error(lean_object *);
lean_object *lean_io_result_get_value(lean_object *);
lean_object *lean_mk_string(char const *s);
void lean_ctor_set(lean_object *o, unsigned i, lean_object *v);
lean_object *lean_alloc_ctor(unsigned tag, unsigned num_objs,
                             unsigned scalar_sz);


lean_object *lean_string_push(lean_object *, uint32_t);
lean_object *l_IO_println___at_main___spec__1(double, lean_object *);
double lean_float_of_scientific(lean_object *, uint8_t, lean_object *);
lean_object *_lean_main(lean_object *, lean_object *);
lean_object *l_IO_print___at_IO_println___spec__1(lean_object *, lean_object *);
double l_main___closed__1;
lean_object *lean_float_to_string(double);
lean_object *l_IO_println___at_main___spec__1(double x_1, lean_object *x_2) {
_start : {
  lean_object *x_3;
  uint32_t x_4;
  lean_object *x_5;
  lean_object *x_6;
  x_3 = lean_float_to_string(x_1);
  x_4 = 10;
  x_5 = lean_string_push(x_3, x_4);
  x_6 = l_IO_print___at_IO_println___spec__1(x_5, x_2);
  return x_6;
}
}
static double _init_l_main___closed__1() {
_start : {
  lean_object *x_1;
  uint8_t x_2;
  lean_object *x_3;
  double x_4;
  x_1 = lean_unsigned_to_nat(79u);
  x_2 = 1;
  x_3 = lean_unsigned_to_nat(1u);
  x_4 = lean_float_of_scientific(x_1, x_2, x_3);
  return x_4;
}
}
lean_object *main_lean_custom_entrypoint_hack(lean_object *x_1, lean_object *x_2) {
_start : {
  double x_3;
  lean_object *x_4;
  x_3 = l_main___closed__1;
  x_4 = l_IO_println___at_main___spec__1(x_3, x_2);
  return x_4;
}
}
lean_object *initialize_Init(lean_object *);
static bool _G_initialized = false;
lean_object *init_lean_custom_entrypoint_hack(lean_object *w) {
  lean_object *res;
  if (_G_initialized)
    return lean_io_result_mk_ok(lean_box(0));
  _G_initialized = true;
  res = initialize_Init(lean_io_mk_world());
  if (lean_io_result_is_error(res))
    return res;
  lean_dec_ref(res);
  l_main___closed__1 = _init_l_main___closed__1();
  return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
