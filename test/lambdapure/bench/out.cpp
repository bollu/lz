
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
void lean_initialize_runtime_module();

lean_object* map( lean_object* arg0, lean_object* arg1){
int x_2 = lean_obj_tag(arg1);
switch(x_2){
case 0:
{
lean_object* x_4 = lean_alloc_ctor(0,0,0);
lean_dec(arg0);
lean_dec(arg1);
return x_4;
}
default:
{
if(lean_is_exclusive(arg1)){
lean_object* x_9 = lean_ctor_get(arg1, 0);
lean_object* x_10 = lean_ctor_get(arg1, 1);
lean_object* x_11 = lean_apply_1(arg0, x_9);
lean_inc(arg0);
lean_object* x_13 = map(arg0, x_10);
lean_object* x_14 = arg1;
lean_ctor_set(x_14, 0, x_11);
lean_ctor_set(x_14, 1, x_13);
return x_14;
}else{
lean_object* x_18 = lean_ctor_get(arg1, 0);
lean_object* x_19 = lean_ctor_get(arg1, 1);
lean_inc(x_18);
lean_object* x_21 = lean_apply_1(arg0, x_18);
lean_inc(arg0);
lean_inc(x_19);
lean_object* x_24 = map(arg0, x_19);
lean_inc(x_21);
lean_inc(x_24);
lean_object* x_27 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_27, 0, x_21);
lean_ctor_set(x_27, 1, x_24);
lean_inc(x_27);
lean_dec(arg1);
return x_27;
}
}
}
}

int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
in = lean_box(0);
int i = argc;
while (i > 1) {
 lean_object* n;
 i--;
 n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
 in = n;
}
//res = _lean_main(in, lean_io_mk_world());
return 0;
}



#ifdef __cplusplus
}
#endif

