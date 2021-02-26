
#include <time.h>
#include <time.h>
#include <stdio.h>
#include <unistd.h>
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
void lean_initialize_runtime_module();

lean_object* L_dot_Inhabited( ){
alloc_counter++;
lean_object* x_2 = lean_alloc_ctor(0,0,0);
return x_2;
}

lean_object* add_one(lean_object* x_1) {
lean_object* x_2; lean_object* x_3;
x_2 = lean_unsigned_to_nat(1u);
x_3 = lean_nat_add(x_1, x_2);
return x_3;
}

lean_object* map_dot__main( lean_object* arg0, lean_object* arg1){
int x_5 = lean_obj_tag(arg1);
switch(x_5){
case 0:
{
lean_dec(arg0);
return arg1;
}
default:
{
lean_object* x_8 = lean_ctor_get(arg1, 0);
lean_object* x_9 = lean_ctor_get(arg1, 1);
lean_inc(arg0);
lean_object* x_10 = lean_apply_1(arg0, x_8);
lean_object* x_11 = map_dot__main(arg0, x_9);
alloc_counter++;
lean_object* x_12 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_12, 0, x_10);
lean_ctor_set(x_12, 1, x_11);
return x_12;
}
}
}
lean_object* map( lean_object* arg0, lean_object* arg1){
lean_object* x_17 = map_dot__main(arg0, arg1);
return x_17;
}
lean_object* make_prime__dot__main( lean_object* arg0, lean_object* arg1){
lean_object* x_20 = lean_box(0);
int x_21 = lean_nat_dec_eq(arg1, x_20);
switch(x_21){
case 0:
{
lean_object* x_23 = lean_nat_sub(arg0, arg1);
lean_object* x_24 = lean_box(1);
lean_object* x_25 = lean_nat_sub(arg1, x_24);
lean_object* x_26 = make_prime__dot__main(arg0, x_25);
alloc_counter++;
lean_object* x_27 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_27, 0, x_23);
lean_ctor_set(x_27, 1, x_26);
return x_27;
}
default:
{
  alloc_counter++;
  alloc_counter++;
lean_object* x_31 = lean_alloc_ctor(0,0,0);
lean_object* x_32 = lean_alloc_ctor(1,2,0);
lean_ctor_set(x_32, 0, arg0);
lean_ctor_set(x_32, 1, x_31);
return x_32;
}
}
}
lean_object* make_prime_( lean_object* arg0, lean_object* arg1){
lean_object* x_37 = make_prime__dot__main(arg0, arg1);
return x_37;
}
lean_object* make( lean_object* arg0){
lean_object* x_40 = make_prime__dot__main(arg0, arg0);
return x_40;
}
lean_object* sum_dot__main( lean_object* arg0){
int x_43 = lean_obj_tag(arg0);
switch(x_43){
case 0:
{
lean_object* x_45 = lean_box(0);
return x_45;
}
default:
{
lean_object* x_47 = lean_ctor_get(arg0, 0);
lean_object* x_48 = lean_ctor_get(arg0, 1);
lean_object* x_49 = sum_dot__main(x_48);
lean_object* x_50 = lean_nat_add(x_47, x_49);
return x_50;
}
}
}
lean_object* sum( lean_object* arg0){
lean_object* x_53 = sum_dot__main(arg0);
return x_53;
}
lean_object* _lean_main( lean_object* arg0, lean_object* arg1){
lean_object* x_56 = lean_box(0);
alloc_counter++;
lean_object* x_57 = lean_alloc_ctor(0,2,0);
lean_ctor_set(x_57, 0, x_56);
lean_ctor_set(x_57, 1, arg1);
return x_57;
}

int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
printf("success %d\n", __LINE__);

in = lean_box(0);
printf("success %d\n", __LINE__);
int i = argc;
printf("success %d\n", __LINE__);
while (i > 1) {
 lean_object* n;
 i--;
 alloc_counter++;
 n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
 in = n;
}
printf("success %d\n", __LINE__);


// lean_object * list = make (lean_box(5000));
// lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
// lean_object* result_list = map(closure,list);
// printf("Amount of allocations: %d\n",alloc_counter);
// printf("Sum of list: %d\n",sum(result_list));


lean_object * list = make (lean_box(500));
printf("success %d\n", __LINE__);
lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
printf("success %d\n", __LINE__);
// lean_object* result_list = map(closure,list);
// printf("Amount of allocations: %d\n",alloc_counter);
// printf("Sum of list: %d\n",sum(result_list));
// res = _lean_main(in, lean_io_mk_world());


printf("success %d\n", __LINE__);
clock_t start, end;
double cpu_time_used;
printf("success %d\n", __LINE__);
lean_object* new_list;
printf("success %d\n", __LINE__);
lean_object* a;
printf("success %d\n", __LINE__);
start = clock();
printf("success %d\n", __LINE__);

printf("success %d\n", __LINE__);
for(int i = 0; i < 10; i++){
    printf("i:%d\n", i);
    printf("success %d\n", __LINE__);
    new_list = map(closure,list);
    printf("success %d\n", __LINE__);
    a = sum(new_list);
}
printf("success %d\n", __LINE__);
end = clock();
printf("success %d\n", __LINE__);
printf("cpu cycles: %f\n", ((double)(end - start) /1000));


// lean_object * list = make (lean_box(500));
// lean_object* closure = lean_alloc_closure((void*)(add_one),1,0);
// lean_object* result_list = map(closure,list);
//
// clock_t start, end;
// double cpu_time_used;
//
// start = clock();
// lean_object* new_list;
// // lean_object* sum;
// for(int i = 0; i < 1000; i++){
//   new_list = map(closure,list);
//   sum(new_list);
// }
//
// end = clock();
//
// // cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
// // printf("Time taken = %d\n",cpu_time_used);
// printf("cpu cycles: %f\n", ((double)(end - start) /1000));


return 0;
}



#ifdef __cplusplus
}
#endif
