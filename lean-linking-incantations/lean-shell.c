// Code that is stolen from LEAN4's sources, used to create an LLVM .S file
// which is then linked into the executable we build.

#include <stdint.h>
#include <stdbool.h>
#include <lean/lean.h>

lean_object *_lean_main(lean_object *, lean_object *);
lean_object *initialize_Init(lean_object *);
void lean_initialize_runtime_module();

// typedef struct lean_object lean_object;
// void lean_io_mark_end_initialization();
// lean_object *lean_string_push(lean_object *, uint32_t);
// int lean_io_result_is_ok(lean_object *);
// void lean_dec_ref(lean_object *);
// void lean_init_task_manage(lean_object *);
// void lean_init_task_manager();
// lean_object *lean_box(int i);
// lean_object *lean_io_result_mk_ok(lean_object *o);
// int lean_unbox(lean_object *o);
// lean_object *lean_io_mk_world();
// bool lean_io_result_is_error(lean_object *);
// void lean_io_result_show_error(lean_object *);
// lean_object *lean_io_result_get_value(lean_object *);
// lean_object *lean_mk_string(char const *s);
// void lean_ctor_set(lean_object *o, unsigned i, lean_object *v);
// lean_object *lean_alloc_ctor(unsigned tag, unsigned num_objs,
//                              unsigned scalar_sz);

// lean_mk_string
// lean_ctor_set
// lean_io_mk_world
static bool _G_initialized = false;
lean_object *initialize_main_x2dprint_x2dret(lean_object *w) {
  lean_object *res;
  if (_G_initialized)
    return lean_io_result_mk_ok(lean_box(0));
  _G_initialized = true;
  res = initialize_Init(lean_io_mk_world());
  if (lean_io_result_is_error(res))
    return res;
  lean_dec_ref(res);
  return lean_io_result_mk_ok(lean_box(0));
}

int main(int argc, char ** argv) {
    lean_object* in; lean_object* res;
    lean_initialize_runtime_module();
    res = initialize_main_x2dprint_x2dret(lean_io_mk_world());
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
