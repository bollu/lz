; ModuleID = 'library.ll'
source_filename = "library.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.lean_object = type { i64 }
%struct.lean_ctor_object = type { %struct.lean_object, [0 x %struct.lean_object*] }
%struct.lean_closure_object = type { %struct.lean_object, i8*, i16, i16, [0 x %struct.lean_object*] }
%struct.lean_array_object = type { %struct.lean_object, i64, i64, [0 x %struct.lean_object*] }
%struct.lean_sarray_object = type { %struct.lean_object, i64, i64, [0 x i8] }
%struct.lean_string_object = type { %struct.lean_object, i64, i64, i64, [0 x i8] }
%struct.lean_thunk_object = type { %struct.lean_object, %struct.lean_object*, %struct.lean_object* }
%struct.lean_task = type { %struct.lean_object, %struct.lean_object*, %struct.lean_task_imp* }
%struct.lean_task_imp = type { %struct.lean_object*, %struct.lean_task*, %struct.lean_task*, i32, i8, i8, i8 }
%struct.lean_ref_object = type { %struct.lean_object, %struct.lean_object* }
%struct.lean_external_object = type { %struct.lean_object, %struct.lean_external_class*, i8* }
%struct.lean_external_class = type { void (i8*)*, void (i8*, %struct.lean_object*)* }

@.str = private unnamed_addr constant [7 x i8] c"sz > 0\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"./lean/lean.h\00", align 1
@__PRETTY_FUNCTION__.lean_get_slot_idx = private unnamed_addr constant [45 x i8] c"unsigned int lean_get_slot_idx(unsigned int)\00", align 1
@.str.2 = private unnamed_addr constant [45 x i8] c"lean_align(sz, LEAN_OBJECT_SIZE_DELTA) == sz\00", align 1
@.str.3 = private unnamed_addr constant [33 x i8] c"sz <= LEAN_MAX_SMALL_OBJECT_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_small_object = private unnamed_addr constant [51 x i8] c"lean_object *lean_alloc_small_object(unsigned int)\00", align 1
@.str.4 = private unnamed_addr constant [34 x i8] c"sz1 <= LEAN_MAX_SMALL_OBJECT_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_ctor_memory = private unnamed_addr constant [50 x i8] c"lean_object *lean_alloc_ctor_memory(unsigned int)\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"lean_is_ctor(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_ctor = private unnamed_addr constant [46 x i8] c"lean_ctor_object *lean_to_ctor(lean_object *)\00", align 1
@.str.6 = private unnamed_addr constant [19 x i8] c"lean_is_closure(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_closure = private unnamed_addr constant [52 x i8] c"lean_closure_object *lean_to_closure(lean_object *)\00", align 1
@.str.7 = private unnamed_addr constant [17 x i8] c"lean_is_array(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_array = private unnamed_addr constant [48 x i8] c"lean_array_object *lean_to_array(lean_object *)\00", align 1
@.str.8 = private unnamed_addr constant [18 x i8] c"lean_is_sarray(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_sarray = private unnamed_addr constant [50 x i8] c"lean_sarray_object *lean_to_sarray(lean_object *)\00", align 1
@.str.9 = private unnamed_addr constant [18 x i8] c"lean_is_string(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_string = private unnamed_addr constant [50 x i8] c"lean_string_object *lean_to_string(lean_object *)\00", align 1
@.str.10 = private unnamed_addr constant [17 x i8] c"lean_is_thunk(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_thunk = private unnamed_addr constant [48 x i8] c"lean_thunk_object *lean_to_thunk(lean_object *)\00", align 1
@.str.11 = private unnamed_addr constant [16 x i8] c"lean_is_task(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_task = private unnamed_addr constant [46 x i8] c"lean_task_object *lean_to_task(lean_object *)\00", align 1
@.str.12 = private unnamed_addr constant [15 x i8] c"lean_is_ref(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_ref = private unnamed_addr constant [44 x i8] c"lean_ref_object *lean_to_ref(lean_object *)\00", align 1
@.str.13 = private unnamed_addr constant [20 x i8] c"lean_is_external(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_external = private unnamed_addr constant [54 x i8] c"lean_external_object *lean_to_external(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_set_non_heap_header = private unnamed_addr constant [81 x i8] c"void lean_set_non_heap_header(lean_object *, size_t, unsigned int, unsigned int)\00", align 1
@.str.14 = private unnamed_addr constant [18 x i8] c"sz < (1ull << 45)\00", align 1
@.str.15 = private unnamed_addr constant [40 x i8] c"sz == 1 || !lean_is_big_object_tag(tag)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_num_objs = private unnamed_addr constant [47 x i8] c"unsigned int lean_ctor_num_objs(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_obj_cptr = private unnamed_addr constant [48 x i8] c"lean_object **lean_ctor_obj_cptr(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_scalar_cptr = private unnamed_addr constant [46 x i8] c"uint8_t *lean_ctor_scalar_cptr(lean_object *)\00", align 1
@.str.16 = private unnamed_addr constant [99 x i8] c"tag <= LeanMaxCtorTag && num_objs < LEAN_MAX_CTOR_FIELDS && scalar_sz < LEAN_MAX_CTOR_SCALARS_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_ctor = private unnamed_addr constant [71 x i8] c"lean_object *lean_alloc_ctor(unsigned int, unsigned int, unsigned int)\00", align 1
@.str.17 = private unnamed_addr constant [26 x i8] c"i < lean_ctor_num_objs(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get = private unnamed_addr constant [59 x i8] c"b_lean_obj_res lean_ctor_get(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set = private unnamed_addr constant [63 x i8] c"void lean_ctor_set(b_lean_obj_arg, unsigned int, lean_obj_arg)\00", align 1
@.str.18 = private unnamed_addr constant [26 x i8] c"new_tag <= LeanMaxCtorTag\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_tag = private unnamed_addr constant [48 x i8] c"void lean_ctor_set_tag(b_lean_obj_arg, uint8_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_release = private unnamed_addr constant [53 x i8] c"void lean_ctor_release(b_lean_obj_arg, unsigned int)\00", align 1
@.str.19 = private unnamed_addr constant [27 x i8] c"i >= lean_ctor_num_objs(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_usize = private unnamed_addr constant [57 x i8] c"size_t lean_ctor_get_usize(b_lean_obj_arg, unsigned int)\00", align 1
@.str.20 = private unnamed_addr constant [48 x i8] c"offset >= lean_ctor_num_objs(o) * sizeof(void*)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_uint8 = private unnamed_addr constant [58 x i8] c"uint8_t lean_ctor_get_uint8(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_uint16 = private unnamed_addr constant [60 x i8] c"uint16_t lean_ctor_get_uint16(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_uint32 = private unnamed_addr constant [60 x i8] c"uint32_t lean_ctor_get_uint32(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_uint64 = private unnamed_addr constant [60 x i8] c"uint64_t lean_ctor_get_uint64(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get_float = private unnamed_addr constant [57 x i8] c"double lean_ctor_get_float(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_usize = private unnamed_addr constant [63 x i8] c"void lean_ctor_set_usize(b_lean_obj_arg, unsigned int, size_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_uint8 = private unnamed_addr constant [64 x i8] c"void lean_ctor_set_uint8(b_lean_obj_arg, unsigned int, uint8_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_uint16 = private unnamed_addr constant [66 x i8] c"void lean_ctor_set_uint16(b_lean_obj_arg, unsigned int, uint16_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_uint32 = private unnamed_addr constant [66 x i8] c"void lean_ctor_set_uint32(b_lean_obj_arg, unsigned int, uint32_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_uint64 = private unnamed_addr constant [66 x i8] c"void lean_ctor_set_uint64(b_lean_obj_arg, unsigned int, uint64_t)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set_float = private unnamed_addr constant [63 x i8] c"void lean_ctor_set_float(b_lean_obj_arg, unsigned int, double)\00", align 1
@.str.21 = private unnamed_addr constant [10 x i8] c"arity > 0\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_closure = private unnamed_addr constant [68 x i8] c"lean_obj_res lean_alloc_closure(void *, unsigned int, unsigned int)\00", align 1
@.str.22 = private unnamed_addr constant [18 x i8] c"num_fixed < arity\00", align 1
@.str.23 = private unnamed_addr constant [30 x i8] c"i < lean_closure_num_fixed(o)\00", align 1
@__PRETTY_FUNCTION__.lean_closure_get = private unnamed_addr constant [62 x i8] c"b_lean_obj_res lean_closure_get(b_lean_obj_arg, unsigned int)\00", align 1
@__PRETTY_FUNCTION__.lean_closure_set = private unnamed_addr constant [66 x i8] c"void lean_closure_set(u_lean_obj_arg, unsigned int, lean_obj_arg)\00", align 1
@__PRETTY_FUNCTION__.lean_array_set_size = private unnamed_addr constant [49 x i8] c"void lean_array_set_size(u_lean_obj_arg, size_t)\00", align 1
@.str.24 = private unnamed_addr constant [21 x i8] c"lean_is_exclusive(o)\00", align 1
@.str.25 = private unnamed_addr constant [29 x i8] c"sz <= lean_array_capacity(o)\00", align 1
@.str.26 = private unnamed_addr constant [23 x i8] c"i < lean_array_size(o)\00", align 1
@__PRETTY_FUNCTION__.lean_array_get_core = private unnamed_addr constant [59 x i8] c"b_lean_obj_res lean_array_get_core(b_lean_obj_arg, size_t)\00", align 1
@.str.27 = private unnamed_addr constant [40 x i8] c"!lean_has_rc(o) || lean_is_exclusive(o)\00", align 1
@__PRETTY_FUNCTION__.lean_array_set_core = private unnamed_addr constant [63 x i8] c"void lean_array_set_core(u_lean_obj_arg, size_t, lean_obj_arg)\00", align 1
@__PRETTY_FUNCTION__.lean_sarray_elem_size = private unnamed_addr constant [50 x i8] c"unsigned int lean_sarray_elem_size(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_sarray_set_size = private unnamed_addr constant [50 x i8] c"void lean_sarray_set_size(u_lean_obj_arg, size_t)\00", align 1
@.str.28 = private unnamed_addr constant [30 x i8] c"sz <= lean_sarray_capacity(o)\00", align 1
@__PRETTY_FUNCTION__.lean_string_cstr = private unnamed_addr constant [45 x i8] c"const char *lean_string_cstr(b_lean_obj_arg)\00", align 1
@.str.29 = private unnamed_addr constant [18 x i8] c"lean_is_scalar(a)\00", align 1
@__PRETTY_FUNCTION__.lean_scalar_to_int64 = private unnamed_addr constant [45 x i8] c"int64_t lean_scalar_to_int64(b_lean_obj_arg)\00", align 1
@__PRETTY_FUNCTION__.lean_scalar_to_int = private unnamed_addr constant [39 x i8] c"int lean_scalar_to_int(b_lean_obj_arg)\00", align 1
@.str.30 = private unnamed_addr constant [29 x i8] c"!lean_int_lt(a, lean_box(0))\00", align 1
@__PRETTY_FUNCTION__.lean_int_to_nat = private unnamed_addr constant [43 x i8] c"lean_obj_res lean_int_to_nat(lean_obj_arg)\00", align 1
@.str.31 = private unnamed_addr constant [24 x i8] c"lean_io_result_is_ok(r)\00", align 1
@__PRETTY_FUNCTION__.lean_io_result_get_value = private unnamed_addr constant [56 x i8] c"b_lean_obj_res lean_io_result_get_value(b_lean_obj_arg)\00", align 1
@.str.32 = private unnamed_addr constant [27 x i8] c"lean_io_result_is_error(r)\00", align 1
@__PRETTY_FUNCTION__.lean_io_result_get_error = private unnamed_addr constant [56 x i8] c"b_lean_obj_res lean_io_result_get_error(b_lean_obj_arg)\00", align 1

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_big_object_tag(i8 zeroext %0) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = icmp eq i32 %4, 246
  br i1 %5, label %18, label %6

6:                                                ; preds = %1
  %7 = load i8, i8* %2, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 247
  br i1 %9, label %18, label %10

10:                                               ; preds = %6
  %11 = load i8, i8* %2, align 1
  %12 = zext i8 %11 to i32
  %13 = icmp eq i32 %12, 248
  br i1 %13, label %18, label %14

14:                                               ; preds = %10
  %15 = load i8, i8* %2, align 1
  %16 = zext i8 %15 to i32
  %17 = icmp eq i32 %16, 249
  br label %18

18:                                               ; preds = %14, %10, %6, %1
  %19 = phi i1 [ true, %10 ], [ true, %6 ], [ true, %1 ], [ %17, %14 ]
  ret i1 %19
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_scalar(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = ptrtoint %struct.lean_object* %3 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 1
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = shl i64 %3, 1
  %5 = or i64 %4, 1
  %6 = inttoptr i64 %5 to %struct.lean_object*
  ret %struct.lean_object* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_uint8(i8 zeroext %0) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i64
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_unbox(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = ptrtoint %struct.lean_object* %3 to i64
  %5 = lshr i64 %4, 1
  ret i64 %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_unbox_uint8(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_unbox(%struct.lean_object* %3)
  %5 = trunc i64 %4 to i8
  ret i8 %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_align(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = udiv i64 %5, %6
  %8 = load i64, i64* %4, align 8
  %9 = mul i64 %7, %8
  %10 = load i64, i64* %4, align 8
  %11 = load i64, i64* %3, align 8
  %12 = load i64, i64* %4, align 8
  %13 = urem i64 %11, %12
  %14 = icmp ne i64 %13, 0
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = mul i64 %10, %16
  %18 = add i64 %9, %17
  ret i64 %18
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_get_slot_idx(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp ugt i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 310, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load i32, i32* %2, align 4
  %9 = zext i32 %8 to i64
  %10 = call i64 @lean_align(i64 %9, i64 8)
  %11 = load i32, i32* %2, align 4
  %12 = zext i32 %11 to i64
  %13 = icmp eq i64 %10, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %7
  br label %16

15:                                               ; preds = %7
  call void @__assert_fail(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 311, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i32, i32* %2, align 4
  %18 = udiv i32 %17, 8
  %19 = sub i32 %18, 1
  ret i32 %19
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_small_object(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = zext i32 %4 to i64
  %6 = call i64 @lean_align(i64 %5, i64 8)
  %7 = trunc i64 %6 to i32
  store i32 %7, i32* %2, align 4
  %8 = load i32, i32* %2, align 4
  %9 = call i32 @lean_get_slot_idx(i32 %8)
  store i32 %9, i32* %3, align 4
  %10 = load i32, i32* %2, align 4
  %11 = icmp ule i32 %10, 4096
  br i1 %11, label %12, label %13

12:                                               ; preds = %1
  br label %14

13:                                               ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 324, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @__PRETTY_FUNCTION__.lean_alloc_small_object, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load i32, i32* %2, align 4
  %16 = load i32, i32* %3, align 4
  %17 = call i8* @lean_alloc_small(i32 %15, i32 %16)
  %18 = bitcast i8* %17 to %struct.lean_object*
  ret %struct.lean_object* %18
}

declare i8* @lean_alloc_small(i32, i32) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_ctor_memory(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64*, align 8
  store i32 %0, i32* %2, align 4
  %7 = load i32, i32* %2, align 4
  %8 = zext i32 %7 to i64
  %9 = call i64 @lean_align(i64 %8, i64 8)
  %10 = trunc i64 %9 to i32
  store i32 %10, i32* %3, align 4
  %11 = load i32, i32* %3, align 4
  %12 = call i32 @lean_get_slot_idx(i32 %11)
  store i32 %12, i32* %4, align 4
  %13 = load i32, i32* %3, align 4
  %14 = icmp ule i32 %13, 4096
  br i1 %14, label %15, label %16

15:                                               ; preds = %1
  br label %17

16:                                               ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 339, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor_memory, i64 0, i64 0)) #5
  unreachable

17:                                               ; preds = %15
  %18 = load i32, i32* %3, align 4
  %19 = load i32, i32* %4, align 4
  %20 = call i8* @lean_alloc_small(i32 %18, i32 %19)
  %21 = bitcast i8* %20 to %struct.lean_object*
  store %struct.lean_object* %21, %struct.lean_object** %5, align 8
  %22 = load i32, i32* %3, align 4
  %23 = load i32, i32* %2, align 4
  %24 = icmp ugt i32 %22, %23
  br i1 %24, label %25, label %34

25:                                               ; preds = %17
  %26 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %27 = bitcast %struct.lean_object* %26 to i8*
  %28 = load i32, i32* %3, align 4
  %29 = zext i32 %28 to i64
  %30 = getelementptr inbounds i8, i8* %27, i64 %29
  %31 = bitcast i8* %30 to i64*
  store i64* %31, i64** %6, align 8
  %32 = load i64*, i64** %6, align 8
  %33 = getelementptr inbounds i64, i64* %32, i64 -1
  store i64 0, i64* %33, align 8
  br label %34

34:                                               ; preds = %25, %17
  %35 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %35
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_small_object_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = bitcast %struct.lean_object* %3 to i8*
  %5 = call i32 @lean_small_mem_size(i8* %4)
  ret i32 %5
}

declare i32 @lean_small_mem_size(i8*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_free_small_object(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = bitcast %struct.lean_object* %3 to i8*
  call void @lean_free_small(i8* %4)
  ret void
}

declare void @lean_free_small(i8*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_ptr_tag(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1
  ret i8 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_ptr_other(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 6
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  ret i32 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_mt(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 5
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 1
  ret i1 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_st(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 5
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 0
  ret i1 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_persistent(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 5
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %8, 2
  ret i1 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_has_rc(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_st(%struct.lean_object* %3)
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call zeroext i1 @lean_is_mt(%struct.lean_object* %6)
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ true, %1 ], [ %7, %5 ]
  ret i1 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64* @lean_get_rc_mt_addr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  ret i64* %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_inc_ref(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %6 = call zeroext i1 @lean_is_st(%struct.lean_object* %5)
  br i1 %6, label %7, label %12

7:                                                ; preds = %1
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %8, i32 0, i32 0
  %10 = load i64, i64* %9, align 8
  %11 = add i64 %10, 1
  store i64 %11, i64* %9, align 8
  br label %22

12:                                               ; preds = %1
  %13 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %14 = call zeroext i1 @lean_is_mt(%struct.lean_object* %13)
  br i1 %14, label %15, label %21

15:                                               ; preds = %12
  %16 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %17 = call i64* @lean_get_rc_mt_addr(%struct.lean_object* %16)
  store i64 1, i64* %3, align 8
  %18 = load i64, i64* %3, align 8
  %19 = atomicrmw add i64* %17, i64 %18 monotonic, align 8
  store i64 %19, i64* %4, align 8
  %20 = load i64, i64* %4, align 8
  br label %21

21:                                               ; preds = %15, %12
  br label %22

22:                                               ; preds = %21, %7
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_inc_ref_n(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call zeroext i1 @lean_is_st(%struct.lean_object* %7)
  br i1 %8, label %9, label %15

9:                                                ; preds = %2
  %10 = load i64, i64* %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %11, i32 0, i32 0
  %13 = load i64, i64* %12, align 8
  %14 = add i64 %13, %10
  store i64 %14, i64* %12, align 8
  br label %26

15:                                               ; preds = %2
  %16 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %17 = call zeroext i1 @lean_is_mt(%struct.lean_object* %16)
  br i1 %17, label %18, label %25

18:                                               ; preds = %15
  %19 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %20 = call i64* @lean_get_rc_mt_addr(%struct.lean_object* %19)
  %21 = load i64, i64* %4, align 8
  store i64 %21, i64* %5, align 8
  %22 = load i64, i64* %5, align 8
  %23 = atomicrmw add i64* %20, i64 %22 monotonic, align 8
  store i64 %23, i64* %6, align 8
  %24 = load i64, i64* %6, align 8
  br label %25

25:                                               ; preds = %18, %15
  br label %26

26:                                               ; preds = %25, %9
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_dec_ref_core(%struct.lean_object* %0) #0 {
  %2 = alloca i1, align 1
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = call zeroext i1 @lean_is_st(%struct.lean_object* %6)
  br i1 %7, label %8, label %18

8:                                                ; preds = %1
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %9, i32 0, i32 0
  %11 = load i64, i64* %10, align 8
  %12 = add i64 %11, -1
  store i64 %12, i64* %10, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %13, i32 0, i32 0
  %15 = load i64, i64* %14, align 8
  %16 = and i64 %15, 4294967295
  %17 = icmp eq i64 %16, 0
  store i1 %17, i1* %2, align 1
  br label %30

18:                                               ; preds = %1
  %19 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %20 = call zeroext i1 @lean_is_mt(%struct.lean_object* %19)
  br i1 %20, label %21, label %29

21:                                               ; preds = %18
  %22 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %23 = call i64* @lean_get_rc_mt_addr(%struct.lean_object* %22)
  store i64 1, i64* %4, align 8
  %24 = load i64, i64* %4, align 8
  %25 = atomicrmw sub i64* %23, i64 %24 acq_rel, align 8
  store i64 %25, i64* %5, align 8
  %26 = load i64, i64* %5, align 8
  %27 = and i64 %26, 4294967295
  %28 = icmp eq i64 %27, 1
  store i1 %28, i1* %2, align 1
  br label %30

29:                                               ; preds = %18
  store i1 false, i1* %2, align 1
  br label %30

30:                                               ; preds = %29, %21, %8
  %31 = load i1, i1* %2, align 1
  ret i1 %31
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_dec_ref(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_dec_ref_core(%struct.lean_object* %3)
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_del(%struct.lean_object* %6)
  br label %7

7:                                                ; preds = %5, %1
  ret void
}

declare void @lean_del(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_inc(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_inc_ref(%struct.lean_object* %6)
  br label %7

7:                                                ; preds = %5, %1
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_inc_n(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %5)
  br i1 %6, label %10, label %7

7:                                                ; preds = %2
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = load i64, i64* %4, align 8
  call void @lean_inc_ref_n(%struct.lean_object* %8, i64 %9)
  br label %10

10:                                               ; preds = %7, %2
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_dec(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec_ref(%struct.lean_object* %6)
  br label %7

7:                                                ; preds = %5, %1
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_ctor(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp sle i32 %5, 244
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_closure(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 245
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 246
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_sarray(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 248
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_string(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 249
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_mpz(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 250
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_thunk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 251
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_task(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 252
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_external(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 254
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_ref(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 253
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_obj_tag(%struct.lean_object* %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %4)
  br i1 %5, label %6, label %10

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i64 @lean_unbox(%struct.lean_object* %7)
  %9 = trunc i64 %8 to i32
  store i32 %9, i32* %2, align 4
  br label %14

10:                                               ; preds = %1
  %11 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %12 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %11)
  %13 = zext i8 %12 to i32
  store i32 %13, i32* %2, align 4
  br label %14

14:                                               ; preds = %10, %6
  %15 = load i32, i32* %2, align 4
  ret i32 %15
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_ctor_object* @lean_to_ctor(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 570, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_to_ctor, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_ctor_object*
  ret %struct.lean_ctor_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_closure(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_closure_object*
  ret %struct.lean_closure_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_array_object* @lean_to_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_array(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_array_object*
  ret %struct.lean_array_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_sarray(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_sarray_object*
  ret %struct.lean_sarray_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_string_object* @lean_to_string(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_string(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_string_object*
  ret %struct.lean_string_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_thunk_object* @lean_to_thunk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_thunk(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 575, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_thunk, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_thunk_object*
  ret %struct.lean_thunk_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_task* @lean_to_task(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_task(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 576, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_to_task, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_task*
  ret %struct.lean_task* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_ref_object* @lean_to_ref(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ref(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 577, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @__PRETTY_FUNCTION__.lean_to_ref, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_ref_object*
  ret %struct.lean_ref_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_external_object* @lean_to_external(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_external(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 578, i8* getelementptr inbounds ([54 x i8], [54 x i8]* @__PRETTY_FUNCTION__.lean_to_external, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_external_object*
  ret %struct.lean_external_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_exclusive(%struct.lean_object* %0) #0 {
  %2 = alloca i1, align 1
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_st(%struct.lean_object* %4)
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %7, i32 0, i32 0
  %9 = load i64, i64* %8, align 8
  %10 = and i64 %9, 4294967295
  %11 = icmp eq i64 %10, 1
  store i1 %11, i1* %2, align 1
  br label %13

12:                                               ; preds = %1
  store i1 false, i1* %2, align 1
  br label %13

13:                                               ; preds = %12, %6
  %14 = load i1, i1* %2, align 1
  ret i1 %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_is_shared(%struct.lean_object* %0) #0 {
  %2 = alloca i1, align 1
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_st(%struct.lean_object* %4)
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %7, i32 0, i32 0
  %9 = load i64, i64* %8, align 8
  %10 = and i64 %9, 4294967295
  %11 = icmp ugt i64 %10, 1
  store i1 %11, i1* %2, align 1
  br label %13

12:                                               ; preds = %1
  store i1 false, i1* %2, align 1
  br label %13

13:                                               ; preds = %12, %6
  %14 = load i1, i1* %2, align 1
  ret i1 %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_nonzero_rc(%struct.lean_object* %0) #0 {
  %2 = alloca i1, align 1
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call zeroext i1 @lean_is_st(%struct.lean_object* %5)
  br i1 %6, label %7, label %13

7:                                                ; preds = %1
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %8, i32 0, i32 0
  %10 = load i64, i64* %9, align 8
  %11 = and i64 %10, 4294967295
  %12 = icmp ugt i64 %11, 0
  store i1 %12, i1* %2, align 1
  br label %24

13:                                               ; preds = %1
  %14 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %15 = call zeroext i1 @lean_is_mt(%struct.lean_object* %14)
  br i1 %15, label %16, label %23

16:                                               ; preds = %13
  %17 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %18 = call i64* @lean_get_rc_mt_addr(%struct.lean_object* %17)
  %19 = load atomic i64, i64* %18 acquire, align 8
  store i64 %19, i64* %4, align 8
  %20 = load i64, i64* %4, align 8
  %21 = and i64 %20, 4294967295
  %22 = icmp ugt i64 %21, 0
  store i1 %22, i1* %2, align 1
  br label %24

23:                                               ; preds = %13
  store i1 false, i1* %2, align 1
  br label %24

24:                                               ; preds = %23, %16, %7
  %25 = load i1, i1* %2, align 1
  ret i1 %25
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_set_st_header(%struct.lean_object* %0, i32 %1, i32 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = shl i64 %8, 56
  %10 = load i32, i32* %6, align 4
  %11 = zext i32 %10 to i64
  %12 = shl i64 %11, 48
  %13 = or i64 %9, %12
  %14 = or i64 %13, 1
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %16 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %15, i32 0, i32 0
  store i64 %14, i64* %16, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_set_non_heap_header(%struct.lean_object* %0, i64 %1, i32 %2, i32 %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store i64 %1, i64* %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %9 = load i64, i64* %6, align 8
  %10 = icmp ugt i64 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %4
  br label %13

12:                                               ; preds = %4
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 659, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #5
  unreachable

13:                                               ; preds = %11
  %14 = load i64, i64* %6, align 8
  %15 = icmp ult i64 %14, 35184372088832
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  br label %18

17:                                               ; preds = %13
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 660, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #5
  unreachable

18:                                               ; preds = %16
  %19 = load i64, i64* %6, align 8
  %20 = icmp eq i64 %19, 1
  br i1 %20, label %25, label %21

21:                                               ; preds = %18
  %22 = load i32, i32* %7, align 4
  %23 = trunc i32 %22 to i8
  %24 = call zeroext i1 @lean_is_big_object_tag(i8 zeroext %23)
  br i1 %24, label %26, label %25

25:                                               ; preds = %21, %18
  br label %27

26:                                               ; preds = %21
  call void @__assert_fail(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 661, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #5
  unreachable

27:                                               ; preds = %25
  %28 = load i32, i32* %7, align 4
  %29 = zext i32 %28 to i64
  %30 = shl i64 %29, 56
  %31 = load i32, i32* %8, align 4
  %32 = zext i32 %31 to i64
  %33 = shl i64 %32, 48
  %34 = or i64 %30, %33
  %35 = or i64 %34, 3298534883328
  %36 = load i64, i64* %6, align 8
  %37 = or i64 %35, %36
  %38 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %39 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %38, i32 0, i32 0
  store i64 %37, i64* %39, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_set_non_heap_header_for_big(%struct.lean_object* %0, i32 %1, i32 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = load i32, i32* %5, align 4
  %9 = load i32, i32* %6, align 4
  call void @lean_set_non_heap_header(%struct.lean_object* %7, i64 1, i32 %8, i32 %9)
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_ctor_num_objs(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call i32 @lean_ptr_other(%struct.lean_object* %8)
  ret i32 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 687, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_ctor_obj_cptr, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_ctor_object* @lean_to_ctor(%struct.lean_object* %8)
  %10 = getelementptr inbounds %struct.lean_ctor_object, %struct.lean_ctor_object* %9, i32 0, i32 1
  %11 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %10, i64 0, i64 0
  ret %struct.lean_object** %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i8* @lean_ctor_scalar_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 692, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_ctor_scalar_cptr, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %8)
  %10 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %11 = call i32 @lean_ctor_num_objs(%struct.lean_object* %10)
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %9, i64 %12
  %14 = bitcast %struct.lean_object** %13 to i8*
  ret i8* %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_ctor(i32 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.lean_object*, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %4, align 4
  %9 = icmp ule i32 %8, 244
  br i1 %9, label %10, label %17

10:                                               ; preds = %3
  %11 = load i32, i32* %5, align 4
  %12 = icmp ult i32 %11, 256
  br i1 %12, label %13, label %17

13:                                               ; preds = %10
  %14 = load i32, i32* %6, align 4
  %15 = icmp ult i32 %14, 1024
  br i1 %15, label %16, label %17

16:                                               ; preds = %13
  br label %18

17:                                               ; preds = %13, %10, %3
  call void @__assert_fail(i8* getelementptr inbounds ([99 x i8], [99 x i8]* @.str.16, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 697, i8* getelementptr inbounds ([71 x i8], [71 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor, i64 0, i64 0)) #5
  unreachable

18:                                               ; preds = %16
  %19 = load i32, i32* %5, align 4
  %20 = zext i32 %19 to i64
  %21 = mul i64 8, %20
  %22 = add i64 8, %21
  %23 = load i32, i32* %6, align 4
  %24 = zext i32 %23 to i64
  %25 = add i64 %22, %24
  %26 = trunc i64 %25 to i32
  %27 = call %struct.lean_object* @lean_alloc_ctor_memory(i32 %26)
  store %struct.lean_object* %27, %struct.lean_object** %7, align 8
  %28 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %29 = load i32, i32* %4, align 4
  %30 = load i32, i32* %5, align 4
  call void @lean_set_st_header(%struct.lean_object* %28, i32 %29, i32 %30)
  %31 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %31
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_ctor_get(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = call i32 @lean_ctor_num_objs(%struct.lean_object* %6)
  %8 = icmp ult i32 %5, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %11

10:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 704, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #5
  unreachable

11:                                               ; preds = %9
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %12)
  %14 = load i32, i32* %4, align 4
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %13, i64 %15
  %17 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  ret %struct.lean_object* %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set(%struct.lean_object* %0, i32 %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call i32 @lean_ctor_num_objs(%struct.lean_object* %8)
  %10 = icmp ult i32 %7, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %3
  br label %13

12:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 709, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set, i64 0, i64 0)) #5
  unreachable

13:                                               ; preds = %11
  %14 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = load i32, i32* %5, align 4
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %16, i64 %18
  store %struct.lean_object* %14, %struct.lean_object** %19, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_tag(%struct.lean_object* %0, i8 zeroext %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i8, align 1
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = icmp sle i32 %6, 244
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %10

9:                                                ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.18, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 714, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_tag, i64 0, i64 0)) #5
  unreachable

10:                                               ; preds = %8
  %11 = load i8, i8* %4, align 1
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %12, i32 0, i32 0
  %14 = bitcast i64* %13 to i8*
  %15 = getelementptr inbounds i8, i8* %14, i64 7
  store i8 %11, i8* %15, align 1
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_release(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  %5 = alloca %struct.lean_object**, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load i32, i32* %4, align 4
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = icmp ult i32 %6, %8
  br i1 %9, label %10, label %11

10:                                               ; preds = %2
  br label %12

11:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 723, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @__PRETTY_FUNCTION__.lean_ctor_release, i64 0, i64 0)) #5
  unreachable

12:                                               ; preds = %10
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %14 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %13)
  store %struct.lean_object** %14, %struct.lean_object*** %5, align 8
  %15 = load %struct.lean_object**, %struct.lean_object*** %5, align 8
  %16 = load i32, i32* %4, align 4
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %15, i64 %17
  %19 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_dec(%struct.lean_object* %19)
  %20 = call %struct.lean_object* @lean_box(i64 0)
  %21 = load %struct.lean_object**, %struct.lean_object*** %5, align 8
  %22 = load i32, i32* %4, align 4
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %21, i64 %23
  store %struct.lean_object* %20, %struct.lean_object** %24, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_ctor_get_usize(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = call i32 @lean_ctor_num_objs(%struct.lean_object* %6)
  %8 = icmp uge i32 %5, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %11

10:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 730, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_usize, i64 0, i64 0)) #5
  unreachable

11:                                               ; preds = %9
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %12)
  %14 = load i32, i32* %4, align 4
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %13, i64 %15
  %17 = bitcast %struct.lean_object** %16 to i64*
  %18 = load i64, i64* %17, align 8
  ret i64 %18
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_ctor_get_uint8(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = zext i32 %5 to i64
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = zext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = icmp uge i64 %6, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %14

13:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 735, i8* getelementptr inbounds ([58 x i8], [58 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint8, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = bitcast %struct.lean_object** %16 to i8*
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  %21 = load i8, i8* %20, align 1
  ret i8 %21
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_ctor_get_uint16(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = zext i32 %5 to i64
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = zext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = icmp uge i64 %6, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %14

13:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 740, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint16, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = bitcast %struct.lean_object** %16 to i8*
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  %21 = bitcast i8* %20 to i16*
  %22 = load i16, i16* %21, align 2
  ret i16 %22
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_ctor_get_uint32(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = zext i32 %5 to i64
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = zext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = icmp uge i64 %6, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %14

13:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 745, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint32, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = bitcast %struct.lean_object** %16 to i8*
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  %21 = bitcast i8* %20 to i32*
  %22 = load i32, i32* %21, align 4
  ret i32 %22
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_ctor_get_uint64(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = zext i32 %5 to i64
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = zext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = icmp uge i64 %6, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %14

13:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 750, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint64, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = bitcast %struct.lean_object** %16 to i8*
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  %21 = bitcast i8* %20 to i64*
  %22 = load i64, i64* %21, align 8
  ret i64 %22
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_ctor_get_float(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = zext i32 %5 to i64
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_ctor_num_objs(%struct.lean_object* %7)
  %9 = zext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = icmp uge i64 %6, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %2
  br label %14

13:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 755, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_float, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = bitcast %struct.lean_object** %16 to i8*
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds i8, i8* %17, i64 %19
  %21 = bitcast i8* %20 to double*
  %22 = load double, double* %21, align 8
  ret double %22
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_usize(%struct.lean_object* %0, i32 %1, i64 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i64 %2, i64* %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call i32 @lean_ctor_num_objs(%struct.lean_object* %8)
  %10 = icmp uge i32 %7, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %3
  br label %13

12:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 760, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_usize, i64 0, i64 0)) #5
  unreachable

13:                                               ; preds = %11
  %14 = load i64, i64* %6, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %16 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %15)
  %17 = load i32, i32* %5, align 4
  %18 = zext i32 %17 to i64
  %19 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %16, i64 %18
  %20 = bitcast %struct.lean_object** %19 to i64*
  store i64 %14, i64* %20, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_uint8(%struct.lean_object* %0, i32 %1, i8 zeroext %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i8, align 1
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i8 %2, i8* %6, align 1
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call i32 @lean_ctor_num_objs(%struct.lean_object* %9)
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 8
  %13 = icmp uge i64 %8, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 765, i8* getelementptr inbounds ([64 x i8], [64 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint8, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i8, i8* %6, align 1
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %19 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %18)
  %20 = bitcast %struct.lean_object** %19 to i8*
  %21 = load i32, i32* %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i8, i8* %20, i64 %22
  store i8 %17, i8* %23, align 1
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_uint16(%struct.lean_object* %0, i32 %1, i16 zeroext %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i16, align 2
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i16 %2, i16* %6, align 2
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call i32 @lean_ctor_num_objs(%struct.lean_object* %9)
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 8
  %13 = icmp uge i64 %8, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 770, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint16, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i16, i16* %6, align 2
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %19 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %18)
  %20 = bitcast %struct.lean_object** %19 to i8*
  %21 = load i32, i32* %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i8, i8* %20, i64 %22
  %24 = bitcast i8* %23 to i16*
  store i16 %17, i16* %24, align 2
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_uint32(%struct.lean_object* %0, i32 %1, i32 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call i32 @lean_ctor_num_objs(%struct.lean_object* %9)
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 8
  %13 = icmp uge i64 %8, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 775, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint32, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i32, i32* %6, align 4
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %19 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %18)
  %20 = bitcast %struct.lean_object** %19 to i8*
  %21 = load i32, i32* %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i8, i8* %20, i64 %22
  %24 = bitcast i8* %23 to i32*
  store i32 %17, i32* %24, align 4
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_uint64(%struct.lean_object* %0, i32 %1, i64 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i64 %2, i64* %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call i32 @lean_ctor_num_objs(%struct.lean_object* %9)
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 8
  %13 = icmp uge i64 %8, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 780, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint64, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i64, i64* %6, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %19 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %18)
  %20 = bitcast %struct.lean_object** %19 to i8*
  %21 = load i32, i32* %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i8, i8* %20, i64 %22
  %24 = bitcast i8* %23 to i64*
  store i64 %17, i64* %24, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_ctor_set_float(%struct.lean_object* %0, i32 %1, double %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store double %2, double* %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = zext i32 %7 to i64
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call i32 @lean_ctor_num_objs(%struct.lean_object* %9)
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 8
  %13 = icmp uge i64 %8, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %3
  br label %16

15:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 785, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_float, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load double, double* %6, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %19 = call %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %18)
  %20 = bitcast %struct.lean_object** %19 to i8*
  %21 = load i32, i32* %5, align 4
  %22 = zext i32 %21 to i64
  %23 = getelementptr inbounds i8, i8* %20, i64 %22
  %24 = bitcast i8* %23 to double*
  store double %17, double* %24, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i8* @lean_closure_fun(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %4, i32 0, i32 1
  %6 = load i8*, i8** %5, align 8
  ret i8* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_closure_arity(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %4, i32 0, i32 2
  %6 = load i16, i16* %5, align 8
  %7 = zext i16 %6 to i32
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_closure_num_fixed(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %4, i32 0, i32 3
  %6 = load i16, i16* %5, align 2
  %7 = zext i16 %6 to i32
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object** @lean_closure_arg_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %4, i32 0, i32 4
  %6 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %5, i64 0, i64 0
  ret %struct.lean_object** %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_closure(i8* %0, i32 %1, i32 %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.lean_closure_object*, align 8
  store i8* %0, i8** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  %8 = load i32, i32* %5, align 4
  %9 = icmp ugt i32 %8, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  br label %12

11:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 796, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #5
  unreachable

12:                                               ; preds = %10
  %13 = load i32, i32* %6, align 4
  %14 = load i32, i32* %5, align 4
  %15 = icmp ult i32 %13, %14
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  br label %18

17:                                               ; preds = %12
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 797, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #5
  unreachable

18:                                               ; preds = %16
  %19 = load i32, i32* %6, align 4
  %20 = zext i32 %19 to i64
  %21 = mul i64 8, %20
  %22 = add i64 24, %21
  %23 = trunc i64 %22 to i32
  %24 = call %struct.lean_object* @lean_alloc_small_object(i32 %23)
  %25 = bitcast %struct.lean_object* %24 to %struct.lean_closure_object*
  store %struct.lean_closure_object* %25, %struct.lean_closure_object** %7, align 8
  %26 = load %struct.lean_closure_object*, %struct.lean_closure_object** %7, align 8
  %27 = bitcast %struct.lean_closure_object* %26 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %27, i32 245, i32 0)
  %28 = load i8*, i8** %4, align 8
  %29 = load %struct.lean_closure_object*, %struct.lean_closure_object** %7, align 8
  %30 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %29, i32 0, i32 1
  store i8* %28, i8** %30, align 8
  %31 = load i32, i32* %5, align 4
  %32 = trunc i32 %31 to i16
  %33 = load %struct.lean_closure_object*, %struct.lean_closure_object** %7, align 8
  %34 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %33, i32 0, i32 2
  store i16 %32, i16* %34, align 8
  %35 = load i32, i32* %6, align 4
  %36 = trunc i32 %35 to i16
  %37 = load %struct.lean_closure_object*, %struct.lean_closure_object** %7, align 8
  %38 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %37, i32 0, i32 3
  store i16 %36, i16* %38, align 2
  %39 = load %struct.lean_closure_object*, %struct.lean_closure_object** %7, align 8
  %40 = bitcast %struct.lean_closure_object* %39 to %struct.lean_object*
  ret %struct.lean_object* %40
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_closure_get(%struct.lean_object* %0, i32 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = call i32 @lean_closure_num_fixed(%struct.lean_object* %6)
  %8 = icmp ult i32 %5, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %11

10:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 806, i8* getelementptr inbounds ([62 x i8], [62 x i8]* @__PRETTY_FUNCTION__.lean_closure_get, i64 0, i64 0)) #5
  unreachable

11:                                               ; preds = %9
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %12)
  %14 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %13, i32 0, i32 4
  %15 = load i32, i32* %4, align 4
  %16 = zext i32 %15 to i64
  %17 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %14, i64 0, i64 %16
  %18 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  ret %struct.lean_object* %18
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_closure_set(%struct.lean_object* %0, i32 %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load i32, i32* %5, align 4
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call i32 @lean_closure_num_fixed(%struct.lean_object* %8)
  %10 = icmp ult i32 %7, %9
  br i1 %10, label %11, label %12

11:                                               ; preds = %3
  br label %13

12:                                               ; preds = %3
  call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 810, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_closure_set, i64 0, i64 0)) #5
  unreachable

13:                                               ; preds = %11
  %14 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %16 = call %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* %15)
  %17 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %16, i32 0, i32 4
  %18 = load i32, i32* %5, align 4
  %19 = zext i32 %18 to i64
  %20 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %17, i64 0, i64 %19
  store %struct.lean_object* %14, %struct.lean_object** %20, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_array(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.lean_array_object*, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %6 = load i64, i64* %4, align 8
  %7 = mul i64 8, %6
  %8 = add i64 24, %7
  %9 = call %struct.lean_object* @lean_alloc_object(i64 %8)
  %10 = bitcast %struct.lean_object* %9 to %struct.lean_array_object*
  store %struct.lean_array_object* %10, %struct.lean_array_object** %5, align 8
  %11 = load %struct.lean_array_object*, %struct.lean_array_object** %5, align 8
  %12 = bitcast %struct.lean_array_object* %11 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %12, i32 246, i32 0)
  %13 = load i64, i64* %3, align 8
  %14 = load %struct.lean_array_object*, %struct.lean_array_object** %5, align 8
  %15 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %14, i32 0, i32 1
  store i64 %13, i64* %15, align 8
  %16 = load i64, i64* %4, align 8
  %17 = load %struct.lean_array_object*, %struct.lean_array_object** %5, align 8
  %18 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %17, i32 0, i32 2
  store i64 %16, i64* %18, align 8
  %19 = load %struct.lean_array_object*, %struct.lean_array_object** %5, align 8
  %20 = bitcast %struct.lean_array_object* %19 to %struct.lean_object*
  ret %struct.lean_object* %20
}

declare %struct.lean_object* @lean_alloc_object(i64) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_array_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %4, i32 0, i32 1
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_array_capacity(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %4, i32 0, i32 2
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_array_byte_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_array_capacity(%struct.lean_object* %3)
  %5 = mul i64 8, %4
  %6 = add i64 24, %5
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object** @lean_array_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %4, i32 0, i32 3
  %6 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %5, i64 0, i64 0
  ret %struct.lean_object** %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_array_set_size(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call zeroext i1 @lean_is_array(%struct.lean_object* %5)
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %9

8:                                                ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 858, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #5
  unreachable

9:                                                ; preds = %7
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %11 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %10)
  br i1 %11, label %12, label %13

12:                                               ; preds = %9
  br label %14

13:                                               ; preds = %9
  call void @__assert_fail(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 859, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load i64, i64* %4, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %17 = call i64 @lean_array_capacity(%struct.lean_object* %16)
  %18 = icmp ule i64 %15, %17
  br i1 %18, label %19, label %20

19:                                               ; preds = %14
  br label %21

20:                                               ; preds = %14
  call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.25, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 860, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #5
  unreachable

21:                                               ; preds = %19
  %22 = load i64, i64* %4, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %24 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %23)
  %25 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %24, i32 0, i32 1
  store i64 %22, i64* %25, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_get_core(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %4, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = call i64 @lean_array_size(%struct.lean_object* %6)
  %8 = icmp ult i64 %5, %7
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %11

10:                                               ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 864, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #5
  unreachable

11:                                               ; preds = %9
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %12)
  %14 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %13, i32 0, i32 3
  %15 = load i64, i64* %4, align 8
  %16 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %14, i64 0, i64 %15
  %17 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  ret %struct.lean_object* %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_array_set_core(%struct.lean_object* %0, i64 %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i64 %1, i64* %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = call zeroext i1 @lean_has_rc(%struct.lean_object* %7)
  br i1 %8, label %9, label %12

9:                                                ; preds = %3
  %10 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %11 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %10)
  br i1 %11, label %12, label %13

12:                                               ; preds = %9, %3
  br label %14

13:                                               ; preds = %9
  call void @__assert_fail(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.27, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 870, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_array_set_core, i64 0, i64 0)) #5
  unreachable

14:                                               ; preds = %12
  %15 = load i64, i64* %5, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %17 = call i64 @lean_array_size(%struct.lean_object* %16)
  %18 = icmp ult i64 %15, %17
  br i1 %18, label %19, label %20

19:                                               ; preds = %14
  br label %21

20:                                               ; preds = %14
  call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 871, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_array_set_core, i64 0, i64 0)) #5
  unreachable

21:                                               ; preds = %19
  %22 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %24 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %23)
  %25 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %24, i32 0, i32 3
  %26 = load i64, i64* %5, align 8
  %27 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %25, i64 0, i64 %26
  store %struct.lean_object* %22, %struct.lean_object** %27, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_sz(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call i64 @lean_array_size(%struct.lean_object* %4)
  %6 = call %struct.lean_object* @lean_box(i64 %5)
  store %struct.lean_object* %6, %struct.lean_object** %3, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %7)
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_get_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_array_size(%struct.lean_object* %3)
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_array() #0 {
  %1 = call %struct.lean_object* @lean_alloc_array(i64 0, i64 0)
  ret %struct.lean_object* %1
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_array_with_capacity(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void (...) @lean_internal_panic_out_of_memory() #6
  unreachable

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %8 = call i64 @lean_unbox(%struct.lean_object* %7)
  %9 = call %struct.lean_object* @lean_alloc_array(i64 0, i64 %8)
  ret %struct.lean_object* %9
}

; Function Attrs: noreturn
declare void @lean_internal_panic_out_of_memory(...) #3

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uget(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %7 = load i64, i64* %4, align 8
  %8 = call %struct.lean_object* @lean_array_get_core(%struct.lean_object* %6, i64 %7)
  store %struct.lean_object* %8, %struct.lean_object** %5, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_inc(%struct.lean_object* %9)
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fget(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  %8 = call %struct.lean_object* @lean_array_uget(%struct.lean_object* %5, i64 %7)
  ret %struct.lean_object* %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_get(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br i1 %10, label %11, label %24

11:                                               ; preds = %3
  %12 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %13 = call i64 @lean_unbox(%struct.lean_object* %12)
  store i64 %13, i64* %8, align 8
  %14 = load i64, i64* %8, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %16 = call i64 @lean_array_size(%struct.lean_object* %15)
  %17 = icmp ult i64 %14, %16
  br i1 %17, label %18, label %23

18:                                               ; preds = %11
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %19)
  %20 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %21 = load i64, i64* %8, align 8
  %22 = call %struct.lean_object* @lean_array_uget(%struct.lean_object* %20, i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %4, align 8
  br label %27

23:                                               ; preds = %11
  br label %24

24:                                               ; preds = %23, %3
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_array_get_panic(%struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %4, align 8
  br label %27

27:                                               ; preds = %24, %18
  %28 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_array_get_panic(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_copy_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* %3, i1 zeroext false)
  ret %struct.lean_object* %4
}

declare %struct.lean_object* @lean_copy_expand_array(%struct.lean_object*, i1 zeroext) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %4)
  br i1 %5, label %6, label %8

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  store %struct.lean_object* %7, %struct.lean_object** %2, align 8
  br label %11

8:                                                ; preds = %1
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = call %struct.lean_object* @lean_copy_array(%struct.lean_object* %9)
  store %struct.lean_object* %10, %struct.lean_object** %2, align 8
  br label %11

11:                                               ; preds = %8, %6
  %12 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %12
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uset(%struct.lean_object* %0, i64 %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object**, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i64 %1, i64* %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %9)
  store %struct.lean_object* %10, %struct.lean_object** %7, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %12 = call %struct.lean_object** @lean_array_cptr(%struct.lean_object* %11)
  %13 = load i64, i64* %5, align 8
  %14 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %12, i64 %13
  store %struct.lean_object** %14, %struct.lean_object*** %8, align 8
  %15 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %16)
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %18 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  store %struct.lean_object* %17, %struct.lean_object** %18, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %19
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fset(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  %10 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %11 = call %struct.lean_object* @lean_array_uset(%struct.lean_object* %7, i64 %9, %struct.lean_object* %10)
  ret %struct.lean_object* %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_set(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br i1 %10, label %11, label %24

11:                                               ; preds = %3
  %12 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %13 = call i64 @lean_unbox(%struct.lean_object* %12)
  store i64 %13, i64* %8, align 8
  %14 = load i64, i64* %8, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %16 = call i64 @lean_array_size(%struct.lean_object* %15)
  %17 = icmp ult i64 %14, %16
  br i1 %17, label %18, label %23

18:                                               ; preds = %11
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = load i64, i64* %8, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %22 = call %struct.lean_object* @lean_array_uset(%struct.lean_object* %19, i64 %20, %struct.lean_object* %21)
  store %struct.lean_object* %22, %struct.lean_object** %4, align 8
  br label %28

23:                                               ; preds = %11
  br label %24

24:                                               ; preds = %23, %3
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %27 = call %struct.lean_object* @lean_array_set_panic(%struct.lean_object* %25, %struct.lean_object* %26)
  store %struct.lean_object* %27, %struct.lean_object** %4, align 8
  br label %28

28:                                               ; preds = %24, %18
  %29 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %29
}

declare %struct.lean_object* @lean_array_set_panic(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_pop(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i64, align 8
  %6 = alloca %struct.lean_object**, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %7)
  store %struct.lean_object* %8, %struct.lean_object** %4, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %9)
  %11 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %10, i32 0, i32 1
  %12 = load i64, i64* %11, align 8
  store i64 %12, i64* %5, align 8
  %13 = load i64, i64* %5, align 8
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %1
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %16, %struct.lean_object** %2, align 8
  br label %31

17:                                               ; preds = %1
  %18 = load i64, i64* %5, align 8
  %19 = add i64 %18, -1
  store i64 %19, i64* %5, align 8
  %20 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %21 = call %struct.lean_object** @lean_array_cptr(%struct.lean_object* %20)
  %22 = load i64, i64* %5, align 8
  %23 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %21, i64 %22
  store %struct.lean_object** %23, %struct.lean_object*** %6, align 8
  %24 = load i64, i64* %5, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %26 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %25)
  %27 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %26, i32 0, i32 1
  store i64 %24, i64* %27, align 8
  %28 = load %struct.lean_object**, %struct.lean_object*** %6, align 8
  %29 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  call void @lean_dec(%struct.lean_object* %29)
  %30 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %30, %struct.lean_object** %2, align 8
  br label %31

31:                                               ; preds = %17, %15
  %32 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %32
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uswap(%struct.lean_object* %0, i64 %1, i64 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object**, align 8
  %9 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i64 %1, i64* %5, align 8
  store i64 %2, i64* %6, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %11 = call %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %10)
  store %struct.lean_object* %11, %struct.lean_object** %7, align 8
  %12 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %13 = call %struct.lean_object** @lean_array_cptr(%struct.lean_object* %12)
  store %struct.lean_object** %13, %struct.lean_object*** %8, align 8
  %14 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  %15 = load i64, i64* %5, align 8
  %16 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %14, i64 %15
  %17 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  store %struct.lean_object* %17, %struct.lean_object** %9, align 8
  %18 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  %19 = load i64, i64* %6, align 8
  %20 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %18, i64 %19
  %21 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %22 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  %23 = load i64, i64* %5, align 8
  %24 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %22, i64 %23
  store %struct.lean_object* %21, %struct.lean_object** %24, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %26 = load %struct.lean_object**, %struct.lean_object*** %8, align 8
  %27 = load i64, i64* %6, align 8
  %28 = getelementptr inbounds %struct.lean_object*, %struct.lean_object** %26, i64 %27
  store %struct.lean_object* %25, %struct.lean_object** %28, align 8
  %29 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %29
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fswap(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  %10 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  %12 = call %struct.lean_object* @lean_array_uswap(%struct.lean_object* %7, i64 %9, i64 %11)
  ret %struct.lean_object* %12
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_swap(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i64, align 8
  %9 = alloca i64, align 8
  %10 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br i1 %12, label %13, label %16

13:                                               ; preds = %3
  %14 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %15 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %14)
  br i1 %15, label %18, label %16

16:                                               ; preds = %13, %3
  %17 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %17, %struct.lean_object** %4, align 8
  br label %41

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  store i64 %20, i64* %8, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %22 = call i64 @lean_unbox(%struct.lean_object* %21)
  store i64 %22, i64* %9, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %24 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %23)
  %25 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %24, i32 0, i32 1
  %26 = load i64, i64* %25, align 8
  store i64 %26, i64* %10, align 8
  %27 = load i64, i64* %8, align 8
  %28 = load i64, i64* %10, align 8
  %29 = icmp uge i64 %27, %28
  br i1 %29, label %34, label %30

30:                                               ; preds = %18
  %31 = load i64, i64* %9, align 8
  %32 = load i64, i64* %10, align 8
  %33 = icmp uge i64 %31, %32
  br i1 %33, label %34, label %36

34:                                               ; preds = %30, %18
  %35 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %35, %struct.lean_object** %4, align 8
  br label %41

36:                                               ; preds = %30
  %37 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %38 = load i64, i64* %8, align 8
  %39 = load i64, i64* %9, align 8
  %40 = call %struct.lean_object* @lean_array_uswap(%struct.lean_object* %37, i64 %38, i64 %39)
  store %struct.lean_object* %40, %struct.lean_object** %4, align 8
  br label %41

41:                                               ; preds = %36, %34, %16
  %42 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %42
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_sarray(i32 %0, i64 %1, i64 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.lean_sarray_object*, align 8
  store i32 %0, i32* %4, align 4
  store i64 %1, i64* %5, align 8
  store i64 %2, i64* %6, align 8
  %8 = load i32, i32* %4, align 4
  %9 = zext i32 %8 to i64
  %10 = load i64, i64* %6, align 8
  %11 = mul i64 %9, %10
  %12 = add i64 24, %11
  %13 = call %struct.lean_object* @lean_alloc_object(i64 %12)
  %14 = bitcast %struct.lean_object* %13 to %struct.lean_sarray_object*
  store %struct.lean_sarray_object* %14, %struct.lean_sarray_object** %7, align 8
  %15 = load %struct.lean_sarray_object*, %struct.lean_sarray_object** %7, align 8
  %16 = bitcast %struct.lean_sarray_object* %15 to %struct.lean_object*
  %17 = load i32, i32* %4, align 4
  call void @lean_set_st_header(%struct.lean_object* %16, i32 248, i32 %17)
  %18 = load i64, i64* %5, align 8
  %19 = load %struct.lean_sarray_object*, %struct.lean_sarray_object** %7, align 8
  %20 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %19, i32 0, i32 1
  store i64 %18, i64* %20, align 8
  %21 = load i64, i64* %6, align 8
  %22 = load %struct.lean_sarray_object*, %struct.lean_sarray_object** %7, align 8
  %23 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %22, i32 0, i32 2
  store i64 %21, i64* %23, align 8
  %24 = load %struct.lean_sarray_object*, %struct.lean_sarray_object** %7, align 8
  %25 = bitcast %struct.lean_sarray_object* %24 to %struct.lean_object*
  ret %struct.lean_object* %25
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_sarray_elem_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_sarray(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1005, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_elem_size, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call i32 @lean_ptr_other(%struct.lean_object* %8)
  ret i32 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_sarray_capacity(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %4, i32 0, i32 2
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_sarray_byte_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i32 @lean_sarray_elem_size(%struct.lean_object* %3)
  %5 = zext i32 %4 to i64
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_sarray_capacity(%struct.lean_object* %6)
  %8 = mul i64 %5, %7
  %9 = add i64 24, %8
  ret i64 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_sarray_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %4, i32 0, i32 1
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define void @lean_sarray_set_size(%struct.lean_object* %0, i64 %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %5)
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %9

8:                                                ; preds = %2
  call void @__assert_fail(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1014, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_set_size, i64 0, i64 0)) #5
  unreachable

9:                                                ; preds = %7
  %10 = load i64, i64* %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %12 = call i64 @lean_sarray_capacity(%struct.lean_object* %11)
  %13 = icmp ule i64 %10, %12
  br i1 %13, label %14, label %15

14:                                               ; preds = %9
  br label %16

15:                                               ; preds = %9
  call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.28, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1015, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_set_size, i64 0, i64 0)) #5
  unreachable

16:                                               ; preds = %14
  %17 = load i64, i64* %4, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %19 = call %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* %18)
  %20 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %19, i32 0, i32 1
  store i64 %17, i64* %20, align 8
  ret void
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i8* @lean_sarray_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_sarray_object, %struct.lean_sarray_object* %4, i32 0, i32 3
  %6 = getelementptr inbounds [0 x i8], [0 x i8]* %5, i64 0, i64 0
  ret i8* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_byte_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void (...) @lean_internal_panic_out_of_memory() #6
  unreachable

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %8 = call i64 @lean_unbox(%struct.lean_object* %7)
  %9 = call %struct.lean_object* @lean_alloc_sarray(i32 1, i64 0, i64 %8)
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_byte_array_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_sarray_size(%struct.lean_object* %3)
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_byte_array_get(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %27

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %6, align 8
  %12 = load i64, i64* %6, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %14 = call i64 @lean_sarray_size(%struct.lean_object* %13)
  %15 = icmp ult i64 %12, %14
  br i1 %15, label %16, label %23

16:                                               ; preds = %9
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i8* @lean_sarray_cptr(%struct.lean_object* %17)
  %19 = load i64, i64* %6, align 8
  %20 = getelementptr inbounds i8, i8* %18, i64 %19
  %21 = load i8, i8* %20, align 1
  %22 = zext i8 %21 to i32
  br label %24

23:                                               ; preds = %9
  br label %24

24:                                               ; preds = %23, %16
  %25 = phi i32 [ %22, %16 ], [ 0, %23 ]
  %26 = trunc i32 %25 to i8
  store i8 %26, i8* %3, align 1
  br label %28

27:                                               ; preds = %2
  store i8 0, i8* %3, align 1
  br label %28

28:                                               ; preds = %27, %24
  %29 = load i8, i8* %3, align 1
  ret i8 %29
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_byte_array_set(%struct.lean_object* %0, %struct.lean_object* %1, i8 zeroext %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca i8, align 1
  %8 = alloca i64, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca i8*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store i8 %2, i8* %7, align 1
  %11 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br i1 %12, label %15, label %13

13:                                               ; preds = %3
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %14, %struct.lean_object** %4, align 8
  br label %40

15:                                               ; preds = %3
  %16 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %17 = call i64 @lean_unbox(%struct.lean_object* %16)
  store i64 %17, i64* %8, align 8
  %18 = load i64, i64* %8, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_sarray_size(%struct.lean_object* %19)
  %21 = icmp uge i64 %18, %20
  br i1 %21, label %22, label %24

22:                                               ; preds = %15
  %23 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %23, %struct.lean_object** %4, align 8
  br label %40

24:                                               ; preds = %15
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %25)
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  %28 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %28, %struct.lean_object** %9, align 8
  br label %32

29:                                               ; preds = %24
  %30 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %31 = call %struct.lean_object* @lean_copy_byte_array(%struct.lean_object* %30)
  store %struct.lean_object* %31, %struct.lean_object** %9, align 8
  br label %32

32:                                               ; preds = %29, %27
  %33 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %34 = call i8* @lean_sarray_cptr(%struct.lean_object* %33)
  %35 = load i64, i64* %8, align 8
  %36 = getelementptr inbounds i8, i8* %34, i64 %35
  store i8* %36, i8** %10, align 8
  %37 = load i8, i8* %7, align 1
  %38 = load i8*, i8** %10, align 8
  store i8 %37, i8* %38, align 1
  %39 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  store %struct.lean_object* %39, %struct.lean_object** %4, align 8
  br label %40

40:                                               ; preds = %32, %22, %13
  %41 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %41
}

declare %struct.lean_object* @lean_copy_byte_array(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_float_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %6, label %5

5:                                                ; preds = %1
  call void (...) @lean_internal_panic_out_of_memory() #6
  unreachable

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %8 = call i64 @lean_unbox(%struct.lean_object* %7)
  %9 = call %struct.lean_object* @lean_alloc_sarray(i32 8, i64 0, i64 %8)
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_float_array_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_sarray_size(%struct.lean_object* %3)
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double* @lean_float_array_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i8* @lean_sarray_cptr(%struct.lean_object* %3)
  %5 = bitcast i8* %4 to double*
  ret double* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_array_get(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %25

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %6, align 8
  %12 = load i64, i64* %6, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %14 = call i64 @lean_sarray_size(%struct.lean_object* %13)
  %15 = icmp ult i64 %12, %14
  br i1 %15, label %16, label %22

16:                                               ; preds = %9
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call double* @lean_float_array_cptr(%struct.lean_object* %17)
  %19 = load i64, i64* %6, align 8
  %20 = getelementptr inbounds double, double* %18, i64 %19
  %21 = load double, double* %20, align 8
  br label %23

22:                                               ; preds = %9
  br label %23

23:                                               ; preds = %22, %16
  %24 = phi double [ %21, %16 ], [ 0.000000e+00, %22 ]
  store double %24, double* %3, align 8
  br label %26

25:                                               ; preds = %2
  store double 0.000000e+00, double* %3, align 8
  br label %26

26:                                               ; preds = %25, %23
  %27 = load double, double* %3, align 8
  ret double %27
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_float_array_set(%struct.lean_object* %0, %struct.lean_object* %1, double %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca double, align 8
  %8 = alloca i64, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca double*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store double %2, double* %7, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br i1 %12, label %15, label %13

13:                                               ; preds = %3
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %14, %struct.lean_object** %4, align 8
  br label %40

15:                                               ; preds = %3
  %16 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %17 = call i64 @lean_unbox(%struct.lean_object* %16)
  store i64 %17, i64* %8, align 8
  %18 = load i64, i64* %8, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_sarray_size(%struct.lean_object* %19)
  %21 = icmp uge i64 %18, %20
  br i1 %21, label %22, label %24

22:                                               ; preds = %15
  %23 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %23, %struct.lean_object** %4, align 8
  br label %40

24:                                               ; preds = %15
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %25)
  br i1 %26, label %27, label %29

27:                                               ; preds = %24
  %28 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  store %struct.lean_object* %28, %struct.lean_object** %9, align 8
  br label %32

29:                                               ; preds = %24
  %30 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %31 = call %struct.lean_object* @lean_copy_float_array(%struct.lean_object* %30)
  store %struct.lean_object* %31, %struct.lean_object** %9, align 8
  br label %32

32:                                               ; preds = %29, %27
  %33 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %34 = call double* @lean_float_array_cptr(%struct.lean_object* %33)
  %35 = load i64, i64* %8, align 8
  %36 = getelementptr inbounds double, double* %34, i64 %35
  store double* %36, double** %10, align 8
  %37 = load double, double* %7, align 8
  %38 = load double*, double** %10, align 8
  store double %37, double* %38, align 8
  %39 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  store %struct.lean_object* %39, %struct.lean_object** %4, align 8
  br label %40

40:                                               ; preds = %32, %22, %13
  %41 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %41
}

declare %struct.lean_object* @lean_copy_float_array(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_array_fget(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  store i64 %7, i64* %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = call double* @lean_float_array_cptr(%struct.lean_object* %8)
  %10 = load i64, i64* %5, align 8
  %11 = getelementptr inbounds double, double* %9, i64 %10
  %12 = load double, double* %11, align 8
  ret double %12
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_float_array_fset(%struct.lean_object* %0, %struct.lean_object* %1, double %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca double, align 8
  %7 = alloca i64, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca double*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store double %2, double* %6, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %7, align 8
  %12 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %13 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %12)
  br i1 %13, label %14, label %16

14:                                               ; preds = %3
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %15, %struct.lean_object** %8, align 8
  br label %19

16:                                               ; preds = %3
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call %struct.lean_object* @lean_copy_float_array(%struct.lean_object* %17)
  store %struct.lean_object* %18, %struct.lean_object** %8, align 8
  br label %19

19:                                               ; preds = %16, %14
  %20 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %21 = call double* @lean_float_array_cptr(%struct.lean_object* %20)
  %22 = load i64, i64* %7, align 8
  %23 = getelementptr inbounds double, double* %21, i64 %22
  store double* %23, double** %9, align 8
  %24 = load double, double* %6, align 8
  %25 = load double*, double** %9, align 8
  store double %24, double* %25, align 8
  %26 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  ret %struct.lean_object* %26
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_string(i64 %0, i64 %1, i64 %2) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca %struct.lean_string_object*, align 8
  store i64 %0, i64* %4, align 8
  store i64 %1, i64* %5, align 8
  store i64 %2, i64* %6, align 8
  %8 = load i64, i64* %5, align 8
  %9 = add i64 32, %8
  %10 = call %struct.lean_object* @lean_alloc_object(i64 %9)
  %11 = bitcast %struct.lean_object* %10 to %struct.lean_string_object*
  store %struct.lean_string_object* %11, %struct.lean_string_object** %7, align 8
  %12 = load %struct.lean_string_object*, %struct.lean_string_object** %7, align 8
  %13 = bitcast %struct.lean_string_object* %12 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %13, i32 249, i32 0)
  %14 = load i64, i64* %4, align 8
  %15 = load %struct.lean_string_object*, %struct.lean_string_object** %7, align 8
  %16 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %15, i32 0, i32 1
  store i64 %14, i64* %16, align 8
  %17 = load i64, i64* %5, align 8
  %18 = load %struct.lean_string_object*, %struct.lean_string_object** %7, align 8
  %19 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %18, i32 0, i32 2
  store i64 %17, i64* %19, align 8
  %20 = load i64, i64* %6, align 8
  %21 = load %struct.lean_string_object*, %struct.lean_string_object** %7, align 8
  %22 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %21, i32 0, i32 3
  store i64 %20, i64* %22, align 8
  %23 = load %struct.lean_string_object*, %struct.lean_string_object** %7, align 8
  %24 = bitcast %struct.lean_string_object* %23 to %struct.lean_object*
  ret %struct.lean_object* %24
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_string_capacity(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_string_object* @lean_to_string(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %4, i32 0, i32 2
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_string_byte_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_string_capacity(%struct.lean_object* %3)
  %5 = add i64 32, %4
  ret i64 %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_char_default_value() #0 {
  ret i32 65
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i8* @lean_string_cstr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_string(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1147, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_string_cstr, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_string_object* @lean_to_string(%struct.lean_object* %8)
  %10 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %9, i32 0, i32 4
  %11 = getelementptr inbounds [0 x i8], [0 x i8]* %10, i64 0, i64 0
  ret i8* %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_string_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_string_object* @lean_to_string(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %4, i32 0, i32 1
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_string_len(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_string_object* @lean_to_string(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %4, i32 0, i32 3
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_string_length(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_string_len(%struct.lean_object* %3)
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_string_utf8_at_end(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %6 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %5)
  br i1 %6, label %7, label %14

7:                                                ; preds = %2
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %11 = call i64 @lean_string_size(%struct.lean_object* %10)
  %12 = sub i64 %11, 1
  %13 = icmp uge i64 %9, %12
  br label %14

14:                                               ; preds = %7, %2
  %15 = phi i1 [ true, %2 ], [ %13, %7 ]
  %16 = zext i1 %15 to i32
  %17 = trunc i32 %16 to i8
  ret i8 %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_string_utf8_byte_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_string_size(%struct.lean_object* %3)
  %5 = sub i64 %4, 1
  %6 = call %struct.lean_object* @lean_box(i64 %5)
  ret %struct.lean_object* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_string_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = icmp eq %struct.lean_object* %5, %6
  br i1 %7, label %25, label %8

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = call i64 @lean_string_size(%struct.lean_object* %9)
  %11 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %12 = call i64 @lean_string_size(%struct.lean_object* %11)
  %13 = icmp eq i64 %10, %12
  br i1 %13, label %14, label %23

14:                                               ; preds = %8
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call i8* @lean_string_cstr(%struct.lean_object* %15)
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i8* @lean_string_cstr(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %20 = call i64 @lean_string_size(%struct.lean_object* %19)
  %21 = call i32 @memcmp(i8* %16, i8* %18, i64 %20) #7
  %22 = icmp eq i32 %21, 0
  br label %23

23:                                               ; preds = %14, %8
  %24 = phi i1 [ false, %8 ], [ %22, %14 ]
  br label %25

25:                                               ; preds = %23, %2
  %26 = phi i1 [ true, %2 ], [ %24, %23 ]
  ret i1 %26
}

; Function Attrs: nounwind readonly
declare i32 @memcmp(i8*, i8*, i64) #4

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_string_ne(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_string_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = xor i1 %7, true
  ret i1 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_string_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_string_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_string_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_string_lt(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

declare zeroext i1 @lean_string_lt(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_thunk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_thunk_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_small_object(i32 24)
  %5 = bitcast %struct.lean_object* %4 to %struct.lean_thunk_object*
  store %struct.lean_thunk_object* %5, %struct.lean_thunk_object** %3, align 8
  %6 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %7 = bitcast %struct.lean_thunk_object* %6 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %7, i32 251, i32 0)
  %8 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %9 = getelementptr inbounds %struct.lean_thunk_object, %struct.lean_thunk_object* %8, i32 0, i32 1
  %10 = bitcast %struct.lean_object** %9 to i64*
  store atomic i64 0, i64* %10 seq_cst, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %12 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %13 = getelementptr inbounds %struct.lean_thunk_object, %struct.lean_thunk_object* %12, i32 0, i32 2
  %14 = ptrtoint %struct.lean_object* %11 to i64
  %15 = bitcast %struct.lean_object** %13 to i64*
  store atomic i64 %14, i64* %15 seq_cst, align 8
  %16 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %17 = bitcast %struct.lean_thunk_object* %16 to %struct.lean_object*
  ret %struct.lean_object* %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_pure(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_thunk_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_small_object(i32 24)
  %5 = bitcast %struct.lean_object* %4 to %struct.lean_thunk_object*
  store %struct.lean_thunk_object* %5, %struct.lean_thunk_object** %3, align 8
  %6 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %7 = bitcast %struct.lean_thunk_object* %6 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %7, i32 251, i32 0)
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %10 = getelementptr inbounds %struct.lean_thunk_object, %struct.lean_thunk_object* %9, i32 0, i32 1
  %11 = ptrtoint %struct.lean_object* %8 to i64
  %12 = bitcast %struct.lean_object** %10 to i64*
  store atomic i64 %11, i64* %12 seq_cst, align 8
  %13 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %14 = getelementptr inbounds %struct.lean_thunk_object, %struct.lean_thunk_object* %13, i32 0, i32 2
  %15 = bitcast %struct.lean_object** %14 to i64*
  store atomic i64 0, i64* %15 seq_cst, align 8
  %16 = load %struct.lean_thunk_object*, %struct.lean_thunk_object** %3, align 8
  %17 = bitcast %struct.lean_thunk_object* %16 to %struct.lean_object*
  ret %struct.lean_object* %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_get(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call %struct.lean_thunk_object* @lean_to_thunk(%struct.lean_object* %5)
  %7 = getelementptr inbounds %struct.lean_thunk_object, %struct.lean_thunk_object* %6, i32 0, i32 1
  %8 = bitcast %struct.lean_object** %7 to i64*
  %9 = load atomic i64, i64* %8 seq_cst, align 8
  %10 = inttoptr i64 %9 to %struct.lean_object*
  store %struct.lean_object* %10, %struct.lean_object** %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %12 = icmp ne %struct.lean_object* %11, null
  br i1 %12, label %13, label %15

13:                                               ; preds = %1
  %14 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %14, %struct.lean_object** %2, align 8
  br label %18

15:                                               ; preds = %1
  %16 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %17 = call %struct.lean_object* @lean_thunk_get_core(%struct.lean_object* %16)
  store %struct.lean_object* %17, %struct.lean_object** %2, align 8
  br label %18

18:                                               ; preds = %15, %13
  %19 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %19
}

declare %struct.lean_object* @lean_thunk_get_core(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_get_own(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call %struct.lean_object* @lean_thunk_get(%struct.lean_object* %4)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_inc(%struct.lean_object* %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_spawn(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  %8 = trunc i64 %7 to i32
  %9 = call %struct.lean_object* @lean_task_spawn_core(%struct.lean_object* %5, i32 %8, i1 zeroext false)
  ret %struct.lean_object* %9
}

declare %struct.lean_object* @lean_task_spawn_core(%struct.lean_object*, i32, i1 zeroext) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_bind(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %10 = call i64 @lean_unbox(%struct.lean_object* %9)
  %11 = trunc i64 %10 to i32
  %12 = call %struct.lean_object* @lean_task_bind_core(%struct.lean_object* %7, %struct.lean_object* %8, i32 %11, i1 zeroext false)
  ret %struct.lean_object* %12
}

declare %struct.lean_object* @lean_task_bind_core(%struct.lean_object*, %struct.lean_object*, i32, i1 zeroext) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_map(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %10 = call i64 @lean_unbox(%struct.lean_object* %9)
  %11 = trunc i64 %10 to i32
  %12 = call %struct.lean_object* @lean_task_map_core(%struct.lean_object* %7, %struct.lean_object* %8, i32 %11, i1 zeroext false)
  ret %struct.lean_object* %12
}

declare %struct.lean_object* @lean_task_map_core(%struct.lean_object*, %struct.lean_object*, i32, i1 zeroext) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_get_own(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call %struct.lean_object* @lean_task_get(%struct.lean_object* %4)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_inc(%struct.lean_object* %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %7)
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %8
}

declare %struct.lean_object* @lean_task_get(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_external(%struct.lean_external_class* %0, i8* %1) #0 {
  %3 = alloca %struct.lean_external_class*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %struct.lean_external_object*, align 8
  store %struct.lean_external_class* %0, %struct.lean_external_class** %3, align 8
  store i8* %1, i8** %4, align 8
  %6 = call %struct.lean_object* @lean_alloc_small_object(i32 24)
  %7 = bitcast %struct.lean_object* %6 to %struct.lean_external_object*
  store %struct.lean_external_object* %7, %struct.lean_external_object** %5, align 8
  %8 = load %struct.lean_external_object*, %struct.lean_external_object** %5, align 8
  %9 = bitcast %struct.lean_external_object* %8 to %struct.lean_object*
  call void @lean_set_st_header(%struct.lean_object* %9, i32 254, i32 0)
  %10 = load %struct.lean_external_class*, %struct.lean_external_class** %3, align 8
  %11 = load %struct.lean_external_object*, %struct.lean_external_object** %5, align 8
  %12 = getelementptr inbounds %struct.lean_external_object, %struct.lean_external_object* %11, i32 0, i32 1
  store %struct.lean_external_class* %10, %struct.lean_external_class** %12, align 8
  %13 = load i8*, i8** %4, align 8
  %14 = load %struct.lean_external_object*, %struct.lean_external_object** %5, align 8
  %15 = getelementptr inbounds %struct.lean_external_object, %struct.lean_external_object* %14, i32 0, i32 2
  store i8* %13, i8** %15, align 8
  %16 = load %struct.lean_external_object*, %struct.lean_external_object** %5, align 8
  %17 = bitcast %struct.lean_external_object* %16 to %struct.lean_object*
  ret %struct.lean_object* %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_external_class* @lean_get_external_class(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_external_object* @lean_to_external(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_external_object, %struct.lean_external_object* %4, i32 0, i32 1
  %6 = load %struct.lean_external_class*, %struct.lean_external_class** %5, align 8
  ret %struct.lean_external_class* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i8* @lean_get_external_data(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_external_object* @lean_to_external(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_external_object, %struct.lean_external_object* %4, i32 0, i32 2
  %6 = load i8*, i8** %5, align 8
  ret i8* %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_usize_to_nat(i64 %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  %4 = load i64, i64* %3, align 8
  %5 = icmp ule i64 %4, 9223372036854775807
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = icmp ne i64 %7, 0
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i64, i64* %3, align 8
  %11 = call %struct.lean_object* @lean_box(i64 %10)
  store %struct.lean_object* %11, %struct.lean_object** %2, align 8
  br label %15

12:                                               ; preds = %1
  %13 = load i64, i64* %3, align 8
  %14 = call %struct.lean_object* @lean_big_usize_to_nat(i64 %13)
  store %struct.lean_object* %14, %struct.lean_object** %2, align 8
  br label %15

15:                                               ; preds = %12, %9
  %16 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %16
}

declare %struct.lean_object* @lean_big_usize_to_nat(i64) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_unsigned_to_nat(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_uint64_to_nat(i64 %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  %4 = load i64, i64* %3, align 8
  %5 = icmp ule i64 %4, 9223372036854775807
  %6 = zext i1 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = icmp ne i64 %7, 0
  br i1 %8, label %9, label %12

9:                                                ; preds = %1
  %10 = load i64, i64* %3, align 8
  %11 = call %struct.lean_object* @lean_box(i64 %10)
  store %struct.lean_object* %11, %struct.lean_object** %2, align 8
  br label %15

12:                                               ; preds = %1
  %13 = load i64, i64* %3, align 8
  %14 = call %struct.lean_object* @lean_big_uint64_to_nat(i64 %13)
  store %struct.lean_object* %14, %struct.lean_object** %2, align 8
  br label %15

15:                                               ; preds = %12, %9
  %16 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %16
}

declare %struct.lean_object* @lean_big_uint64_to_nat(i64) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_succ(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %4)
  br i1 %5, label %6, label %11

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i64 @lean_unbox(%struct.lean_object* %7)
  %9 = add i64 %8, 1
  %10 = call %struct.lean_object* @lean_usize_to_nat(i64 %9)
  store %struct.lean_object* %10, %struct.lean_object** %2, align 8
  br label %14

11:                                               ; preds = %1
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_object* @lean_nat_big_succ(%struct.lean_object* %12)
  store %struct.lean_object* %13, %struct.lean_object** %2, align 8
  br label %14

14:                                               ; preds = %11, %6
  %15 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %15
}

declare %struct.lean_object* @lean_nat_big_succ(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_add(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i64 @lean_unbox(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  %21 = add i64 %18, %20
  %22 = call %struct.lean_object* @lean_usize_to_nat(i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_nat_big_add(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_nat_big_add(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_eq(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp eq i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_eq(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp eq i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_eq(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp eq i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_eq(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp eq i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_eq(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_float_eq(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fcmp oeq double %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_sub(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %8)
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br label %13

13:                                               ; preds = %10, %2
  %14 = phi i1 [ false, %2 ], [ %12, %10 ]
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %33

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  store i64 %20, i64* %6, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %22 = call i64 @lean_unbox(%struct.lean_object* %21)
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %6, align 8
  %24 = load i64, i64* %7, align 8
  %25 = icmp ult i64 %23, %24
  br i1 %25, label %26, label %28

26:                                               ; preds = %18
  %27 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %27, %struct.lean_object** %3, align 8
  br label %37

28:                                               ; preds = %18
  %29 = load i64, i64* %6, align 8
  %30 = load i64, i64* %7, align 8
  %31 = sub i64 %29, %30
  %32 = call %struct.lean_object* @lean_box(i64 %31)
  store %struct.lean_object* %32, %struct.lean_object** %3, align 8
  br label %37

33:                                               ; preds = %13
  %34 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %36 = call %struct.lean_object* @lean_nat_big_sub(%struct.lean_object* %34, %struct.lean_object* %35)
  store %struct.lean_object* %36, %struct.lean_object** %3, align 8
  br label %37

37:                                               ; preds = %33, %28, %26
  %38 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %38
}

declare %struct.lean_object* @lean_nat_big_sub(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_mul(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  %8 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br i1 %10, label %11, label %14

11:                                               ; preds = %2
  %12 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %13 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %12)
  br label %14

14:                                               ; preds = %11, %2
  %15 = phi i1 [ false, %2 ], [ %13, %11 ]
  %16 = zext i1 %15 to i32
  %17 = sext i32 %16 to i64
  %18 = icmp ne i64 %17, 0
  br i1 %18, label %19, label %47

19:                                               ; preds = %14
  %20 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %21 = call i64 @lean_unbox(%struct.lean_object* %20)
  store i64 %21, i64* %6, align 8
  %22 = load i64, i64* %6, align 8
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %24, label %26

24:                                               ; preds = %19
  %25 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %25, %struct.lean_object** %3, align 8
  br label %51

26:                                               ; preds = %19
  %27 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %28 = call i64 @lean_unbox(%struct.lean_object* %27)
  store i64 %28, i64* %7, align 8
  %29 = load i64, i64* %6, align 8
  %30 = load i64, i64* %7, align 8
  %31 = mul i64 %29, %30
  store i64 %31, i64* %8, align 8
  %32 = load i64, i64* %8, align 8
  %33 = icmp ule i64 %32, 9223372036854775807
  br i1 %33, label %34, label %43

34:                                               ; preds = %26
  %35 = load i64, i64* %8, align 8
  %36 = load i64, i64* %6, align 8
  %37 = udiv i64 %35, %36
  %38 = load i64, i64* %7, align 8
  %39 = icmp eq i64 %37, %38
  br i1 %39, label %40, label %43

40:                                               ; preds = %34
  %41 = load i64, i64* %8, align 8
  %42 = call %struct.lean_object* @lean_box(i64 %41)
  store %struct.lean_object* %42, %struct.lean_object** %3, align 8
  br label %51

43:                                               ; preds = %34, %26
  %44 = load i64, i64* %6, align 8
  %45 = load i64, i64* %7, align 8
  %46 = call %struct.lean_object* @lean_nat_overflow_mul(i64 %44, i64 %45)
  store %struct.lean_object* %46, %struct.lean_object** %3, align 8
  br label %51

47:                                               ; preds = %14
  %48 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %49 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %50 = call %struct.lean_object* @lean_nat_big_mul(%struct.lean_object* %48, %struct.lean_object* %49)
  store %struct.lean_object* %50, %struct.lean_object** %3, align 8
  br label %51

51:                                               ; preds = %47, %43, %40, %24
  %52 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %52
}

declare %struct.lean_object* @lean_nat_overflow_mul(i64, i64) #2

declare %struct.lean_object* @lean_nat_big_mul(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_div(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %8)
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br label %13

13:                                               ; preds = %10, %2
  %14 = phi i1 [ false, %2 ], [ %12, %10 ]
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %32

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  store i64 %20, i64* %6, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %22 = call i64 @lean_unbox(%struct.lean_object* %21)
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %7, align 8
  %24 = icmp eq i64 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %18
  %26 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %36

27:                                               ; preds = %18
  %28 = load i64, i64* %6, align 8
  %29 = load i64, i64* %7, align 8
  %30 = udiv i64 %28, %29
  %31 = call %struct.lean_object* @lean_box(i64 %30)
  store %struct.lean_object* %31, %struct.lean_object** %3, align 8
  br label %36

32:                                               ; preds = %13
  %33 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %34 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %35 = call %struct.lean_object* @lean_nat_big_div(%struct.lean_object* %33, %struct.lean_object* %34)
  store %struct.lean_object* %35, %struct.lean_object** %3, align 8
  br label %36

36:                                               ; preds = %32, %27, %25
  %37 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %37
}

declare %struct.lean_object* @lean_nat_big_div(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_mod(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %8)
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br label %13

13:                                               ; preds = %10, %2
  %14 = phi i1 [ false, %2 ], [ %12, %10 ]
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %33

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  store i64 %20, i64* %6, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %22 = call i64 @lean_unbox(%struct.lean_object* %21)
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %7, align 8
  %24 = icmp eq i64 %23, 0
  br i1 %24, label %25, label %28

25:                                               ; preds = %18
  %26 = load i64, i64* %6, align 8
  %27 = call %struct.lean_object* @lean_box(i64 %26)
  store %struct.lean_object* %27, %struct.lean_object** %3, align 8
  br label %37

28:                                               ; preds = %18
  %29 = load i64, i64* %6, align 8
  %30 = load i64, i64* %7, align 8
  %31 = urem i64 %29, %30
  %32 = call %struct.lean_object* @lean_box(i64 %31)
  store %struct.lean_object* %32, %struct.lean_object** %3, align 8
  br label %37

33:                                               ; preds = %13
  %34 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %36 = call %struct.lean_object* @lean_nat_big_mod(%struct.lean_object* %34, %struct.lean_object* %35)
  store %struct.lean_object* %36, %struct.lean_object** %3, align 8
  br label %37

37:                                               ; preds = %33, %28, %25
  %38 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %38
}

declare %struct.lean_object* @lean_nat_big_mod(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_nat_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %20

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %19 = icmp eq %struct.lean_object* %17, %18
  store i1 %19, i1* %3, align 1
  br label %24

20:                                               ; preds = %11
  %21 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %23 = call zeroext i1 @lean_nat_big_eq(%struct.lean_object* %21, %struct.lean_object* %22)
  store i1 %23, i1* %3, align 1
  br label %24

24:                                               ; preds = %20, %16
  %25 = load i1, i1* %3, align 1
  ret i1 %25
}

declare zeroext i1 @lean_nat_big_eq(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_nat_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_nat_ne(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_nat_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = xor i1 %7, true
  ret i1 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_nat_le(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %20

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %19 = icmp ule %struct.lean_object* %17, %18
  store i1 %19, i1* %3, align 1
  br label %24

20:                                               ; preds = %11
  %21 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %23 = call zeroext i1 @lean_nat_big_le(%struct.lean_object* %21, %struct.lean_object* %22)
  store i1 %23, i1* %3, align 1
  br label %24

24:                                               ; preds = %20, %16
  %25 = load i1, i1* %3, align 1
  ret i1 %25
}

declare zeroext i1 @lean_nat_big_le(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_le(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_nat_le(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_nat_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %20

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %19 = icmp ult %struct.lean_object* %17, %18
  store i1 %19, i1* %3, align 1
  br label %24

20:                                               ; preds = %11
  %21 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %23 = call zeroext i1 @lean_nat_big_lt(%struct.lean_object* %21, %struct.lean_object* %22)
  store i1 %23, i1* %3, align 1
  br label %24

24:                                               ; preds = %20, %16
  %25 = load i1, i1* %3, align 1
  ret i1 %25
}

declare zeroext i1 @lean_nat_big_lt(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_nat_lt(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_land(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = ptrtoint %struct.lean_object* %17 to i64
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = ptrtoint %struct.lean_object* %19 to i64
  %21 = and i64 %18, %20
  %22 = inttoptr i64 %21 to %struct.lean_object*
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_nat_big_land(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_nat_big_land(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_lor(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = ptrtoint %struct.lean_object* %17 to i64
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = ptrtoint %struct.lean_object* %19 to i64
  %21 = or i64 %18, %20
  %22 = inttoptr i64 %21 to %struct.lean_object*
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_nat_big_lor(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_nat_big_lor(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_lxor(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i64 @lean_unbox(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_unbox(%struct.lean_object* %19)
  %21 = xor i64 %18, %20
  %22 = call %struct.lean_object* @lean_box(i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_nat_big_xor(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_nat_big_xor(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_to_int(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int64_to_int(i64 %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  %4 = load i64, i64* %3, align 8
  %5 = icmp sle i64 -2147483648, %4
  br i1 %5, label %6, label %9

6:                                                ; preds = %1
  %7 = load i64, i64* %3, align 8
  %8 = icmp sle i64 %7, 2147483647
  br label %9

9:                                                ; preds = %6, %1
  %10 = phi i1 [ false, %1 ], [ %8, %6 ]
  %11 = zext i1 %10 to i32
  %12 = sext i32 %11 to i64
  %13 = icmp ne i64 %12, 0
  br i1 %13, label %14, label %19

14:                                               ; preds = %9
  %15 = load i64, i64* %3, align 8
  %16 = trunc i64 %15 to i32
  %17 = zext i32 %16 to i64
  %18 = call %struct.lean_object* @lean_box(i64 %17)
  store %struct.lean_object* %18, %struct.lean_object** %2, align 8
  br label %22

19:                                               ; preds = %9
  %20 = load i64, i64* %3, align 8
  %21 = call %struct.lean_object* @lean_big_int64_to_int(i64 %20)
  store %struct.lean_object* %21, %struct.lean_object** %2, align 8
  br label %22

22:                                               ; preds = %19, %14
  %23 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %23
}

declare %struct.lean_object* @lean_big_int64_to_int(i64) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_scalar_to_int64(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.29, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1495, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_scalar_to_int64, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  %10 = trunc i64 %9 to i32
  %11 = sext i32 %10 to i64
  ret i64 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_scalar_to_int(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.29, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1503, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__PRETTY_FUNCTION__.lean_scalar_to_int, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  %10 = trunc i64 %9 to i32
  ret i32 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_to_int(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %5)
  br i1 %6, label %7, label %17

7:                                                ; preds = %1
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = call i64 @lean_unbox(%struct.lean_object* %8)
  store i64 %9, i64* %4, align 8
  %10 = load i64, i64* %4, align 8
  %11 = icmp ule i64 %10, 2147483647
  br i1 %11, label %12, label %14

12:                                               ; preds = %7
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  store %struct.lean_object* %13, %struct.lean_object** %2, align 8
  br label %19

14:                                               ; preds = %7
  %15 = load i64, i64* %4, align 8
  %16 = call %struct.lean_object* @lean_big_size_t_to_int(i64 %15)
  store %struct.lean_object* %16, %struct.lean_object** %2, align 8
  br label %19

17:                                               ; preds = %1
  %18 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  store %struct.lean_object* %18, %struct.lean_object** %2, align 8
  br label %19

19:                                               ; preds = %17, %14, %12
  %20 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %20
}

declare %struct.lean_object* @lean_big_size_t_to_int(i64) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_neg(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %4)
  br i1 %5, label %6, label %11

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i64 @lean_scalar_to_int64(%struct.lean_object* %7)
  %9 = sub nsw i64 0, %8
  %10 = call %struct.lean_object* @lean_int64_to_int(i64 %9)
  store %struct.lean_object* %10, %struct.lean_object** %2, align 8
  br label %14

11:                                               ; preds = %1
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %13 = call %struct.lean_object* @lean_int_big_neg(%struct.lean_object* %12)
  store %struct.lean_object* %13, %struct.lean_object** %2, align 8
  br label %14

14:                                               ; preds = %11, %6
  %15 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %15
}

declare %struct.lean_object* @lean_int_big_neg(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_neg_succ_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call %struct.lean_object* @lean_nat_succ(%struct.lean_object* %6)
  store %struct.lean_object* %7, %struct.lean_object** %3, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %8)
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = call %struct.lean_object* @lean_nat_to_int(%struct.lean_object* %9)
  store %struct.lean_object* %10, %struct.lean_object** %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_dec(%struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %13 = call %struct.lean_object* @lean_int_neg(%struct.lean_object* %12)
  store %struct.lean_object* %13, %struct.lean_object** %5, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec(%struct.lean_object* %14)
  %15 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %15
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_add(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i64 @lean_scalar_to_int64(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_scalar_to_int64(%struct.lean_object* %19)
  %21 = add nsw i64 %18, %20
  %22 = call %struct.lean_object* @lean_int64_to_int(i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_int_big_add(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_add(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_sub(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i64 @lean_scalar_to_int64(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_scalar_to_int64(%struct.lean_object* %19)
  %21 = sub nsw i64 %18, %20
  %22 = call %struct.lean_object* @lean_int64_to_int(i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_int_big_sub(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_sub(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_mul(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %23

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i64 @lean_scalar_to_int64(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i64 @lean_scalar_to_int64(%struct.lean_object* %19)
  %21 = mul nsw i64 %18, %20
  %22 = call %struct.lean_object* @lean_int64_to_int(i64 %21)
  store %struct.lean_object* %22, %struct.lean_object** %3, align 8
  br label %27

23:                                               ; preds = %11
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %26 = call %struct.lean_object* @lean_int_big_mul(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %27

27:                                               ; preds = %23, %16
  %28 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_mul(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_div(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %8)
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br label %13

13:                                               ; preds = %10, %2
  %14 = phi i1 [ false, %2 ], [ %12, %10 ]
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %34

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call i32 @lean_scalar_to_int(%struct.lean_object* %19)
  %21 = sext i32 %20 to i64
  store i64 %21, i64* %6, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %23 = call i32 @lean_scalar_to_int(%struct.lean_object* %22)
  %24 = sext i32 %23 to i64
  store i64 %24, i64* %7, align 8
  %25 = load i64, i64* %7, align 8
  %26 = icmp eq i64 %25, 0
  br i1 %26, label %27, label %29

27:                                               ; preds = %18
  %28 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %28, %struct.lean_object** %3, align 8
  br label %38

29:                                               ; preds = %18
  %30 = load i64, i64* %6, align 8
  %31 = load i64, i64* %7, align 8
  %32 = sdiv i64 %30, %31
  %33 = call %struct.lean_object* @lean_int64_to_int(i64 %32)
  store %struct.lean_object* %33, %struct.lean_object** %3, align 8
  br label %38

34:                                               ; preds = %13
  %35 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %36 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %37 = call %struct.lean_object* @lean_int_big_div(%struct.lean_object* %35, %struct.lean_object* %36)
  store %struct.lean_object* %37, %struct.lean_object** %3, align 8
  br label %38

38:                                               ; preds = %34, %29, %27
  %39 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %39
}

declare %struct.lean_object* @lean_int_big_div(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_mod(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %9 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %8)
  br i1 %9, label %10, label %13

10:                                               ; preds = %2
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %11)
  br label %13

13:                                               ; preds = %10, %2
  %14 = phi i1 [ false, %2 ], [ %12, %10 ]
  %15 = zext i1 %14 to i32
  %16 = sext i32 %15 to i64
  %17 = icmp ne i64 %16, 0
  br i1 %17, label %18, label %32

18:                                               ; preds = %13
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call i64 @lean_scalar_to_int64(%struct.lean_object* %19)
  store i64 %20, i64* %6, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %22 = call i64 @lean_scalar_to_int64(%struct.lean_object* %21)
  store i64 %22, i64* %7, align 8
  %23 = load i64, i64* %7, align 8
  %24 = icmp eq i64 %23, 0
  br i1 %24, label %25, label %27

25:                                               ; preds = %18
  %26 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %26, %struct.lean_object** %3, align 8
  br label %36

27:                                               ; preds = %18
  %28 = load i64, i64* %6, align 8
  %29 = load i64, i64* %7, align 8
  %30 = srem i64 %28, %29
  %31 = call %struct.lean_object* @lean_int64_to_int(i64 %30)
  store %struct.lean_object* %31, %struct.lean_object** %3, align 8
  br label %36

32:                                               ; preds = %13
  %33 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %34 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %35 = call %struct.lean_object* @lean_int_big_mod(%struct.lean_object* %33, %struct.lean_object* %34)
  store %struct.lean_object* %35, %struct.lean_object** %3, align 8
  br label %36

36:                                               ; preds = %32, %27, %25
  %37 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %37
}

declare %struct.lean_object* @lean_int_big_mod(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_int_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %20

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %19 = icmp eq %struct.lean_object* %17, %18
  store i1 %19, i1* %3, align 1
  br label %24

20:                                               ; preds = %11
  %21 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %23 = call zeroext i1 @lean_int_big_eq(%struct.lean_object* %21, %struct.lean_object* %22)
  store i1 %23, i1* %3, align 1
  br label %24

24:                                               ; preds = %20, %16
  %25 = load i1, i1* %3, align 1
  ret i1 %25
}

declare zeroext i1 @lean_int_big_eq(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_int_ne(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_int_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = xor i1 %7, true
  ret i1 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_int_le(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %22

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i32 @lean_scalar_to_int(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i32 @lean_scalar_to_int(%struct.lean_object* %19)
  %21 = icmp sle i32 %18, %20
  store i1 %21, i1* %3, align 1
  br label %26

22:                                               ; preds = %11
  %23 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %25 = call zeroext i1 @lean_int_big_le(%struct.lean_object* %23, %struct.lean_object* %24)
  store i1 %25, i1* %3, align 1
  br label %26

26:                                               ; preds = %22, %16
  %27 = load i1, i1* %3, align 1
  ret i1 %27
}

declare zeroext i1 @lean_int_big_le(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_int_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca i1, align 1
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %6)
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %10 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %2
  %12 = phi i1 [ false, %2 ], [ %10, %8 ]
  %13 = zext i1 %12 to i32
  %14 = sext i32 %13 to i64
  %15 = icmp ne i64 %14, 0
  br i1 %15, label %16, label %22

16:                                               ; preds = %11
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = call i32 @lean_scalar_to_int(%struct.lean_object* %17)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = call i32 @lean_scalar_to_int(%struct.lean_object* %19)
  %21 = icmp slt i32 %18, %20
  store i1 %21, i1* %3, align 1
  br label %26

22:                                               ; preds = %11
  %23 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %25 = call zeroext i1 @lean_int_big_lt(%struct.lean_object* %23, %struct.lean_object* %24)
  store i1 %25, i1* %3, align 1
  br label %26

26:                                               ; preds = %22, %16
  %27 = load i1, i1* %3, align 1
  ret i1 %27
}

declare zeroext i1 @lean_int_big_lt(%struct.lean_object*, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_to_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call %struct.lean_object* @lean_box(i64 0)
  %6 = call zeroext i1 @lean_int_lt(%struct.lean_object* %4, %struct.lean_object* %5)
  br i1 %6, label %8, label %7

7:                                                ; preds = %1
  br label %9

8:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1639, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @__PRETTY_FUNCTION__.lean_int_to_nat, i64 0, i64 0)) #5
  unreachable

9:                                                ; preds = %7
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %11 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %10)
  br i1 %11, label %12, label %14

12:                                               ; preds = %9
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  store %struct.lean_object* %13, %struct.lean_object** %2, align 8
  br label %17

14:                                               ; preds = %9
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %16 = call %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object* %15)
  store %struct.lean_object* %16, %struct.lean_object** %2, align 8
  br label %17

17:                                               ; preds = %14, %12
  %18 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %18
}

declare %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_abs(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call %struct.lean_object* @lean_box(i64 0)
  %6 = call zeroext i1 @lean_int_lt(%struct.lean_object* %4, %struct.lean_object* %5)
  br i1 %6, label %7, label %11

7:                                                ; preds = %1
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = call %struct.lean_object* @lean_int_neg(%struct.lean_object* %8)
  %10 = call %struct.lean_object* @lean_int_to_nat(%struct.lean_object* %9)
  store %struct.lean_object* %10, %struct.lean_object** %2, align 8
  br label %15

11:                                               ; preds = %1
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_inc(%struct.lean_object* %12)
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %14 = call %struct.lean_object* @lean_int_to_nat(%struct.lean_object* %13)
  store %struct.lean_object* %14, %struct.lean_object** %2, align 8
  br label %15

15:                                               ; preds = %11, %7
  %16 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %16
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_int_eq(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_le(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_int_le(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %7 = call zeroext i1 @lean_int_lt(%struct.lean_object* %5, %struct.lean_object* %6)
  %8 = zext i1 %7 to i8
  ret i8 %8
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_nonneg(%struct.lean_object* %0) #0 {
  %2 = alloca i8, align 1
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %5 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %4)
  br i1 %5, label %6, label %12

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call i32 @lean_scalar_to_int(%struct.lean_object* %7)
  %9 = icmp sge i32 %8, 0
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  store i8 %11, i8* %2, align 1
  br label %16

12:                                               ; preds = %1
  %13 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %14 = call zeroext i1 @lean_int_big_nonneg(%struct.lean_object* %13)
  %15 = zext i1 %14 to i8
  store i8 %15, i8* %2, align 1
  br label %16

16:                                               ; preds = %12, %6
  %17 = load i8, i8* %2, align 1
  ret i8 %17
}

declare zeroext i1 @lean_int_big_nonneg(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %10

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  %8 = trunc i64 %7 to i8
  %9 = zext i8 %8 to i32
  br label %14

10:                                               ; preds = %1
  %11 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %12 = call zeroext i8 @lean_uint8_of_big_nat(%struct.lean_object* %11)
  %13 = zext i8 %12 to i32
  br label %14

14:                                               ; preds = %10, %5
  %15 = phi i32 [ %9, %5 ], [ %13, %10 ]
  %16 = trunc i32 %15 to i8
  ret i8 %16
}

declare zeroext i8 @lean_uint8_of_big_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_of_nat_mk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i8, align 1
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call zeroext i8 @lean_uint8_of_nat(%struct.lean_object* %4)
  store i8 %5, i8* %3, align 1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %6)
  %7 = load i8, i8* %3, align 1
  ret i8 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_uint8_to_nat(i8 zeroext %0) #0 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_add(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = add nsw i32 %6, %8
  %10 = trunc i32 %9 to i8
  ret i8 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_sub(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = sub nsw i32 %6, %8
  %10 = trunc i32 %9 to i8
  ret i8 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_mul(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = mul nsw i32 %6, %8
  %10 = trunc i32 %9 to i8
  ret i8 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_div(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %15

9:                                                ; preds = %2
  %10 = load i8, i8* %3, align 1
  %11 = zext i8 %10 to i32
  %12 = load i8, i8* %4, align 1
  %13 = zext i8 %12 to i32
  %14 = sdiv i32 %11, %13
  br label %15

15:                                               ; preds = %9, %8
  %16 = phi i32 [ 0, %8 ], [ %14, %9 ]
  %17 = trunc i32 %16 to i8
  ret i8 %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_mod(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load i8, i8* %3, align 1
  %10 = zext i8 %9 to i32
  br label %17

11:                                               ; preds = %2
  %12 = load i8, i8* %3, align 1
  %13 = zext i8 %12 to i32
  %14 = load i8, i8* %4, align 1
  %15 = zext i8 %14 to i32
  %16 = srem i32 %13, %15
  br label %17

17:                                               ; preds = %11, %8
  %18 = phi i32 [ %10, %8 ], [ %16, %11 ]
  %19 = trunc i32 %18 to i8
  ret i8 %19
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_modn(i8 zeroext %0, %struct.lean_object* %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i32, align 4
  store i8 %0, i8* %4, align 1
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %26

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  %12 = trunc i64 %11 to i32
  store i32 %12, i32* %6, align 4
  %13 = load i32, i32* %6, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %18

15:                                               ; preds = %9
  %16 = load i8, i8* %4, align 1
  %17 = zext i8 %16 to i32
  br label %23

18:                                               ; preds = %9
  %19 = load i8, i8* %4, align 1
  %20 = zext i8 %19 to i32
  %21 = load i32, i32* %6, align 4
  %22 = urem i32 %20, %21
  br label %23

23:                                               ; preds = %18, %15
  %24 = phi i32 [ %17, %15 ], [ %22, %18 ]
  %25 = trunc i32 %24 to i8
  store i8 %25, i8* %3, align 1
  br label %28

26:                                               ; preds = %2
  %27 = load i8, i8* %4, align 1
  store i8 %27, i8* %3, align 1
  br label %28

28:                                               ; preds = %26, %23
  %29 = load i8, i8* %3, align 1
  ret i8 %29
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_dec_eq(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp eq i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_dec_lt(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp slt i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_dec_le(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp sle i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %10

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  %8 = trunc i64 %7 to i16
  %9 = sext i16 %8 to i32
  br label %14

10:                                               ; preds = %1
  %11 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %12 = call zeroext i16 @lean_uint16_of_big_nat(%struct.lean_object* %11)
  %13 = zext i16 %12 to i32
  br label %14

14:                                               ; preds = %10, %5
  %15 = phi i32 [ %9, %5 ], [ %13, %10 ]
  %16 = trunc i32 %15 to i16
  ret i16 %16
}

declare zeroext i16 @lean_uint16_of_big_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_of_nat_mk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i16, align 2
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call zeroext i16 @lean_uint16_of_nat(%struct.lean_object* %4)
  store i16 %5, i16* %3, align 2
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %6)
  %7 = load i16, i16* %3, align 2
  ret i16 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_uint16_to_nat(i16 zeroext %0) #0 {
  %2 = alloca i16, align 2
  store i16 %0, i16* %2, align 2
  %3 = load i16, i16* %2, align 2
  %4 = zext i16 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_add(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = add nsw i32 %6, %8
  %10 = trunc i32 %9 to i16
  ret i16 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_sub(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = sub nsw i32 %6, %8
  %10 = trunc i32 %9 to i16
  ret i16 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_mul(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = mul nsw i32 %6, %8
  %10 = trunc i32 %9 to i16
  ret i16 %10
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_div(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %4, align 2
  %6 = zext i16 %5 to i32
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %15

9:                                                ; preds = %2
  %10 = load i16, i16* %3, align 2
  %11 = zext i16 %10 to i32
  %12 = load i16, i16* %4, align 2
  %13 = zext i16 %12 to i32
  %14 = sdiv i32 %11, %13
  br label %15

15:                                               ; preds = %9, %8
  %16 = phi i32 [ 0, %8 ], [ %14, %9 ]
  %17 = trunc i32 %16 to i16
  ret i16 %17
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_mod(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %4, align 2
  %6 = zext i16 %5 to i32
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load i16, i16* %3, align 2
  %10 = zext i16 %9 to i32
  br label %17

11:                                               ; preds = %2
  %12 = load i16, i16* %3, align 2
  %13 = zext i16 %12 to i32
  %14 = load i16, i16* %4, align 2
  %15 = zext i16 %14 to i32
  %16 = srem i32 %13, %15
  br label %17

17:                                               ; preds = %11, %8
  %18 = phi i32 [ %10, %8 ], [ %16, %11 ]
  %19 = trunc i32 %18 to i16
  ret i16 %19
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_modn(i16 zeroext %0, %struct.lean_object* %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i32, align 4
  store i16 %0, i16* %4, align 2
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %26

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  %12 = trunc i64 %11 to i32
  store i32 %12, i32* %6, align 4
  %13 = load i32, i32* %6, align 4
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %18

15:                                               ; preds = %9
  %16 = load i16, i16* %4, align 2
  %17 = zext i16 %16 to i32
  br label %23

18:                                               ; preds = %9
  %19 = load i16, i16* %4, align 2
  %20 = zext i16 %19 to i32
  %21 = load i32, i32* %6, align 4
  %22 = urem i32 %20, %21
  br label %23

23:                                               ; preds = %18, %15
  %24 = phi i32 [ %17, %15 ], [ %22, %18 ]
  %25 = trunc i32 %24 to i16
  store i16 %25, i16* %3, align 2
  br label %28

26:                                               ; preds = %2
  %27 = load i16, i16* %4, align 2
  store i16 %27, i16* %3, align 2
  br label %28

28:                                               ; preds = %26, %23
  %29 = load i16, i16* %3, align 2
  ret i16 %29
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_dec_eq(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp eq i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_dec_lt(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp slt i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_dec_le(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp sle i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %9

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  %8 = trunc i64 %7 to i32
  br label %12

9:                                                ; preds = %1
  %10 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %11 = call i32 @lean_uint32_of_big_nat(%struct.lean_object* %10)
  br label %12

12:                                               ; preds = %9, %5
  %13 = phi i32 [ %8, %5 ], [ %11, %9 ]
  ret i32 %13
}

declare i32 @lean_uint32_of_big_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_of_nat_mk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call i32 @lean_uint32_of_nat(%struct.lean_object* %4)
  store i32 %5, i32* %3, align 4
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %6)
  %7 = load i32, i32* %3, align 4
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_uint32_to_nat(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_add(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = add i32 %5, %6
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_sub(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = sub i32 %5, %6
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_mul(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = mul i32 %5, %6
  ret i32 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_div(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %12

8:                                                ; preds = %2
  %9 = load i32, i32* %3, align 4
  %10 = load i32, i32* %4, align 4
  %11 = udiv i32 %9, %10
  br label %12

12:                                               ; preds = %8, %7
  %13 = phi i32 [ 0, %7 ], [ %11, %8 ]
  ret i32 %13
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_mod(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %4, align 4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %2
  %8 = load i32, i32* %3, align 4
  br label %13

9:                                                ; preds = %2
  %10 = load i32, i32* %3, align 4
  %11 = load i32, i32* %4, align 4
  %12 = urem i32 %10, %11
  br label %13

13:                                               ; preds = %9, %7
  %14 = phi i32 [ %8, %7 ], [ %12, %9 ]
  ret i32 %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_uint32_modn(i32 %0, %struct.lean_object* %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  store i32 %0, i32* %4, align 4
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %25

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %6, align 8
  %12 = load i64, i64* %6, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %17

14:                                               ; preds = %9
  %15 = load i32, i32* %4, align 4
  %16 = zext i32 %15 to i64
  br label %22

17:                                               ; preds = %9
  %18 = load i32, i32* %4, align 4
  %19 = zext i32 %18 to i64
  %20 = load i64, i64* %6, align 8
  %21 = urem i64 %19, %20
  br label %22

22:                                               ; preds = %17, %14
  %23 = phi i64 [ %16, %14 ], [ %21, %17 ]
  %24 = trunc i64 %23 to i32
  store i32 %24, i32* %3, align 4
  br label %27

25:                                               ; preds = %2
  %26 = load i32, i32* %4, align 4
  store i32 %26, i32* %3, align 4
  br label %27

27:                                               ; preds = %25, %22
  %28 = load i32, i32* %3, align 4
  ret i32 %28
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_dec_eq(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp eq i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_dec_lt(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp ult i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_dec_le(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp ule i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  br label %11

8:                                                ; preds = %1
  %9 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %10 = call i64 @lean_uint64_of_big_nat(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %5
  %12 = phi i64 [ %7, %5 ], [ %10, %8 ]
  ret i64 %12
}

declare i64 @lean_uint64_of_big_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_of_nat_mk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call i64 @lean_uint64_of_nat(%struct.lean_object* %4)
  store i64 %5, i64* %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %6)
  %7 = load i64, i64* %3, align 8
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_add(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = add i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_sub(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sub i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_mul(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = mul i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_div(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %4, align 8
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %12

8:                                                ; preds = %2
  %9 = load i64, i64* %3, align 8
  %10 = load i64, i64* %4, align 8
  %11 = udiv i64 %9, %10
  br label %12

12:                                               ; preds = %8, %7
  %13 = phi i64 [ 0, %7 ], [ %11, %8 ]
  ret i64 %13
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_mod(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %4, align 8
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %2
  %8 = load i64, i64* %3, align 8
  br label %13

9:                                                ; preds = %2
  %10 = load i64, i64* %3, align 8
  %11 = load i64, i64* %4, align 8
  %12 = urem i64 %10, %11
  br label %13

13:                                               ; preds = %9, %7
  %14 = phi i64 [ %8, %7 ], [ %12, %9 ]
  ret i64 %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_uint64_modn(i64 %0, %struct.lean_object* %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  store i64 %0, i64* %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %22

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %6, align 8
  %12 = load i64, i64* %6, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %9
  %15 = load i64, i64* %4, align 8
  br label %20

16:                                               ; preds = %9
  %17 = load i64, i64* %4, align 8
  %18 = load i64, i64* %6, align 8
  %19 = urem i64 %17, %18
  br label %20

20:                                               ; preds = %16, %14
  %21 = phi i64 [ %15, %14 ], [ %19, %16 ]
  store i64 %21, i64* %3, align 8
  br label %26

22:                                               ; preds = %2
  %23 = load i64, i64* %4, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %25 = call i64 @lean_uint64_big_modn(i64 %23, %struct.lean_object* %24)
  store i64 %25, i64* %3, align 8
  br label %26

26:                                               ; preds = %22, %20
  %27 = load i64, i64* %3, align 8
  ret i64 %27
}

declare i64 @lean_uint64_big_modn(i64, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_dec_eq(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp eq i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_dec_lt(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ult i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_dec_le(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ule i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_of_nat(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %3)
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = call i64 @lean_unbox(%struct.lean_object* %6)
  br label %11

8:                                                ; preds = %1
  %9 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %10 = call i64 @lean_usize_of_big_nat(%struct.lean_object* %9)
  br label %11

11:                                               ; preds = %8, %5
  %12 = phi i64 [ %7, %5 ], [ %10, %8 ]
  ret i64 %12
}

declare i64 @lean_usize_of_big_nat(%struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_of_nat_mk(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i64, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %5 = call i64 @lean_usize_of_nat(%struct.lean_object* %4)
  store i64 %5, i64* %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %6)
  %7 = load i64, i64* %3, align 8
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_add(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = add i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_sub(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = sub i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_mul(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = mul i64 %5, %6
  ret i64 %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_div(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %4, align 8
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %12

8:                                                ; preds = %2
  %9 = load i64, i64* %3, align 8
  %10 = load i64, i64* %4, align 8
  %11 = udiv i64 %9, %10
  br label %12

12:                                               ; preds = %8, %7
  %13 = phi i64 [ 0, %7 ], [ %11, %8 ]
  ret i64 %13
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_mod(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %4, align 8
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %2
  %8 = load i64, i64* %3, align 8
  br label %13

9:                                                ; preds = %2
  %10 = load i64, i64* %3, align 8
  %11 = load i64, i64* %4, align 8
  %12 = urem i64 %10, %11
  br label %13

13:                                               ; preds = %9, %7
  %14 = phi i64 [ %8, %7 ], [ %12, %9 ]
  ret i64 %14
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_usize_modn(i64 %0, %struct.lean_object* %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i64, align 8
  store i64 %0, i64* %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %8 = call zeroext i1 @lean_is_scalar(%struct.lean_object* %7)
  br i1 %8, label %9, label %22

9:                                                ; preds = %2
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i64 @lean_unbox(%struct.lean_object* %10)
  store i64 %11, i64* %6, align 8
  %12 = load i64, i64* %6, align 8
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %14, label %16

14:                                               ; preds = %9
  %15 = load i64, i64* %4, align 8
  br label %20

16:                                               ; preds = %9
  %17 = load i64, i64* %4, align 8
  %18 = load i64, i64* %6, align 8
  %19 = urem i64 %17, %18
  br label %20

20:                                               ; preds = %16, %14
  %21 = phi i64 [ %15, %14 ], [ %19, %16 ]
  store i64 %21, i64* %3, align 8
  br label %26

22:                                               ; preds = %2
  %23 = load i64, i64* %4, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %25 = call i64 @lean_usize_big_modn(i64 %23, %struct.lean_object* %24)
  store i64 %25, i64* %3, align 8
  br label %26

26:                                               ; preds = %22, %20
  %27 = load i64, i64* %3, align 8
  ret i64 %27
}

declare i64 @lean_usize_big_modn(i64, %struct.lean_object*) #2

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_dec_eq(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp eq i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_dec_lt(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ult i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_dec_le(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ule i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_uint32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i32 @lean_unbox_uint32(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_unbox(%struct.lean_object* %3)
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_uint64(i64 %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca %struct.lean_object*, align 8
  store i64 %0, i64* %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 0, i32 8)
  store %struct.lean_object* %4, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load i64, i64* %2, align 8
  call void @lean_ctor_set_uint64(%struct.lean_object* %5, i32 0, i64 %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_unbox_uint64(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_ctor_get_uint64(%struct.lean_object* %3, i32 0)
  ret i64 %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_usize(i64 %0) #0 {
  %2 = alloca i64, align 8
  %3 = alloca %struct.lean_object*, align 8
  store i64 %0, i64* %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 0, i32 8)
  store %struct.lean_object* %4, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load i64, i64* %2, align 8
  call void @lean_ctor_set_usize(%struct.lean_object* %5, i32 0, i64 %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_unbox_usize(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_ctor_get_usize(%struct.lean_object* %3, i32 0)
  ret i64 %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_float(double %0) #0 {
  %2 = alloca double, align 8
  %3 = alloca %struct.lean_object*, align 8
  store double %0, double* %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 0, i32 8)
  store %struct.lean_object* %4, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load double, double* %2, align 8
  call void @lean_ctor_set_float(%struct.lean_object* %5, i32 0, double %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_unbox_float(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call double @lean_ctor_get_float(%struct.lean_object* %3, i32 0)
  ret double %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_mk_world() #0 {
  %1 = call %struct.lean_object* @lean_box(i64 0)
  ret %struct.lean_object* %1
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 0
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i1 @lean_io_result_is_error(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 1
  ret i1 %6
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_get_value(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.31, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1866, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__.lean_io_result_get_value, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %8, i32 0)
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_get_error(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_io_result_is_error(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1867, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__.lean_io_result_get_error, i64 0, i64 0)) #5
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %8, i32 0)
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_mk_ok(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %4, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %5, i32 0, %struct.lean_object* %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call %struct.lean_object* @lean_box(i64 0)
  call void @lean_ctor_set(%struct.lean_object* %7, i32 1, %struct.lean_object* %8)
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_mk_error(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %4, %struct.lean_object** %3, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %5, i32 0, %struct.lean_object* %6)
  %7 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %8 = call %struct.lean_object* @lean_box(i64 0)
  call void @lean_ctor_set(%struct.lean_object* %7, i32 1, %struct.lean_object* %8)
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define i64 @lean_ptr_addr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = ptrtoint %struct.lean_object* %3 to i64
  ret i64 %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_le(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp sle i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_le(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp sle i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_le(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp ule i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_le(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ule i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_float_le(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fcmp ole double %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_le(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ule i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_lt(i8 zeroext %0, i8 zeroext %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i8, align 1
  store i8 %0, i8* %3, align 1
  store i8 %1, i8* %4, align 1
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = load i8, i8* %4, align 1
  %8 = zext i8 %7 to i32
  %9 = icmp slt i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint16_lt(i16 zeroext %0, i16 zeroext %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i16, align 2
  store i16 %0, i16* %3, align 2
  store i16 %1, i16* %4, align 2
  %5 = load i16, i16* %3, align 2
  %6 = zext i16 %5 to i32
  %7 = load i16, i16* %4, align 2
  %8 = zext i16 %7 to i32
  %9 = icmp slt i32 %6, %8
  %10 = zext i1 %9 to i32
  %11 = trunc i32 %10 to i8
  ret i8 %11
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint32_lt(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp ult i32 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_uint64_lt(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ult i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_float_lt(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fcmp olt double %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_usize_lt(i64 %0, i64 %1) #0 {
  %3 = alloca i64, align 8
  %4 = alloca i64, align 8
  store i64 %0, i64* %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load i64, i64* %3, align 8
  %6 = load i64, i64* %4, align 8
  %7 = icmp ult i64 %5, %6
  %8 = zext i1 %7 to i32
  %9 = trunc i32 %8 to i8
  ret i8 %9
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define zeroext i8 @lean_float_to_uint8(double %0) #0 {
  %2 = alloca double, align 8
  store double %0, double* %2, align 8
  %3 = load double, double* %2, align 8
  %4 = fptoui double %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_add(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fadd double %5, %6
  ret double %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_sub(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fsub double %5, %6
  ret double %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_mul(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fmul double %5, %6
  ret double %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_div(double %0, double %1) #0 {
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  store double %0, double* %3, align 8
  store double %1, double* %4, align 8
  %5 = load double, double* %3, align 8
  %6 = load double, double* %4, align 8
  %7 = fdiv double %5, %6
  ret double %7
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define double @lean_float_negate(double %0) #0 {
  %2 = alloca double, align 8
  store double %0, double* %2, align 8
  %3 = load double, double* %2, align 8
  %4 = fneg double %3
  ret double %4
}

; Function Attrs: alwaysinline nounwind sspstrong uwtable
define %struct.lean_object* @unsafeCast(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %3
}

attributes #0 = { alwaysinline nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { noreturn }
attributes #7 = { nounwind readonly }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 11.1.0"}
