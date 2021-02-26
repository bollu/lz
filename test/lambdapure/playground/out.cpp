
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

lean_object* evaLExpr_dot__main( lean_object* arg0){
int x_1 = lean_obj_tag(arg0);
bool x_2 = x_1 == 0;
if(x_2){
lean_object* x_4 = lean_ctor_get(arg0, 0);
return x_4;
}
else{
bool x_6 = x_1 == 1;
if(x_6){
lean_object* x_8 = lean_ctor_get(arg0, 0);
lean_object* x_9 = lean_ctor_get(arg0, 1);
lean_object*  x_10 = evaLExpr_dot__main(x_8);
lean_object*  x_11 = evaLExpr_dot__main(x_9);
lean_object*  x_12 = lean_nat_add(x_10, x_11);
return x_12;
}
else{
lean_object* x_15 = lean_box(1u);
return x_15;
}
}

}
lean_object* evaLExpr( lean_object* arg0){
lean_object*  x_17 = evaLExpr_dot__main(arg0);
return x_17;

}
lean_object* oneplustwo_dot__closed_1( ){
lean_object* x_20 = lean_box(2u);
lean_object* x_21 = lean_alloc_ctor(0,1,0);
lean_ctor_set(x_21, 0, x_20);
return x_21;

}
lean_object* oneplustwo_dot__closed_2( ){
lean_object* x_25 = lean_box(1u);
lean_object* x_26 = lean_alloc_ctor(0,1,0);
lean_ctor_set(x_26, 0, x_25);
return x_26;

}
lean_object* oneplustwo_dot__closed_3( ){
lean_object*  x_30 = oneplustwo_dot__closed_1();
lean_object*  x_31 = oneplustwo_dot__closed_2();
lean_object* x_32 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_32, 0, x_30);
lean_ctor_set(x_32, 1, x_31);
return x_32;

}
lean_object* oneplustwo_dot__closed_4( ){
lean_object*  x_37 = oneplustwo_dot__closed_3();
lean_object*  x_38 = evaLExpr_dot__main(x_37);
return x_38;

}
lean_object* oneplustwo( ){
lean_object*  x_41 = oneplustwo_dot__closed_4();
return x_41;

}
int main(int argc, char ** argv) {
lean_initialize_runtime_module();
lean_object* x_44 = lean_box(0u);
lean_object* x_45 = lean_alloc_ctor(0,2,0);
lean_object* y = oneplustwo();
lean_object* z = lean_box(3u);
bool b = lean_nat_dec_eq(y,z);
if(b){
  printf("True\n" );
}else {
  printf("False\n");
}
// lean_ctor_set(x_45, 0, x_44);
// lean_ctor_set(x_45, 1, arg1);
return 0;
}



#ifdef __cplusplus
}
#endif
