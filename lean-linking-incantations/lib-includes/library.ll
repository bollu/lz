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

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i1 @lean_is_big_object_tag(i8 zeroext %0) local_unnamed_addr #0 {
  %2 = add i8 %0, 10
  %3 = icmp ult i8 %2, 4
  ret i1 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i1 @lean_is_scalar(%struct.lean_object* %0) local_unnamed_addr #0 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp ne i64 %3, 0
  ret i1 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_box(i64 %0) local_unnamed_addr #0 {
  %2 = shl i64 %0, 1
  %3 = or i64 %2, 1
  %4 = inttoptr i64 %3 to %struct.lean_object*
  ret %struct.lean_object* %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_box_uint8(i8 zeroext %0) local_unnamed_addr #0 {
  %2 = zext i8 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_unbox(%struct.lean_object* %0) local_unnamed_addr #0 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = lshr i64 %2, 1
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_unbox_uint8(%struct.lean_object* %0) local_unnamed_addr #0 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = lshr i64 %2, 1
  %4 = trunc i64 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_align(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = urem i64 %0, %1
  %4 = sub i64 %0, %3
  %5 = icmp eq i64 %3, 0
  %6 = select i1 %5, i64 0, i64 %1
  %7 = add i64 %4, %6
  ret i64 %7
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_get_slot_idx(i32 %0) local_unnamed_addr #1 {
  %2 = icmp eq i32 %0, 0
  br i1 %2, label %3, label %4

3:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 310, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

4:                                                ; preds = %1
  %5 = zext i32 %0 to i64
  %6 = and i32 %0, 7
  %7 = zext i32 %6 to i64
  %8 = sub nsw i64 %5, %7
  %9 = icmp eq i32 %6, 0
  %10 = select i1 %9, i64 0, i64 8
  %11 = add nsw i64 %8, %10
  %12 = icmp eq i64 %11, %5
  br i1 %12, label %14, label %13

13:                                               ; preds = %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 311, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %4
  %15 = lshr i32 %0, 3
  %16 = add nsw i32 %15, -1
  ret i32 %16
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) local_unnamed_addr #2

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_small_object(i32 %0) local_unnamed_addr #1 {
  %2 = and i32 %0, 7
  %3 = and i32 %0, -8
  %4 = icmp eq i32 %2, 0
  %5 = select i1 %4, i32 0, i32 8
  %6 = add i32 %5, %3
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %9

8:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 310, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %1
  %10 = icmp ult i32 %6, 4097
  br i1 %10, label %12, label %11

11:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 324, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @__PRETTY_FUNCTION__.lean_alloc_small_object, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %9
  %13 = lshr exact i32 %6, 3
  %14 = add nsw i32 %13, -1
  %15 = tail call i8* @lean_alloc_small(i32 %6, i32 %14) #12
  %16 = bitcast i8* %15 to %struct.lean_object*
  ret %struct.lean_object* %16
}

declare i8* @lean_alloc_small(i32, i32) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_ctor_memory(i32 %0) local_unnamed_addr #1 {
  %2 = zext i32 %0 to i64
  %3 = and i32 %0, 7
  %4 = zext i32 %3 to i64
  %5 = sub nsw i64 %2, %4
  %6 = icmp eq i32 %3, 0
  %7 = select i1 %6, i64 0, i64 8
  %8 = add nsw i64 %5, %7
  %9 = trunc i64 %8 to i32
  %10 = icmp eq i32 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 310, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %1
  %13 = and i64 %8, 4294967295
  %14 = and i32 %9, 7
  %15 = zext i32 %14 to i64
  %16 = sub nsw i64 %13, %15
  %17 = icmp eq i32 %14, 0
  %18 = select i1 %17, i64 0, i64 8
  %19 = add nsw i64 %16, %18
  %20 = icmp eq i64 %19, %13
  br i1 %20, label %22, label %21

21:                                               ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 311, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

22:                                               ; preds = %12
  %23 = icmp ult i32 %9, 4097
  br i1 %23, label %25, label %24

24:                                               ; preds = %22
  tail call void @__assert_fail(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 339, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor_memory, i64 0, i64 0)) #11
  unreachable

25:                                               ; preds = %22
  %26 = lshr i32 %9, 3
  %27 = add nsw i32 %26, -1
  %28 = tail call i8* @lean_alloc_small(i32 %9, i32 %27) #12
  %29 = icmp ugt i32 %9, %0
  br i1 %29, label %30, label %34

30:                                               ; preds = %25
  %31 = getelementptr inbounds i8, i8* %28, i64 %13
  %32 = getelementptr inbounds i8, i8* %31, i64 -8
  %33 = bitcast i8* %32 to i64*
  store i64 0, i64* %33, align 8, !tbaa !3
  br label %34

34:                                               ; preds = %30, %25
  %35 = bitcast i8* %28 to %struct.lean_object*
  ret %struct.lean_object* %35
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_small_object_size(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = tail call i32 @lean_small_mem_size(i8* %2) #12
  ret i32 %3
}

declare i32 @lean_small_mem_size(i8*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define void @lean_free_small_object(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  tail call void @lean_free_small(i8* %2) #12
  ret void
}

declare void @lean_free_small(i8*) local_unnamed_addr #3

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i8 @lean_ptr_tag(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  ret i8 %4
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define i32 @lean_ptr_other(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 6
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = zext i8 %4 to i32
  ret i32 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_mt(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 1
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_st(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_persistent(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 2
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_has_rc(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, 2
  ret i1 %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64* @lean_get_rc_mt_addr(%struct.lean_object* readnone %0) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  ret i64* %2
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define void @lean_inc_ref(%struct.lean_object* nocapture %0) local_unnamed_addr #5 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  switch i8 %4, label %12 [
    i8 0, label %5
    i8 1, label %9
  ], !prof !8

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !9
  %8 = add i64 %7, 1
  store i64 %8, i64* %6, align 8, !tbaa !9
  br label %12

9:                                                ; preds = %1
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %11 = atomicrmw add i64* %10, i64 1 monotonic, align 8
  br label %12

12:                                               ; preds = %9, %5, %1
  ret void
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define void @lean_inc_ref_n(%struct.lean_object* nocapture %0, i64 %1) local_unnamed_addr #5 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 5
  %5 = load i8, i8* %4, align 1, !tbaa !7
  switch i8 %5, label %13 [
    i8 0, label %6
    i8 1, label %10
  ], !prof !8

6:                                                ; preds = %2
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = add i64 %8, %1
  store i64 %9, i64* %7, align 8, !tbaa !9
  br label %13

10:                                               ; preds = %2
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %12 = atomicrmw add i64* %11, i64 %1 monotonic, align 8
  br label %13

13:                                               ; preds = %10, %6, %2
  ret void
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define zeroext i1 @lean_dec_ref_core(%struct.lean_object* nocapture %0) local_unnamed_addr #5 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  switch i8 %4, label %16 [
    i8 0, label %5
    i8 1, label %11
  ], !prof !8

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !9
  %8 = add i64 %7, -1
  store i64 %8, i64* %6, align 8, !tbaa !9
  %9 = and i64 %8, 4294967295
  %10 = icmp eq i64 %9, 0
  br label %16

11:                                               ; preds = %1
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %13 = atomicrmw sub i64* %12, i64 1 acq_rel, align 8
  %14 = and i64 %13, 4294967295
  %15 = icmp eq i64 %14, 1
  br label %16

16:                                               ; preds = %11, %5, %1
  %17 = phi i1 [ %10, %5 ], [ %15, %11 ], [ false, %1 ]
  ret i1 %17
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_dec_ref(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  switch i8 %4, label %17 [
    i8 0, label %5
    i8 1, label %11
  ], !prof !8

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !9
  %8 = add i64 %7, -1
  store i64 %8, i64* %6, align 8, !tbaa !9
  %9 = and i64 %8, 4294967295
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %16, label %17

11:                                               ; preds = %1
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %13 = atomicrmw sub i64* %12, i64 1 acq_rel, align 8
  %14 = and i64 %13, 4294967295
  %15 = icmp eq i64 %14, 1
  br i1 %15, label %16, label %17

16:                                               ; preds = %11, %5
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %17

17:                                               ; preds = %16, %11, %5, %1
  ret void
}

declare void @lean_del(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define void @lean_inc(%struct.lean_object* %0) local_unnamed_addr #5 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %16

5:                                                ; preds = %1
  %6 = bitcast %struct.lean_object* %0 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 5
  %8 = load i8, i8* %7, align 1, !tbaa !7
  switch i8 %8, label %16 [
    i8 0, label %9
    i8 1, label %13
  ], !prof !8

9:                                                ; preds = %5
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !9
  %12 = add i64 %11, 1
  store i64 %12, i64* %10, align 8, !tbaa !9
  br label %16

13:                                               ; preds = %5
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %15 = atomicrmw add i64* %14, i64 1 monotonic, align 8
  br label %16

16:                                               ; preds = %13, %9, %5, %1
  ret void
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define void @lean_inc_n(%struct.lean_object* %0, i64 %1) local_unnamed_addr #5 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %6, label %17

6:                                                ; preds = %2
  %7 = bitcast %struct.lean_object* %0 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 5
  %9 = load i8, i8* %8, align 1, !tbaa !7
  switch i8 %9, label %17 [
    i8 0, label %10
    i8 1, label %14
  ], !prof !8

10:                                               ; preds = %6
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !9
  %13 = add i64 %12, %1
  store i64 %13, i64* %11, align 8, !tbaa !9
  br label %17

14:                                               ; preds = %6
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %16 = atomicrmw add i64* %15, i64 %1 monotonic, align 8
  br label %17

17:                                               ; preds = %14, %10, %6, %2
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_dec(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %21

5:                                                ; preds = %1
  %6 = bitcast %struct.lean_object* %0 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 5
  %8 = load i8, i8* %7, align 1, !tbaa !7
  switch i8 %8, label %21 [
    i8 0, label %9
    i8 1, label %15
  ], !prof !8

9:                                                ; preds = %5
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %11 = load i64, i64* %10, align 8, !tbaa !9
  %12 = add i64 %11, -1
  store i64 %12, i64* %10, align 8, !tbaa !9
  %13 = and i64 %12, 4294967295
  %14 = icmp eq i64 %13, 0
  br i1 %14, label %20, label %21

15:                                               ; preds = %5
  %16 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %17 = atomicrmw sub i64* %16, i64 1 acq_rel, align 8
  %18 = and i64 %17, 4294967295
  %19 = icmp eq i64 %18, 1
  br i1 %19, label %20, label %21

20:                                               ; preds = %15, %9
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %21

21:                                               ; preds = %20, %15, %9, %5, %1
  ret void
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_ctor(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_closure(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_array(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_sarray(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_string(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_mpz(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -6
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_thunk(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -5
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_task(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -4
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_external(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -2
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_ref(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -3
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define i32 @lean_obj_tag(%struct.lean_object* %0) local_unnamed_addr #4 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i32
  br label %13

8:                                                ; preds = %1
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i32
  br label %13

13:                                               ; preds = %8, %5
  %14 = phi i32 [ %7, %5 ], [ %12, %8 ]
  ret i32 %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_ctor_object* @lean_to_ctor(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 570, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_to_ctor, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_ctor_object*
  ret %struct.lean_ctor_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_closure_object* @lean_to_closure(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_closure_object*
  ret %struct.lean_closure_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_array_object* @lean_to_array(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_array_object*
  ret %struct.lean_array_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_sarray_object* @lean_to_sarray(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_sarray_object*
  ret %struct.lean_sarray_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_string_object* @lean_to_string(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_string_object*
  ret %struct.lean_string_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_thunk_object* @lean_to_thunk(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -5
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 575, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_thunk, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_thunk_object*
  ret %struct.lean_thunk_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_task* @lean_to_task(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -4
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 576, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_to_task, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_task*
  ret %struct.lean_task* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_ref_object* @lean_to_ref(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -3
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 577, i8* getelementptr inbounds ([44 x i8], [44 x i8]* @__PRETTY_FUNCTION__.lean_to_ref, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_ref_object*
  ret %struct.lean_ref_object* %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_external_object* @lean_to_external(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -2
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 578, i8* getelementptr inbounds ([54 x i8], [54 x i8]* @__PRETTY_FUNCTION__.lean_to_external, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_external_object*
  ret %struct.lean_external_object* %8
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_exclusive(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %6, label %11, !prof !11

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = and i64 %8, 4294967295
  %10 = icmp eq i64 %9, 1
  br label %11

11:                                               ; preds = %6, %1
  %12 = phi i1 [ %10, %6 ], [ false, %1 ]
  ret i1 %12
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_is_shared(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %6, label %11, !prof !11

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = and i64 %8, 4294967294
  %10 = icmp ne i64 %9, 0
  br label %11

11:                                               ; preds = %6, %1
  %12 = phi i1 [ %10, %6 ], [ false, %1 ]
  ret i1 %12
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn
define zeroext i1 @lean_nonzero_rc(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #5 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  switch i8 %4, label %15 [
    i8 0, label %5
    i8 1, label %10
  ], !prof !8

5:                                                ; preds = %1
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %7 = load i64, i64* %6, align 8, !tbaa !9
  %8 = and i64 %7, 4294967295
  %9 = icmp ne i64 %8, 0
  br label %15

10:                                               ; preds = %1
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %12 = load atomic i64, i64* %11 acquire, align 8
  %13 = and i64 %12, 4294967295
  %14 = icmp ne i64 %13, 0
  br label %15

15:                                               ; preds = %10, %5, %1
  %16 = phi i1 [ %9, %5 ], [ %14, %10 ], [ false, %1 ]
  ret i1 %16
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn writeonly
define void @lean_set_st_header(%struct.lean_object* nocapture %0, i32 %1, i32 %2) local_unnamed_addr #6 {
  %4 = zext i32 %1 to i64
  %5 = shl i64 %4, 56
  %6 = zext i32 %2 to i64
  %7 = shl i64 %6, 48
  %8 = or i64 %5, %7
  %9 = or i64 %8, 1
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  store i64 %9, i64* %10, align 8, !tbaa !9
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_set_non_heap_header(%struct.lean_object* nocapture %0, i64 %1, i32 %2, i32 %3) local_unnamed_addr #1 {
  %5 = icmp eq i64 %1, 0
  br i1 %5, label %6, label %7

6:                                                ; preds = %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 659, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %4
  %8 = icmp ult i64 %1, 35184372088832
  br i1 %8, label %10, label %9

9:                                                ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.14, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 660, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %7
  %11 = icmp eq i64 %1, 1
  br i1 %11, label %17, label %12

12:                                               ; preds = %10
  %13 = trunc i32 %2 to i8
  %14 = add i8 %13, 10
  %15 = icmp ult i8 %14, 4
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  tail call void @__assert_fail(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.15, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 661, i8* getelementptr inbounds ([81 x i8], [81 x i8]* @__PRETTY_FUNCTION__.lean_set_non_heap_header, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %12, %10
  %18 = zext i32 %2 to i64
  %19 = shl i64 %18, 56
  %20 = zext i32 %3 to i64
  %21 = shl i64 %20, 48
  %22 = or i64 %19, %1
  %23 = or i64 %22, %21
  %24 = or i64 %23, 3298534883328
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  store i64 %24, i64* %25, align 8, !tbaa !9
  ret void
}

; Function Attrs: nofree norecurse nounwind sspstrong uwtable willreturn writeonly
define void @lean_set_non_heap_header_for_big(%struct.lean_object* nocapture %0, i32 %1, i32 %2) local_unnamed_addr #6 {
  %4 = zext i32 %1 to i64
  %5 = shl i64 %4, 56
  %6 = zext i32 %2 to i64
  %7 = shl i64 %6, 48
  %8 = or i64 %5, %7
  %9 = or i64 %8, 3298534883329
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  store i64 %9, i64* %10, align 8, !tbaa !9
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_ctor_num_objs(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = zext i8 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 687, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_ctor_obj_cptr, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_object**
  ret %struct.lean_object** %9
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull i8* @lean_ctor_scalar_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 692, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_ctor_scalar_cptr, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %9 = getelementptr inbounds i8, i8* %2, i64 6
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = zext i8 %10 to i64
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %8, i64 %11
  %13 = bitcast %struct.lean_object* %12 to i8*
  ret i8* %13
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_ctor(i32 %0, i32 %1, i32 %2) local_unnamed_addr #1 {
  %4 = icmp ult i32 %0, 245
  %5 = icmp ult i32 %1, 256
  %6 = and i1 %4, %5
  %7 = icmp ult i32 %2, 1024
  %8 = and i1 %6, %7
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([99 x i8], [99 x i8]* @.str.16, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 697, i8* getelementptr inbounds ([71 x i8], [71 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = shl nuw nsw i32 %1, 3
  %12 = add nuw nsw i32 %11, 8
  %13 = add nuw nsw i32 %12, %2
  %14 = tail call %struct.lean_object* @lean_alloc_ctor_memory(i32 %13)
  %15 = zext i32 %0 to i64
  %16 = shl nuw i64 %15, 56
  %17 = zext i32 %1 to i64
  %18 = shl nuw nsw i64 %17, 48
  %19 = or i64 %16, %18
  %20 = or i64 %19, 1
  %21 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %14, i64 0, i32 0
  store i64 %20, i64* %21, align 8, !tbaa !9
  ret %struct.lean_object* %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_ctor_get(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp ult i8 %5, -11
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8, i8* %3, i64 6
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = zext i8 %10 to i32
  %12 = icmp ugt i32 %11, %1
  br i1 %12, label %14, label %13

13:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 704, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %8
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %16 = zext i32 %1 to i64
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %15, i64 %16
  %18 = bitcast %struct.lean_object* %17 to %struct.lean_object**
  %19 = load %struct.lean_object*, %struct.lean_object** %18, align 8, !tbaa !12
  ret %struct.lean_object* %19
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set(%struct.lean_object* nocapture %0, i32 %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %3
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i32
  %13 = icmp ugt i32 %12, %1
  br i1 %13, label %15, label %14

14:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 709, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set, i64 0, i64 0)) #11
  unreachable

15:                                               ; preds = %9
  %16 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %17 = zext i32 %1 to i64
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 %17
  %19 = bitcast %struct.lean_object* %18 to %struct.lean_object**
  store %struct.lean_object* %2, %struct.lean_object** %19, align 8, !tbaa !12
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_tag(%struct.lean_object* nocapture %0, i8 zeroext %1) local_unnamed_addr #1 {
  %3 = icmp ult i8 %1, -11
  br i1 %3, label %5, label %4

4:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.18, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 714, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_tag, i64 0, i64 0)) #11
  unreachable

5:                                                ; preds = %2
  %6 = bitcast %struct.lean_object* %0 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 7
  store i8 %1, i8* %7, align 1, !tbaa !7
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_release(%struct.lean_object* nocapture %0, i32 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp ult i8 %5, -11
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8, i8* %3, i64 6
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = zext i8 %10 to i32
  %12 = icmp ugt i32 %11, %1
  br i1 %12, label %14, label %13

13:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 723, i8* getelementptr inbounds ([53 x i8], [53 x i8]* @__PRETTY_FUNCTION__.lean_ctor_release, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %8
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %16 = zext i32 %1 to i64
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %15, i64 %16
  %18 = bitcast %struct.lean_object* %17 to %struct.lean_object**
  %19 = load %struct.lean_object*, %struct.lean_object** %18, align 8, !tbaa !12
  %20 = ptrtoint %struct.lean_object* %19 to i64
  %21 = and i64 %20, 1
  %22 = icmp eq i64 %21, 0
  br i1 %22, label %23, label %39

23:                                               ; preds = %14
  %24 = bitcast %struct.lean_object* %19 to i8*
  %25 = getelementptr inbounds i8, i8* %24, i64 5
  %26 = load i8, i8* %25, align 1, !tbaa !7
  switch i8 %26, label %39 [
    i8 0, label %27
    i8 1, label %33
  ], !prof !8

27:                                               ; preds = %23
  %28 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %19, i64 0, i32 0
  %29 = load i64, i64* %28, align 8, !tbaa !9
  %30 = add i64 %29, -1
  store i64 %30, i64* %28, align 8, !tbaa !9
  %31 = and i64 %30, 4294967295
  %32 = icmp eq i64 %31, 0
  br i1 %32, label %38, label %39

33:                                               ; preds = %23
  %34 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %19, i64 0, i32 0
  %35 = atomicrmw sub i64* %34, i64 1 acq_rel, align 8
  %36 = and i64 %35, 4294967295
  %37 = icmp eq i64 %36, 1
  br i1 %37, label %38, label %39

38:                                               ; preds = %33, %27
  tail call void @lean_del(%struct.lean_object* nonnull %19) #12
  br label %39

39:                                               ; preds = %38, %33, %27, %23, %14
  store %struct.lean_object* inttoptr (i64 1 to %struct.lean_object*), %struct.lean_object** %18, align 8, !tbaa !12
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_ctor_get_usize(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp ult i8 %5, -11
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8, i8* %3, i64 6
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = zext i8 %10 to i32
  %12 = icmp ugt i32 %11, %1
  br i1 %12, label %13, label %14

13:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 730, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_usize, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %8
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %16 = zext i32 %1 to i64
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %15, i64 %16
  %18 = getelementptr %struct.lean_object, %struct.lean_object* %17, i64 0, i32 0
  %19 = load i64, i64* %18, align 8, !tbaa !3
  ret i64 %19
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_ctor_get_uint8(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = zext i32 %1 to i64
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %2
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 3
  %14 = icmp ugt i64 %13, %3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 735, i8* getelementptr inbounds ([58 x i8], [58 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint8, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %18 = bitcast %struct.lean_object* %17 to i8*
  %19 = getelementptr inbounds i8, i8* %18, i64 %3
  %20 = load i8, i8* %19, align 1, !tbaa !7
  ret i8 %20
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i16 @lean_ctor_get_uint16(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = zext i32 %1 to i64
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %2
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 3
  %14 = icmp ugt i64 %13, %3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 740, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint16, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %18 = bitcast %struct.lean_object* %17 to i8*
  %19 = getelementptr inbounds i8, i8* %18, i64 %3
  %20 = bitcast i8* %19 to i16*
  %21 = load i16, i16* %20, align 2, !tbaa !14
  ret i16 %21
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_ctor_get_uint32(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = zext i32 %1 to i64
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %2
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 3
  %14 = icmp ugt i64 %13, %3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 745, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint32, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %18 = bitcast %struct.lean_object* %17 to i8*
  %19 = getelementptr inbounds i8, i8* %18, i64 %3
  %20 = bitcast i8* %19 to i32*
  %21 = load i32, i32* %20, align 4, !tbaa !16
  ret i32 %21
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_ctor_get_uint64(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = zext i32 %1 to i64
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %2
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 3
  %14 = icmp ugt i64 %13, %3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 750, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint64, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %18 = bitcast %struct.lean_object* %17 to i8*
  %19 = getelementptr inbounds i8, i8* %18, i64 %3
  %20 = bitcast i8* %19 to i64*
  %21 = load i64, i64* %20, align 8, !tbaa !3
  ret i64 %21
}

; Function Attrs: nounwind sspstrong uwtable
define double @lean_ctor_get_float(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = zext i32 %1 to i64
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %2
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 3
  %14 = icmp ugt i64 %13, %3
  br i1 %14, label %15, label %16

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 755, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_float, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %18 = bitcast %struct.lean_object* %17 to i8*
  %19 = getelementptr inbounds i8, i8* %18, i64 %3
  %20 = bitcast i8* %19 to double*
  %21 = load double, double* %20, align 8, !tbaa !18
  ret double %21
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_usize(%struct.lean_object* nocapture %0, i32 %1, i64 %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %3
  %10 = getelementptr inbounds i8, i8* %4, i64 6
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = zext i8 %11 to i32
  %13 = icmp ugt i32 %12, %1
  br i1 %13, label %14, label %15

14:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 760, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_usize, i64 0, i64 0)) #11
  unreachable

15:                                               ; preds = %9
  %16 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %17 = zext i32 %1 to i64
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 %17
  %19 = getelementptr %struct.lean_object, %struct.lean_object* %18, i64 0, i32 0
  store i64 %2, i64* %19, align 8, !tbaa !3
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_uint8(%struct.lean_object* nocapture %0, i32 %1, i8 zeroext %2) local_unnamed_addr #1 {
  %4 = zext i32 %1 to i64
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp ult i8 %7, -11
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, i8* %5, i64 6
  %12 = load i8, i8* %11, align 1, !tbaa !7
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 3
  %15 = icmp ugt i64 %14, %4
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 765, i8* getelementptr inbounds ([64 x i8], [64 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint8, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %10
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %4
  store i8 %2, i8* %20, align 1, !tbaa !7
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_uint16(%struct.lean_object* nocapture %0, i32 %1, i16 zeroext %2) local_unnamed_addr #1 {
  %4 = zext i32 %1 to i64
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp ult i8 %7, -11
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, i8* %5, i64 6
  %12 = load i8, i8* %11, align 1, !tbaa !7
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 3
  %15 = icmp ugt i64 %14, %4
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 770, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint16, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %10
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %4
  %21 = bitcast i8* %20 to i16*
  store i16 %2, i16* %21, align 2, !tbaa !14
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_uint32(%struct.lean_object* nocapture %0, i32 %1, i32 %2) local_unnamed_addr #1 {
  %4 = zext i32 %1 to i64
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp ult i8 %7, -11
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, i8* %5, i64 6
  %12 = load i8, i8* %11, align 1, !tbaa !7
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 3
  %15 = icmp ugt i64 %14, %4
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 775, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint32, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %10
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %4
  %21 = bitcast i8* %20 to i32*
  store i32 %2, i32* %21, align 4, !tbaa !16
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_uint64(%struct.lean_object* nocapture %0, i32 %1, i64 %2) local_unnamed_addr #1 {
  %4 = zext i32 %1 to i64
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp ult i8 %7, -11
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, i8* %5, i64 6
  %12 = load i8, i8* %11, align 1, !tbaa !7
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 3
  %15 = icmp ugt i64 %14, %4
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 780, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_uint64, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %10
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %4
  %21 = bitcast i8* %20 to i64*
  store i64 %2, i64* %21, align 8, !tbaa !3
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_ctor_set_float(%struct.lean_object* nocapture %0, i32 %1, double %2) local_unnamed_addr #1 {
  %4 = zext i32 %1 to i64
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp ult i8 %7, -11
  br i1 %8, label %10, label %9

9:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %3
  %11 = getelementptr inbounds i8, i8* %5, i64 6
  %12 = load i8, i8* %11, align 1, !tbaa !7
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 3
  %15 = icmp ugt i64 %14, %4
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 785, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set_float, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %10
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %4
  %21 = bitcast i8* %20 to double*
  store double %2, double* %21, align 8, !tbaa !18
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define i8* @lean_closure_fun(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %9 = bitcast %struct.lean_object* %8 to i8**
  %10 = load i8*, i8** %9, align 8, !tbaa !20
  ret i8* %10
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_closure_arity(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2
  %9 = bitcast %struct.lean_object* %8 to i16*
  %10 = load i16, i16* %9, align 8, !tbaa !22
  %11 = zext i16 %10 to i32
  ret i32 %11
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_closure_num_fixed(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = bitcast %struct.lean_object* %0 to %struct.lean_closure_object*
  %9 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %8, i64 0, i32 3
  %10 = load i16, i16* %9, align 2, !tbaa !23
  %11 = zext i16 %10 to i32
  ret i32 %11
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object** @lean_closure_arg_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_object**
  ret %struct.lean_object** %9
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_closure(i8* %0, i32 %1, i32 %2) local_unnamed_addr #1 {
  %4 = icmp eq i32 %1, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.21, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 796, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #11
  unreachable

6:                                                ; preds = %3
  %7 = icmp ult i32 %2, %1
  br i1 %7, label %9, label %8

8:                                                ; preds = %6
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.22, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 797, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %6
  %10 = shl i32 %2, 3
  %11 = add i32 %10, 24
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 310, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %9
  %15 = icmp ult i32 %11, 4097
  br i1 %15, label %17, label %16

16:                                               ; preds = %14
  tail call void @__assert_fail(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 324, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @__PRETTY_FUNCTION__.lean_alloc_small_object, i64 0, i64 0)) #11
  unreachable

17:                                               ; preds = %14
  %18 = lshr exact i32 %11, 3
  %19 = add nsw i32 %18, -1
  %20 = tail call i8* @lean_alloc_small(i32 %11, i32 %19) #12
  %21 = bitcast i8* %20 to %struct.lean_object*
  %22 = bitcast i8* %20 to i64*
  store i64 -792633534417207295, i64* %22, align 8, !tbaa !9
  %23 = getelementptr inbounds i8, i8* %20, i64 8
  %24 = bitcast i8* %23 to i8**
  store i8* %0, i8** %24, align 8, !tbaa !20
  %25 = trunc i32 %1 to i16
  %26 = getelementptr inbounds i8, i8* %20, i64 16
  %27 = bitcast i8* %26 to i16*
  store i16 %25, i16* %27, align 8, !tbaa !22
  %28 = trunc i32 %2 to i16
  %29 = getelementptr inbounds i8, i8* %20, i64 18
  %30 = bitcast i8* %29 to i16*
  store i16 %28, i16* %30, align 2, !tbaa !23
  ret %struct.lean_object* %21
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_closure_get(%struct.lean_object* nocapture readonly %0, i32 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, -11
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = bitcast %struct.lean_object* %0 to %struct.lean_closure_object*
  %10 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %9, i64 0, i32 3
  %11 = load i16, i16* %10, align 2, !tbaa !23
  %12 = zext i16 %11 to i32
  %13 = icmp ugt i32 %12, %1
  br i1 %13, label %15, label %14

14:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 806, i8* getelementptr inbounds ([62 x i8], [62 x i8]* @__PRETTY_FUNCTION__.lean_closure_get, i64 0, i64 0)) #11
  unreachable

15:                                               ; preds = %8
  %16 = zext i32 %1 to i64
  %17 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %9, i64 0, i32 4, i64 %16
  %18 = load %struct.lean_object*, %struct.lean_object** %17, align 8, !tbaa !12
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_closure_set(%struct.lean_object* nocapture %0, i32 %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 7
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp eq i8 %6, -11
  br i1 %7, label %9, label %8

8:                                                ; preds = %3
  tail call void @__assert_fail(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 571, i8* getelementptr inbounds ([52 x i8], [52 x i8]* @__PRETTY_FUNCTION__.lean_to_closure, i64 0, i64 0)) #11
  unreachable

9:                                                ; preds = %3
  %10 = bitcast %struct.lean_object* %0 to %struct.lean_closure_object*
  %11 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %10, i64 0, i32 3
  %12 = load i16, i16* %11, align 2, !tbaa !23
  %13 = zext i16 %12 to i32
  %14 = icmp ugt i32 %13, %1
  br i1 %14, label %16, label %15

15:                                               ; preds = %9
  tail call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.23, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 810, i8* getelementptr inbounds ([66 x i8], [66 x i8]* @__PRETTY_FUNCTION__.lean_closure_set, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %9
  %17 = zext i32 %1 to i64
  %18 = getelementptr inbounds %struct.lean_closure_object, %struct.lean_closure_object* %10, i64 0, i32 4, i64 %17
  store %struct.lean_object* %2, %struct.lean_object** %18, align 8, !tbaa !12
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_array(i64 %0, i64 %1) local_unnamed_addr #1 {
  %3 = shl i64 %1, 3
  %4 = add i64 %3, 24
  %5 = tail call %struct.lean_object* @lean_alloc_object(i64 %4) #12
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 0, i32 0
  store i64 -720575940379279359, i64* %6, align 8, !tbaa !9
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 1, i32 0
  store i64 %0, i64* %7, align 8, !tbaa !24
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 2, i32 0
  store i64 %1, i64* %8, align 8, !tbaa !26
  ret %struct.lean_object* %5
}

declare %struct.lean_object* @lean_alloc_object(i64) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_array_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_array_capacity(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !26
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_array_byte_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !26
  %10 = shl i64 %9, 3
  %11 = add i64 %10, 24
  ret i64 %11
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object** @lean_array_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_object**
  ret %struct.lean_object** %9
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_array_set_size(%struct.lean_object* nocapture %0, i64 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, -10
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 858, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds i8, i8* %3, i64 5
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = icmp eq i8 %10, 0
  br i1 %11, label %12, label %17, !prof !11

12:                                               ; preds = %8
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %14 = load i64, i64* %13, align 8, !tbaa !9
  %15 = and i64 %14, 4294967295
  %16 = icmp eq i64 %15, 1
  br i1 %16, label %18, label %17

17:                                               ; preds = %12, %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 859, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #11
  unreachable

18:                                               ; preds = %12
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !26
  %21 = icmp ult i64 %20, %1
  br i1 %21, label %22, label %23

22:                                               ; preds = %18
  tail call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.25, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 860, i8* getelementptr inbounds ([49 x i8], [49 x i8]* @__PRETTY_FUNCTION__.lean_array_set_size, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %18
  %24 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  store i64 %1, i64* %24, align 8, !tbaa !24
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_get_core(%struct.lean_object* nocapture readonly %0, i64 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, -10
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !24
  %11 = icmp ugt i64 %10, %1
  br i1 %11, label %13, label %12

12:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 864, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #11
  unreachable

13:                                               ; preds = %8
  %14 = bitcast %struct.lean_object* %0 to %struct.lean_array_object*
  %15 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %14, i64 0, i32 3, i64 %1
  %16 = load %struct.lean_object*, %struct.lean_object** %15, align 8, !tbaa !12
  ret %struct.lean_object* %16
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_array_set_core(%struct.lean_object* nocapture %0, i64 %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 5
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp ult i8 %6, 2
  br i1 %7, label %8, label %16

8:                                                ; preds = %3
  %9 = icmp eq i8 %6, 0
  br i1 %9, label %10, label %15, !prof !11

10:                                               ; preds = %8
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !9
  %13 = and i64 %12, 4294967295
  %14 = icmp eq i64 %13, 1
  br i1 %14, label %16, label %15

15:                                               ; preds = %10, %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.27, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 870, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_array_set_core, i64 0, i64 0)) #11
  unreachable

16:                                               ; preds = %10, %3
  %17 = getelementptr inbounds i8, i8* %4, i64 7
  %18 = load i8, i8* %17, align 1, !tbaa !7
  %19 = icmp eq i8 %18, -10
  br i1 %19, label %21, label %20

20:                                               ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

21:                                               ; preds = %16
  %22 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %23 = load i64, i64* %22, align 8, !tbaa !24
  %24 = icmp ugt i64 %23, %1
  br i1 %24, label %26, label %25

25:                                               ; preds = %21
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 871, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_array_set_core, i64 0, i64 0)) #11
  unreachable

26:                                               ; preds = %21
  %27 = bitcast %struct.lean_object* %0 to %struct.lean_array_object*
  %28 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %27, i64 0, i32 3, i64 %1
  store %struct.lean_object* %2, %struct.lean_object** %28, align 8, !tbaa !12
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_array_sz(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  %10 = ptrtoint %struct.lean_object* %0 to i64
  %11 = and i64 %10, 1
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %13, label %28

13:                                               ; preds = %7
  %14 = getelementptr inbounds i8, i8* %2, i64 5
  %15 = load i8, i8* %14, align 1, !tbaa !7
  switch i8 %15, label %28 [
    i8 0, label %16
    i8 1, label %22
  ], !prof !8

16:                                               ; preds = %13
  %17 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %18 = load i64, i64* %17, align 8, !tbaa !9
  %19 = add i64 %18, -1
  store i64 %19, i64* %17, align 8, !tbaa !9
  %20 = and i64 %19, 4294967295
  %21 = icmp eq i64 %20, 0
  br i1 %21, label %27, label %28

22:                                               ; preds = %13
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %24 = atomicrmw sub i64* %23, i64 1 acq_rel, align 8
  %25 = and i64 %24, 4294967295
  %26 = icmp eq i64 %25, 1
  br i1 %26, label %27, label %28

27:                                               ; preds = %22, %16
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %28

28:                                               ; preds = %27, %22, %16, %13, %7
  %29 = shl i64 %9, 1
  %30 = or i64 %29, 1
  %31 = inttoptr i64 %30 to %struct.lean_object*
  ret %struct.lean_object* %31
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_array_get_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -10
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  %10 = shl i64 %9, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  ret %struct.lean_object* %12
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_array() local_unnamed_addr #1 {
  %1 = tail call %struct.lean_object* @lean_alloc_object(i64 24) #12
  %2 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 0, i32 0
  store i64 -720575940379279359, i64* %2, align 8, !tbaa !9
  %3 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 1, i32 0
  %4 = bitcast i64* %3 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %4, i8 0, i64 16, i1 false)
  ret %struct.lean_object* %1
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_array_with_capacity(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void (...) @lean_internal_panic_out_of_memory() #11
  unreachable

6:                                                ; preds = %1
  %7 = lshr i64 %2, 1
  %8 = shl i64 %7, 3
  %9 = add i64 %8, 24
  %10 = tail call %struct.lean_object* @lean_alloc_object(i64 %9) #12
  %11 = bitcast %struct.lean_object* %10 to <2 x i64>*
  store <2 x i64> <i64 -720575940379279359, i64 0>, <2 x i64>* %11, align 8, !tbaa !3
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %10, i64 2, i32 0
  store i64 %7, i64* %12, align 8, !tbaa !26
  ret %struct.lean_object* %10
}

; Function Attrs: noreturn
declare void @lean_internal_panic_out_of_memory(...) local_unnamed_addr #7

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uget(%struct.lean_object* nocapture readonly %0, i64 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, -10
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !24
  %11 = icmp ugt i64 %10, %1
  br i1 %11, label %13, label %12

12:                                               ; preds = %8
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 864, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #11
  unreachable

13:                                               ; preds = %8
  %14 = bitcast %struct.lean_object* %0 to %struct.lean_array_object*
  %15 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %14, i64 0, i32 3, i64 %1
  %16 = load %struct.lean_object*, %struct.lean_object** %15, align 8, !tbaa !12
  %17 = ptrtoint %struct.lean_object* %16 to i64
  %18 = and i64 %17, 1
  %19 = icmp eq i64 %18, 0
  br i1 %19, label %20, label %31

20:                                               ; preds = %13
  %21 = bitcast %struct.lean_object* %16 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 5
  %23 = load i8, i8* %22, align 1, !tbaa !7
  switch i8 %23, label %31 [
    i8 0, label %24
    i8 1, label %28
  ], !prof !8

24:                                               ; preds = %20
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 0, i32 0
  %26 = load i64, i64* %25, align 8, !tbaa !9
  %27 = add i64 %26, 1
  store i64 %27, i64* %25, align 8, !tbaa !9
  br label %31

28:                                               ; preds = %20
  %29 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 0, i32 0
  %30 = atomicrmw add i64* %29, i64 1 monotonic, align 8
  br label %31

31:                                               ; preds = %28, %24, %20, %13
  ret %struct.lean_object* %16
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fget(%struct.lean_object* nocapture readonly %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = lshr i64 %3, 1
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp eq i8 %7, -10
  br i1 %8, label %10, label %9

9:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %2
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !24
  %13 = icmp ugt i64 %12, %4
  br i1 %13, label %15, label %14

14:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 864, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #11
  unreachable

15:                                               ; preds = %10
  %16 = bitcast %struct.lean_object* %0 to %struct.lean_array_object*
  %17 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %16, i64 0, i32 3, i64 %4
  %18 = load %struct.lean_object*, %struct.lean_object** %17, align 8, !tbaa !12
  %19 = ptrtoint %struct.lean_object* %18 to i64
  %20 = and i64 %19, 1
  %21 = icmp eq i64 %20, 0
  br i1 %21, label %22, label %33

22:                                               ; preds = %15
  %23 = bitcast %struct.lean_object* %18 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 5
  %25 = load i8, i8* %24, align 1, !tbaa !7
  switch i8 %25, label %33 [
    i8 0, label %26
    i8 1, label %30
  ], !prof !8

26:                                               ; preds = %22
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 0, i32 0
  %28 = load i64, i64* %27, align 8, !tbaa !9
  %29 = add i64 %28, 1
  store i64 %29, i64* %27, align 8, !tbaa !9
  br label %33

30:                                               ; preds = %22
  %31 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 0, i32 0
  %32 = atomicrmw add i64* %31, i64 1 monotonic, align 8
  br label %33

33:                                               ; preds = %30, %26, %22, %15
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_get(%struct.lean_object* %0, %struct.lean_object* nocapture readonly %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %2 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %64, label %7

7:                                                ; preds = %3
  %8 = lshr i64 %4, 1
  %9 = bitcast %struct.lean_object* %1 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = icmp eq i8 %11, -10
  br i1 %12, label %14, label %13

13:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %7
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 1, i32 0
  %16 = load i64, i64* %15, align 8, !tbaa !24
  %17 = icmp ult i64 %8, %16
  br i1 %17, label %18, label %64

18:                                               ; preds = %14
  %19 = ptrtoint %struct.lean_object* %0 to i64
  %20 = and i64 %19, 1
  %21 = icmp eq i64 %20, 0
  br i1 %21, label %22, label %38

22:                                               ; preds = %18
  %23 = bitcast %struct.lean_object* %0 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 5
  %25 = load i8, i8* %24, align 1, !tbaa !7
  switch i8 %25, label %38 [
    i8 0, label %26
    i8 1, label %32
  ], !prof !8

26:                                               ; preds = %22
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %28 = load i64, i64* %27, align 8, !tbaa !9
  %29 = add i64 %28, -1
  store i64 %29, i64* %27, align 8, !tbaa !9
  %30 = and i64 %29, 4294967295
  %31 = icmp eq i64 %30, 0
  br i1 %31, label %37, label %38

32:                                               ; preds = %22
  %33 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %34 = atomicrmw sub i64* %33, i64 1 acq_rel, align 8
  %35 = and i64 %34, 4294967295
  %36 = icmp eq i64 %35, 1
  br i1 %36, label %37, label %38

37:                                               ; preds = %32, %26
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %38

38:                                               ; preds = %37, %32, %26, %22, %18
  %39 = load i8, i8* %10, align 1, !tbaa !7
  %40 = icmp eq i8 %39, -10
  br i1 %40, label %42, label %41

41:                                               ; preds = %38
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

42:                                               ; preds = %38
  %43 = load i64, i64* %15, align 8, !tbaa !24
  %44 = icmp ugt i64 %43, %8
  br i1 %44, label %46, label %45

45:                                               ; preds = %42
  tail call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.26, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 864, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #11
  unreachable

46:                                               ; preds = %42
  %47 = bitcast %struct.lean_object* %1 to %struct.lean_array_object*
  %48 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %47, i64 0, i32 3, i64 %8
  %49 = load %struct.lean_object*, %struct.lean_object** %48, align 8, !tbaa !12
  %50 = ptrtoint %struct.lean_object* %49 to i64
  %51 = and i64 %50, 1
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %53, label %66

53:                                               ; preds = %46
  %54 = bitcast %struct.lean_object* %49 to i8*
  %55 = getelementptr inbounds i8, i8* %54, i64 5
  %56 = load i8, i8* %55, align 1, !tbaa !7
  switch i8 %56, label %66 [
    i8 0, label %57
    i8 1, label %61
  ], !prof !8

57:                                               ; preds = %53
  %58 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %49, i64 0, i32 0
  %59 = load i64, i64* %58, align 8, !tbaa !9
  %60 = add i64 %59, 1
  store i64 %60, i64* %58, align 8, !tbaa !9
  br label %66

61:                                               ; preds = %53
  %62 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %49, i64 0, i32 0
  %63 = atomicrmw add i64* %62, i64 1 monotonic, align 8
  br label %66

64:                                               ; preds = %14, %3
  %65 = tail call %struct.lean_object* @lean_array_get_panic(%struct.lean_object* %0) #12
  br label %66

66:                                               ; preds = %64, %61, %57, %53, %46
  %67 = phi %struct.lean_object* [ %65, %64 ], [ %49, %61 ], [ %49, %57 ], [ %49, %53 ], [ %49, %46 ]
  ret %struct.lean_object* %67
}

declare %struct.lean_object* @lean_array_get_panic(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_copy_array(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* %0, i1 zeroext false) #12
  ret %struct.lean_object* %2
}

declare %struct.lean_object* @lean_copy_expand_array(%struct.lean_object*, i1 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %6, label %11, !prof !11

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = and i64 %8, 4294967295
  %10 = icmp eq i64 %9, 1
  br i1 %10, label %13, label %11

11:                                               ; preds = %6, %1
  %12 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  br label %13

13:                                               ; preds = %11, %6
  %14 = phi %struct.lean_object* [ %12, %11 ], [ %0, %6 ]
  ret %struct.lean_object* %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uset(%struct.lean_object* %0, i64 %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 5
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %13, !prof !11

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !9
  %11 = and i64 %10, 4294967295
  %12 = icmp eq i64 %11, 1
  br i1 %12, label %16, label %13

13:                                               ; preds = %8, %3
  %14 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %15 = bitcast %struct.lean_object* %14 to i8*
  br label %16

16:                                               ; preds = %13, %8
  %17 = phi i8* [ %4, %8 ], [ %15, %13 ]
  %18 = phi %struct.lean_object* [ %0, %8 ], [ %14, %13 ]
  %19 = getelementptr inbounds i8, i8* %17, i64 7
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, -10
  br i1 %21, label %23, label %22

22:                                               ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %16
  %24 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 3
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %24, i64 %1
  %26 = bitcast %struct.lean_object* %25 to %struct.lean_object**
  %27 = load %struct.lean_object*, %struct.lean_object** %26, align 8, !tbaa !12
  %28 = ptrtoint %struct.lean_object* %27 to i64
  %29 = and i64 %28, 1
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %31, label %47

31:                                               ; preds = %23
  %32 = bitcast %struct.lean_object* %27 to i8*
  %33 = getelementptr inbounds i8, i8* %32, i64 5
  %34 = load i8, i8* %33, align 1, !tbaa !7
  switch i8 %34, label %47 [
    i8 0, label %35
    i8 1, label %41
  ], !prof !8

35:                                               ; preds = %31
  %36 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %27, i64 0, i32 0
  %37 = load i64, i64* %36, align 8, !tbaa !9
  %38 = add i64 %37, -1
  store i64 %38, i64* %36, align 8, !tbaa !9
  %39 = and i64 %38, 4294967295
  %40 = icmp eq i64 %39, 0
  br i1 %40, label %46, label %47

41:                                               ; preds = %31
  %42 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %27, i64 0, i32 0
  %43 = atomicrmw sub i64* %42, i64 1 acq_rel, align 8
  %44 = and i64 %43, 4294967295
  %45 = icmp eq i64 %44, 1
  br i1 %45, label %46, label %47

46:                                               ; preds = %41, %35
  tail call void @lean_del(%struct.lean_object* nonnull %27) #12
  br label %47

47:                                               ; preds = %46, %41, %35, %31, %23
  store %struct.lean_object* %2, %struct.lean_object** %26, align 8, !tbaa !12
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fset(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %1 to i64
  %5 = lshr i64 %4, 1
  %6 = bitcast %struct.lean_object* %0 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 5
  %8 = load i8, i8* %7, align 1, !tbaa !7
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %10, label %15, !prof !11

10:                                               ; preds = %3
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !9
  %13 = and i64 %12, 4294967295
  %14 = icmp eq i64 %13, 1
  br i1 %14, label %18, label %15

15:                                               ; preds = %10, %3
  %16 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %17 = bitcast %struct.lean_object* %16 to i8*
  br label %18

18:                                               ; preds = %15, %10
  %19 = phi i8* [ %6, %10 ], [ %17, %15 ]
  %20 = phi %struct.lean_object* [ %0, %10 ], [ %16, %15 ]
  %21 = getelementptr inbounds i8, i8* %19, i64 7
  %22 = load i8, i8* %21, align 1, !tbaa !7
  %23 = icmp eq i8 %22, -10
  br i1 %23, label %25, label %24

24:                                               ; preds = %18
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

25:                                               ; preds = %18
  %26 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %20, i64 3
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %26, i64 %5
  %28 = bitcast %struct.lean_object* %27 to %struct.lean_object**
  %29 = load %struct.lean_object*, %struct.lean_object** %28, align 8, !tbaa !12
  %30 = ptrtoint %struct.lean_object* %29 to i64
  %31 = and i64 %30, 1
  %32 = icmp eq i64 %31, 0
  br i1 %32, label %33, label %49

33:                                               ; preds = %25
  %34 = bitcast %struct.lean_object* %29 to i8*
  %35 = getelementptr inbounds i8, i8* %34, i64 5
  %36 = load i8, i8* %35, align 1, !tbaa !7
  switch i8 %36, label %49 [
    i8 0, label %37
    i8 1, label %43
  ], !prof !8

37:                                               ; preds = %33
  %38 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %29, i64 0, i32 0
  %39 = load i64, i64* %38, align 8, !tbaa !9
  %40 = add i64 %39, -1
  store i64 %40, i64* %38, align 8, !tbaa !9
  %41 = and i64 %40, 4294967295
  %42 = icmp eq i64 %41, 0
  br i1 %42, label %48, label %49

43:                                               ; preds = %33
  %44 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %29, i64 0, i32 0
  %45 = atomicrmw sub i64* %44, i64 1 acq_rel, align 8
  %46 = and i64 %45, 4294967295
  %47 = icmp eq i64 %46, 1
  br i1 %47, label %48, label %49

48:                                               ; preds = %43, %37
  tail call void @lean_del(%struct.lean_object* nonnull %29) #12
  br label %49

49:                                               ; preds = %48, %43, %37, %33, %25
  store %struct.lean_object* %2, %struct.lean_object** %28, align 8, !tbaa !12
  ret %struct.lean_object* %20
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_set(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %1 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %60, label %7

7:                                                ; preds = %3
  %8 = lshr i64 %4, 1
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = icmp eq i8 %11, -10
  br i1 %12, label %14, label %13

13:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %7
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %16 = load i64, i64* %15, align 8, !tbaa !24
  %17 = icmp ult i64 %8, %16
  br i1 %17, label %18, label %60

18:                                               ; preds = %14
  %19 = getelementptr inbounds i8, i8* %9, i64 5
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %22, label %27, !prof !11

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %24 = load i64, i64* %23, align 8, !tbaa !9
  %25 = and i64 %24, 4294967295
  %26 = icmp eq i64 %25, 1
  br i1 %26, label %34, label %27

27:                                               ; preds = %22, %18
  %28 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %29 = bitcast %struct.lean_object* %28 to i8*
  %30 = getelementptr inbounds i8, i8* %29, i64 7
  %31 = load i8, i8* %30, align 1, !tbaa !7
  %32 = icmp eq i8 %31, -10
  br i1 %32, label %34, label %33

33:                                               ; preds = %27
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

34:                                               ; preds = %27, %22
  %35 = phi %struct.lean_object* [ %28, %27 ], [ %0, %22 ]
  %36 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %35, i64 3
  %37 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %36, i64 %8
  %38 = bitcast %struct.lean_object* %37 to %struct.lean_object**
  %39 = load %struct.lean_object*, %struct.lean_object** %38, align 8, !tbaa !12
  %40 = ptrtoint %struct.lean_object* %39 to i64
  %41 = and i64 %40, 1
  %42 = icmp eq i64 %41, 0
  br i1 %42, label %43, label %59

43:                                               ; preds = %34
  %44 = bitcast %struct.lean_object* %39 to i8*
  %45 = getelementptr inbounds i8, i8* %44, i64 5
  %46 = load i8, i8* %45, align 1, !tbaa !7
  switch i8 %46, label %59 [
    i8 0, label %47
    i8 1, label %53
  ], !prof !8

47:                                               ; preds = %43
  %48 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %39, i64 0, i32 0
  %49 = load i64, i64* %48, align 8, !tbaa !9
  %50 = add i64 %49, -1
  store i64 %50, i64* %48, align 8, !tbaa !9
  %51 = and i64 %50, 4294967295
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %58, label %59

53:                                               ; preds = %43
  %54 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %39, i64 0, i32 0
  %55 = atomicrmw sub i64* %54, i64 1 acq_rel, align 8
  %56 = and i64 %55, 4294967295
  %57 = icmp eq i64 %56, 1
  br i1 %57, label %58, label %59

58:                                               ; preds = %53, %47
  tail call void @lean_del(%struct.lean_object* nonnull %39) #12
  br label %59

59:                                               ; preds = %58, %53, %47, %43, %34
  store %struct.lean_object* %2, %struct.lean_object** %38, align 8, !tbaa !12
  br label %62

60:                                               ; preds = %14, %3
  %61 = tail call %struct.lean_object* @lean_array_set_panic(%struct.lean_object* %0, %struct.lean_object* %2) #12
  br label %62

62:                                               ; preds = %60, %59
  %63 = phi %struct.lean_object* [ %61, %60 ], [ %35, %59 ]
  ret %struct.lean_object* %63
}

declare %struct.lean_object* @lean_array_set_panic(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_pop(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 5
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %6, label %11, !prof !11

6:                                                ; preds = %1
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %8 = load i64, i64* %7, align 8, !tbaa !9
  %9 = and i64 %8, 4294967295
  %10 = icmp eq i64 %9, 1
  br i1 %10, label %14, label %11

11:                                               ; preds = %6, %1
  %12 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %13 = bitcast %struct.lean_object* %12 to i8*
  br label %14

14:                                               ; preds = %11, %6
  %15 = phi i8* [ %2, %6 ], [ %13, %11 ]
  %16 = phi %struct.lean_object* [ %0, %6 ], [ %12, %11 ]
  %17 = getelementptr inbounds i8, i8* %15, i64 7
  %18 = load i8, i8* %17, align 1, !tbaa !7
  %19 = icmp eq i8 %18, -10
  br i1 %19, label %21, label %20

20:                                               ; preds = %14
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

21:                                               ; preds = %14
  %22 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 1, i32 0
  %23 = load i64, i64* %22, align 8, !tbaa !24
  %24 = icmp eq i64 %23, 0
  br i1 %24, label %50, label %25

25:                                               ; preds = %21
  %26 = add i64 %23, -1
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 3
  %28 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %27, i64 %26
  %29 = bitcast %struct.lean_object* %28 to %struct.lean_object**
  store i64 %26, i64* %22, align 8, !tbaa !24
  %30 = load %struct.lean_object*, %struct.lean_object** %29, align 8, !tbaa !12
  %31 = ptrtoint %struct.lean_object* %30 to i64
  %32 = and i64 %31, 1
  %33 = icmp eq i64 %32, 0
  br i1 %33, label %34, label %50

34:                                               ; preds = %25
  %35 = bitcast %struct.lean_object* %30 to i8*
  %36 = getelementptr inbounds i8, i8* %35, i64 5
  %37 = load i8, i8* %36, align 1, !tbaa !7
  switch i8 %37, label %50 [
    i8 0, label %38
    i8 1, label %44
  ], !prof !8

38:                                               ; preds = %34
  %39 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %30, i64 0, i32 0
  %40 = load i64, i64* %39, align 8, !tbaa !9
  %41 = add i64 %40, -1
  store i64 %41, i64* %39, align 8, !tbaa !9
  %42 = and i64 %41, 4294967295
  %43 = icmp eq i64 %42, 0
  br i1 %43, label %49, label %50

44:                                               ; preds = %34
  %45 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %30, i64 0, i32 0
  %46 = atomicrmw sub i64* %45, i64 1 acq_rel, align 8
  %47 = and i64 %46, 4294967295
  %48 = icmp eq i64 %47, 1
  br i1 %48, label %49, label %50

49:                                               ; preds = %44, %38
  tail call void @lean_del(%struct.lean_object* nonnull %30) #12
  br label %50

50:                                               ; preds = %49, %44, %38, %34, %25, %21
  ret %struct.lean_object* %16
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_uswap(%struct.lean_object* %0, i64 %1, i64 %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 5
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %13, !prof !11

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !9
  %11 = and i64 %10, 4294967295
  %12 = icmp eq i64 %11, 1
  br i1 %12, label %16, label %13

13:                                               ; preds = %8, %3
  %14 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %15 = bitcast %struct.lean_object* %14 to i8*
  br label %16

16:                                               ; preds = %13, %8
  %17 = phi i8* [ %4, %8 ], [ %15, %13 ]
  %18 = phi %struct.lean_object* [ %0, %8 ], [ %14, %13 ]
  %19 = getelementptr inbounds i8, i8* %17, i64 7
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, -10
  br i1 %21, label %23, label %22

22:                                               ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %16
  %24 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 3
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %24, i64 %1
  %26 = bitcast %struct.lean_object* %25 to %struct.lean_object**
  %27 = load %struct.lean_object*, %struct.lean_object** %26, align 8, !tbaa !12
  %28 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %24, i64 %2
  %29 = bitcast %struct.lean_object* %28 to %struct.lean_object**
  %30 = load %struct.lean_object*, %struct.lean_object** %29, align 8, !tbaa !12
  store %struct.lean_object* %30, %struct.lean_object** %26, align 8, !tbaa !12
  store %struct.lean_object* %27, %struct.lean_object** %29, align 8, !tbaa !12
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_fswap(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 5
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %13, !prof !11

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !9
  %11 = and i64 %10, 4294967295
  %12 = icmp eq i64 %11, 1
  br i1 %12, label %16, label %13

13:                                               ; preds = %8, %3
  %14 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %15 = bitcast %struct.lean_object* %14 to i8*
  br label %16

16:                                               ; preds = %13, %8
  %17 = phi i8* [ %4, %8 ], [ %15, %13 ]
  %18 = phi %struct.lean_object* [ %0, %8 ], [ %14, %13 ]
  %19 = getelementptr inbounds i8, i8* %17, i64 7
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, -10
  br i1 %21, label %23, label %22

22:                                               ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %16
  %24 = ptrtoint %struct.lean_object* %2 to i64
  %25 = lshr i64 %24, 1
  %26 = ptrtoint %struct.lean_object* %1 to i64
  %27 = lshr i64 %26, 1
  %28 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 3
  %29 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %28, i64 %27
  %30 = bitcast %struct.lean_object* %29 to %struct.lean_object**
  %31 = load %struct.lean_object*, %struct.lean_object** %30, align 8, !tbaa !12
  %32 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %28, i64 %25
  %33 = bitcast %struct.lean_object* %32 to %struct.lean_object**
  %34 = load %struct.lean_object*, %struct.lean_object** %33, align 8, !tbaa !12
  store %struct.lean_object* %34, %struct.lean_object** %30, align 8, !tbaa !12
  store %struct.lean_object* %31, %struct.lean_object** %33, align 8, !tbaa !12
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_array_swap(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %1 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %50, label %7

7:                                                ; preds = %3
  %8 = ptrtoint %struct.lean_object* %2 to i64
  %9 = and i64 %8, 1
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %50, label %11

11:                                               ; preds = %7
  %12 = lshr i64 %4, 1
  %13 = lshr i64 %8, 1
  %14 = bitcast %struct.lean_object* %0 to i8*
  %15 = getelementptr inbounds i8, i8* %14, i64 7
  %16 = load i8, i8* %15, align 1, !tbaa !7
  %17 = icmp eq i8 %16, -10
  br i1 %17, label %19, label %18

18:                                               ; preds = %11
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

19:                                               ; preds = %11
  %20 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %21 = load i64, i64* %20, align 8, !tbaa !24
  %22 = icmp ult i64 %12, %21
  %23 = icmp ult i64 %13, %21
  %24 = and i1 %22, %23
  br i1 %24, label %25, label %50

25:                                               ; preds = %19
  %26 = getelementptr inbounds i8, i8* %14, i64 5
  %27 = load i8, i8* %26, align 1, !tbaa !7
  %28 = icmp eq i8 %27, 0
  br i1 %28, label %29, label %34, !prof !11

29:                                               ; preds = %25
  %30 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %31 = load i64, i64* %30, align 8, !tbaa !9
  %32 = and i64 %31, 4294967295
  %33 = icmp eq i64 %32, 1
  br i1 %33, label %41, label %34

34:                                               ; preds = %29, %25
  %35 = tail call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* nonnull %0, i1 zeroext false) #12
  %36 = bitcast %struct.lean_object* %35 to i8*
  %37 = getelementptr inbounds i8, i8* %36, i64 7
  %38 = load i8, i8* %37, align 1, !tbaa !7
  %39 = icmp eq i8 %38, -10
  br i1 %39, label %41, label %40

40:                                               ; preds = %34
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #11
  unreachable

41:                                               ; preds = %34, %29
  %42 = phi %struct.lean_object* [ %35, %34 ], [ %0, %29 ]
  %43 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %42, i64 3
  %44 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %43, i64 %12
  %45 = bitcast %struct.lean_object* %44 to %struct.lean_object**
  %46 = load %struct.lean_object*, %struct.lean_object** %45, align 8, !tbaa !12
  %47 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %43, i64 %13
  %48 = bitcast %struct.lean_object* %47 to %struct.lean_object**
  %49 = load %struct.lean_object*, %struct.lean_object** %48, align 8, !tbaa !12
  store %struct.lean_object* %49, %struct.lean_object** %45, align 8, !tbaa !12
  store %struct.lean_object* %46, %struct.lean_object** %48, align 8, !tbaa !12
  br label %50

50:                                               ; preds = %41, %19, %7, %3
  %51 = phi %struct.lean_object* [ %0, %7 ], [ %0, %3 ], [ %42, %41 ], [ %0, %19 ]
  ret %struct.lean_object* %51
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_sarray(i32 %0, i64 %1, i64 %2) local_unnamed_addr #1 {
  %4 = zext i32 %0 to i64
  %5 = mul i64 %4, %2
  %6 = add i64 %5, 24
  %7 = tail call %struct.lean_object* @lean_alloc_object(i64 %6) #12
  %8 = shl i64 %4, 48
  %9 = or i64 %8, -576460752303423487
  %10 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %7, i64 0, i32 0
  store i64 %9, i64* %10, align 8, !tbaa !9
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %7, i64 1, i32 0
  store i64 %1, i64* %11, align 8, !tbaa !24
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %7, i64 2, i32 0
  store i64 %2, i64* %12, align 8, !tbaa !26
  ret %struct.lean_object* %7
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_sarray_elem_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1005, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_elem_size, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = zext i8 %9 to i32
  ret i32 %10
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_sarray_capacity(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !26
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_sarray_byte_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1005, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_elem_size, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = zext i8 %9 to i64
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !26
  %13 = mul i64 %12, %10
  %14 = add i64 %13, 24
  ret i64 %14
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_sarray_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define void @lean_sarray_set_size(%struct.lean_object* nocapture %0, i64 %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 5
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, 0
  br i1 %6, label %7, label %12, !prof !11

7:                                                ; preds = %2
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !9
  %10 = and i64 %9, 4294967295
  %11 = icmp eq i64 %10, 1
  br i1 %11, label %13, label %12

12:                                               ; preds = %7, %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.24, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1014, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_set_size, i64 0, i64 0)) #11
  unreachable

13:                                               ; preds = %7
  %14 = getelementptr inbounds i8, i8* %3, i64 7
  %15 = load i8, i8* %14, align 1, !tbaa !7
  %16 = icmp eq i8 %15, -8
  br i1 %16, label %18, label %17

17:                                               ; preds = %13
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

18:                                               ; preds = %13
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !26
  %21 = icmp ult i64 %20, %1
  br i1 %21, label %22, label %23

22:                                               ; preds = %18
  tail call void @__assert_fail(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.28, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1015, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_sarray_set_size, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %18
  %24 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  store i64 %1, i64* %24, align 8, !tbaa !24
  ret void
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull i8* @lean_sarray_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %9 = bitcast %struct.lean_object* %8 to i8*
  ret i8* %9
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_byte_array(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void (...) @lean_internal_panic_out_of_memory() #11
  unreachable

6:                                                ; preds = %1
  %7 = lshr i64 %2, 1
  %8 = add nuw i64 %7, 24
  %9 = tail call %struct.lean_object* @lean_alloc_object(i64 %8) #12
  %10 = bitcast %struct.lean_object* %9 to <2 x i64>*
  store <2 x i64> <i64 -576179277326712831, i64 0>, <2 x i64>* %10, align 8, !tbaa !3
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %9, i64 2, i32 0
  store i64 %7, i64* %11, align 8, !tbaa !26
  ret %struct.lean_object* %9
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_byte_array_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  %10 = shl i64 %9, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  ret %struct.lean_object* %12
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_byte_array_get(%struct.lean_object* nocapture readonly %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %22, label %6

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = bitcast %struct.lean_object* %0 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 7
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = icmp eq i8 %10, -8
  br i1 %11, label %13, label %12

12:                                               ; preds = %6
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

13:                                               ; preds = %6
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !24
  %16 = icmp ult i64 %7, %15
  br i1 %16, label %17, label %22

17:                                               ; preds = %13
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %19 = bitcast %struct.lean_object* %18 to i8*
  %20 = getelementptr inbounds i8, i8* %19, i64 %7
  %21 = load i8, i8* %20, align 1, !tbaa !7
  br label %22

22:                                               ; preds = %17, %13, %2
  %23 = phi i8 [ %21, %17 ], [ 0, %13 ], [ 0, %2 ]
  ret i8 %23
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_byte_array_set(%struct.lean_object* %0, %struct.lean_object* %1, i8 zeroext %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %1 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %3
  %8 = lshr i64 %4, 1
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = icmp eq i8 %11, -8
  br i1 %12, label %14, label %13

13:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %7
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %16 = load i64, i64* %15, align 8, !tbaa !24
  %17 = icmp ult i64 %8, %16
  br i1 %17, label %18, label %39

18:                                               ; preds = %14
  %19 = getelementptr inbounds i8, i8* %9, i64 5
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %22, label %27, !prof !11

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %24 = load i64, i64* %23, align 8, !tbaa !9
  %25 = and i64 %24, 4294967295
  %26 = icmp eq i64 %25, 1
  br i1 %26, label %34, label %27

27:                                               ; preds = %22, %18
  %28 = tail call %struct.lean_object* @lean_copy_byte_array(%struct.lean_object* nonnull %0) #12
  %29 = bitcast %struct.lean_object* %28 to i8*
  %30 = getelementptr inbounds i8, i8* %29, i64 7
  %31 = load i8, i8* %30, align 1, !tbaa !7
  %32 = icmp eq i8 %31, -8
  br i1 %32, label %34, label %33

33:                                               ; preds = %27
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

34:                                               ; preds = %27, %22
  %35 = phi %struct.lean_object* [ %28, %27 ], [ %0, %22 ]
  %36 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %35, i64 3
  %37 = bitcast %struct.lean_object* %36 to i8*
  %38 = getelementptr inbounds i8, i8* %37, i64 %8
  store i8 %2, i8* %38, align 1, !tbaa !7
  br label %39

39:                                               ; preds = %34, %14, %3
  %40 = phi %struct.lean_object* [ %0, %3 ], [ %35, %34 ], [ %0, %14 ]
  ret %struct.lean_object* %40
}

declare %struct.lean_object* @lean_copy_byte_array(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_empty_float_array(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void (...) @lean_internal_panic_out_of_memory() #11
  unreachable

6:                                                ; preds = %1
  %7 = lshr i64 %2, 1
  %8 = shl i64 %7, 3
  %9 = add i64 %8, 24
  %10 = tail call %struct.lean_object* @lean_alloc_object(i64 %9) #12
  %11 = bitcast %struct.lean_object* %10 to <2 x i64>*
  store <2 x i64> <i64 -574208952489738239, i64 0>, <2 x i64>* %11, align 8, !tbaa !3
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %10, i64 2, i32 0
  store i64 %7, i64* %12, align 8, !tbaa !26
  ret %struct.lean_object* %10
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_float_array_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !24
  %10 = shl i64 %9, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  ret %struct.lean_object* %12
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull double* @lean_float_array_cptr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -8
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %9 = bitcast %struct.lean_object* %8 to double*
  ret double* %9
}

; Function Attrs: nounwind sspstrong uwtable
define double @lean_float_array_get(%struct.lean_object* nocapture readonly %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %22, label %6

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = bitcast %struct.lean_object* %0 to i8*
  %9 = getelementptr inbounds i8, i8* %8, i64 7
  %10 = load i8, i8* %9, align 1, !tbaa !7
  %11 = icmp eq i8 %10, -8
  br i1 %11, label %13, label %12

12:                                               ; preds = %6
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

13:                                               ; preds = %6
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !24
  %16 = icmp ult i64 %7, %15
  br i1 %16, label %17, label %22

17:                                               ; preds = %13
  %18 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 %7
  %20 = bitcast %struct.lean_object* %19 to double*
  %21 = load double, double* %20, align 8, !tbaa !18
  br label %22

22:                                               ; preds = %17, %13, %2
  %23 = phi double [ %21, %17 ], [ 0.000000e+00, %13 ], [ 0.000000e+00, %2 ]
  ret double %23
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_float_array_set(%struct.lean_object* %0, %struct.lean_object* %1, double %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %1 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %39, label %7

7:                                                ; preds = %3
  %8 = lshr i64 %4, 1
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 7
  %11 = load i8, i8* %10, align 1, !tbaa !7
  %12 = icmp eq i8 %11, -8
  br i1 %12, label %14, label %13

13:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

14:                                               ; preds = %7
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %16 = load i64, i64* %15, align 8, !tbaa !24
  %17 = icmp ult i64 %8, %16
  br i1 %17, label %18, label %39

18:                                               ; preds = %14
  %19 = getelementptr inbounds i8, i8* %9, i64 5
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %22, label %27, !prof !11

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %24 = load i64, i64* %23, align 8, !tbaa !9
  %25 = and i64 %24, 4294967295
  %26 = icmp eq i64 %25, 1
  br i1 %26, label %34, label %27

27:                                               ; preds = %22, %18
  %28 = tail call %struct.lean_object* @lean_copy_float_array(%struct.lean_object* nonnull %0) #12
  %29 = bitcast %struct.lean_object* %28 to i8*
  %30 = getelementptr inbounds i8, i8* %29, i64 7
  %31 = load i8, i8* %30, align 1, !tbaa !7
  %32 = icmp eq i8 %31, -8
  br i1 %32, label %34, label %33

33:                                               ; preds = %27
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

34:                                               ; preds = %27, %22
  %35 = phi %struct.lean_object* [ %28, %27 ], [ %0, %22 ]
  %36 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %35, i64 3
  %37 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %36, i64 %8
  %38 = bitcast %struct.lean_object* %37 to double*
  store double %2, double* %38, align 8, !tbaa !18
  br label %39

39:                                               ; preds = %34, %14, %3
  %40 = phi %struct.lean_object* [ %0, %3 ], [ %35, %34 ], [ %0, %14 ]
  ret %struct.lean_object* %40
}

declare %struct.lean_object* @lean_copy_float_array(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define double @lean_float_array_fget(%struct.lean_object* nocapture readonly %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = bitcast %struct.lean_object* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i64 7
  %5 = load i8, i8* %4, align 1, !tbaa !7
  %6 = icmp eq i8 %5, -8
  br i1 %6, label %8, label %7

7:                                                ; preds = %2
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

8:                                                ; preds = %2
  %9 = ptrtoint %struct.lean_object* %1 to i64
  %10 = lshr i64 %9, 1
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3
  %12 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %11, i64 %10
  %13 = bitcast %struct.lean_object* %12 to double*
  %14 = load double, double* %13, align 8, !tbaa !18
  ret double %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_float_array_fset(%struct.lean_object* %0, %struct.lean_object* %1, double %2) local_unnamed_addr #1 {
  %4 = bitcast %struct.lean_object* %0 to i8*
  %5 = getelementptr inbounds i8, i8* %4, i64 5
  %6 = load i8, i8* %5, align 1, !tbaa !7
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %13, !prof !11

8:                                                ; preds = %3
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %10 = load i64, i64* %9, align 8, !tbaa !9
  %11 = and i64 %10, 4294967295
  %12 = icmp eq i64 %11, 1
  br i1 %12, label %16, label %13

13:                                               ; preds = %8, %3
  %14 = tail call %struct.lean_object* @lean_copy_float_array(%struct.lean_object* nonnull %0) #12
  %15 = bitcast %struct.lean_object* %14 to i8*
  br label %16

16:                                               ; preds = %13, %8
  %17 = phi i8* [ %4, %8 ], [ %15, %13 ]
  %18 = phi %struct.lean_object* [ %0, %8 ], [ %14, %13 ]
  %19 = getelementptr inbounds i8, i8* %17, i64 7
  %20 = load i8, i8* %19, align 1, !tbaa !7
  %21 = icmp eq i8 %20, -8
  br i1 %21, label %23, label %22

22:                                               ; preds = %16
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 573, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_sarray, i64 0, i64 0)) #11
  unreachable

23:                                               ; preds = %16
  %24 = ptrtoint %struct.lean_object* %1 to i64
  %25 = lshr i64 %24, 1
  %26 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %18, i64 3
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %26, i64 %25
  %28 = bitcast %struct.lean_object* %27 to double*
  store double %2, double* %28, align 8, !tbaa !18
  ret %struct.lean_object* %18
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_string(i64 %0, i64 %1, i64 %2) local_unnamed_addr #1 {
  %4 = add i64 %1, 32
  %5 = tail call %struct.lean_object* @lean_alloc_object(i64 %4) #12
  %6 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 0, i32 0
  store i64 -504403158265495551, i64* %6, align 8, !tbaa !9
  %7 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 1, i32 0
  store i64 %0, i64* %7, align 8, !tbaa !27
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 2, i32 0
  store i64 %1, i64* %8, align 8, !tbaa !29
  %9 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %5, i64 3, i32 0
  store i64 %2, i64* %9, align 8, !tbaa !30
  ret %struct.lean_object* %5
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_string_capacity(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !29
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_string_byte_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !29
  %10 = add i64 %9, 32
  ret i64 %10
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_char_default_value() local_unnamed_addr #0 {
  ret i32 65
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull i8* @lean_string_cstr(%struct.lean_object* readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1147, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_string_cstr, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 4
  %9 = bitcast %struct.lean_object* %8 to i8*
  ret i8* %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_string_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !27
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_string_len(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !30
  ret i64 %9
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_string_length(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 3, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !30
  %10 = shl i64 %9, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  ret %struct.lean_object* %12
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_string_utf8_at_end(%struct.lean_object* nocapture readonly %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %19, label %6

6:                                                ; preds = %2
  %7 = bitcast %struct.lean_object* %0 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 7
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, -7
  br i1 %10, label %12, label %11

11:                                               ; preds = %6
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %6
  %13 = lshr i64 %3, 1
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !27
  %16 = add i64 %15, -1
  %17 = icmp uge i64 %13, %16
  %18 = zext i1 %17 to i8
  br label %19

19:                                               ; preds = %12, %2
  %20 = phi i8 [ 1, %2 ], [ %18, %12 ]
  ret i8 %20
}

; Function Attrs: nounwind sspstrong uwtable
define nonnull %struct.lean_object* @lean_string_utf8_byte_size(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -7
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load i64, i64* %8, align 8, !tbaa !27
  %10 = shl i64 %9, 1
  %11 = add i64 %10, -1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  ret %struct.lean_object* %12
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_string_eq(%struct.lean_object* readonly %0, %struct.lean_object* readonly %1) local_unnamed_addr #1 {
  %3 = icmp eq %struct.lean_object* %0, %1
  br i1 %3, label %29, label %4

4:                                                ; preds = %2
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp eq i8 %7, -7
  br i1 %8, label %10, label %9

9:                                                ; preds = %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %4
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !27
  %13 = bitcast %struct.lean_object* %1 to i8*
  %14 = getelementptr inbounds i8, i8* %13, i64 7
  %15 = load i8, i8* %14, align 1, !tbaa !7
  %16 = icmp eq i8 %15, -7
  br i1 %16, label %18, label %17

17:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

18:                                               ; preds = %10
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 1, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !27
  %21 = icmp eq i64 %12, %20
  br i1 %21, label %22, label %29

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 4
  %24 = bitcast %struct.lean_object* %23 to i8*
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 4
  %26 = bitcast %struct.lean_object* %25 to i8*
  %27 = tail call i32 @bcmp(i8* nonnull %24, i8* nonnull %26, i64 %12)
  %28 = icmp eq i32 %27, 0
  br label %29

29:                                               ; preds = %22, %18, %2
  %30 = phi i1 [ true, %2 ], [ false, %18 ], [ %28, %22 ]
  ret i1 %30
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_string_ne(%struct.lean_object* readonly %0, %struct.lean_object* readonly %1) local_unnamed_addr #1 {
  %3 = icmp eq %struct.lean_object* %0, %1
  br i1 %3, label %29, label %4

4:                                                ; preds = %2
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp eq i8 %7, -7
  br i1 %8, label %10, label %9

9:                                                ; preds = %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %4
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !27
  %13 = bitcast %struct.lean_object* %1 to i8*
  %14 = getelementptr inbounds i8, i8* %13, i64 7
  %15 = load i8, i8* %14, align 1, !tbaa !7
  %16 = icmp eq i8 %15, -7
  br i1 %16, label %18, label %17

17:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

18:                                               ; preds = %10
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 1, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !27
  %21 = icmp eq i64 %12, %20
  br i1 %21, label %22, label %29

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 4
  %24 = bitcast %struct.lean_object* %23 to i8*
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 4
  %26 = bitcast %struct.lean_object* %25 to i8*
  %27 = tail call i32 @bcmp(i8* nonnull %24, i8* nonnull %26, i64 %12) #12
  %28 = icmp ne i32 %27, 0
  br label %29

29:                                               ; preds = %22, %18, %2
  %30 = phi i1 [ false, %2 ], [ true, %18 ], [ %28, %22 ]
  ret i1 %30
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_string_dec_eq(%struct.lean_object* readonly %0, %struct.lean_object* readonly %1) local_unnamed_addr #1 {
  %3 = icmp eq %struct.lean_object* %0, %1
  br i1 %3, label %30, label %4

4:                                                ; preds = %2
  %5 = bitcast %struct.lean_object* %0 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1, !tbaa !7
  %8 = icmp eq i8 %7, -7
  br i1 %8, label %10, label %9

9:                                                ; preds = %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

10:                                               ; preds = %4
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !27
  %13 = bitcast %struct.lean_object* %1 to i8*
  %14 = getelementptr inbounds i8, i8* %13, i64 7
  %15 = load i8, i8* %14, align 1, !tbaa !7
  %16 = icmp eq i8 %15, -7
  br i1 %16, label %18, label %17

17:                                               ; preds = %10
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 574, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #11
  unreachable

18:                                               ; preds = %10
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 1, i32 0
  %20 = load i64, i64* %19, align 8, !tbaa !27
  %21 = icmp eq i64 %12, %20
  br i1 %21, label %22, label %30

22:                                               ; preds = %18
  %23 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 4
  %24 = bitcast %struct.lean_object* %23 to i8*
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %1, i64 4
  %26 = bitcast %struct.lean_object* %25 to i8*
  %27 = tail call i32 @bcmp(i8* nonnull %24, i8* nonnull %26, i64 %12) #12
  %28 = icmp eq i32 %27, 0
  %29 = zext i1 %28 to i8
  br label %30

30:                                               ; preds = %22, %18, %2
  %31 = phi i8 [ 1, %2 ], [ 0, %18 ], [ %29, %22 ]
  ret i8 %31
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_string_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = tail call zeroext i1 @lean_string_lt(%struct.lean_object* %0, %struct.lean_object* %1) #12
  %4 = zext i1 %3 to i8
  ret i8 %4
}

declare zeroext i1 @lean_string_lt(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_mk_thunk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 24, i32 2) #12
  %3 = bitcast i8* %2 to %struct.lean_object*
  %4 = bitcast i8* %2 to i64*
  store i64 -360287970189639679, i64* %4, align 8, !tbaa !9
  %5 = getelementptr inbounds i8, i8* %2, i64 8
  %6 = bitcast i8* %5 to i64*
  store atomic i64 0, i64* %6 seq_cst, align 8, !tbaa !31
  %7 = ptrtoint %struct.lean_object* %0 to i64
  %8 = getelementptr inbounds i8, i8* %2, i64 16
  %9 = bitcast i8* %8 to i64*
  store atomic i64 %7, i64* %9 seq_cst, align 8, !tbaa !33
  ret %struct.lean_object* %3
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_pure(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 24, i32 2) #12
  %3 = bitcast i8* %2 to %struct.lean_object*
  %4 = bitcast i8* %2 to i64*
  store i64 -360287970189639679, i64* %4, align 8, !tbaa !9
  %5 = ptrtoint %struct.lean_object* %0 to i64
  %6 = getelementptr inbounds i8, i8* %2, i64 8
  %7 = bitcast i8* %6 to i64*
  store atomic i64 %5, i64* %7 seq_cst, align 8, !tbaa !31
  %8 = getelementptr inbounds i8, i8* %2, i64 16
  %9 = bitcast i8* %8 to i64*
  store atomic i64 0, i64* %9 seq_cst, align 8, !tbaa !33
  ret %struct.lean_object* %3
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_get(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -5
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 575, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_thunk, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load atomic i64, i64* %8 seq_cst, align 8, !tbaa !31
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %13, label %11

11:                                               ; preds = %7
  %12 = inttoptr i64 %9 to %struct.lean_object*
  br label %15

13:                                               ; preds = %7
  %14 = tail call %struct.lean_object* @lean_thunk_get_core(%struct.lean_object* nonnull %0) #12
  br label %15

15:                                               ; preds = %13, %11
  %16 = phi %struct.lean_object* [ %12, %11 ], [ %14, %13 ]
  ret %struct.lean_object* %16
}

declare %struct.lean_object* @lean_thunk_get_core(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_thunk_get_own(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -5
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 575, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_thunk, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %9 = load atomic i64, i64* %8 seq_cst, align 8, !tbaa !31
  %10 = icmp eq i64 %9, 0
  br i1 %10, label %13, label %11

11:                                               ; preds = %7
  %12 = inttoptr i64 %9 to %struct.lean_object*
  br label %15

13:                                               ; preds = %7
  %14 = tail call %struct.lean_object* @lean_thunk_get_core(%struct.lean_object* nonnull %0) #12
  br label %15

15:                                               ; preds = %13, %11
  %16 = phi %struct.lean_object* [ %12, %11 ], [ %14, %13 ]
  %17 = ptrtoint %struct.lean_object* %16 to i64
  %18 = and i64 %17, 1
  %19 = icmp eq i64 %18, 0
  br i1 %19, label %20, label %31

20:                                               ; preds = %15
  %21 = bitcast %struct.lean_object* %16 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 5
  %23 = load i8, i8* %22, align 1, !tbaa !7
  switch i8 %23, label %31 [
    i8 0, label %24
    i8 1, label %28
  ], !prof !8

24:                                               ; preds = %20
  %25 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 0, i32 0
  %26 = load i64, i64* %25, align 8, !tbaa !9
  %27 = add i64 %26, 1
  store i64 %27, i64* %25, align 8, !tbaa !9
  br label %31

28:                                               ; preds = %20
  %29 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %16, i64 0, i32 0
  %30 = atomicrmw add i64* %29, i64 1 monotonic, align 8
  br label %31

31:                                               ; preds = %28, %24, %20, %15
  ret %struct.lean_object* %16
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_spawn(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = lshr i64 %3, 1
  %5 = trunc i64 %4 to i32
  %6 = tail call %struct.lean_object* @lean_task_spawn_core(%struct.lean_object* %0, i32 %5, i1 zeroext false) #12
  ret %struct.lean_object* %6
}

declare %struct.lean_object* @lean_task_spawn_core(%struct.lean_object*, i32, i1 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_bind(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %2 to i64
  %5 = lshr i64 %4, 1
  %6 = trunc i64 %5 to i32
  %7 = tail call %struct.lean_object* @lean_task_bind_core(%struct.lean_object* %0, %struct.lean_object* %1, i32 %6, i1 zeroext false) #12
  ret %struct.lean_object* %7
}

declare %struct.lean_object* @lean_task_bind_core(%struct.lean_object*, %struct.lean_object*, i32, i1 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_map(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) local_unnamed_addr #1 {
  %4 = ptrtoint %struct.lean_object* %2 to i64
  %5 = lshr i64 %4, 1
  %6 = trunc i64 %5 to i32
  %7 = tail call %struct.lean_object* @lean_task_map_core(%struct.lean_object* %0, %struct.lean_object* %1, i32 %6, i1 zeroext false) #12
  ret %struct.lean_object* %7
}

declare %struct.lean_object* @lean_task_map_core(%struct.lean_object*, %struct.lean_object*, i32, i1 zeroext) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_task_get_own(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call %struct.lean_object* @lean_task_get(%struct.lean_object* %0) #12
  %3 = ptrtoint %struct.lean_object* %2 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %6, label %17

6:                                                ; preds = %1
  %7 = bitcast %struct.lean_object* %2 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 5
  %9 = load i8, i8* %8, align 1, !tbaa !7
  switch i8 %9, label %17 [
    i8 0, label %10
    i8 1, label %14
  ], !prof !8

10:                                               ; preds = %6
  %11 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %2, i64 0, i32 0
  %12 = load i64, i64* %11, align 8, !tbaa !9
  %13 = add i64 %12, 1
  store i64 %13, i64* %11, align 8, !tbaa !9
  br label %17

14:                                               ; preds = %6
  %15 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %2, i64 0, i32 0
  %16 = atomicrmw add i64* %15, i64 1 monotonic, align 8
  br label %17

17:                                               ; preds = %14, %10, %6, %1
  %18 = ptrtoint %struct.lean_object* %0 to i64
  %19 = and i64 %18, 1
  %20 = icmp eq i64 %19, 0
  br i1 %20, label %21, label %37

21:                                               ; preds = %17
  %22 = bitcast %struct.lean_object* %0 to i8*
  %23 = getelementptr inbounds i8, i8* %22, i64 5
  %24 = load i8, i8* %23, align 1, !tbaa !7
  switch i8 %24, label %37 [
    i8 0, label %25
    i8 1, label %31
  ], !prof !8

25:                                               ; preds = %21
  %26 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %27 = load i64, i64* %26, align 8, !tbaa !9
  %28 = add i64 %27, -1
  store i64 %28, i64* %26, align 8, !tbaa !9
  %29 = and i64 %28, 4294967295
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %36, label %37

31:                                               ; preds = %21
  %32 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %33 = atomicrmw sub i64* %32, i64 1 acq_rel, align 8
  %34 = and i64 %33, 4294967295
  %35 = icmp eq i64 %34, 1
  br i1 %35, label %36, label %37

36:                                               ; preds = %31, %25
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %37

37:                                               ; preds = %36, %31, %25, %21, %17
  ret %struct.lean_object* %2
}

declare %struct.lean_object* @lean_task_get(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_alloc_external(%struct.lean_external_class* %0, i8* %1) local_unnamed_addr #1 {
  %3 = tail call i8* @lean_alloc_small(i32 24, i32 2) #12
  %4 = bitcast i8* %3 to %struct.lean_object*
  %5 = bitcast i8* %3 to i64*
  store i64 -144115188075855871, i64* %5, align 8, !tbaa !9
  %6 = getelementptr inbounds i8, i8* %3, i64 8
  %7 = bitcast i8* %6 to %struct.lean_external_class**
  store %struct.lean_external_class* %0, %struct.lean_external_class** %7, align 8, !tbaa !34
  %8 = getelementptr inbounds i8, i8* %3, i64 16
  %9 = bitcast i8* %8 to i8**
  store i8* %1, i8** %9, align 8, !tbaa !36
  ret %struct.lean_object* %4
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_external_class* @lean_get_external_class(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -2
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 578, i8* getelementptr inbounds ([54 x i8], [54 x i8]* @__PRETTY_FUNCTION__.lean_to_external, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_external_class**
  %10 = load %struct.lean_external_class*, %struct.lean_external_class** %9, align 8, !tbaa !34
  ret %struct.lean_external_class* %10
}

; Function Attrs: nounwind sspstrong uwtable
define i8* @lean_get_external_data(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, -2
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 578, i8* getelementptr inbounds ([54 x i8], [54 x i8]* @__PRETTY_FUNCTION__.lean_to_external, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 2
  %9 = bitcast %struct.lean_object* %8 to i8**
  %10 = load i8*, i8** %9, align 8, !tbaa !36
  ret i8* %10
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_usize_to_nat(i64 %0) local_unnamed_addr #1 {
  %2 = icmp slt i64 %0, 0
  br i1 %2, label %7, label %3, !prof !37

3:                                                ; preds = %1
  %4 = shl nuw i64 %0, 1
  %5 = or i64 %4, 1
  %6 = inttoptr i64 %5 to %struct.lean_object*
  br label %9

7:                                                ; preds = %1
  %8 = tail call %struct.lean_object* @lean_big_usize_to_nat(i64 %0) #12
  br label %9

9:                                                ; preds = %7, %3
  %10 = phi %struct.lean_object* [ %6, %3 ], [ %8, %7 ]
  ret %struct.lean_object* %10
}

declare %struct.lean_object* @lean_big_usize_to_nat(i64) local_unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_unsigned_to_nat(i32 %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_uint64_to_nat(i64 %0) local_unnamed_addr #1 {
  %2 = icmp slt i64 %0, 0
  br i1 %2, label %7, label %3, !prof !37

3:                                                ; preds = %1
  %4 = shl nuw i64 %0, 1
  %5 = or i64 %4, 1
  %6 = inttoptr i64 %5 to %struct.lean_object*
  br label %9

7:                                                ; preds = %1
  %8 = tail call %struct.lean_object* @lean_big_uint64_to_nat(i64 %0) #12
  br label %9

9:                                                ; preds = %7, %3
  %10 = phi %struct.lean_object* [ %6, %3 ], [ %8, %7 ]
  ret %struct.lean_object* %10
}

declare %struct.lean_object* @lean_big_uint64_to_nat(i64) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_succ(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %15, label %5, !prof !37

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = add nuw i64 %6, 1
  %8 = icmp slt i64 %7, 0
  br i1 %8, label %13, label %9, !prof !37

9:                                                ; preds = %5
  %10 = shl nuw i64 %7, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  br label %17

13:                                               ; preds = %5
  %14 = tail call %struct.lean_object* @lean_big_usize_to_nat(i64 -9223372036854775808) #12
  br label %17

15:                                               ; preds = %1
  %16 = tail call %struct.lean_object* @lean_nat_big_succ(%struct.lean_object* %0) #12
  br label %17

17:                                               ; preds = %15, %13, %9
  %18 = phi %struct.lean_object* [ %16, %15 ], [ %12, %9 ], [ %14, %13 ]
  ret %struct.lean_object* %18
}

declare %struct.lean_object* @lean_nat_big_succ(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_add(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %21, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %21, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = lshr i64 %7, 1
  %13 = add nuw i64 %12, %11
  %14 = icmp slt i64 %13, 0
  br i1 %14, label %19, label %15, !prof !37

15:                                               ; preds = %10
  %16 = shl nuw i64 %13, 1
  %17 = or i64 %16, 1
  %18 = inttoptr i64 %17 to %struct.lean_object*
  br label %23

19:                                               ; preds = %10
  %20 = tail call %struct.lean_object* @lean_big_usize_to_nat(i64 %13) #12
  br label %23

21:                                               ; preds = %6, %2
  %22 = tail call %struct.lean_object* @lean_nat_big_add(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %23

23:                                               ; preds = %21, %19, %15
  %24 = phi %struct.lean_object* [ %22, %21 ], [ %18, %15 ], [ %20, %19 ]
  ret %struct.lean_object* %24
}

declare %struct.lean_object* @lean_nat_big_add(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_eq(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_eq(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_eq(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_eq(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_eq(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_float_eq(double %0, double %1) local_unnamed_addr #0 {
  %3 = fcmp oeq double %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_sub(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %19, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %19, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = lshr i64 %7, 1
  %13 = icmp ult i64 %11, %12
  br i1 %13, label %21, label %14

14:                                               ; preds = %10
  %15 = sub nsw i64 %11, %12
  %16 = shl i64 %15, 1
  %17 = or i64 %16, 1
  %18 = inttoptr i64 %17 to %struct.lean_object*
  br label %21

19:                                               ; preds = %6, %2
  %20 = tail call %struct.lean_object* @lean_nat_big_sub(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %21

21:                                               ; preds = %19, %14, %10
  %22 = phi %struct.lean_object* [ %20, %19 ], [ %18, %14 ], [ inttoptr (i64 1 to %struct.lean_object*), %10 ]
  ret %struct.lean_object* %22
}

declare %struct.lean_object* @lean_nat_big_sub(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_mul(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %26, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %26, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %28, label %13

13:                                               ; preds = %10
  %14 = lshr i64 %7, 1
  %15 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %11, i64 %14)
  %16 = extractvalue { i64, i1 } %15, 0
  %17 = icmp sgt i64 %16, -1
  br i1 %17, label %18, label %24

18:                                               ; preds = %13
  %19 = extractvalue { i64, i1 } %15, 1
  br i1 %19, label %24, label %20

20:                                               ; preds = %18
  %21 = shl nuw i64 %16, 1
  %22 = or i64 %21, 1
  %23 = inttoptr i64 %22 to %struct.lean_object*
  br label %28

24:                                               ; preds = %18, %13
  %25 = tail call %struct.lean_object* @lean_nat_overflow_mul(i64 %11, i64 %14) #12
  br label %28

26:                                               ; preds = %6, %2
  %27 = tail call %struct.lean_object* @lean_nat_big_mul(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %28

28:                                               ; preds = %26, %24, %20, %10
  %29 = phi %struct.lean_object* [ %27, %26 ], [ %0, %10 ], [ %23, %20 ], [ %25, %24 ]
  ret %struct.lean_object* %29
}

declare %struct.lean_object* @lean_nat_overflow_mul(i64, i64) local_unnamed_addr #3

declare %struct.lean_object* @lean_nat_big_mul(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_div(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %19, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %19, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %7, 1
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %21, label %13

13:                                               ; preds = %10
  %14 = lshr i64 %3, 1
  %15 = udiv i64 %14, %11
  %16 = shl nuw i64 %15, 1
  %17 = or i64 %16, 1
  %18 = inttoptr i64 %17 to %struct.lean_object*
  br label %21

19:                                               ; preds = %6, %2
  %20 = tail call %struct.lean_object* @lean_nat_big_div(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %21

21:                                               ; preds = %19, %13, %10
  %22 = phi %struct.lean_object* [ %20, %19 ], [ %18, %13 ], [ inttoptr (i64 1 to %struct.lean_object*), %10 ]
  ret %struct.lean_object* %22
}

declare %struct.lean_object* @lean_nat_big_div(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_mod(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %22, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %22, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %7, 1
  %12 = icmp eq i64 %11, 0
  br i1 %12, label %13, label %16

13:                                               ; preds = %10
  %14 = or i64 %3, 1
  %15 = inttoptr i64 %14 to %struct.lean_object*
  br label %24

16:                                               ; preds = %10
  %17 = lshr i64 %3, 1
  %18 = urem i64 %17, %11
  %19 = shl nuw i64 %18, 1
  %20 = or i64 %19, 1
  %21 = inttoptr i64 %20 to %struct.lean_object*
  br label %24

22:                                               ; preds = %6, %2
  %23 = tail call %struct.lean_object* @lean_nat_big_mod(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %24

24:                                               ; preds = %22, %16, %13
  %25 = phi %struct.lean_object* [ %23, %22 ], [ %15, %13 ], [ %21, %16 ]
  ret %struct.lean_object* %25
}

declare %struct.lean_object* @lean_nat_big_mod(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_nat_eq(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  ret i1 %15
}

declare zeroext i1 @lean_nat_big_eq(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = zext i1 %15 to i8
  ret i8 %16
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_nat_ne(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = xor i1 %15, true
  ret i1 %16
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_nat_le(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp ule %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_le(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  ret i1 %15
}

declare zeroext i1 @lean_nat_big_le(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_le(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp ule %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_le(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = zext i1 %15 to i8
  ret i8 %16
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_nat_lt(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp ult %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_lt(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  ret i1 %15
}

declare zeroext i1 @lean_nat_big_lt(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_nat_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp ult %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_nat_big_lt(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = zext i1 %15 to i8
  ret i8 %16
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_land(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %13, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %13, label %10, !prof !37

10:                                               ; preds = %6
  %11 = and i64 %7, %3
  %12 = inttoptr i64 %11 to %struct.lean_object*
  br label %15

13:                                               ; preds = %6, %2
  %14 = tail call %struct.lean_object* @lean_nat_big_land(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %15

15:                                               ; preds = %13, %10
  %16 = phi %struct.lean_object* [ %12, %10 ], [ %14, %13 ]
  ret %struct.lean_object* %16
}

declare %struct.lean_object* @lean_nat_big_land(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_lor(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %13, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %13, label %10, !prof !37

10:                                               ; preds = %6
  %11 = or i64 %7, %3
  %12 = inttoptr i64 %11 to %struct.lean_object*
  br label %15

13:                                               ; preds = %6, %2
  %14 = tail call %struct.lean_object* @lean_nat_big_lor(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %15

15:                                               ; preds = %13, %10
  %16 = phi %struct.lean_object* [ %12, %10 ], [ %14, %13 ]
  ret %struct.lean_object* %16
}

declare %struct.lean_object* @lean_nat_big_lor(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_lxor(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %14, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %14, label %10, !prof !37

10:                                               ; preds = %6
  %11 = xor i64 %7, %3
  %12 = or i64 %11, 1
  %13 = inttoptr i64 %12 to %struct.lean_object*
  br label %16

14:                                               ; preds = %6, %2
  %15 = tail call %struct.lean_object* @lean_nat_big_xor(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %16

16:                                               ; preds = %14, %10
  %17 = phi %struct.lean_object* [ %13, %10 ], [ %15, %14 ]
  ret %struct.lean_object* %17
}

declare %struct.lean_object* @lean_nat_big_xor(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_int_to_int(i32 %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int64_to_int(i64 %0) local_unnamed_addr #1 {
  %2 = add i64 %0, 2147483648
  %3 = icmp ult i64 %2, 4294967296
  br i1 %3, label %4, label %9, !prof !11

4:                                                ; preds = %1
  %5 = shl nsw i64 %0, 1
  %6 = and i64 %5, 8589934590
  %7 = or i64 %6, 1
  %8 = inttoptr i64 %7 to %struct.lean_object*
  br label %11

9:                                                ; preds = %1
  %10 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %0) #12
  br label %11

11:                                               ; preds = %9, %4
  %12 = phi %struct.lean_object* [ %8, %4 ], [ %10, %9 ]
  ret %struct.lean_object* %12
}

declare %struct.lean_object* @lean_big_int64_to_int(i64) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_scalar_to_int64(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.29, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1495, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_scalar_to_int64, i64 0, i64 0)) #11
  unreachable

6:                                                ; preds = %1
  %7 = shl i64 %2, 31
  %8 = ashr i64 %7, 32
  ret i64 %8
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_scalar_to_int(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.29, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1503, i8* getelementptr inbounds ([39 x i8], [39 x i8]* @__PRETTY_FUNCTION__.lean_scalar_to_int, i64 0, i64 0)) #11
  unreachable

6:                                                ; preds = %1
  %7 = lshr i64 %2, 1
  %8 = trunc i64 %7 to i32
  ret i32 %8
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_to_int(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  %5 = icmp ult %struct.lean_object* %0, inttoptr (i64 4294967296 to %struct.lean_object*)
  %6 = or i1 %5, %4
  br i1 %6, label %10, label %7

7:                                                ; preds = %1
  %8 = lshr i64 %2, 1
  %9 = tail call %struct.lean_object* @lean_big_size_t_to_int(i64 %8) #12
  br label %10

10:                                               ; preds = %7, %1
  %11 = phi %struct.lean_object* [ %9, %7 ], [ %0, %1 ]
  ret %struct.lean_object* %11
}

declare %struct.lean_object* @lean_big_size_t_to_int(i64) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_neg(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %18, label %5, !prof !37

5:                                                ; preds = %1
  %6 = shl i64 %2, 31
  %7 = ashr i64 %6, 32
  %8 = sub nsw i64 0, %7
  %9 = sub nsw i64 2147483648, %7
  %10 = icmp ult i64 %9, 4294967296
  br i1 %10, label %11, label %16, !prof !11

11:                                               ; preds = %5
  %12 = shl nsw i64 %8, 1
  %13 = and i64 %12, 8589934590
  %14 = or i64 %13, 1
  %15 = inttoptr i64 %14 to %struct.lean_object*
  br label %20

16:                                               ; preds = %5
  %17 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %8) #12
  br label %20

18:                                               ; preds = %1
  %19 = tail call %struct.lean_object* @lean_int_big_neg(%struct.lean_object* %0) #12
  br label %20

20:                                               ; preds = %18, %16, %11
  %21 = phi %struct.lean_object* [ %19, %18 ], [ %15, %11 ], [ %17, %16 ]
  ret %struct.lean_object* %21
}

declare %struct.lean_object* @lean_int_big_neg(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_neg_succ_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %15, label %5, !prof !37

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = add nuw i64 %6, 1
  %8 = icmp slt i64 %7, 0
  br i1 %8, label %13, label %9, !prof !37

9:                                                ; preds = %5
  %10 = shl nuw i64 %7, 1
  %11 = or i64 %10, 1
  %12 = inttoptr i64 %11 to %struct.lean_object*
  br label %32

13:                                               ; preds = %5
  %14 = tail call %struct.lean_object* @lean_big_usize_to_nat(i64 -9223372036854775808) #12
  br label %32

15:                                               ; preds = %1
  %16 = tail call %struct.lean_object* @lean_nat_big_succ(%struct.lean_object* %0) #12
  %17 = bitcast %struct.lean_object* %0 to i8*
  %18 = getelementptr inbounds i8, i8* %17, i64 5
  %19 = load i8, i8* %18, align 1, !tbaa !7
  switch i8 %19, label %32 [
    i8 0, label %20
    i8 1, label %26
  ], !prof !8

20:                                               ; preds = %15
  %21 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %22 = load i64, i64* %21, align 8, !tbaa !9
  %23 = add i64 %22, -1
  store i64 %23, i64* %21, align 8, !tbaa !9
  %24 = and i64 %23, 4294967295
  %25 = icmp eq i64 %24, 0
  br i1 %25, label %31, label %32

26:                                               ; preds = %15
  %27 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %28 = atomicrmw sub i64* %27, i64 1 acq_rel, align 8
  %29 = and i64 %28, 4294967295
  %30 = icmp eq i64 %29, 1
  br i1 %30, label %31, label %32

31:                                               ; preds = %26, %20
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %32

32:                                               ; preds = %31, %26, %20, %15, %13, %9
  %33 = phi %struct.lean_object* [ %16, %15 ], [ %16, %20 ], [ %16, %26 ], [ %16, %31 ], [ %14, %13 ], [ %12, %9 ]
  %34 = ptrtoint %struct.lean_object* %33 to i64
  %35 = and i64 %34, 1
  %36 = icmp eq i64 %35, 0
  %37 = icmp ult %struct.lean_object* %33, inttoptr (i64 4294967296 to %struct.lean_object*)
  %38 = or i1 %37, %36
  br i1 %38, label %42, label %39

39:                                               ; preds = %32
  %40 = lshr i64 %34, 1
  %41 = tail call %struct.lean_object* @lean_big_size_t_to_int(i64 %40) #12
  br label %42

42:                                               ; preds = %39, %32
  %43 = phi %struct.lean_object* [ %41, %39 ], [ %33, %32 ]
  br i1 %36, label %44, label %60

44:                                               ; preds = %42
  %45 = bitcast %struct.lean_object* %33 to i8*
  %46 = getelementptr inbounds i8, i8* %45, i64 5
  %47 = load i8, i8* %46, align 1, !tbaa !7
  switch i8 %47, label %60 [
    i8 0, label %48
    i8 1, label %54
  ], !prof !8

48:                                               ; preds = %44
  %49 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %33, i64 0, i32 0
  %50 = load i64, i64* %49, align 8, !tbaa !9
  %51 = add i64 %50, -1
  store i64 %51, i64* %49, align 8, !tbaa !9
  %52 = and i64 %51, 4294967295
  %53 = icmp eq i64 %52, 0
  br i1 %53, label %59, label %60

54:                                               ; preds = %44
  %55 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %33, i64 0, i32 0
  %56 = atomicrmw sub i64* %55, i64 1 acq_rel, align 8
  %57 = and i64 %56, 4294967295
  %58 = icmp eq i64 %57, 1
  br i1 %58, label %59, label %60

59:                                               ; preds = %54, %48
  tail call void @lean_del(%struct.lean_object* nonnull %33) #12
  br label %60

60:                                               ; preds = %59, %54, %48, %44, %42
  %61 = ptrtoint %struct.lean_object* %43 to i64
  %62 = and i64 %61, 1
  %63 = icmp eq i64 %62, 0
  br i1 %63, label %77, label %64, !prof !37

64:                                               ; preds = %60
  %65 = shl i64 %61, 31
  %66 = ashr i64 %65, 32
  %67 = sub nsw i64 0, %66
  %68 = sub nsw i64 2147483648, %66
  %69 = icmp ult i64 %68, 4294967296
  br i1 %69, label %70, label %75, !prof !11

70:                                               ; preds = %64
  %71 = shl nsw i64 %67, 1
  %72 = and i64 %71, 8589934590
  %73 = or i64 %72, 1
  %74 = inttoptr i64 %73 to %struct.lean_object*
  br label %94

75:                                               ; preds = %64
  %76 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %67) #12
  br label %94

77:                                               ; preds = %60
  %78 = tail call %struct.lean_object* @lean_int_big_neg(%struct.lean_object* %43) #12
  %79 = bitcast %struct.lean_object* %43 to i8*
  %80 = getelementptr inbounds i8, i8* %79, i64 5
  %81 = load i8, i8* %80, align 1, !tbaa !7
  switch i8 %81, label %94 [
    i8 0, label %82
    i8 1, label %88
  ], !prof !8

82:                                               ; preds = %77
  %83 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %43, i64 0, i32 0
  %84 = load i64, i64* %83, align 8, !tbaa !9
  %85 = add i64 %84, -1
  store i64 %85, i64* %83, align 8, !tbaa !9
  %86 = and i64 %85, 4294967295
  %87 = icmp eq i64 %86, 0
  br i1 %87, label %93, label %94

88:                                               ; preds = %77
  %89 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %43, i64 0, i32 0
  %90 = atomicrmw sub i64* %89, i64 1 acq_rel, align 8
  %91 = and i64 %90, 4294967295
  %92 = icmp eq i64 %91, 1
  br i1 %92, label %93, label %94

93:                                               ; preds = %88, %82
  tail call void @lean_del(%struct.lean_object* nonnull %43) #12
  br label %94

94:                                               ; preds = %93, %88, %82, %77, %75, %70
  %95 = phi %struct.lean_object* [ %78, %77 ], [ %78, %82 ], [ %78, %88 ], [ %78, %93 ], [ %76, %75 ], [ %74, %70 ]
  ret %struct.lean_object* %95
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_add(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %25, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %25, label %10, !prof !37

10:                                               ; preds = %6
  %11 = shl i64 %3, 31
  %12 = ashr i64 %11, 32
  %13 = shl i64 %7, 31
  %14 = ashr i64 %13, 32
  %15 = add nsw i64 %14, %12
  %16 = add nsw i64 %15, 2147483648
  %17 = icmp ult i64 %16, 4294967296
  br i1 %17, label %18, label %23, !prof !11

18:                                               ; preds = %10
  %19 = shl nsw i64 %15, 1
  %20 = and i64 %19, 8589934590
  %21 = or i64 %20, 1
  %22 = inttoptr i64 %21 to %struct.lean_object*
  br label %27

23:                                               ; preds = %10
  %24 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %15) #12
  br label %27

25:                                               ; preds = %6, %2
  %26 = tail call %struct.lean_object* @lean_int_big_add(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %27

27:                                               ; preds = %25, %23, %18
  %28 = phi %struct.lean_object* [ %26, %25 ], [ %22, %18 ], [ %24, %23 ]
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_add(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_sub(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %25, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %25, label %10, !prof !37

10:                                               ; preds = %6
  %11 = shl i64 %3, 31
  %12 = ashr i64 %11, 32
  %13 = shl i64 %7, 31
  %14 = ashr i64 %13, 32
  %15 = sub nsw i64 %12, %14
  %16 = add nsw i64 %15, 2147483648
  %17 = icmp ult i64 %16, 4294967296
  br i1 %17, label %18, label %23, !prof !11

18:                                               ; preds = %10
  %19 = shl nsw i64 %15, 1
  %20 = and i64 %19, 8589934590
  %21 = or i64 %20, 1
  %22 = inttoptr i64 %21 to %struct.lean_object*
  br label %27

23:                                               ; preds = %10
  %24 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %15) #12
  br label %27

25:                                               ; preds = %6, %2
  %26 = tail call %struct.lean_object* @lean_int_big_sub(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %27

27:                                               ; preds = %25, %23, %18
  %28 = phi %struct.lean_object* [ %26, %25 ], [ %22, %18 ], [ %24, %23 ]
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_sub(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_mul(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %25, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %25, label %10, !prof !37

10:                                               ; preds = %6
  %11 = shl i64 %3, 31
  %12 = ashr i64 %11, 32
  %13 = shl i64 %7, 31
  %14 = ashr i64 %13, 32
  %15 = mul nsw i64 %14, %12
  %16 = add nsw i64 %15, 2147483648
  %17 = icmp ult i64 %16, 4294967296
  br i1 %17, label %18, label %23, !prof !11

18:                                               ; preds = %10
  %19 = shl nsw i64 %15, 1
  %20 = and i64 %19, 8589934590
  %21 = or i64 %20, 1
  %22 = inttoptr i64 %21 to %struct.lean_object*
  br label %27

23:                                               ; preds = %10
  %24 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %15) #12
  br label %27

25:                                               ; preds = %6, %2
  %26 = tail call %struct.lean_object* @lean_int_big_mul(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %27

27:                                               ; preds = %25, %23, %18
  %28 = phi %struct.lean_object* [ %26, %25 ], [ %22, %18 ], [ %24, %23 ]
  ret %struct.lean_object* %28
}

declare %struct.lean_object* @lean_int_big_mul(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_div(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %29, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %29, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %7, 1
  %12 = trunc i64 %11 to i32
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %31, label %14

14:                                               ; preds = %10
  %15 = shl i64 %11, 32
  %16 = ashr exact i64 %15, 32
  %17 = shl i64 %3, 31
  %18 = ashr i64 %17, 32
  %19 = sdiv i64 %18, %16
  %20 = add nsw i64 %19, 2147483648
  %21 = icmp ult i64 %20, 4294967296
  br i1 %21, label %22, label %27, !prof !11

22:                                               ; preds = %14
  %23 = shl nsw i64 %19, 1
  %24 = and i64 %23, 8589934590
  %25 = or i64 %24, 1
  %26 = inttoptr i64 %25 to %struct.lean_object*
  br label %31

27:                                               ; preds = %14
  %28 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %19) #12
  br label %31

29:                                               ; preds = %6, %2
  %30 = tail call %struct.lean_object* @lean_int_big_div(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %31

31:                                               ; preds = %29, %27, %22, %10
  %32 = phi %struct.lean_object* [ %30, %29 ], [ inttoptr (i64 1 to %struct.lean_object*), %10 ], [ %26, %22 ], [ %28, %27 ]
  ret %struct.lean_object* %32
}

declare %struct.lean_object* @lean_int_big_div(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_mod(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %22, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %22, label %10, !prof !37

10:                                               ; preds = %6
  %11 = shl i64 %7, 31
  %12 = ashr i64 %11, 32
  %13 = icmp eq i64 %12, 0
  br i1 %13, label %24, label %14

14:                                               ; preds = %10
  %15 = shl i64 %3, 31
  %16 = ashr i64 %15, 32
  %17 = srem i64 %16, %12
  %18 = shl nsw i64 %17, 1
  %19 = and i64 %18, 8589934590
  %20 = or i64 %19, 1
  %21 = inttoptr i64 %20 to %struct.lean_object*
  br label %24

22:                                               ; preds = %6, %2
  %23 = tail call %struct.lean_object* @lean_int_big_mod(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %24

24:                                               ; preds = %22, %14, %10
  %25 = phi %struct.lean_object* [ %23, %22 ], [ %0, %10 ], [ %21, %14 ]
  ret %struct.lean_object* %25
}

declare %struct.lean_object* @lean_int_big_mod(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_int_eq(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_int_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  ret i1 %15
}

declare zeroext i1 @lean_int_big_eq(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_int_ne(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_int_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = xor i1 %15, true
  ret i1 %16
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_int_le(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %16, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = trunc i64 %11 to i32
  %13 = lshr i64 %7, 1
  %14 = trunc i64 %13 to i32
  %15 = icmp sle i32 %12, %14
  br label %18

16:                                               ; preds = %6, %2
  %17 = tail call zeroext i1 @lean_int_big_le(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %18

18:                                               ; preds = %16, %10
  %19 = phi i1 [ %15, %10 ], [ %17, %16 ]
  ret i1 %19
}

declare zeroext i1 @lean_int_big_le(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i1 @lean_int_lt(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %16, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = trunc i64 %11 to i32
  %13 = lshr i64 %7, 1
  %14 = trunc i64 %13 to i32
  %15 = icmp slt i32 %12, %14
  br label %18

16:                                               ; preds = %6, %2
  %17 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %18

18:                                               ; preds = %16, %10
  %19 = phi i1 [ %15, %10 ], [ %17, %16 ]
  ret i1 %19
}

declare zeroext i1 @lean_int_big_lt(%struct.lean_object*, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_int_to_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %9, label %5, !prof !37

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i32
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %11, label %14

9:                                                ; preds = %1
  %10 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* %0, %struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #12
  br i1 %10, label %11, label %12

11:                                               ; preds = %9, %5
  tail call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1639, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @__PRETTY_FUNCTION__.lean_int_to_nat, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %9
  %13 = tail call %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object* %0) #12
  br label %14

14:                                               ; preds = %12, %5
  %15 = phi %struct.lean_object* [ %13, %12 ], [ %0, %5 ]
  ret %struct.lean_object* %15
}

declare %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_nat_abs(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %9, label %5, !prof !37

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i32
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %11, label %56

9:                                                ; preds = %1
  %10 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* %0, %struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #12
  br i1 %10, label %24, label %40

11:                                               ; preds = %5
  %12 = shl i64 %2, 31
  %13 = ashr i64 %12, 32
  %14 = sub nsw i64 0, %13
  %15 = sub nsw i64 2147483648, %13
  %16 = icmp ult i64 %15, 4294967296
  br i1 %16, label %17, label %22, !prof !11

17:                                               ; preds = %11
  %18 = shl nsw i64 %14, 1
  %19 = and i64 %18, 8589934590
  %20 = or i64 %19, 1
  %21 = inttoptr i64 %20 to %struct.lean_object*
  br label %26

22:                                               ; preds = %11
  %23 = tail call %struct.lean_object* @lean_big_int64_to_int(i64 %14) #12
  br label %26

24:                                               ; preds = %9
  %25 = tail call %struct.lean_object* @lean_int_big_neg(%struct.lean_object* %0) #12
  br label %26

26:                                               ; preds = %24, %22, %17
  %27 = phi %struct.lean_object* [ %25, %24 ], [ %21, %17 ], [ %23, %22 ]
  %28 = ptrtoint %struct.lean_object* %27 to i64
  %29 = and i64 %28, 1
  %30 = icmp eq i64 %29, 0
  br i1 %30, label %35, label %31, !prof !37

31:                                               ; preds = %26
  %32 = lshr i64 %28, 1
  %33 = trunc i64 %32 to i32
  %34 = icmp slt i32 %33, 0
  br i1 %34, label %37, label %56

35:                                               ; preds = %26
  %36 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* %27, %struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #12
  br i1 %36, label %37, label %38

37:                                               ; preds = %35, %31
  tail call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1639, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @__PRETTY_FUNCTION__.lean_int_to_nat, i64 0, i64 0)) #11
  unreachable

38:                                               ; preds = %35
  %39 = tail call %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object* %27) #12
  br label %56

40:                                               ; preds = %9
  %41 = bitcast %struct.lean_object* %0 to i8*
  %42 = getelementptr inbounds i8, i8* %41, i64 5
  %43 = load i8, i8* %42, align 1, !tbaa !7
  switch i8 %43, label %51 [
    i8 0, label %44
    i8 1, label %48
  ], !prof !8

44:                                               ; preds = %40
  %45 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %46 = load i64, i64* %45, align 8, !tbaa !9
  %47 = add i64 %46, 1
  store i64 %47, i64* %45, align 8, !tbaa !9
  br label %51

48:                                               ; preds = %40
  %49 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %50 = atomicrmw add i64* %49, i64 1 monotonic, align 8
  br label %51

51:                                               ; preds = %48, %44, %40
  %52 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* nonnull %0, %struct.lean_object* nonnull inttoptr (i64 1 to %struct.lean_object*)) #12
  br i1 %52, label %53, label %54

53:                                               ; preds = %51
  tail call void @__assert_fail(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1639, i8* getelementptr inbounds ([43 x i8], [43 x i8]* @__PRETTY_FUNCTION__.lean_int_to_nat, i64 0, i64 0)) #11
  unreachable

54:                                               ; preds = %51
  %55 = tail call %struct.lean_object* @lean_big_int_to_nat(%struct.lean_object* nonnull %0) #12
  br label %56

56:                                               ; preds = %54, %38, %31, %5
  %57 = phi %struct.lean_object* [ %39, %38 ], [ %27, %31 ], [ %55, %54 ], [ %0, %5 ]
  ret %struct.lean_object* %57
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %12, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %12, label %10, !prof !37

10:                                               ; preds = %6
  %11 = icmp eq %struct.lean_object* %0, %1
  br label %14

12:                                               ; preds = %6, %2
  %13 = tail call zeroext i1 @lean_int_big_eq(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i1 [ %11, %10 ], [ %13, %12 ]
  %16 = zext i1 %15 to i8
  ret i8 %16
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_le(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %16, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = trunc i64 %11 to i32
  %13 = lshr i64 %7, 1
  %14 = trunc i64 %13 to i32
  %15 = icmp sle i32 %12, %14
  br label %18

16:                                               ; preds = %6, %2
  %17 = tail call zeroext i1 @lean_int_big_le(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %18

18:                                               ; preds = %16, %10
  %19 = phi i1 [ %15, %10 ], [ %17, %16 ]
  %20 = zext i1 %19 to i8
  ret i8 %20
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %0 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = ptrtoint %struct.lean_object* %1 to i64
  %8 = and i64 %7, 1
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %16, label %10, !prof !37

10:                                               ; preds = %6
  %11 = lshr i64 %3, 1
  %12 = trunc i64 %11 to i32
  %13 = lshr i64 %7, 1
  %14 = trunc i64 %13 to i32
  %15 = icmp slt i32 %12, %14
  br label %18

16:                                               ; preds = %6, %2
  %17 = tail call zeroext i1 @lean_int_big_lt(%struct.lean_object* %0, %struct.lean_object* %1) #12
  br label %18

18:                                               ; preds = %16, %10
  %19 = phi i1 [ %15, %10 ], [ %17, %16 ]
  %20 = zext i1 %19 to i8
  ret i8 %20
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_int_dec_nonneg(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %10, label %5, !prof !37

5:                                                ; preds = %1
  %6 = lshr i64 %2, 32
  %7 = trunc i64 %6 to i8
  %8 = and i8 %7, 1
  %9 = xor i8 %8, 1
  br label %13

10:                                               ; preds = %1
  %11 = tail call zeroext i1 @lean_int_big_nonneg(%struct.lean_object* %0) #12
  %12 = zext i1 %11 to i8
  br label %13

13:                                               ; preds = %10, %5
  %14 = phi i8 [ %9, %5 ], [ %12, %10 ]
  ret i8 %14
}

declare zeroext i1 @lean_int_big_nonneg(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i8
  br label %10

8:                                                ; preds = %1
  %9 = tail call zeroext i8 @lean_uint8_of_big_nat(%struct.lean_object* %0) #12
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i8 [ %7, %5 ], [ %9, %8 ]
  ret i8 %11
}

declare zeroext i8 @lean_uint8_of_big_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i8 @lean_uint8_of_nat_mk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i8
  br label %25

8:                                                ; preds = %1
  %9 = tail call zeroext i8 @lean_uint8_of_big_nat(%struct.lean_object* %0) #12
  %10 = bitcast %struct.lean_object* %0 to i8*
  %11 = getelementptr inbounds i8, i8* %10, i64 5
  %12 = load i8, i8* %11, align 1, !tbaa !7
  switch i8 %12, label %25 [
    i8 0, label %13
    i8 1, label %19
  ], !prof !8

13:                                               ; preds = %8
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !9
  %16 = add i64 %15, -1
  store i64 %16, i64* %14, align 8, !tbaa !9
  %17 = and i64 %16, 4294967295
  %18 = icmp eq i64 %17, 0
  br i1 %18, label %24, label %25

19:                                               ; preds = %8
  %20 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %21 = atomicrmw sub i64* %20, i64 1 acq_rel, align 8
  %22 = and i64 %21, 4294967295
  %23 = icmp eq i64 %22, 1
  br i1 %23, label %24, label %25

24:                                               ; preds = %19, %13
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %25

25:                                               ; preds = %24, %19, %13, %8, %5
  %26 = phi i8 [ %7, %5 ], [ %9, %8 ], [ %9, %13 ], [ %9, %19 ], [ %9, %24 ]
  ret i8 %26
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_uint8_to_nat(i8 zeroext %0) local_unnamed_addr #0 {
  %2 = zext i8 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_add(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = add i8 %1, %0
  ret i8 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_sub(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = sub i8 %0, %1
  ret i8 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_mul(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = mul i8 %1, %0
  ret i8 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_div(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i8 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = udiv i8 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i8 [ %5, %4 ], [ 0, %2 ]
  ret i8 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_mod(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i8 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = urem i8 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i8 [ %5, %4 ], [ %0, %2 ]
  ret i8 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_modn(i8 zeroext %0, %struct.lean_object* %1) local_unnamed_addr #0 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = trunc i64 %7 to i32
  %9 = icmp eq i32 %8, 0
  %10 = zext i8 %0 to i32
  br i1 %9, label %13, label %11

11:                                               ; preds = %6
  %12 = urem i32 %10, %8
  br label %13

13:                                               ; preds = %11, %6
  %14 = phi i32 [ %12, %11 ], [ %10, %6 ]
  %15 = trunc i32 %14 to i8
  br label %16

16:                                               ; preds = %13, %2
  %17 = phi i8 [ %15, %13 ], [ %0, %2 ]
  ret i8 %17
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_dec_eq(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_dec_lt(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ult i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_dec_le(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ule i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i16
  br label %10

8:                                                ; preds = %1
  %9 = tail call zeroext i16 @lean_uint16_of_big_nat(%struct.lean_object* %0) #12
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i16 [ %7, %5 ], [ %9, %8 ]
  ret i16 %11
}

declare zeroext i16 @lean_uint16_of_big_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define zeroext i16 @lean_uint16_of_nat_mk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i16
  br label %25

8:                                                ; preds = %1
  %9 = tail call zeroext i16 @lean_uint16_of_big_nat(%struct.lean_object* %0) #12
  %10 = bitcast %struct.lean_object* %0 to i8*
  %11 = getelementptr inbounds i8, i8* %10, i64 5
  %12 = load i8, i8* %11, align 1, !tbaa !7
  switch i8 %12, label %25 [
    i8 0, label %13
    i8 1, label %19
  ], !prof !8

13:                                               ; preds = %8
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !9
  %16 = add i64 %15, -1
  store i64 %16, i64* %14, align 8, !tbaa !9
  %17 = and i64 %16, 4294967295
  %18 = icmp eq i64 %17, 0
  br i1 %18, label %24, label %25

19:                                               ; preds = %8
  %20 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %21 = atomicrmw sub i64* %20, i64 1 acq_rel, align 8
  %22 = and i64 %21, 4294967295
  %23 = icmp eq i64 %22, 1
  br i1 %23, label %24, label %25

24:                                               ; preds = %19, %13
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %25

25:                                               ; preds = %24, %19, %13, %8, %5
  %26 = phi i16 [ %7, %5 ], [ %9, %8 ], [ %9, %13 ], [ %9, %19 ], [ %9, %24 ]
  ret i16 %26
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_uint16_to_nat(i16 zeroext %0) local_unnamed_addr #0 {
  %2 = zext i16 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_add(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = add i16 %1, %0
  ret i16 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_sub(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = sub i16 %0, %1
  ret i16 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_mul(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = mul i16 %1, %0
  ret i16 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_div(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i16 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = udiv i16 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i16 [ %5, %4 ], [ 0, %2 ]
  ret i16 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_mod(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i16 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = urem i16 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i16 [ %5, %4 ], [ %0, %2 ]
  ret i16 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i16 @lean_uint16_modn(i16 zeroext %0, %struct.lean_object* %1) local_unnamed_addr #0 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %16, label %6, !prof !37

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = trunc i64 %7 to i32
  %9 = icmp eq i32 %8, 0
  %10 = zext i16 %0 to i32
  br i1 %9, label %13, label %11

11:                                               ; preds = %6
  %12 = urem i32 %10, %8
  br label %13

13:                                               ; preds = %11, %6
  %14 = phi i32 [ %12, %11 ], [ %10, %6 ]
  %15 = trunc i32 %14 to i16
  br label %16

16:                                               ; preds = %13, %2
  %17 = phi i16 [ %15, %13 ], [ %0, %2 ]
  ret i16 %17
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_dec_eq(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp eq i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_dec_lt(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ult i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_dec_le(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ule i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_uint32_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i32
  br label %10

8:                                                ; preds = %1
  %9 = tail call i32 @lean_uint32_of_big_nat(%struct.lean_object* %0) #12
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i32 [ %7, %5 ], [ %9, %8 ]
  ret i32 %11
}

declare i32 @lean_uint32_of_big_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define i32 @lean_uint32_of_nat_mk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  %7 = trunc i64 %6 to i32
  br label %25

8:                                                ; preds = %1
  %9 = tail call i32 @lean_uint32_of_big_nat(%struct.lean_object* %0) #12
  %10 = bitcast %struct.lean_object* %0 to i8*
  %11 = getelementptr inbounds i8, i8* %10, i64 5
  %12 = load i8, i8* %11, align 1, !tbaa !7
  switch i8 %12, label %25 [
    i8 0, label %13
    i8 1, label %19
  ], !prof !8

13:                                               ; preds = %8
  %14 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %15 = load i64, i64* %14, align 8, !tbaa !9
  %16 = add i64 %15, -1
  store i64 %16, i64* %14, align 8, !tbaa !9
  %17 = and i64 %16, 4294967295
  %18 = icmp eq i64 %17, 0
  br i1 %18, label %24, label %25

19:                                               ; preds = %8
  %20 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %21 = atomicrmw sub i64* %20, i64 1 acq_rel, align 8
  %22 = and i64 %21, 4294967295
  %23 = icmp eq i64 %22, 1
  br i1 %23, label %24, label %25

24:                                               ; preds = %19, %13
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %25

25:                                               ; preds = %24, %19, %13, %8, %5
  %26 = phi i32 [ %7, %5 ], [ %9, %8 ], [ %9, %13 ], [ %9, %19 ], [ %9, %24 ]
  ret i32 %26
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_uint32_to_nat(i32 %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_add(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = add i32 %1, %0
  ret i32 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_sub(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = sub i32 %0, %1
  ret i32 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_mul(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = mul i32 %1, %0
  ret i32 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_div(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = udiv i32 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i32 [ %5, %4 ], [ 0, %2 ]
  ret i32 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_mod(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = urem i32 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i32 [ %5, %4 ], [ %0, %2 ]
  ret i32 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_uint32_modn(i32 %0, %struct.lean_object* %1) local_unnamed_addr #0 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %15, label %6, !prof !37

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = icmp eq i64 %7, 0
  %9 = zext i32 %0 to i64
  br i1 %8, label %12, label %10

10:                                               ; preds = %6
  %11 = urem i64 %9, %7
  br label %12

12:                                               ; preds = %10, %6
  %13 = phi i64 [ %11, %10 ], [ %9, %6 ]
  %14 = trunc i64 %13 to i32
  br label %15

15:                                               ; preds = %12, %2
  %16 = phi i32 [ %14, %12 ], [ %0, %2 ]
  ret i32 %16
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_dec_eq(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp eq i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_dec_lt(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp ult i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_dec_le(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp ule i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_uint64_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  br label %9

7:                                                ; preds = %1
  %8 = tail call i64 @lean_uint64_of_big_nat(%struct.lean_object* %0) #12
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i64 [ %6, %5 ], [ %8, %7 ]
  ret i64 %10
}

declare i64 @lean_uint64_of_big_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_uint64_of_nat_mk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  br label %24

7:                                                ; preds = %1
  %8 = tail call i64 @lean_uint64_of_big_nat(%struct.lean_object* %0) #12
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 5
  %11 = load i8, i8* %10, align 1, !tbaa !7
  switch i8 %11, label %24 [
    i8 0, label %12
    i8 1, label %18
  ], !prof !8

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %14 = load i64, i64* %13, align 8, !tbaa !9
  %15 = add i64 %14, -1
  store i64 %15, i64* %13, align 8, !tbaa !9
  %16 = and i64 %15, 4294967295
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %23, label %24

18:                                               ; preds = %7
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %20 = atomicrmw sub i64* %19, i64 1 acq_rel, align 8
  %21 = and i64 %20, 4294967295
  %22 = icmp eq i64 %21, 1
  br i1 %22, label %23, label %24

23:                                               ; preds = %18, %12
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %24

24:                                               ; preds = %23, %18, %12, %7, %5
  %25 = phi i64 [ %6, %5 ], [ %8, %7 ], [ %8, %12 ], [ %8, %18 ], [ %8, %23 ]
  ret i64 %25
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_uint64_add(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = add i64 %1, %0
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_uint64_sub(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = sub i64 %0, %1
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_uint64_mul(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = mul i64 %1, %0
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_uint64_div(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = udiv i64 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i64 [ %5, %4 ], [ 0, %2 ]
  ret i64 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_uint64_mod(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = urem i64 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i64 [ %5, %4 ], [ %0, %2 ]
  ret i64 %7
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_uint64_modn(i64 %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %11, label %6, !prof !37

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %13, label %9

9:                                                ; preds = %6
  %10 = urem i64 %0, %7
  br label %13

11:                                               ; preds = %2
  %12 = tail call i64 @lean_uint64_big_modn(i64 %0, %struct.lean_object* %1) #12
  br label %13

13:                                               ; preds = %11, %9, %6
  %14 = phi i64 [ %12, %11 ], [ %10, %9 ], [ %0, %6 ]
  ret i64 %14
}

declare i64 @lean_uint64_big_modn(i64, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_dec_eq(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_dec_lt(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ult i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_dec_le(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ule i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_usize_of_nat(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  br label %9

7:                                                ; preds = %1
  %8 = tail call i64 @lean_usize_of_big_nat(%struct.lean_object* %0) #12
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i64 [ %6, %5 ], [ %8, %7 ]
  ret i64 %10
}

declare i64 @lean_usize_of_big_nat(%struct.lean_object*) local_unnamed_addr #3

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_usize_of_nat_mk(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = and i64 %2, 1
  %4 = icmp eq i64 %3, 0
  br i1 %4, label %7, label %5

5:                                                ; preds = %1
  %6 = lshr i64 %2, 1
  br label %24

7:                                                ; preds = %1
  %8 = tail call i64 @lean_usize_of_big_nat(%struct.lean_object* %0) #12
  %9 = bitcast %struct.lean_object* %0 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 5
  %11 = load i8, i8* %10, align 1, !tbaa !7
  switch i8 %11, label %24 [
    i8 0, label %12
    i8 1, label %18
  ], !prof !8

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %14 = load i64, i64* %13, align 8, !tbaa !9
  %15 = add i64 %14, -1
  store i64 %15, i64* %13, align 8, !tbaa !9
  %16 = and i64 %15, 4294967295
  %17 = icmp eq i64 %16, 0
  br i1 %17, label %23, label %24

18:                                               ; preds = %7
  %19 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 0, i32 0
  %20 = atomicrmw sub i64* %19, i64 1 acq_rel, align 8
  %21 = and i64 %20, 4294967295
  %22 = icmp eq i64 %21, 1
  br i1 %22, label %23, label %24

23:                                               ; preds = %18, %12
  tail call void @lean_del(%struct.lean_object* nonnull %0) #12
  br label %24

24:                                               ; preds = %23, %18, %12, %7, %5
  %25 = phi i64 [ %6, %5 ], [ %8, %7 ], [ %8, %12 ], [ %8, %18 ], [ %8, %23 ]
  ret i64 %25
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_usize_add(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = add i64 %1, %0
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_usize_sub(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = sub i64 %0, %1
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_usize_mul(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = mul i64 %1, %0
  ret i64 %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_usize_div(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = udiv i64 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i64 [ %5, %4 ], [ 0, %2 ]
  ret i64 %7
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_usize_mod(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %1, 0
  br i1 %3, label %6, label %4

4:                                                ; preds = %2
  %5 = urem i64 %0, %1
  br label %6

6:                                                ; preds = %4, %2
  %7 = phi i64 [ %5, %4 ], [ %0, %2 ]
  ret i64 %7
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_usize_modn(i64 %0, %struct.lean_object* %1) local_unnamed_addr #1 {
  %3 = ptrtoint %struct.lean_object* %1 to i64
  %4 = and i64 %3, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %11, label %6, !prof !37

6:                                                ; preds = %2
  %7 = lshr i64 %3, 1
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %13, label %9

9:                                                ; preds = %6
  %10 = urem i64 %0, %7
  br label %13

11:                                               ; preds = %2
  %12 = tail call i64 @lean_usize_big_modn(i64 %0, %struct.lean_object* %1) #12
  br label %13

13:                                               ; preds = %11, %9, %6
  %14 = phi i64 [ %12, %11 ], [ %10, %9 ], [ %0, %6 ]
  ret i64 %14
}

declare i64 @lean_usize_big_modn(i64, %struct.lean_object*) local_unnamed_addr #3

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_dec_eq(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp eq i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_dec_lt(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ult i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_dec_le(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ule i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_box_uint32(i32 %0) local_unnamed_addr #0 {
  %2 = zext i32 %0 to i64
  %3 = shl nuw nsw i64 %2, 1
  %4 = or i64 %3, 1
  %5 = inttoptr i64 %4 to %struct.lean_object*
  ret %struct.lean_object* %5
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i32 @lean_unbox_uint32(%struct.lean_object* %0) local_unnamed_addr #0 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  %3 = lshr i64 %2, 1
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_uint64(i64 %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 16, i32 1) #12
  %3 = bitcast i8* %2 to i64*
  store i64 1, i64* %3, align 8, !tbaa !9
  %4 = bitcast i8* %2 to %struct.lean_object*
  %5 = getelementptr inbounds i8, i8* %2, i64 8
  %6 = bitcast i8* %5 to i64*
  store i64 %0, i64* %6, align 8, !tbaa !3
  ret %struct.lean_object* %4
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_unbox_uint64(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 750, i8* getelementptr inbounds ([60 x i8], [60 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_uint64, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %14 = load i64, i64* %13, align 8, !tbaa !3
  ret i64 %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_usize(i64 %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 16, i32 1) #12
  %3 = bitcast i8* %2 to i64*
  store i64 1, i64* %3, align 8, !tbaa !9
  %4 = bitcast i8* %2 to %struct.lean_object*
  %5 = getelementptr inbounds i8, i8* %2, i64 8
  %6 = bitcast i8* %5 to i64*
  store i64 %0, i64* %6, align 8, !tbaa !3
  ret %struct.lean_object* %4
}

; Function Attrs: nounwind sspstrong uwtable
define i64 @lean_unbox_usize(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.19, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 730, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_usize, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1, i32 0
  %14 = load i64, i64* %13, align 8, !tbaa !3
  ret i64 %14
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_box_float(double %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 16, i32 1) #12
  %3 = bitcast i8* %2 to i64*
  store i64 1, i64* %3, align 8, !tbaa !9
  %4 = bitcast i8* %2 to %struct.lean_object*
  %5 = getelementptr inbounds i8, i8* %2, i64 8
  %6 = bitcast i8* %5 to double*
  store double %0, double* %6, align 8, !tbaa !18
  ret %struct.lean_object* %4
}

; Function Attrs: nounwind sspstrong uwtable
define double @lean_unbox_float(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp ult i8 %4, -11
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 682, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %12, label %11

11:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([48 x i8], [48 x i8]* @.str.20, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 755, i8* getelementptr inbounds ([57 x i8], [57 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get_float, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %14 = bitcast %struct.lean_object* %13 to double*
  %15 = load double, double* %14, align 8, !tbaa !18
  ret double %15
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define nonnull %struct.lean_object* @lean_io_mk_world() local_unnamed_addr #0 {
  ret %struct.lean_object* inttoptr (i64 1 to %struct.lean_object*)
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_io_result_is_ok(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  ret i1 %5
}

; Function Attrs: norecurse nounwind readonly sspstrong uwtable willreturn
define zeroext i1 @lean_io_result_is_error(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #4 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 1
  ret i1 %5
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_get_value(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.31, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1866, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__.lean_io_result_get_value, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 704, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %14 = bitcast %struct.lean_object* %13 to %struct.lean_object**
  %15 = load %struct.lean_object*, %struct.lean_object** %14, align 8, !tbaa !12
  ret %struct.lean_object* %15
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_get_error(%struct.lean_object* nocapture readonly %0) local_unnamed_addr #1 {
  %2 = bitcast %struct.lean_object* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i64 7
  %4 = load i8, i8* %3, align 1, !tbaa !7
  %5 = icmp eq i8 %4, 1
  br i1 %5, label %7, label %6

6:                                                ; preds = %1
  tail call void @__assert_fail(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 1867, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__.lean_io_result_get_error, i64 0, i64 0)) #11
  unreachable

7:                                                ; preds = %1
  %8 = getelementptr inbounds i8, i8* %2, i64 6
  %9 = load i8, i8* %8, align 1, !tbaa !7
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %11, label %12

11:                                               ; preds = %7
  tail call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.17, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i32 704, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #11
  unreachable

12:                                               ; preds = %7
  %13 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %0, i64 1
  %14 = bitcast %struct.lean_object* %13 to %struct.lean_object**
  %15 = load %struct.lean_object*, %struct.lean_object** %14, align 8, !tbaa !12
  ret %struct.lean_object* %15
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_mk_ok(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 24, i32 2) #12
  %3 = bitcast i8* %2 to i64*
  store i64 562949953421313, i64* %3, align 8, !tbaa !9
  %4 = getelementptr inbounds i8, i8* %2, i64 8
  %5 = bitcast i8* %4 to %struct.lean_object**
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8, !tbaa !12
  %6 = bitcast i8* %2 to %struct.lean_object*
  %7 = getelementptr inbounds i8, i8* %2, i64 16
  %8 = bitcast i8* %7 to %struct.lean_object**
  store %struct.lean_object* inttoptr (i64 1 to %struct.lean_object*), %struct.lean_object** %8, align 8, !tbaa !12
  ret %struct.lean_object* %6
}

; Function Attrs: nounwind sspstrong uwtable
define %struct.lean_object* @lean_io_result_mk_error(%struct.lean_object* %0) local_unnamed_addr #1 {
  %2 = tail call i8* @lean_alloc_small(i32 24, i32 2) #12
  %3 = bitcast i8* %2 to i64*
  store i64 72620543991349249, i64* %3, align 8, !tbaa !9
  %4 = getelementptr inbounds i8, i8* %2, i64 8
  %5 = bitcast i8* %4 to %struct.lean_object**
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8, !tbaa !12
  %6 = bitcast i8* %2 to %struct.lean_object*
  %7 = getelementptr inbounds i8, i8* %2, i64 16
  %8 = bitcast i8* %7 to %struct.lean_object**
  store %struct.lean_object* inttoptr (i64 1 to %struct.lean_object*), %struct.lean_object** %8, align 8, !tbaa !12
  ret %struct.lean_object* %6
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define i64 @lean_ptr_addr(%struct.lean_object* %0) local_unnamed_addr #0 {
  %2 = ptrtoint %struct.lean_object* %0 to i64
  ret i64 %2
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_le(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ule i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_le(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ule i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_le(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp ule i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_le(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ule i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_float_le(double %0, double %1) local_unnamed_addr #0 {
  %3 = fcmp ole double %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_le(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ule i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint8_lt(i8 zeroext %0, i8 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ult i8 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint16_lt(i16 zeroext %0, i16 zeroext %1) local_unnamed_addr #0 {
  %3 = icmp ult i16 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint32_lt(i32 %0, i32 %1) local_unnamed_addr #0 {
  %3 = icmp ult i32 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_uint64_lt(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ult i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_float_lt(double %0, double %1) local_unnamed_addr #0 {
  %3 = fcmp olt double %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_usize_lt(i64 %0, i64 %1) local_unnamed_addr #0 {
  %3 = icmp ult i64 %0, %1
  %4 = zext i1 %3 to i8
  ret i8 %4
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define zeroext i8 @lean_float_to_uint8(double %0) local_unnamed_addr #0 {
  %2 = fptoui double %0 to i8
  ret i8 %2
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define double @lean_float_add(double %0, double %1) local_unnamed_addr #0 {
  %3 = fadd double %0, %1
  ret double %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define double @lean_float_sub(double %0, double %1) local_unnamed_addr #0 {
  %3 = fsub double %0, %1
  ret double %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define double @lean_float_mul(double %0, double %1) local_unnamed_addr #0 {
  %3 = fmul double %0, %1
  ret double %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define double @lean_float_div(double %0, double %1) local_unnamed_addr #0 {
  %3 = fdiv double %0, %1
  ret double %3
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define double @lean_float_negate(double %0) local_unnamed_addr #0 {
  %2 = fneg double %0
  ret double %2
}

; Function Attrs: alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn
define %struct.lean_object* @unsafeCast(%struct.lean_object* readnone returned %0) local_unnamed_addr #0 {
  ret %struct.lean_object* %0
}

; Function Attrs: argmemonly nofree nounwind readonly willreturn
declare i32 @bcmp(i8* nocapture, i8* nocapture, i64) local_unnamed_addr #8

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64) #9

; Function Attrs: argmemonly nofree nosync nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #10

attributes #0 = { alwaysinline norecurse nounwind readnone sspstrong uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind sspstrong uwtable "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { norecurse nounwind readonly sspstrong uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nofree norecurse nounwind sspstrong uwtable willreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nofree norecurse nounwind sspstrong uwtable willreturn writeonly "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { argmemonly nofree nounwind readonly willreturn }
attributes #9 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #10 = { argmemonly nofree nosync nounwind willreturn writeonly }
attributes #11 = { noreturn nounwind }
attributes #12 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 12.0.1"}
!3 = !{!4, !4, i64 0}
!4 = !{!"long", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!5, !5, i64 0}
!8 = !{!"branch_weights", i32 1, i32 4000, i32 1}
!9 = !{!10, !4, i64 0}
!10 = !{!"", !4, i64 0}
!11 = !{!"branch_weights", i32 2000, i32 1}
!12 = !{!13, !13, i64 0}
!13 = !{!"any pointer", !5, i64 0}
!14 = !{!15, !15, i64 0}
!15 = !{!"short", !5, i64 0}
!16 = !{!17, !17, i64 0}
!17 = !{!"int", !5, i64 0}
!18 = !{!19, !19, i64 0}
!19 = !{!"double", !5, i64 0}
!20 = !{!21, !13, i64 8}
!21 = !{!"", !10, i64 0, !13, i64 8, !15, i64 16, !15, i64 18, !5, i64 24}
!22 = !{!21, !15, i64 16}
!23 = !{!21, !15, i64 18}
!24 = !{!25, !4, i64 8}
!25 = !{!"", !10, i64 0, !4, i64 8, !4, i64 16, !5, i64 24}
!26 = !{!25, !4, i64 16}
!27 = !{!28, !4, i64 8}
!28 = !{!"", !10, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !5, i64 32}
!29 = !{!28, !4, i64 16}
!30 = !{!28, !4, i64 24}
!31 = !{!32, !5, i64 8}
!32 = !{!"", !10, i64 0, !5, i64 8, !5, i64 16}
!33 = !{!32, !5, i64 16}
!34 = !{!35, !13, i64 8}
!35 = !{!"", !10, i64 0, !13, i64 8, !13, i64 16}
!36 = !{!35, !13, i64 16}
!37 = !{!"branch_weights", i32 1, i32 2000}
