#include <stdbool.h>
#include <stdint.h>
#include "lean/lean.h"

lean_object *l_IO_println___at_main___spec__1(lean_object *, lean_object *);

// typedef struct lean_object lean_object;
// void lean_io_mark_end_initialization();
// lean_object *lean_string_push(lean_object *, uint32_t);
// lean_object *_lean_main(lean_object *, lean_object *);
// void lean_initialize_runtime_module();
// int lean_io_result_is_ok(lean_object *);
// void lean_dec_ref(lean_object *);
// void lean_init_task_manage(lean_object *);
// void lean_init_task_manager();
// lean_object *lean_box(int i);
// lean_object *lean_io_result_mk_ok(lean_object *o);
// int lean_unbox(lean_object *o);
// lean_object *lean_io_mk_world();
// lean_object *initialize_Init(lean_object *);
// bool lean_io_result_is_error(lean_object *);
// void lean_io_result_show_error(lean_object *);
// lean_object *lean_io_result_get_value(lean_object *);
// lean_object *lean_mk_string(char const *s);
// void lean_ctor_set(lean_object *o, unsigned i, lean_object *v);
// lean_object *lean_alloc_ctor(unsigned tag, unsigned num_objs,
//                              unsigned scalar_sz);
// lean_object *lean_ctor_get(lean_object *o, unsigned i);
// void lean_ctor_set_tag(lean_object *o, uint8_t new_tag);
// lean_object *lean_unsigned_to_nat(unsigned n);
// unsigned lean_obj_tag(lean_object *o);
// 
// 
// // generated from sample program:
// // set_option trace.compiler.ir.init true
// // def main (xs: List String) : IO UInt32 := IO.println 7 *> pure 120
// 
// void lean_ctor_set_uint32(lean_object *o, unsigned offset, uint32_t v);

lean_object *_lean_main(lean_object *x_1, lean_object *x_2) {
  uint32_t x_3;
  lean_object *x_4;
  lean_object *x_5;
  x_3 = 120;
  x_4 = lean_unsigned_to_nat(7u);
  x_5 = l_IO_println___at_main___spec__1(x_4, x_2);
  if (lean_obj_tag(x_5) == 0) {
    lean_object *x_6;
    lean_object *x_7;
    x_6 = lean_ctor_get(x_5, 1);
    x_7 = lean_alloc_ctor(0, 2, 0);
    // lean_ctor_set(x_7, 0, x_3); HACK: edited manually by yours truly.
    lean_ctor_set_uint32(x_7, 0, x_3);
    lean_ctor_set(x_7, 1, x_6);
    return x_7;
  } else {
    lean_object *x_8;
    lean_object *x_9;
    lean_object *x_10;
    x_8 = lean_ctor_get(x_5, 0);
    x_9 = lean_ctor_get(x_5, 1);
    x_10 = lean_alloc_ctor(1, 2, 0);
    lean_ctor_set(x_10, 0, x_8);
    lean_ctor_set(x_10, 1, x_9);
    return x_10;
  }
}
