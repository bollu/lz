; ModuleID = 'qsort.c'
source_filename = "qsort.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.lean_object = type { i64 }
%struct.lean_array_object = type { %struct.lean_object, i64, i64, [0 x %struct.lean_object*] }
%struct.lean_closure_object = type { %struct.lean_object, i8*, i16, i16, [0 x %struct.lean_object*] }
%struct.lean_string_object = type { %struct.lean_object, i64, i64, i64, [0 x i8] }
%struct.lean_ctor_object = type { %struct.lean_object, [0 x %struct.lean_object*] }

@l_checkSortedAux___boxed__const__1 = dso_local global %struct.lean_object* null, align 8
@l_checkSortedAux___closed__2 = dso_local global %struct.lean_object* null, align 8
@l_term_u2191____1___closed__2 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__7 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__3 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__9 = dso_local global %struct.lean_object* null, align 8
@l_Array_empty___closed__1 = external global %struct.lean_object*, align 8
@l_Lean_nullKind___closed__2 = external global %struct.lean_object*, align 8
@l_myMacro____x40_Init_Notation___hyg_2191____closed__4 = external global %struct.lean_object*, align 8
@l_String_instInhabitedString = external global %struct.lean_object*, align 8
@l_List_head_x21___rarg___closed__3 = external global %struct.lean_object*, align 8
@l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1 = dso_local global %struct.lean_object* null, align 8
@l_qsortAux___at_main___spec__2___boxed__const__1 = dso_local global %struct.lean_object* null, align 8
@_G_initialized = internal global i8 0, align 1
@l_checkSortedAux___closed__1 = dso_local global %struct.lean_object* null, align 8
@l_term_u2191____1___closed__1 = dso_local global %struct.lean_object* null, align 8
@l_term_u2191____1___closed__3 = dso_local global %struct.lean_object* null, align 8
@l_term_u2191____1 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__1 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__2 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__4 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__5 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__6 = dso_local global %struct.lean_object* null, align 8
@l_myMacro____x40_qsort___hyg_178____closed__8 = dso_local global %struct.lean_object* null, align 8
@.str = private unnamed_addr constant [17 x i8] c"lean_is_array(o)\00", align 1
@.str.1 = private unnamed_addr constant [56 x i8] c"/home/bollu/work/lean4/build/stage1/include/lean/lean.h\00", align 1
@__PRETTY_FUNCTION__.lean_to_array = private unnamed_addr constant [48 x i8] c"lean_array_object *lean_to_array(lean_object *)\00", align 1
@.str.2 = private unnamed_addr constant [18 x i8] c"lean_is_string(o)\00", align 1
@__PRETTY_FUNCTION__.lean_to_string = private unnamed_addr constant [50 x i8] c"lean_string_object *lean_to_string(lean_object *)\00", align 1
@.str.3 = private unnamed_addr constant [23 x i8] c"i < lean_array_size(o)\00", align 1
@__PRETTY_FUNCTION__.lean_array_get_core = private unnamed_addr constant [59 x i8] c"b_lean_obj_res lean_array_get_core(b_lean_obj_arg, size_t)\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"arity > 0\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_closure = private unnamed_addr constant [68 x i8] c"lean_obj_res lean_alloc_closure(void *, unsigned int, unsigned int)\00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"num_fixed < arity\00", align 1
@.str.6 = private unnamed_addr constant [33 x i8] c"sz <= LEAN_MAX_SMALL_OBJECT_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_small_object = private unnamed_addr constant [51 x i8] c"lean_object *lean_alloc_small_object(unsigned int)\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"sz > 0\00", align 1
@__PRETTY_FUNCTION__.lean_get_slot_idx = private unnamed_addr constant [45 x i8] c"unsigned int lean_get_slot_idx(unsigned int)\00", align 1
@.str.8 = private unnamed_addr constant [45 x i8] c"lean_align(sz, LEAN_OBJECT_SIZE_DELTA) == sz\00", align 1
@.str.9 = private unnamed_addr constant [99 x i8] c"tag <= LeanMaxCtorTag && num_objs < LEAN_MAX_CTOR_FIELDS && scalar_sz < LEAN_MAX_CTOR_SCALARS_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_ctor = private unnamed_addr constant [71 x i8] c"lean_object *lean_alloc_ctor(unsigned int, unsigned int, unsigned int)\00", align 1
@.str.10 = private unnamed_addr constant [34 x i8] c"sz1 <= LEAN_MAX_SMALL_OBJECT_SIZE\00", align 1
@__PRETTY_FUNCTION__.lean_alloc_ctor_memory = private unnamed_addr constant [50 x i8] c"lean_object *lean_alloc_ctor_memory(unsigned int)\00", align 1
@.str.11 = private unnamed_addr constant [26 x i8] c"i < lean_ctor_num_objs(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_set = private unnamed_addr constant [63 x i8] c"void lean_ctor_set(b_lean_obj_arg, unsigned int, lean_obj_arg)\00", align 1
@.str.12 = private unnamed_addr constant [16 x i8] c"lean_is_ctor(o)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_num_objs = private unnamed_addr constant [47 x i8] c"unsigned int lean_ctor_num_objs(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_obj_cptr = private unnamed_addr constant [48 x i8] c"lean_object **lean_ctor_obj_cptr(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_to_ctor = private unnamed_addr constant [46 x i8] c"lean_ctor_object *lean_to_ctor(lean_object *)\00", align 1
@__PRETTY_FUNCTION__.lean_ctor_get = private unnamed_addr constant [59 x i8] c"b_lean_obj_res lean_ctor_get(b_lean_obj_arg, unsigned int)\00", align 1
@.str.13 = private unnamed_addr constant [20 x i8] c"array is not sorted\00", align 1
@l_instInhabitedUInt32 = external global i32, align 4
@.str.14 = private unnamed_addr constant [11 x i8] c"term\E2\86\91__1\00", align 1
@l_term_u2191_____closed__3 = external global %struct.lean_object*, align 8
@.str.15 = private unnamed_addr constant [13 x i8] c"UInt32.toNat\00", align 1
@.str.16 = private unnamed_addr constant [7 x i8] c"UInt32\00", align 1
@.str.17 = private unnamed_addr constant [6 x i8] c"toNat\00", align 1
@.str.18 = private unnamed_addr constant [24 x i8] c"lean_io_result_is_ok(r)\00", align 1
@__PRETTY_FUNCTION__.lean_io_result_get_value = private unnamed_addr constant [56 x i8] c"b_lean_obj_res lean_io_result_get_value(b_lean_obj_arg)\00", align 1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_get_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_array_size(%struct.lean_object* %3)
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_string_utf8_byte_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_string_size(%struct.lean_object* %3)
  %5 = sub i64 %4, 1
  %6 = call %struct.lean_object* @lean_box(i64 %5)
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_uint32_of_nat(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_nat_add(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_nat_sub(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_swap(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_get(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_uint32_to_nat(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i8 @lean_nat_dec_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @l_badRand(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  br label %7

7:                                                ; preds = %1
  store i32 1664525, i32* %3, align 4
  %8 = load i32, i32* %2, align 4
  %9 = load i32, i32* %3, align 4
  %10 = mul i32 %8, %9
  store i32 %10, i32* %4, align 4
  store i32 1013904223, i32* %5, align 4
  %11 = load i32, i32* %4, align 4
  %12 = load i32, i32* %5, align 4
  %13 = add i32 %11, %12
  store i32 %13, i32* %6, align 4
  %14 = load i32, i32* %6, align 4
  ret i32 %14
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_badRand___boxed(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %6

6:                                                ; preds = %1
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %8 = call i32 @lean_unbox_uint32(%struct.lean_object* %7)
  store i32 %8, i32* %3, align 4
  %9 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %9)
  %10 = load i32, i32* %3, align 4
  %11 = call i32 @l_badRand(i32 %10)
  store i32 %11, i32* %4, align 4
  %12 = load i32, i32* %4, align 4
  %13 = call %struct.lean_object* @lean_box_uint32(i32 %12)
  store %struct.lean_object* %13, %struct.lean_object** %5, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %14
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_unbox_uint32(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call i64 @lean_unbox(%struct.lean_object* %3)
  %5 = trunc i64 %4 to i32
  ret i32 %5
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_dec(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_box_uint32(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_box(i64 %4)
  ret %struct.lean_object* %5
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_mkRandomArray_match__1___rarg(%struct.lean_object* %0, i32 %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca i8, align 1
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %7, align 8
  store i32 %1, i32* %8, align 4
  store %struct.lean_object* %2, %struct.lean_object** %9, align 8
  store %struct.lean_object* %3, %struct.lean_object** %10, align 8
  store %struct.lean_object* %4, %struct.lean_object** %11, align 8
  br label %20

20:                                               ; preds = %5
  %21 = call %struct.lean_object* @lean_unsigned_to_nat(i32 0)
  store %struct.lean_object* %21, %struct.lean_object** %12, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %24 = call zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %22, %struct.lean_object* %23)
  store i8 %24, i8* %13, align 1
  %25 = load i8, i8* %13, align 1
  %26 = zext i8 %25 to i32
  %27 = icmp eq i32 %26, 0
  br i1 %27, label %28, label %42

28:                                               ; preds = %20
  %29 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %29)
  %30 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %30, %struct.lean_object** %14, align 8
  %31 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %32 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %33 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %31, %struct.lean_object* %32)
  store %struct.lean_object* %33, %struct.lean_object** %15, align 8
  %34 = load i32, i32* %8, align 4
  %35 = call %struct.lean_object* @lean_box_uint32(i32 %34)
  store %struct.lean_object* %35, %struct.lean_object** %16, align 8
  %36 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %37 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %38 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %39 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %40 = call %struct.lean_object* @lean_apply_3(%struct.lean_object* %36, %struct.lean_object* %37, %struct.lean_object* %38, %struct.lean_object* %39)
  store %struct.lean_object* %40, %struct.lean_object** %17, align 8
  %41 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  store %struct.lean_object* %41, %struct.lean_object** %6, align 8
  br label %51

42:                                               ; preds = %20
  %43 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %43)
  %44 = load i32, i32* %8, align 4
  %45 = call %struct.lean_object* @lean_box_uint32(i32 %44)
  store %struct.lean_object* %45, %struct.lean_object** %18, align 8
  %46 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %47 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %48 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %49 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %46, %struct.lean_object* %47, %struct.lean_object* %48)
  store %struct.lean_object* %49, %struct.lean_object** %19, align 8
  %50 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  store %struct.lean_object* %50, %struct.lean_object** %6, align 8
  br label %51

51:                                               ; preds = %42, %28
  %52 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  ret %struct.lean_object* %52
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_unsigned_to_nat(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = zext i32 %3 to i64
  %5 = call %struct.lean_object* @lean_usize_to_nat(i64 %4)
  ret %struct.lean_object* %5
}

declare %struct.lean_object* @lean_apply_3(%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*) #1

declare %struct.lean_object* @lean_apply_2(%struct.lean_object*, %struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_mkRandomArray_match__1(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l_mkRandomArray_match__1___rarg___boxed to i8*), i32 5, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_alloc_closure(i8* %0, i32 %1, i32 %2) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 794, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #3
  unreachable

12:                                               ; preds = %10
  %13 = load i32, i32* %6, align 4
  %14 = load i32, i32* %5, align 4
  %15 = icmp ult i32 %13, %14
  br i1 %15, label %16, label %17

16:                                               ; preds = %12
  br label %18

17:                                               ; preds = %12
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 795, i8* getelementptr inbounds ([68 x i8], [68 x i8]* @__PRETTY_FUNCTION__.lean_alloc_closure, i64 0, i64 0)) #3
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_mkRandomArray_match__1___rarg___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store %struct.lean_object* %3, %struct.lean_object** %9, align 8
  store %struct.lean_object* %4, %struct.lean_object** %10, align 8
  br label %13

13:                                               ; preds = %5
  %14 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %15 = call i32 @lean_unbox_uint32(%struct.lean_object* %14)
  store i32 %15, i32* %11, align 4
  %16 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec(%struct.lean_object* %16)
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %18 = load i32, i32* %11, align 4
  %19 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %20 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %22 = call %struct.lean_object* @l_mkRandomArray_match__1___rarg(%struct.lean_object* %17, i32 %18, %struct.lean_object* %19, %struct.lean_object* %20, %struct.lean_object* %21)
  store %struct.lean_object* %22, %struct.lean_object** %12, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %23)
  %24 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  ret %struct.lean_object* %24
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_mkRandomArray(%struct.lean_object* %0, i32 %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i8, align 1
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %14

14:                                               ; preds = %22, %3
  %15 = call %struct.lean_object* @lean_unsigned_to_nat(i32 0)
  store %struct.lean_object* %15, %struct.lean_object** %7, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %18 = call zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %16, %struct.lean_object* %17)
  store i8 %18, i8* %8, align 1
  %19 = load i8, i8* %8, align 1
  %20 = zext i8 %19 to i32
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %38

22:                                               ; preds = %14
  %23 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %23, %struct.lean_object** %9, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %26 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %24, %struct.lean_object* %25)
  store %struct.lean_object* %26, %struct.lean_object** %10, align 8
  %27 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec(%struct.lean_object* %27)
  %28 = load i32, i32* %5, align 4
  %29 = call i32 @l_badRand(i32 %28)
  store i32 %29, i32* %11, align 4
  %30 = load i32, i32* %5, align 4
  %31 = call %struct.lean_object* @lean_box_uint32(i32 %30)
  store %struct.lean_object* %31, %struct.lean_object** %12, align 8
  %32 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %33 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %34 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %32, %struct.lean_object* %33)
  store %struct.lean_object* %34, %struct.lean_object** %13, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  store %struct.lean_object* %35, %struct.lean_object** %4, align 8
  %36 = load i32, i32* %11, align 4
  store i32 %36, i32* %5, align 4
  %37 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  store %struct.lean_object* %37, %struct.lean_object** %6, align 8
  br label %14

38:                                               ; preds = %14
  %39 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec(%struct.lean_object* %39)
  %40 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  ret %struct.lean_object* %40
}

declare %struct.lean_object* @lean_array_push(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_mkRandomArray___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %9

9:                                                ; preds = %3
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = call i32 @lean_unbox_uint32(%struct.lean_object* %10)
  store i32 %11, i32* %7, align 4
  %12 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %12)
  %13 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %14 = load i32, i32* %7, align 4
  %15 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %16 = call %struct.lean_object* @l_mkRandomArray(%struct.lean_object* %13, i32 %14, %struct.lean_object* %15)
  store %struct.lean_object* %16, %struct.lean_object** %8, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  ret %struct.lean_object* %17
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_checkSortedAux___lambda__1(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  store %struct.lean_object* %3, %struct.lean_object** %8, align 8
  br label %12

12:                                               ; preds = %4
  %13 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %13, %struct.lean_object** %9, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %16 = call %struct.lean_object* @lean_nat_add(%struct.lean_object* %14, %struct.lean_object* %15)
  store %struct.lean_object* %16, %struct.lean_object** %10, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %20 = call %struct.lean_object* @l_checkSortedAux(%struct.lean_object* %17, %struct.lean_object* %18, %struct.lean_object* %19)
  store %struct.lean_object* %20, %struct.lean_object** %11, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %21)
  %22 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  ret %struct.lean_object* %22
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_checkSortedAux(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i8, align 1
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca i32, align 4
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca i32, align 4
  %21 = alloca i8, align 1
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  br label %26

26:                                               ; preds = %3
  %27 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %28 = call %struct.lean_object* @lean_array_get_size(%struct.lean_object* %27)
  store %struct.lean_object* %28, %struct.lean_object** %8, align 8
  %29 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %29, %struct.lean_object** %9, align 8
  %30 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %31 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %32 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %30, %struct.lean_object* %31)
  store %struct.lean_object* %32, %struct.lean_object** %10, align 8
  %33 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_dec(%struct.lean_object* %33)
  %34 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %36 = call zeroext i8 @lean_nat_dec_lt(%struct.lean_object* %34, %struct.lean_object* %35)
  store i8 %36, i8* %11, align 1
  %37 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %37)
  %38 = load i8, i8* %11, align 1
  %39 = zext i8 %38 to i32
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %49

41:                                               ; preds = %26
  %42 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %42, %struct.lean_object** %12, align 8
  %43 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %43, %struct.lean_object** %13, align 8
  %44 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %45 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  call void @lean_ctor_set(%struct.lean_object* %44, i32 0, %struct.lean_object* %45)
  %46 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %47 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_ctor_set(%struct.lean_object* %46, i32 1, %struct.lean_object* %47)
  %48 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  store %struct.lean_object* %48, %struct.lean_object** %4, align 8
  br label %94

49:                                               ; preds = %26
  %50 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___boxed__const__1, align 8
  store %struct.lean_object* %50, %struct.lean_object** %14, align 8
  %51 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %52 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %53 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %54 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %51, %struct.lean_object* %52, %struct.lean_object* %53)
  store %struct.lean_object* %54, %struct.lean_object** %15, align 8
  %55 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %56 = call i32 @lean_unbox_uint32(%struct.lean_object* %55)
  store i32 %56, i32* %16, align 4
  %57 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %57)
  %58 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %59 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %60 = call %struct.lean_object* @lean_nat_add(%struct.lean_object* %58, %struct.lean_object* %59)
  store %struct.lean_object* %60, %struct.lean_object** %17, align 8
  %61 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___boxed__const__1, align 8
  store %struct.lean_object* %61, %struct.lean_object** %18, align 8
  %62 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %63 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %64 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %65 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %62, %struct.lean_object* %63, %struct.lean_object* %64)
  store %struct.lean_object* %65, %struct.lean_object** %19, align 8
  %66 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %66)
  %67 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %68 = call i32 @lean_unbox_uint32(%struct.lean_object* %67)
  store i32 %68, i32* %20, align 4
  %69 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_dec(%struct.lean_object* %69)
  %70 = load i32, i32* %16, align 4
  %71 = load i32, i32* %20, align 4
  %72 = icmp ule i32 %70, %71
  %73 = zext i1 %72 to i32
  %74 = trunc i32 %73 to i8
  store i8 %74, i8* %21, align 1
  %75 = load i8, i8* %21, align 1
  %76 = zext i8 %75 to i32
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %78, label %86

78:                                               ; preds = %49
  %79 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___closed__2, align 8
  store %struct.lean_object* %79, %struct.lean_object** %22, align 8
  %80 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %80, %struct.lean_object** %23, align 8
  %81 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %82 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  call void @lean_ctor_set(%struct.lean_object* %81, i32 0, %struct.lean_object* %82)
  %83 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %84 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_ctor_set(%struct.lean_object* %83, i32 1, %struct.lean_object* %84)
  %85 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  store %struct.lean_object* %85, %struct.lean_object** %4, align 8
  br label %94

86:                                               ; preds = %49
  %87 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %87, %struct.lean_object** %24, align 8
  %88 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %89 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %90 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %91 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %92 = call %struct.lean_object* @l_checkSortedAux___lambda__1(%struct.lean_object* %88, %struct.lean_object* %89, %struct.lean_object* %90, %struct.lean_object* %91)
  store %struct.lean_object* %92, %struct.lean_object** %25, align 8
  %93 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  store %struct.lean_object* %93, %struct.lean_object** %4, align 8
  br label %94

94:                                               ; preds = %86, %78, %41
  %95 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %95
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_box(i64 %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = shl i64 %3, 1
  %5 = or i64 %4, 1
  %6 = inttoptr i64 %5 to %struct.lean_object*
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_alloc_ctor(i32 %0, i32 %1, i32 %2) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([99 x i8], [99 x i8]* @.str.9, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 695, i8* getelementptr inbounds ([71 x i8], [71 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor, i64 0, i64 0)) #3
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_ctor_set(%struct.lean_object* %0, i32 %1, %struct.lean_object* %2) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 707, i8* getelementptr inbounds ([63 x i8], [63 x i8]* @__PRETTY_FUNCTION__.lean_ctor_set, i64 0, i64 0)) #3
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_checkSortedAux___lambda__1___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  store %struct.lean_object* %3, %struct.lean_object** %8, align 8
  br label %10

10:                                               ; preds = %4
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %15 = call %struct.lean_object* @l_checkSortedAux___lambda__1(%struct.lean_object* %11, %struct.lean_object* %12, %struct.lean_object* %13, %struct.lean_object* %14)
  store %struct.lean_object* %15, %struct.lean_object** %9, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec(%struct.lean_object* %16)
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %17)
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %18)
  %19 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  ret %struct.lean_object* %19
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_checkSortedAux___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %8

8:                                                ; preds = %3
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %12 = call %struct.lean_object* @l_checkSortedAux(%struct.lean_object* %9, %struct.lean_object* %10, %struct.lean_object* %11)
  store %struct.lean_object* %12, %struct.lean_object** %7, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %13)
  %14 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec(%struct.lean_object* %14)
  %15 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %15
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_myMacro____x40_qsort___hyg_178_(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca i8, align 1
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca i8, align 1
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca %struct.lean_object*, align 8
  %21 = alloca %struct.lean_object*, align 8
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca %struct.lean_object*, align 8
  %27 = alloca %struct.lean_object*, align 8
  %28 = alloca %struct.lean_object*, align 8
  %29 = alloca %struct.lean_object*, align 8
  %30 = alloca %struct.lean_object*, align 8
  %31 = alloca %struct.lean_object*, align 8
  %32 = alloca %struct.lean_object*, align 8
  %33 = alloca %struct.lean_object*, align 8
  %34 = alloca %struct.lean_object*, align 8
  %35 = alloca %struct.lean_object*, align 8
  %36 = alloca %struct.lean_object*, align 8
  %37 = alloca %struct.lean_object*, align 8
  %38 = alloca %struct.lean_object*, align 8
  %39 = alloca %struct.lean_object*, align 8
  %40 = alloca %struct.lean_object*, align 8
  %41 = alloca %struct.lean_object*, align 8
  %42 = alloca %struct.lean_object*, align 8
  %43 = alloca %struct.lean_object*, align 8
  %44 = alloca %struct.lean_object*, align 8
  %45 = alloca %struct.lean_object*, align 8
  %46 = alloca %struct.lean_object*, align 8
  %47 = alloca %struct.lean_object*, align 8
  %48 = alloca %struct.lean_object*, align 8
  %49 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  br label %50

50:                                               ; preds = %3
  %51 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__2, align 8
  store %struct.lean_object* %51, %struct.lean_object** %8, align 8
  %52 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_inc(%struct.lean_object* %52)
  %53 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %54 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %55 = call zeroext i8 @l_Lean_Syntax_isOfKind(%struct.lean_object* %53, %struct.lean_object* %54)
  store i8 %55, i8* %9, align 1
  %56 = load i8, i8* %9, align 1
  %57 = zext i8 %56 to i32
  %58 = icmp eq i32 %57, 0
  br i1 %58, label %59, label %69

59:                                               ; preds = %50
  %60 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %60)
  %61 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %61)
  %62 = call %struct.lean_object* @lean_box(i64 1)
  store %struct.lean_object* %62, %struct.lean_object** %10, align 8
  %63 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %63, %struct.lean_object** %11, align 8
  %64 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %65 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_ctor_set(%struct.lean_object* %64, i32 0, %struct.lean_object* %65)
  %66 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %67 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_ctor_set(%struct.lean_object* %66, i32 1, %struct.lean_object* %67)
  %68 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  store %struct.lean_object* %68, %struct.lean_object** %4, align 8
  br label %196

69:                                               ; preds = %50
  %70 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %70, %struct.lean_object** %12, align 8
  %71 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %72 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %73 = call %struct.lean_object* @l_Lean_Syntax_getArg(%struct.lean_object* %71, %struct.lean_object* %72)
  store %struct.lean_object* %73, %struct.lean_object** %13, align 8
  %74 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %74)
  %75 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %76 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %77 = call %struct.lean_object* @l_Lean_MonadRef_mkInfoFromRefPos___at_myMacro____x40_Init_Notation___hyg_109____spec__1(%struct.lean_object* %75, %struct.lean_object* %76)
  store %struct.lean_object* %77, %struct.lean_object** %14, align 8
  %78 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %79 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %78)
  %80 = xor i1 %79, true
  %81 = zext i1 %80 to i32
  %82 = trunc i32 %81 to i8
  store i8 %82, i8* %15, align 1
  %83 = load i8, i8* %15, align 1
  %84 = zext i8 %83 to i32
  %85 = icmp eq i32 %84, 0
  br i1 %85, label %86, label %137

86:                                               ; preds = %69
  %87 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %88 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %87, i32 0)
  store %struct.lean_object* %88, %struct.lean_object** %16, align 8
  %89 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %90 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %89, i32 2)
  store %struct.lean_object* %90, %struct.lean_object** %17, align 8
  %91 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_inc(%struct.lean_object* %91)
  %92 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %93 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %92, i32 1)
  store %struct.lean_object* %93, %struct.lean_object** %18, align 8
  %94 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_inc(%struct.lean_object* %94)
  %95 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %95)
  %96 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__7, align 8
  store %struct.lean_object* %96, %struct.lean_object** %19, align 8
  %97 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %98 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %99 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %100 = call %struct.lean_object* @l_Lean_addMacroScope(%struct.lean_object* %97, %struct.lean_object* %98, %struct.lean_object* %99)
  store %struct.lean_object* %100, %struct.lean_object** %20, align 8
  %101 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__3, align 8
  store %struct.lean_object* %101, %struct.lean_object** %21, align 8
  %102 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__9, align 8
  store %struct.lean_object* %102, %struct.lean_object** %22, align 8
  %103 = call %struct.lean_object* @lean_alloc_ctor(i32 3, i32 4, i32 0)
  store %struct.lean_object* %103, %struct.lean_object** %23, align 8
  %104 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %105 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  call void @lean_ctor_set(%struct.lean_object* %104, i32 0, %struct.lean_object* %105)
  %106 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %107 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_ctor_set(%struct.lean_object* %106, i32 1, %struct.lean_object* %107)
  %108 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %109 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_ctor_set(%struct.lean_object* %108, i32 2, %struct.lean_object* %109)
  %110 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %111 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  call void @lean_ctor_set(%struct.lean_object* %110, i32 3, %struct.lean_object* %111)
  %112 = load %struct.lean_object*, %struct.lean_object** @l_Array_empty___closed__1, align 8
  store %struct.lean_object* %112, %struct.lean_object** %24, align 8
  %113 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %114 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %115 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %113, %struct.lean_object* %114)
  store %struct.lean_object* %115, %struct.lean_object** %25, align 8
  %116 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %117 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %118 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %116, %struct.lean_object* %117)
  store %struct.lean_object* %118, %struct.lean_object** %26, align 8
  %119 = load %struct.lean_object*, %struct.lean_object** @l_Lean_nullKind___closed__2, align 8
  store %struct.lean_object* %119, %struct.lean_object** %27, align 8
  %120 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %120, %struct.lean_object** %28, align 8
  %121 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  %122 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  call void @lean_ctor_set(%struct.lean_object* %121, i32 0, %struct.lean_object* %122)
  %123 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  %124 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  call void @lean_ctor_set(%struct.lean_object* %123, i32 1, %struct.lean_object* %124)
  %125 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %126 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  %127 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %125, %struct.lean_object* %126)
  store %struct.lean_object* %127, %struct.lean_object** %29, align 8
  %128 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_Init_Notation___hyg_2191____closed__4, align 8
  store %struct.lean_object* %128, %struct.lean_object** %30, align 8
  %129 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %129, %struct.lean_object** %31, align 8
  %130 = load %struct.lean_object*, %struct.lean_object** %31, align 8
  %131 = load %struct.lean_object*, %struct.lean_object** %30, align 8
  call void @lean_ctor_set(%struct.lean_object* %130, i32 0, %struct.lean_object* %131)
  %132 = load %struct.lean_object*, %struct.lean_object** %31, align 8
  %133 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  call void @lean_ctor_set(%struct.lean_object* %132, i32 1, %struct.lean_object* %133)
  %134 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %135 = load %struct.lean_object*, %struct.lean_object** %31, align 8
  call void @lean_ctor_set(%struct.lean_object* %134, i32 0, %struct.lean_object* %135)
  %136 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  store %struct.lean_object* %136, %struct.lean_object** %4, align 8
  br label %196

137:                                              ; preds = %69
  %138 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %139 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %138, i32 0)
  store %struct.lean_object* %139, %struct.lean_object** %32, align 8
  %140 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %141 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %140, i32 1)
  store %struct.lean_object* %141, %struct.lean_object** %33, align 8
  %142 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  call void @lean_inc(%struct.lean_object* %142)
  %143 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  call void @lean_inc(%struct.lean_object* %143)
  %144 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  call void @lean_dec(%struct.lean_object* %144)
  %145 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %146 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %145, i32 2)
  store %struct.lean_object* %146, %struct.lean_object** %34, align 8
  %147 = load %struct.lean_object*, %struct.lean_object** %34, align 8
  call void @lean_inc(%struct.lean_object* %147)
  %148 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %149 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %148, i32 1)
  store %struct.lean_object* %149, %struct.lean_object** %35, align 8
  %150 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  call void @lean_inc(%struct.lean_object* %150)
  %151 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %151)
  %152 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__7, align 8
  store %struct.lean_object* %152, %struct.lean_object** %36, align 8
  %153 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %154 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  %155 = load %struct.lean_object*, %struct.lean_object** %34, align 8
  %156 = call %struct.lean_object* @l_Lean_addMacroScope(%struct.lean_object* %153, %struct.lean_object* %154, %struct.lean_object* %155)
  store %struct.lean_object* %156, %struct.lean_object** %37, align 8
  %157 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__3, align 8
  store %struct.lean_object* %157, %struct.lean_object** %38, align 8
  %158 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__9, align 8
  store %struct.lean_object* %158, %struct.lean_object** %39, align 8
  %159 = call %struct.lean_object* @lean_alloc_ctor(i32 3, i32 4, i32 0)
  store %struct.lean_object* %159, %struct.lean_object** %40, align 8
  %160 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %161 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  call void @lean_ctor_set(%struct.lean_object* %160, i32 0, %struct.lean_object* %161)
  %162 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %163 = load %struct.lean_object*, %struct.lean_object** %38, align 8
  call void @lean_ctor_set(%struct.lean_object* %162, i32 1, %struct.lean_object* %163)
  %164 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %165 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  call void @lean_ctor_set(%struct.lean_object* %164, i32 2, %struct.lean_object* %165)
  %166 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %167 = load %struct.lean_object*, %struct.lean_object** %39, align 8
  call void @lean_ctor_set(%struct.lean_object* %166, i32 3, %struct.lean_object* %167)
  %168 = load %struct.lean_object*, %struct.lean_object** @l_Array_empty___closed__1, align 8
  store %struct.lean_object* %168, %struct.lean_object** %41, align 8
  %169 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %170 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %171 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %169, %struct.lean_object* %170)
  store %struct.lean_object* %171, %struct.lean_object** %42, align 8
  %172 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %173 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %174 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %172, %struct.lean_object* %173)
  store %struct.lean_object* %174, %struct.lean_object** %43, align 8
  %175 = load %struct.lean_object*, %struct.lean_object** @l_Lean_nullKind___closed__2, align 8
  store %struct.lean_object* %175, %struct.lean_object** %44, align 8
  %176 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %176, %struct.lean_object** %45, align 8
  %177 = load %struct.lean_object*, %struct.lean_object** %45, align 8
  %178 = load %struct.lean_object*, %struct.lean_object** %44, align 8
  call void @lean_ctor_set(%struct.lean_object* %177, i32 0, %struct.lean_object* %178)
  %179 = load %struct.lean_object*, %struct.lean_object** %45, align 8
  %180 = load %struct.lean_object*, %struct.lean_object** %43, align 8
  call void @lean_ctor_set(%struct.lean_object* %179, i32 1, %struct.lean_object* %180)
  %181 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %182 = load %struct.lean_object*, %struct.lean_object** %45, align 8
  %183 = call %struct.lean_object* @lean_array_push(%struct.lean_object* %181, %struct.lean_object* %182)
  store %struct.lean_object* %183, %struct.lean_object** %46, align 8
  %184 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_Init_Notation___hyg_2191____closed__4, align 8
  store %struct.lean_object* %184, %struct.lean_object** %47, align 8
  %185 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %185, %struct.lean_object** %48, align 8
  %186 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %187 = load %struct.lean_object*, %struct.lean_object** %47, align 8
  call void @lean_ctor_set(%struct.lean_object* %186, i32 0, %struct.lean_object* %187)
  %188 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %189 = load %struct.lean_object*, %struct.lean_object** %46, align 8
  call void @lean_ctor_set(%struct.lean_object* %188, i32 1, %struct.lean_object* %189)
  %190 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %190, %struct.lean_object** %49, align 8
  %191 = load %struct.lean_object*, %struct.lean_object** %49, align 8
  %192 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  call void @lean_ctor_set(%struct.lean_object* %191, i32 0, %struct.lean_object* %192)
  %193 = load %struct.lean_object*, %struct.lean_object** %49, align 8
  %194 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  call void @lean_ctor_set(%struct.lean_object* %193, i32 1, %struct.lean_object* %194)
  %195 = load %struct.lean_object*, %struct.lean_object** %49, align 8
  store %struct.lean_object* %195, %struct.lean_object** %4, align 8
  br label %196

196:                                              ; preds = %137, %86, %59
  %197 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %197
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_inc(%struct.lean_object* %0) #0 {
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

declare zeroext i8 @l_Lean_Syntax_isOfKind(%struct.lean_object*, %struct.lean_object*) #1

declare %struct.lean_object* @l_Lean_Syntax_getArg(%struct.lean_object*, %struct.lean_object*) #1

declare %struct.lean_object* @l_Lean_MonadRef_mkInfoFromRefPos___at_myMacro____x40_Init_Notation___hyg_109____spec__1(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_exclusive(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_ctor_get(%struct.lean_object* %0, i32 %1) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.11, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 702, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_ctor_get, i64 0, i64 0)) #3
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

declare %struct.lean_object* @l_Lean_addMacroScope(%struct.lean_object*, %struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux_match__1___rarg(%struct.lean_object* %0, i32 %1, i32 %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  store %struct.lean_object* %3, %struct.lean_object** %8, align 8
  br label %12

12:                                               ; preds = %4
  %13 = load i32, i32* %6, align 4
  %14 = call %struct.lean_object* @lean_box_uint32(i32 %13)
  store %struct.lean_object* %14, %struct.lean_object** %9, align 8
  %15 = load i32, i32* %7, align 4
  %16 = call %struct.lean_object* @lean_box_uint32(i32 %15)
  store %struct.lean_object* %16, %struct.lean_object** %10, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %20 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %21 = call %struct.lean_object* @lean_apply_3(%struct.lean_object* %17, %struct.lean_object* %18, %struct.lean_object* %19, %struct.lean_object* %20)
  store %struct.lean_object* %21, %struct.lean_object** %11, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  ret %struct.lean_object* %22
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux_match__1(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  br label %6

6:                                                ; preds = %2
  %7 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l___private_qsort_0__partitionAux_match__1___rarg___boxed to i8*), i32 4, i32 0)
  store %struct.lean_object* %7, %struct.lean_object** %5, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %8
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux_match__1___rarg___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  store %struct.lean_object* %3, %struct.lean_object** %8, align 8
  br label %12

12:                                               ; preds = %4
  %13 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %14 = call i32 @lean_unbox_uint32(%struct.lean_object* %13)
  store i32 %14, i32* %9, align 4
  %15 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %15)
  %16 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %17 = call i32 @lean_unbox_uint32(%struct.lean_object* %16)
  store i32 %17, i32* %10, align 4
  %18 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec(%struct.lean_object* %18)
  %19 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %20 = load i32, i32* %9, align 4
  %21 = load i32, i32* %10, align 4
  %22 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %23 = call %struct.lean_object* @l___private_qsort_0__partitionAux_match__1___rarg(%struct.lean_object* %19, i32 %20, i32 %21, %struct.lean_object* %22)
  store %struct.lean_object* %23, %struct.lean_object** %11, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  ret %struct.lean_object* %24
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %0, %struct.lean_object* %1, i32 %2, %struct.lean_object* %3, %struct.lean_object* %4, i32 %5, i32 %6) #0 {
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i8, align 1
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca %struct.lean_object*, align 8
  %21 = alloca %struct.lean_object*, align 8
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca i8, align 1
  %25 = alloca i32, align 4
  %26 = alloca i32, align 4
  %27 = alloca %struct.lean_object*, align 8
  %28 = alloca %struct.lean_object*, align 8
  %29 = alloca i32, align 4
  %30 = alloca i32, align 4
  %31 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %8, align 8
  store %struct.lean_object* %1, %struct.lean_object** %9, align 8
  store i32 %2, i32* %10, align 4
  store %struct.lean_object* %3, %struct.lean_object** %11, align 8
  store %struct.lean_object* %4, %struct.lean_object** %12, align 8
  store i32 %5, i32* %13, align 4
  store i32 %6, i32* %14, align 4
  br label %32

32:                                               ; preds = %90, %84, %7
  %33 = load i32, i32* %14, align 4
  %34 = load i32, i32* %10, align 4
  %35 = icmp ult i32 %33, %34
  %36 = zext i1 %35 to i32
  %37 = trunc i32 %36 to i8
  store i8 %37, i8* %15, align 1
  %38 = load i8, i8* %15, align 1
  %39 = zext i8 %38 to i32
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %41, label %63

41:                                               ; preds = %32
  %42 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %42)
  %43 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_dec(%struct.lean_object* %43)
  %44 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_dec(%struct.lean_object* %44)
  %45 = load i32, i32* %13, align 4
  %46 = call %struct.lean_object* @lean_uint32_to_nat(i32 %45)
  store %struct.lean_object* %46, %struct.lean_object** %16, align 8
  %47 = load i32, i32* %10, align 4
  %48 = call %struct.lean_object* @lean_uint32_to_nat(i32 %47)
  store %struct.lean_object* %48, %struct.lean_object** %17, align 8
  %49 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %50 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %51 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %52 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %49, %struct.lean_object* %50, %struct.lean_object* %51)
  store %struct.lean_object* %52, %struct.lean_object** %18, align 8
  %53 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %53)
  %54 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  call void @lean_dec(%struct.lean_object* %54)
  %55 = load i32, i32* %13, align 4
  %56 = call %struct.lean_object* @lean_box_uint32(i32 %55)
  store %struct.lean_object* %56, %struct.lean_object** %19, align 8
  %57 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %57, %struct.lean_object** %20, align 8
  %58 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %59 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_ctor_set(%struct.lean_object* %58, i32 0, %struct.lean_object* %59)
  %60 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %61 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_ctor_set(%struct.lean_object* %60, i32 1, %struct.lean_object* %61)
  %62 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  ret %struct.lean_object* %62

63:                                               ; preds = %32
  %64 = load i32, i32* %14, align 4
  %65 = call %struct.lean_object* @lean_uint32_to_nat(i32 %64)
  store %struct.lean_object* %65, %struct.lean_object** %21, align 8
  %66 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_inc(%struct.lean_object* %66)
  %67 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %68 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %69 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %70 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %67, %struct.lean_object* %68, %struct.lean_object* %69)
  store %struct.lean_object* %70, %struct.lean_object** %22, align 8
  %71 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_inc(%struct.lean_object* %71)
  %72 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_inc(%struct.lean_object* %72)
  %73 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %74 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %75 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %76 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %73, %struct.lean_object* %74, %struct.lean_object* %75)
  store %struct.lean_object* %76, %struct.lean_object** %23, align 8
  %77 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %78 = call i64 @lean_unbox(%struct.lean_object* %77)
  %79 = trunc i64 %78 to i8
  store i8 %79, i8* %24, align 1
  %80 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  call void @lean_dec(%struct.lean_object* %80)
  %81 = load i8, i8* %24, align 1
  %82 = zext i8 %81 to i32
  %83 = icmp eq i32 %82, 0
  br i1 %83, label %84, label %90

84:                                               ; preds = %63
  %85 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %85)
  store i32 1, i32* %25, align 4
  %86 = load i32, i32* %14, align 4
  %87 = load i32, i32* %25, align 4
  %88 = add i32 %86, %87
  store i32 %88, i32* %26, align 4
  %89 = load i32, i32* %26, align 4
  store i32 %89, i32* %14, align 4
  br label %32

90:                                               ; preds = %63
  %91 = load i32, i32* %13, align 4
  %92 = call %struct.lean_object* @lean_uint32_to_nat(i32 %91)
  store %struct.lean_object* %92, %struct.lean_object** %27, align 8
  %93 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %94 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  %95 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %96 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %93, %struct.lean_object* %94, %struct.lean_object* %95)
  store %struct.lean_object* %96, %struct.lean_object** %28, align 8
  %97 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %97)
  %98 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  call void @lean_dec(%struct.lean_object* %98)
  store i32 1, i32* %29, align 4
  %99 = load i32, i32* %13, align 4
  %100 = load i32, i32* %29, align 4
  %101 = add i32 %99, %100
  store i32 %101, i32* %30, align 4
  %102 = load i32, i32* %14, align 4
  %103 = load i32, i32* %29, align 4
  %104 = add i32 %102, %103
  store i32 %104, i32* %31, align 4
  %105 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  store %struct.lean_object* %105, %struct.lean_object** %12, align 8
  %106 = load i32, i32* %30, align 4
  store i32 %106, i32* %13, align 4
  %107 = load i32, i32* %31, align 4
  store i32 %107, i32* %14, align 4
  br label %32
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i64 @lean_unbox(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = ptrtoint %struct.lean_object* %3 to i64
  %5 = lshr i64 %4, 1
  ret i64 %5
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l___private_qsort_0__partitionAux___rarg___boxed to i8*), i32 7, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux___rarg___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4, %struct.lean_object* %5, %struct.lean_object* %6) #0 {
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %8, align 8
  store %struct.lean_object* %1, %struct.lean_object** %9, align 8
  store %struct.lean_object* %2, %struct.lean_object** %10, align 8
  store %struct.lean_object* %3, %struct.lean_object** %11, align 8
  store %struct.lean_object* %4, %struct.lean_object** %12, align 8
  store %struct.lean_object* %5, %struct.lean_object** %13, align 8
  store %struct.lean_object* %6, %struct.lean_object** %14, align 8
  br label %19

19:                                               ; preds = %7
  %20 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %21 = call i32 @lean_unbox_uint32(%struct.lean_object* %20)
  store i32 %21, i32* %15, align 4
  %22 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %22)
  %23 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %24 = call i32 @lean_unbox_uint32(%struct.lean_object* %23)
  store i32 %24, i32* %16, align 4
  %25 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  call void @lean_dec(%struct.lean_object* %25)
  %26 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %27 = call i32 @lean_unbox_uint32(%struct.lean_object* %26)
  store i32 %27, i32* %17, align 4
  %28 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  call void @lean_dec(%struct.lean_object* %28)
  %29 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %30 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %31 = load i32, i32* %15, align 4
  %32 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %33 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %34 = load i32, i32* %16, align 4
  %35 = load i32, i32* %17, align 4
  %36 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %29, %struct.lean_object* %30, i32 %31, %struct.lean_object* %32, %struct.lean_object* %33, i32 %34, i32 %35)
  store %struct.lean_object* %36, %struct.lean_object** %18, align 8
  %37 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  ret %struct.lean_object* %37
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_partition___rarg(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, i32 %3, i32 %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca i8, align 1
  %21 = alloca %struct.lean_object*, align 8
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca %struct.lean_object*, align 8
  %27 = alloca i8, align 1
  %28 = alloca %struct.lean_object*, align 8
  %29 = alloca %struct.lean_object*, align 8
  %30 = alloca i8, align 1
  %31 = alloca %struct.lean_object*, align 8
  %32 = alloca %struct.lean_object*, align 8
  %33 = alloca %struct.lean_object*, align 8
  %34 = alloca %struct.lean_object*, align 8
  %35 = alloca %struct.lean_object*, align 8
  %36 = alloca %struct.lean_object*, align 8
  %37 = alloca %struct.lean_object*, align 8
  %38 = alloca %struct.lean_object*, align 8
  %39 = alloca i8, align 1
  %40 = alloca %struct.lean_object*, align 8
  %41 = alloca %struct.lean_object*, align 8
  %42 = alloca %struct.lean_object*, align 8
  %43 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %7, align 8
  store %struct.lean_object* %1, %struct.lean_object** %8, align 8
  store %struct.lean_object* %2, %struct.lean_object** %9, align 8
  store i32 %3, i32* %10, align 4
  store i32 %4, i32* %11, align 4
  br label %44

44:                                               ; preds = %5
  %45 = load i32, i32* %10, align 4
  %46 = load i32, i32* %11, align 4
  %47 = add i32 %45, %46
  store i32 %47, i32* %12, align 4
  store i32 2, i32* %13, align 4
  %48 = load i32, i32* %13, align 4
  %49 = icmp eq i32 %48, 0
  br i1 %49, label %50, label %51

50:                                               ; preds = %44
  br label %55

51:                                               ; preds = %44
  %52 = load i32, i32* %12, align 4
  %53 = load i32, i32* %13, align 4
  %54 = udiv i32 %52, %53
  br label %55

55:                                               ; preds = %51, %50
  %56 = phi i32 [ 0, %50 ], [ %54, %51 ]
  store i32 %56, i32* %14, align 4
  %57 = load i32, i32* %14, align 4
  %58 = call %struct.lean_object* @lean_uint32_to_nat(i32 %57)
  store %struct.lean_object* %58, %struct.lean_object** %15, align 8
  %59 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %59)
  %60 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %61 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %62 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %63 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %60, %struct.lean_object* %61, %struct.lean_object* %62)
  store %struct.lean_object* %63, %struct.lean_object** %16, align 8
  %64 = load i32, i32* %10, align 4
  %65 = call %struct.lean_object* @lean_uint32_to_nat(i32 %64)
  store %struct.lean_object* %65, %struct.lean_object** %17, align 8
  %66 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %66)
  %67 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %68 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %69 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %70 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %67, %struct.lean_object* %68, %struct.lean_object* %69)
  store %struct.lean_object* %70, %struct.lean_object** %18, align 8
  %71 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_inc(%struct.lean_object* %71)
  %72 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %73 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %74 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %75 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %72, %struct.lean_object* %73, %struct.lean_object* %74)
  store %struct.lean_object* %75, %struct.lean_object** %19, align 8
  %76 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %77 = call i64 @lean_unbox(%struct.lean_object* %76)
  %78 = trunc i64 %77 to i8
  store i8 %78, i8* %20, align 1
  %79 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_dec(%struct.lean_object* %79)
  %80 = load i32, i32* %11, align 4
  %81 = call %struct.lean_object* @lean_uint32_to_nat(i32 %80)
  store %struct.lean_object* %81, %struct.lean_object** %21, align 8
  %82 = load i8, i8* %20, align 1
  %83 = zext i8 %82 to i32
  %84 = icmp eq i32 %83, 0
  br i1 %84, label %85, label %87

85:                                               ; preds = %55
  %86 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  store %struct.lean_object* %86, %struct.lean_object** %22, align 8
  br label %93

87:                                               ; preds = %55
  %88 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %89 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %90 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %91 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %88, %struct.lean_object* %89, %struct.lean_object* %90)
  store %struct.lean_object* %91, %struct.lean_object** %23, align 8
  %92 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  store %struct.lean_object* %92, %struct.lean_object** %22, align 8
  br label %93

93:                                               ; preds = %87, %85
  %94 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %94)
  %95 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %96 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %97 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %98 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %95, %struct.lean_object* %96, %struct.lean_object* %97)
  store %struct.lean_object* %98, %struct.lean_object** %24, align 8
  %99 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %99)
  %100 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %101 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %102 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %103 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %100, %struct.lean_object* %101, %struct.lean_object* %102)
  store %struct.lean_object* %103, %struct.lean_object** %25, align 8
  %104 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_inc(%struct.lean_object* %104)
  %105 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  call void @lean_inc(%struct.lean_object* %105)
  %106 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %107 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %108 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %109 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %106, %struct.lean_object* %107, %struct.lean_object* %108)
  store %struct.lean_object* %109, %struct.lean_object** %26, align 8
  %110 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  %111 = call i64 @lean_unbox(%struct.lean_object* %110)
  %112 = trunc i64 %111 to i8
  store i8 %112, i8* %27, align 1
  %113 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  call void @lean_dec(%struct.lean_object* %113)
  %114 = load i8, i8* %27, align 1
  %115 = zext i8 %114 to i32
  %116 = icmp eq i32 %115, 0
  br i1 %116, label %117, label %171

117:                                              ; preds = %93
  %118 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %118)
  %119 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %119)
  %120 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %121 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %122 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %123 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %120, %struct.lean_object* %121, %struct.lean_object* %122)
  store %struct.lean_object* %123, %struct.lean_object** %28, align 8
  %124 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_inc(%struct.lean_object* %124)
  %125 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  call void @lean_inc(%struct.lean_object* %125)
  %126 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %127 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  %128 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %129 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %126, %struct.lean_object* %127, %struct.lean_object* %128)
  store %struct.lean_object* %129, %struct.lean_object** %29, align 8
  %130 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  %131 = call i64 @lean_unbox(%struct.lean_object* %130)
  %132 = trunc i64 %131 to i8
  store i8 %132, i8* %30, align 1
  %133 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  call void @lean_dec(%struct.lean_object* %133)
  %134 = load i8, i8* %30, align 1
  %135 = zext i8 %134 to i32
  %136 = icmp eq i32 %135, 0
  br i1 %136, label %137, label %149

137:                                              ; preds = %117
  %138 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %138)
  %139 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %139)
  %140 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %141 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %142 = load i32, i32* %11, align 4
  %143 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %144 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %145 = load i32, i32* %10, align 4
  %146 = load i32, i32* %10, align 4
  %147 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %140, %struct.lean_object* %141, i32 %142, %struct.lean_object* %143, %struct.lean_object* %144, i32 %145, i32 %146)
  store %struct.lean_object* %147, %struct.lean_object** %31, align 8
  %148 = load %struct.lean_object*, %struct.lean_object** %31, align 8
  store %struct.lean_object* %148, %struct.lean_object** %6, align 8
  br label %235

149:                                              ; preds = %117
  %150 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  call void @lean_dec(%struct.lean_object* %150)
  %151 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %152 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %153 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %154 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %151, %struct.lean_object* %152, %struct.lean_object* %153)
  store %struct.lean_object* %154, %struct.lean_object** %32, align 8
  %155 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %155)
  %156 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %156)
  %157 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %158 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  %159 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %160 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %157, %struct.lean_object* %158, %struct.lean_object* %159)
  store %struct.lean_object* %160, %struct.lean_object** %33, align 8
  %161 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %161)
  %162 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %163 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %164 = load i32, i32* %11, align 4
  %165 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  %166 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  %167 = load i32, i32* %10, align 4
  %168 = load i32, i32* %10, align 4
  %169 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %162, %struct.lean_object* %163, i32 %164, %struct.lean_object* %165, %struct.lean_object* %166, i32 %167, i32 %168)
  store %struct.lean_object* %169, %struct.lean_object** %34, align 8
  %170 = load %struct.lean_object*, %struct.lean_object** %34, align 8
  store %struct.lean_object* %170, %struct.lean_object** %6, align 8
  br label %235

171:                                              ; preds = %93
  %172 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  call void @lean_dec(%struct.lean_object* %172)
  %173 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %174 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %175 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %176 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %173, %struct.lean_object* %174, %struct.lean_object* %175)
  store %struct.lean_object* %176, %struct.lean_object** %35, align 8
  %177 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %177)
  %178 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %178)
  %179 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %180 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %181 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %182 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %179, %struct.lean_object* %180, %struct.lean_object* %181)
  store %struct.lean_object* %182, %struct.lean_object** %36, align 8
  %183 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %183)
  %184 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %185 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %186 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %187 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %184, %struct.lean_object* %185, %struct.lean_object* %186)
  store %struct.lean_object* %187, %struct.lean_object** %37, align 8
  %188 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_inc(%struct.lean_object* %188)
  %189 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  call void @lean_inc(%struct.lean_object* %189)
  %190 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %191 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  %192 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  %193 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %190, %struct.lean_object* %191, %struct.lean_object* %192)
  store %struct.lean_object* %193, %struct.lean_object** %38, align 8
  %194 = load %struct.lean_object*, %struct.lean_object** %38, align 8
  %195 = call i64 @lean_unbox(%struct.lean_object* %194)
  %196 = trunc i64 %195 to i8
  store i8 %196, i8* %39, align 1
  %197 = load %struct.lean_object*, %struct.lean_object** %38, align 8
  call void @lean_dec(%struct.lean_object* %197)
  %198 = load i8, i8* %39, align 1
  %199 = zext i8 %198 to i32
  %200 = icmp eq i32 %199, 0
  br i1 %200, label %201, label %213

201:                                              ; preds = %171
  %202 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %202)
  %203 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %203)
  %204 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %205 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %206 = load i32, i32* %11, align 4
  %207 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  %208 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %209 = load i32, i32* %10, align 4
  %210 = load i32, i32* %10, align 4
  %211 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %204, %struct.lean_object* %205, i32 %206, %struct.lean_object* %207, %struct.lean_object* %208, i32 %209, i32 %210)
  store %struct.lean_object* %211, %struct.lean_object** %40, align 8
  %212 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  store %struct.lean_object* %212, %struct.lean_object** %6, align 8
  br label %235

213:                                              ; preds = %171
  %214 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  call void @lean_dec(%struct.lean_object* %214)
  %215 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %216 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %217 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %218 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %215, %struct.lean_object* %216, %struct.lean_object* %217)
  store %struct.lean_object* %218, %struct.lean_object** %41, align 8
  %219 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %219)
  %220 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %220)
  %221 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %222 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %223 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %224 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %221, %struct.lean_object* %222, %struct.lean_object* %223)
  store %struct.lean_object* %224, %struct.lean_object** %42, align 8
  %225 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %225)
  %226 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %227 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %228 = load i32, i32* %11, align 4
  %229 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %230 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %231 = load i32, i32* %10, align 4
  %232 = load i32, i32* %10, align 4
  %233 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %226, %struct.lean_object* %227, i32 %228, %struct.lean_object* %229, %struct.lean_object* %230, i32 %231, i32 %232)
  store %struct.lean_object* %233, %struct.lean_object** %43, align 8
  %234 = load %struct.lean_object*, %struct.lean_object** %43, align 8
  store %struct.lean_object* %234, %struct.lean_object** %6, align 8
  br label %235

235:                                              ; preds = %213, %201, %149, %137
  %236 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  ret %struct.lean_object* %236
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_partition(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l_partition___rarg___boxed to i8*), i32 5, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_partition___rarg___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store %struct.lean_object* %3, %struct.lean_object** %9, align 8
  store %struct.lean_object* %4, %struct.lean_object** %10, align 8
  br label %14

14:                                               ; preds = %5
  %15 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %16 = call i32 @lean_unbox_uint32(%struct.lean_object* %15)
  store i32 %16, i32* %11, align 4
  %17 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_dec(%struct.lean_object* %17)
  %18 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %19 = call i32 @lean_unbox_uint32(%struct.lean_object* %18)
  store i32 %19, i32* %12, align 4
  %20 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %20)
  %21 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %24 = load i32, i32* %11, align 4
  %25 = load i32, i32* %12, align 4
  %26 = call %struct.lean_object* @l_partition___rarg(%struct.lean_object* %21, %struct.lean_object* %22, %struct.lean_object* %23, i32 %24, i32 %25)
  store %struct.lean_object* %26, %struct.lean_object** %13, align 8
  %27 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  ret %struct.lean_object* %27
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, i32 %3, i32 %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i8, align 1
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca i8, align 1
  %21 = alloca %struct.lean_object*, align 8
  %22 = alloca i32, align 4
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca %struct.lean_object*, align 8
  %27 = alloca %struct.lean_object*, align 8
  %28 = alloca i8, align 1
  %29 = alloca %struct.lean_object*, align 8
  %30 = alloca %struct.lean_object*, align 8
  %31 = alloca i8, align 1
  %32 = alloca %struct.lean_object*, align 8
  %33 = alloca %struct.lean_object*, align 8
  %34 = alloca %struct.lean_object*, align 8
  %35 = alloca i32, align 4
  %36 = alloca %struct.lean_object*, align 8
  %37 = alloca i32, align 4
  %38 = alloca i32, align 4
  %39 = alloca %struct.lean_object*, align 8
  %40 = alloca %struct.lean_object*, align 8
  %41 = alloca %struct.lean_object*, align 8
  %42 = alloca %struct.lean_object*, align 8
  %43 = alloca %struct.lean_object*, align 8
  %44 = alloca i32, align 4
  %45 = alloca %struct.lean_object*, align 8
  %46 = alloca i32, align 4
  %47 = alloca i32, align 4
  %48 = alloca %struct.lean_object*, align 8
  %49 = alloca %struct.lean_object*, align 8
  %50 = alloca %struct.lean_object*, align 8
  %51 = alloca %struct.lean_object*, align 8
  %52 = alloca i8, align 1
  %53 = alloca %struct.lean_object*, align 8
  %54 = alloca %struct.lean_object*, align 8
  %55 = alloca %struct.lean_object*, align 8
  %56 = alloca i32, align 4
  %57 = alloca %struct.lean_object*, align 8
  %58 = alloca i32, align 4
  %59 = alloca i32, align 4
  %60 = alloca %struct.lean_object*, align 8
  %61 = alloca %struct.lean_object*, align 8
  %62 = alloca %struct.lean_object*, align 8
  %63 = alloca %struct.lean_object*, align 8
  %64 = alloca %struct.lean_object*, align 8
  %65 = alloca i32, align 4
  %66 = alloca %struct.lean_object*, align 8
  %67 = alloca i32, align 4
  %68 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  br label %69

69:                                               ; preds = %329, %291, %213, %175, %5
  %70 = load i32, i32* %9, align 4
  %71 = load i32, i32* %10, align 4
  %72 = icmp ult i32 %70, %71
  %73 = zext i1 %72 to i32
  %74 = trunc i32 %73 to i8
  store i8 %74, i8* %11, align 1
  %75 = load i8, i8* %11, align 1
  %76 = zext i8 %75 to i32
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %78, label %82

78:                                               ; preds = %69
  %79 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec(%struct.lean_object* %79)
  %80 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %80)
  %81 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  ret %struct.lean_object* %81

82:                                               ; preds = %69
  %83 = load i32, i32* %9, align 4
  %84 = load i32, i32* %10, align 4
  %85 = add i32 %83, %84
  store i32 %85, i32* %12, align 4
  store i32 2, i32* %13, align 4
  %86 = load i32, i32* %13, align 4
  %87 = icmp eq i32 %86, 0
  br i1 %87, label %88, label %89

88:                                               ; preds = %82
  br label %93

89:                                               ; preds = %82
  %90 = load i32, i32* %12, align 4
  %91 = load i32, i32* %13, align 4
  %92 = udiv i32 %90, %91
  br label %93

93:                                               ; preds = %89, %88
  %94 = phi i32 [ 0, %88 ], [ %92, %89 ]
  store i32 %94, i32* %14, align 4
  %95 = load i32, i32* %14, align 4
  %96 = call %struct.lean_object* @lean_uint32_to_nat(i32 %95)
  store %struct.lean_object* %96, %struct.lean_object** %15, align 8
  %97 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %97)
  %98 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %99 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %100 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %101 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %98, %struct.lean_object* %99, %struct.lean_object* %100)
  store %struct.lean_object* %101, %struct.lean_object** %16, align 8
  %102 = load i32, i32* %9, align 4
  %103 = call %struct.lean_object* @lean_uint32_to_nat(i32 %102)
  store %struct.lean_object* %103, %struct.lean_object** %17, align 8
  %104 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %104)
  %105 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %106 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %107 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %108 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %105, %struct.lean_object* %106, %struct.lean_object* %107)
  store %struct.lean_object* %108, %struct.lean_object** %18, align 8
  %109 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %109)
  %110 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %111 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %112 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %113 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %110, %struct.lean_object* %111, %struct.lean_object* %112)
  store %struct.lean_object* %113, %struct.lean_object** %19, align 8
  %114 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %115 = call i64 @lean_unbox(%struct.lean_object* %114)
  %116 = trunc i64 %115 to i8
  store i8 %116, i8* %20, align 1
  %117 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_dec(%struct.lean_object* %117)
  %118 = load i32, i32* %10, align 4
  %119 = call %struct.lean_object* @lean_uint32_to_nat(i32 %118)
  store %struct.lean_object* %119, %struct.lean_object** %21, align 8
  store i32 1, i32* %22, align 4
  %120 = load i8, i8* %20, align 1
  %121 = zext i8 %120 to i32
  %122 = icmp eq i32 %121, 0
  br i1 %122, label %123, label %125

123:                                              ; preds = %93
  %124 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  store %struct.lean_object* %124, %struct.lean_object** %23, align 8
  br label %131

125:                                              ; preds = %93
  %126 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %127 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %128 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %129 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %126, %struct.lean_object* %127, %struct.lean_object* %128)
  store %struct.lean_object* %129, %struct.lean_object** %24, align 8
  %130 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  store %struct.lean_object* %130, %struct.lean_object** %23, align 8
  br label %131

131:                                              ; preds = %125, %123
  %132 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %132)
  %133 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %134 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %135 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %136 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %133, %struct.lean_object* %134, %struct.lean_object* %135)
  store %struct.lean_object* %136, %struct.lean_object** %25, align 8
  %137 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %137)
  %138 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %139 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %140 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %141 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %138, %struct.lean_object* %139, %struct.lean_object* %140)
  store %struct.lean_object* %141, %struct.lean_object** %26, align 8
  %142 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %142)
  %143 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_inc(%struct.lean_object* %143)
  %144 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %145 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %146 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  %147 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %144, %struct.lean_object* %145, %struct.lean_object* %146)
  store %struct.lean_object* %147, %struct.lean_object** %27, align 8
  %148 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  %149 = call i64 @lean_unbox(%struct.lean_object* %148)
  %150 = trunc i64 %149 to i8
  store i8 %150, i8* %28, align 1
  %151 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  call void @lean_dec(%struct.lean_object* %151)
  %152 = load i8, i8* %28, align 1
  %153 = zext i8 %152 to i32
  %154 = icmp eq i32 %153, 0
  br i1 %154, label %155, label %261

155:                                              ; preds = %131
  %156 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %156)
  %157 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %157)
  %158 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %159 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %160 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %161 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %158, %struct.lean_object* %159, %struct.lean_object* %160)
  store %struct.lean_object* %161, %struct.lean_object** %29, align 8
  %162 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %162)
  %163 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_inc(%struct.lean_object* %163)
  %164 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %165 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  %166 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %167 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %164, %struct.lean_object* %165, %struct.lean_object* %166)
  store %struct.lean_object* %167, %struct.lean_object** %30, align 8
  %168 = load %struct.lean_object*, %struct.lean_object** %30, align 8
  %169 = call i64 @lean_unbox(%struct.lean_object* %168)
  %170 = trunc i64 %169 to i8
  store i8 %170, i8* %31, align 1
  %171 = load %struct.lean_object*, %struct.lean_object** %30, align 8
  call void @lean_dec(%struct.lean_object* %171)
  %172 = load i8, i8* %31, align 1
  %173 = zext i8 %172 to i32
  %174 = icmp eq i32 %173, 0
  br i1 %174, label %175, label %213

175:                                              ; preds = %155
  %176 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %176)
  %177 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %177)
  %178 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %178)
  %179 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %179)
  %180 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %181 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %182 = load i32, i32* %10, align 4
  %183 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %184 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %185 = load i32, i32* %9, align 4
  %186 = load i32, i32* %9, align 4
  %187 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %180, %struct.lean_object* %181, i32 %182, %struct.lean_object* %183, %struct.lean_object* %184, i32 %185, i32 %186)
  store %struct.lean_object* %187, %struct.lean_object** %32, align 8
  %188 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  %189 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %188, i32 0)
  store %struct.lean_object* %189, %struct.lean_object** %33, align 8
  %190 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  call void @lean_inc(%struct.lean_object* %190)
  %191 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  %192 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %191, i32 1)
  store %struct.lean_object* %192, %struct.lean_object** %34, align 8
  %193 = load %struct.lean_object*, %struct.lean_object** %34, align 8
  call void @lean_inc(%struct.lean_object* %193)
  %194 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  call void @lean_dec(%struct.lean_object* %194)
  %195 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  %196 = call i32 @lean_unbox_uint32(%struct.lean_object* %195)
  store i32 %196, i32* %35, align 4
  %197 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %197)
  %198 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %198)
  %199 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %200 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %201 = load %struct.lean_object*, %struct.lean_object** %34, align 8
  %202 = load i32, i32* %9, align 4
  %203 = load i32, i32* %35, align 4
  %204 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %199, %struct.lean_object* %200, %struct.lean_object* %201, i32 %202, i32 %203)
  store %struct.lean_object* %204, %struct.lean_object** %36, align 8
  %205 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  %206 = call i32 @lean_unbox_uint32(%struct.lean_object* %205)
  store i32 %206, i32* %37, align 4
  %207 = load %struct.lean_object*, %struct.lean_object** %33, align 8
  call void @lean_dec(%struct.lean_object* %207)
  %208 = load i32, i32* %37, align 4
  %209 = load i32, i32* %22, align 4
  %210 = add i32 %208, %209
  store i32 %210, i32* %38, align 4
  %211 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  store %struct.lean_object* %211, %struct.lean_object** %8, align 8
  %212 = load i32, i32* %38, align 4
  store i32 %212, i32* %9, align 4
  br label %69

213:                                              ; preds = %155
  %214 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_dec(%struct.lean_object* %214)
  %215 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %216 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %217 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %218 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %215, %struct.lean_object* %216, %struct.lean_object* %217)
  store %struct.lean_object* %218, %struct.lean_object** %39, align 8
  %219 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %219)
  %220 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %220)
  %221 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %222 = load %struct.lean_object*, %struct.lean_object** %39, align 8
  %223 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %224 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %221, %struct.lean_object* %222, %struct.lean_object* %223)
  store %struct.lean_object* %224, %struct.lean_object** %40, align 8
  %225 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %225)
  %226 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %226)
  %227 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %227)
  %228 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %229 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %230 = load i32, i32* %10, align 4
  %231 = load %struct.lean_object*, %struct.lean_object** %40, align 8
  %232 = load %struct.lean_object*, %struct.lean_object** %39, align 8
  %233 = load i32, i32* %9, align 4
  %234 = load i32, i32* %9, align 4
  %235 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %228, %struct.lean_object* %229, i32 %230, %struct.lean_object* %231, %struct.lean_object* %232, i32 %233, i32 %234)
  store %struct.lean_object* %235, %struct.lean_object** %41, align 8
  %236 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %237 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %236, i32 0)
  store %struct.lean_object* %237, %struct.lean_object** %42, align 8
  %238 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  call void @lean_inc(%struct.lean_object* %238)
  %239 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  %240 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %239, i32 1)
  store %struct.lean_object* %240, %struct.lean_object** %43, align 8
  %241 = load %struct.lean_object*, %struct.lean_object** %43, align 8
  call void @lean_inc(%struct.lean_object* %241)
  %242 = load %struct.lean_object*, %struct.lean_object** %41, align 8
  call void @lean_dec(%struct.lean_object* %242)
  %243 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %244 = call i32 @lean_unbox_uint32(%struct.lean_object* %243)
  store i32 %244, i32* %44, align 4
  %245 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %245)
  %246 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %246)
  %247 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %248 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %249 = load %struct.lean_object*, %struct.lean_object** %43, align 8
  %250 = load i32, i32* %9, align 4
  %251 = load i32, i32* %44, align 4
  %252 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %247, %struct.lean_object* %248, %struct.lean_object* %249, i32 %250, i32 %251)
  store %struct.lean_object* %252, %struct.lean_object** %45, align 8
  %253 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %254 = call i32 @lean_unbox_uint32(%struct.lean_object* %253)
  store i32 %254, i32* %46, align 4
  %255 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  call void @lean_dec(%struct.lean_object* %255)
  %256 = load i32, i32* %46, align 4
  %257 = load i32, i32* %22, align 4
  %258 = add i32 %256, %257
  store i32 %258, i32* %47, align 4
  %259 = load %struct.lean_object*, %struct.lean_object** %45, align 8
  store %struct.lean_object* %259, %struct.lean_object** %8, align 8
  %260 = load i32, i32* %47, align 4
  store i32 %260, i32* %9, align 4
  br label %69

261:                                              ; preds = %131
  %262 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_dec(%struct.lean_object* %262)
  %263 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  %264 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %265 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %266 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %263, %struct.lean_object* %264, %struct.lean_object* %265)
  store %struct.lean_object* %266, %struct.lean_object** %48, align 8
  %267 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %267)
  %268 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %268)
  %269 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %270 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %271 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %272 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %269, %struct.lean_object* %270, %struct.lean_object* %271)
  store %struct.lean_object* %272, %struct.lean_object** %49, align 8
  %273 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %273)
  %274 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %275 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %276 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %277 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %274, %struct.lean_object* %275, %struct.lean_object* %276)
  store %struct.lean_object* %277, %struct.lean_object** %50, align 8
  %278 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %278)
  %279 = load %struct.lean_object*, %struct.lean_object** %50, align 8
  call void @lean_inc(%struct.lean_object* %279)
  %280 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %281 = load %struct.lean_object*, %struct.lean_object** %49, align 8
  %282 = load %struct.lean_object*, %struct.lean_object** %50, align 8
  %283 = call %struct.lean_object* @lean_apply_2(%struct.lean_object* %280, %struct.lean_object* %281, %struct.lean_object* %282)
  store %struct.lean_object* %283, %struct.lean_object** %51, align 8
  %284 = load %struct.lean_object*, %struct.lean_object** %51, align 8
  %285 = call i64 @lean_unbox(%struct.lean_object* %284)
  %286 = trunc i64 %285 to i8
  store i8 %286, i8* %52, align 1
  %287 = load %struct.lean_object*, %struct.lean_object** %51, align 8
  call void @lean_dec(%struct.lean_object* %287)
  %288 = load i8, i8* %52, align 1
  %289 = zext i8 %288 to i32
  %290 = icmp eq i32 %289, 0
  br i1 %290, label %291, label %329

291:                                              ; preds = %261
  %292 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %292)
  %293 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %293)
  %294 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %294)
  %295 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %295)
  %296 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %297 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %298 = load i32, i32* %10, align 4
  %299 = load %struct.lean_object*, %struct.lean_object** %50, align 8
  %300 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %301 = load i32, i32* %9, align 4
  %302 = load i32, i32* %9, align 4
  %303 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %296, %struct.lean_object* %297, i32 %298, %struct.lean_object* %299, %struct.lean_object* %300, i32 %301, i32 %302)
  store %struct.lean_object* %303, %struct.lean_object** %53, align 8
  %304 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %305 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %304, i32 0)
  store %struct.lean_object* %305, %struct.lean_object** %54, align 8
  %306 = load %struct.lean_object*, %struct.lean_object** %54, align 8
  call void @lean_inc(%struct.lean_object* %306)
  %307 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %308 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %307, i32 1)
  store %struct.lean_object* %308, %struct.lean_object** %55, align 8
  %309 = load %struct.lean_object*, %struct.lean_object** %55, align 8
  call void @lean_inc(%struct.lean_object* %309)
  %310 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  call void @lean_dec(%struct.lean_object* %310)
  %311 = load %struct.lean_object*, %struct.lean_object** %54, align 8
  %312 = call i32 @lean_unbox_uint32(%struct.lean_object* %311)
  store i32 %312, i32* %56, align 4
  %313 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %313)
  %314 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %314)
  %315 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %316 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %317 = load %struct.lean_object*, %struct.lean_object** %55, align 8
  %318 = load i32, i32* %9, align 4
  %319 = load i32, i32* %56, align 4
  %320 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %315, %struct.lean_object* %316, %struct.lean_object* %317, i32 %318, i32 %319)
  store %struct.lean_object* %320, %struct.lean_object** %57, align 8
  %321 = load %struct.lean_object*, %struct.lean_object** %54, align 8
  %322 = call i32 @lean_unbox_uint32(%struct.lean_object* %321)
  store i32 %322, i32* %58, align 4
  %323 = load %struct.lean_object*, %struct.lean_object** %54, align 8
  call void @lean_dec(%struct.lean_object* %323)
  %324 = load i32, i32* %58, align 4
  %325 = load i32, i32* %22, align 4
  %326 = add i32 %324, %325
  store i32 %326, i32* %59, align 4
  %327 = load %struct.lean_object*, %struct.lean_object** %57, align 8
  store %struct.lean_object* %327, %struct.lean_object** %8, align 8
  %328 = load i32, i32* %59, align 4
  store i32 %328, i32* %9, align 4
  br label %69

329:                                              ; preds = %261
  %330 = load %struct.lean_object*, %struct.lean_object** %50, align 8
  call void @lean_dec(%struct.lean_object* %330)
  %331 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %332 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %333 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %334 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %331, %struct.lean_object* %332, %struct.lean_object* %333)
  store %struct.lean_object* %334, %struct.lean_object** %60, align 8
  %335 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %335)
  %336 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %336)
  %337 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %338 = load %struct.lean_object*, %struct.lean_object** %60, align 8
  %339 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %340 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %337, %struct.lean_object* %338, %struct.lean_object* %339)
  store %struct.lean_object* %340, %struct.lean_object** %61, align 8
  %341 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %341)
  %342 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %342)
  %343 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %343)
  %344 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %345 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %346 = load i32, i32* %10, align 4
  %347 = load %struct.lean_object*, %struct.lean_object** %61, align 8
  %348 = load %struct.lean_object*, %struct.lean_object** %60, align 8
  %349 = load i32, i32* %9, align 4
  %350 = load i32, i32* %9, align 4
  %351 = call %struct.lean_object* @l___private_qsort_0__partitionAux___rarg(%struct.lean_object* %344, %struct.lean_object* %345, i32 %346, %struct.lean_object* %347, %struct.lean_object* %348, i32 %349, i32 %350)
  store %struct.lean_object* %351, %struct.lean_object** %62, align 8
  %352 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  %353 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %352, i32 0)
  store %struct.lean_object* %353, %struct.lean_object** %63, align 8
  %354 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  call void @lean_inc(%struct.lean_object* %354)
  %355 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  %356 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %355, i32 1)
  store %struct.lean_object* %356, %struct.lean_object** %64, align 8
  %357 = load %struct.lean_object*, %struct.lean_object** %64, align 8
  call void @lean_inc(%struct.lean_object* %357)
  %358 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  call void @lean_dec(%struct.lean_object* %358)
  %359 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  %360 = call i32 @lean_unbox_uint32(%struct.lean_object* %359)
  store i32 %360, i32* %65, align 4
  %361 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %361)
  %362 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %362)
  %363 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %364 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %365 = load %struct.lean_object*, %struct.lean_object** %64, align 8
  %366 = load i32, i32* %9, align 4
  %367 = load i32, i32* %65, align 4
  %368 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %363, %struct.lean_object* %364, %struct.lean_object* %365, i32 %366, i32 %367)
  store %struct.lean_object* %368, %struct.lean_object** %66, align 8
  %369 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  %370 = call i32 @lean_unbox_uint32(%struct.lean_object* %369)
  store i32 %370, i32* %67, align 4
  %371 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  call void @lean_dec(%struct.lean_object* %371)
  %372 = load i32, i32* %67, align 4
  %373 = load i32, i32* %22, align 4
  %374 = add i32 %372, %373
  store i32 %374, i32* %68, align 4
  %375 = load %struct.lean_object*, %struct.lean_object** %66, align 8
  store %struct.lean_object* %375, %struct.lean_object** %8, align 8
  %376 = load i32, i32* %68, align 4
  store i32 %376, i32* %9, align 4
  br label %69
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsortAux(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l_qsortAux___rarg___boxed to i8*), i32 5, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsortAux___rarg___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store %struct.lean_object* %3, %struct.lean_object** %9, align 8
  store %struct.lean_object* %4, %struct.lean_object** %10, align 8
  br label %14

14:                                               ; preds = %5
  %15 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %16 = call i32 @lean_unbox_uint32(%struct.lean_object* %15)
  store i32 %16, i32* %11, align 4
  %17 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_dec(%struct.lean_object* %17)
  %18 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %19 = call i32 @lean_unbox_uint32(%struct.lean_object* %18)
  store i32 %19, i32* %12, align 4
  %20 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %20)
  %21 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %23 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %24 = load i32, i32* %11, align 4
  %25 = load i32, i32* %12, align 4
  %26 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %21, %struct.lean_object* %22, %struct.lean_object* %23, i32 %24, i32 %25)
  store %struct.lean_object* %26, %struct.lean_object** %13, align 8
  %27 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  ret %struct.lean_object* %27
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsort___rarg(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca i32, align 4
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %13

13:                                               ; preds = %3
  store i32 0, i32* %7, align 4
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %15 = call %struct.lean_object* @lean_array_get_size(%struct.lean_object* %14)
  store %struct.lean_object* %15, %struct.lean_object** %8, align 8
  %16 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %16, %struct.lean_object** %9, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %19 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %17, %struct.lean_object* %18)
  store %struct.lean_object* %19, %struct.lean_object** %10, align 8
  %20 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_dec(%struct.lean_object* %20)
  %21 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %22 = call i32 @lean_uint32_of_nat(%struct.lean_object* %21)
  store i32 %22, i32* %11, align 4
  %23 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %23)
  %24 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %26 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %27 = load i32, i32* %7, align 4
  %28 = load i32, i32* %11, align 4
  %29 = call %struct.lean_object* @l_qsortAux___rarg(%struct.lean_object* %24, %struct.lean_object* %25, %struct.lean_object* %26, i32 %27, i32 %28)
  store %struct.lean_object* %29, %struct.lean_object** %12, align 8
  %30 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  ret %struct.lean_object* %30
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsort(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = call %struct.lean_object* @lean_alloc_closure(i8* bitcast (%struct.lean_object* (%struct.lean_object*, %struct.lean_object*, %struct.lean_object*)* @l_qsort___rarg to i8*), i32 3, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %3, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_List_head_x21___at_main___spec__1(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  br label %8

8:                                                ; preds = %1
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = call i32 @lean_obj_tag(%struct.lean_object* %9)
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %19

12:                                               ; preds = %8
  %13 = load %struct.lean_object*, %struct.lean_object** @l_String_instInhabitedString, align 8
  store %struct.lean_object* %13, %struct.lean_object** %4, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** @l_List_head_x21___rarg___closed__3, align 8
  store %struct.lean_object* %14, %struct.lean_object** %5, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %17 = call %struct.lean_object* @lean_panic_fn(%struct.lean_object* %15, %struct.lean_object* %16)
  store %struct.lean_object* %17, %struct.lean_object** %6, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  store %struct.lean_object* %18, %struct.lean_object** %2, align 8
  br label %24

19:                                               ; preds = %8
  %20 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %21 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %20, i32 0)
  store %struct.lean_object* %21, %struct.lean_object** %7, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_inc(%struct.lean_object* %22)
  %23 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  store %struct.lean_object* %23, %struct.lean_object** %2, align 8
  br label %24

24:                                               ; preds = %19, %12
  %25 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %25
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_obj_tag(%struct.lean_object* %0) #0 {
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

declare %struct.lean_object* @lean_panic_fn(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %0, i32 %1, %struct.lean_object* %2, i32 %3, i32 %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i8, align 1
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca i32, align 4
  %21 = alloca i8, align 1
  %22 = alloca i32, align 4
  %23 = alloca i32, align 4
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca i32, align 4
  %27 = alloca i32, align 4
  %28 = alloca i32, align 4
  store i32 %0, i32* %6, align 4
  store i32 %1, i32* %7, align 4
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  br label %29

29:                                               ; preds = %82, %76, %5
  %30 = load i32, i32* %10, align 4
  %31 = load i32, i32* %6, align 4
  %32 = icmp ult i32 %30, %31
  %33 = zext i1 %32 to i32
  %34 = trunc i32 %33 to i8
  store i8 %34, i8* %11, align 1
  %35 = load i8, i8* %11, align 1
  %36 = zext i8 %35 to i32
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %57

38:                                               ; preds = %29
  %39 = load i32, i32* %9, align 4
  %40 = call %struct.lean_object* @lean_uint32_to_nat(i32 %39)
  store %struct.lean_object* %40, %struct.lean_object** %12, align 8
  %41 = load i32, i32* %6, align 4
  %42 = call %struct.lean_object* @lean_uint32_to_nat(i32 %41)
  store %struct.lean_object* %42, %struct.lean_object** %13, align 8
  %43 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %44 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %45 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %46 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %43, %struct.lean_object* %44, %struct.lean_object* %45)
  store %struct.lean_object* %46, %struct.lean_object** %14, align 8
  %47 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  call void @lean_dec(%struct.lean_object* %47)
  %48 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  call void @lean_dec(%struct.lean_object* %48)
  %49 = load i32, i32* %9, align 4
  %50 = call %struct.lean_object* @lean_box_uint32(i32 %49)
  store %struct.lean_object* %50, %struct.lean_object** %15, align 8
  %51 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %51, %struct.lean_object** %16, align 8
  %52 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %53 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_ctor_set(%struct.lean_object* %52, i32 0, %struct.lean_object* %53)
  %54 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %55 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  call void @lean_ctor_set(%struct.lean_object* %54, i32 1, %struct.lean_object* %55)
  %56 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  ret %struct.lean_object* %56

57:                                               ; preds = %29
  %58 = load i32, i32* %10, align 4
  %59 = call %struct.lean_object* @lean_uint32_to_nat(i32 %58)
  store %struct.lean_object* %59, %struct.lean_object** %17, align 8
  %60 = load %struct.lean_object*, %struct.lean_object** @l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1, align 8
  store %struct.lean_object* %60, %struct.lean_object** %18, align 8
  %61 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %62 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %63 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %64 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %61, %struct.lean_object* %62, %struct.lean_object* %63)
  store %struct.lean_object* %64, %struct.lean_object** %19, align 8
  %65 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %66 = call i32 @lean_unbox_uint32(%struct.lean_object* %65)
  store i32 %66, i32* %20, align 4
  %67 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_dec(%struct.lean_object* %67)
  %68 = load i32, i32* %20, align 4
  %69 = load i32, i32* %7, align 4
  %70 = icmp ult i32 %68, %69
  %71 = zext i1 %70 to i32
  %72 = trunc i32 %71 to i8
  store i8 %72, i8* %21, align 1
  %73 = load i8, i8* %21, align 1
  %74 = zext i8 %73 to i32
  %75 = icmp eq i32 %74, 0
  br i1 %75, label %76, label %82

76:                                               ; preds = %57
  %77 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %77)
  store i32 1, i32* %22, align 4
  %78 = load i32, i32* %10, align 4
  %79 = load i32, i32* %22, align 4
  %80 = add i32 %78, %79
  store i32 %80, i32* %23, align 4
  %81 = load i32, i32* %23, align 4
  store i32 %81, i32* %10, align 4
  br label %29

82:                                               ; preds = %57
  %83 = load i32, i32* %9, align 4
  %84 = call %struct.lean_object* @lean_uint32_to_nat(i32 %83)
  store %struct.lean_object* %84, %struct.lean_object** %24, align 8
  %85 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %86 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %87 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %88 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %85, %struct.lean_object* %86, %struct.lean_object* %87)
  store %struct.lean_object* %88, %struct.lean_object** %25, align 8
  %89 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %89)
  %90 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  call void @lean_dec(%struct.lean_object* %90)
  store i32 1, i32* %26, align 4
  %91 = load i32, i32* %9, align 4
  %92 = load i32, i32* %26, align 4
  %93 = add i32 %91, %92
  store i32 %93, i32* %27, align 4
  %94 = load i32, i32* %10, align 4
  %95 = load i32, i32* %26, align 4
  %96 = add i32 %94, %95
  store i32 %96, i32* %28, align 4
  %97 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  store %struct.lean_object* %97, %struct.lean_object** %8, align 8
  %98 = load i32, i32* %27, align 4
  store i32 %98, i32* %9, align 4
  %99 = load i32, i32* %28, align 4
  store i32 %99, i32* %10, align 4
  br label %29
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %0, i32 %1, i32 %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca i32, align 4
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca i32, align 4
  %19 = alloca i8, align 1
  %20 = alloca %struct.lean_object*, align 8
  %21 = alloca i32, align 4
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca %struct.lean_object*, align 8
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca i32, align 4
  %27 = alloca %struct.lean_object*, align 8
  %28 = alloca %struct.lean_object*, align 8
  %29 = alloca i32, align 4
  %30 = alloca i8, align 1
  %31 = alloca %struct.lean_object*, align 8
  %32 = alloca %struct.lean_object*, align 8
  %33 = alloca i32, align 4
  %34 = alloca i8, align 1
  %35 = alloca %struct.lean_object*, align 8
  %36 = alloca %struct.lean_object*, align 8
  %37 = alloca %struct.lean_object*, align 8
  %38 = alloca i32, align 4
  %39 = alloca %struct.lean_object*, align 8
  %40 = alloca i32, align 4
  %41 = alloca i32, align 4
  %42 = alloca %struct.lean_object*, align 8
  %43 = alloca %struct.lean_object*, align 8
  %44 = alloca %struct.lean_object*, align 8
  %45 = alloca i32, align 4
  %46 = alloca %struct.lean_object*, align 8
  %47 = alloca %struct.lean_object*, align 8
  %48 = alloca %struct.lean_object*, align 8
  %49 = alloca i32, align 4
  %50 = alloca %struct.lean_object*, align 8
  %51 = alloca i32, align 4
  %52 = alloca i32, align 4
  %53 = alloca %struct.lean_object*, align 8
  %54 = alloca %struct.lean_object*, align 8
  %55 = alloca %struct.lean_object*, align 8
  %56 = alloca i32, align 4
  %57 = alloca %struct.lean_object*, align 8
  %58 = alloca %struct.lean_object*, align 8
  %59 = alloca i32, align 4
  %60 = alloca i8, align 1
  %61 = alloca %struct.lean_object*, align 8
  %62 = alloca %struct.lean_object*, align 8
  %63 = alloca %struct.lean_object*, align 8
  %64 = alloca i32, align 4
  %65 = alloca %struct.lean_object*, align 8
  %66 = alloca i32, align 4
  %67 = alloca i32, align 4
  %68 = alloca %struct.lean_object*, align 8
  %69 = alloca %struct.lean_object*, align 8
  %70 = alloca %struct.lean_object*, align 8
  %71 = alloca i32, align 4
  %72 = alloca %struct.lean_object*, align 8
  %73 = alloca %struct.lean_object*, align 8
  %74 = alloca %struct.lean_object*, align 8
  %75 = alloca i32, align 4
  %76 = alloca %struct.lean_object*, align 8
  %77 = alloca i32, align 4
  %78 = alloca i32, align 4
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  br label %79

79:                                               ; preds = %316, %286, %214, %184, %3
  %80 = load i32, i32* %5, align 4
  %81 = load i32, i32* %6, align 4
  %82 = icmp ult i32 %80, %81
  %83 = zext i1 %82 to i32
  %84 = trunc i32 %83 to i8
  store i8 %84, i8* %7, align 1
  %85 = load i8, i8* %7, align 1
  %86 = zext i8 %85 to i32
  %87 = icmp eq i32 %86, 0
  br i1 %87, label %88, label %90

88:                                               ; preds = %79
  %89 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %89

90:                                               ; preds = %79
  %91 = load i32, i32* %5, align 4
  %92 = load i32, i32* %6, align 4
  %93 = add i32 %91, %92
  store i32 %93, i32* %8, align 4
  store i32 2, i32* %9, align 4
  %94 = load i32, i32* %9, align 4
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %96, label %97

96:                                               ; preds = %90
  br label %101

97:                                               ; preds = %90
  %98 = load i32, i32* %8, align 4
  %99 = load i32, i32* %9, align 4
  %100 = udiv i32 %98, %99
  br label %101

101:                                              ; preds = %97, %96
  %102 = phi i32 [ 0, %96 ], [ %100, %97 ]
  store i32 %102, i32* %10, align 4
  %103 = load i32, i32* %10, align 4
  %104 = call %struct.lean_object* @lean_uint32_to_nat(i32 %103)
  store %struct.lean_object* %104, %struct.lean_object** %11, align 8
  %105 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %105, %struct.lean_object** %12, align 8
  %106 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %107 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %108 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %109 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %106, %struct.lean_object* %107, %struct.lean_object* %108)
  store %struct.lean_object* %109, %struct.lean_object** %13, align 8
  %110 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %111 = call i32 @lean_unbox_uint32(%struct.lean_object* %110)
  store i32 %111, i32* %14, align 4
  %112 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  call void @lean_dec(%struct.lean_object* %112)
  %113 = load i32, i32* %5, align 4
  %114 = call %struct.lean_object* @lean_uint32_to_nat(i32 %113)
  store %struct.lean_object* %114, %struct.lean_object** %15, align 8
  %115 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %115, %struct.lean_object** %16, align 8
  %116 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %117 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %118 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %119 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %116, %struct.lean_object* %117, %struct.lean_object* %118)
  store %struct.lean_object* %119, %struct.lean_object** %17, align 8
  %120 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  %121 = call i32 @lean_unbox_uint32(%struct.lean_object* %120)
  store i32 %121, i32* %18, align 4
  %122 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_dec(%struct.lean_object* %122)
  %123 = load i32, i32* %14, align 4
  %124 = load i32, i32* %18, align 4
  %125 = icmp ult i32 %123, %124
  %126 = zext i1 %125 to i32
  %127 = trunc i32 %126 to i8
  store i8 %127, i8* %19, align 1
  %128 = load i32, i32* %6, align 4
  %129 = call %struct.lean_object* @lean_uint32_to_nat(i32 %128)
  store %struct.lean_object* %129, %struct.lean_object** %20, align 8
  store i32 1, i32* %21, align 4
  %130 = load i8, i8* %19, align 1
  %131 = zext i8 %130 to i32
  %132 = icmp eq i32 %131, 0
  br i1 %132, label %133, label %135

133:                                              ; preds = %101
  %134 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %134, %struct.lean_object** %22, align 8
  br label %141

135:                                              ; preds = %101
  %136 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %137 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %138 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %139 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %136, %struct.lean_object* %137, %struct.lean_object* %138)
  store %struct.lean_object* %139, %struct.lean_object** %23, align 8
  %140 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  store %struct.lean_object* %140, %struct.lean_object** %22, align 8
  br label %141

141:                                              ; preds = %135, %133
  %142 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %142, %struct.lean_object** %24, align 8
  %143 = load %struct.lean_object*, %struct.lean_object** %24, align 8
  %144 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %145 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %146 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %143, %struct.lean_object* %144, %struct.lean_object* %145)
  store %struct.lean_object* %146, %struct.lean_object** %25, align 8
  %147 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  %148 = call i32 @lean_unbox_uint32(%struct.lean_object* %147)
  store i32 %148, i32* %26, align 4
  %149 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_dec(%struct.lean_object* %149)
  %150 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %150, %struct.lean_object** %27, align 8
  %151 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  %152 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %153 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %154 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %151, %struct.lean_object* %152, %struct.lean_object* %153)
  store %struct.lean_object* %154, %struct.lean_object** %28, align 8
  %155 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  %156 = call i32 @lean_unbox_uint32(%struct.lean_object* %155)
  store i32 %156, i32* %29, align 4
  %157 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  call void @lean_dec(%struct.lean_object* %157)
  %158 = load i32, i32* %26, align 4
  %159 = load i32, i32* %29, align 4
  %160 = icmp ult i32 %158, %159
  %161 = zext i1 %160 to i32
  %162 = trunc i32 %161 to i8
  store i8 %162, i8* %30, align 1
  %163 = load i8, i8* %30, align 1
  %164 = zext i8 %163 to i32
  %165 = icmp eq i32 %164, 0
  br i1 %165, label %166, label %256

166:                                              ; preds = %141
  %167 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %167)
  %168 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %168, %struct.lean_object** %31, align 8
  %169 = load %struct.lean_object*, %struct.lean_object** %31, align 8
  %170 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %171 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %172 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %169, %struct.lean_object* %170, %struct.lean_object* %171)
  store %struct.lean_object* %172, %struct.lean_object** %32, align 8
  %173 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  %174 = call i32 @lean_unbox_uint32(%struct.lean_object* %173)
  store i32 %174, i32* %33, align 4
  %175 = load %struct.lean_object*, %struct.lean_object** %32, align 8
  call void @lean_dec(%struct.lean_object* %175)
  %176 = load i32, i32* %33, align 4
  %177 = load i32, i32* %26, align 4
  %178 = icmp ult i32 %176, %177
  %179 = zext i1 %178 to i32
  %180 = trunc i32 %179 to i8
  store i8 %180, i8* %34, align 1
  %181 = load i8, i8* %34, align 1
  %182 = zext i8 %181 to i32
  %183 = icmp eq i32 %182, 0
  br i1 %183, label %184, label %214

184:                                              ; preds = %166
  %185 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_dec(%struct.lean_object* %185)
  %186 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %186)
  %187 = load i32, i32* %6, align 4
  %188 = load i32, i32* %26, align 4
  %189 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %190 = load i32, i32* %5, align 4
  %191 = load i32, i32* %5, align 4
  %192 = call %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %187, i32 %188, %struct.lean_object* %189, i32 %190, i32 %191)
  store %struct.lean_object* %192, %struct.lean_object** %35, align 8
  %193 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %194 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %193, i32 0)
  store %struct.lean_object* %194, %struct.lean_object** %36, align 8
  %195 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  call void @lean_inc(%struct.lean_object* %195)
  %196 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  %197 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %196, i32 1)
  store %struct.lean_object* %197, %struct.lean_object** %37, align 8
  %198 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  call void @lean_inc(%struct.lean_object* %198)
  %199 = load %struct.lean_object*, %struct.lean_object** %35, align 8
  call void @lean_dec(%struct.lean_object* %199)
  %200 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  %201 = call i32 @lean_unbox_uint32(%struct.lean_object* %200)
  store i32 %201, i32* %38, align 4
  %202 = load %struct.lean_object*, %struct.lean_object** %37, align 8
  %203 = load i32, i32* %5, align 4
  %204 = load i32, i32* %38, align 4
  %205 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %202, i32 %203, i32 %204)
  store %struct.lean_object* %205, %struct.lean_object** %39, align 8
  %206 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  %207 = call i32 @lean_unbox_uint32(%struct.lean_object* %206)
  store i32 %207, i32* %40, align 4
  %208 = load %struct.lean_object*, %struct.lean_object** %36, align 8
  call void @lean_dec(%struct.lean_object* %208)
  %209 = load i32, i32* %40, align 4
  %210 = load i32, i32* %21, align 4
  %211 = add i32 %209, %210
  store i32 %211, i32* %41, align 4
  %212 = load %struct.lean_object*, %struct.lean_object** %39, align 8
  store %struct.lean_object* %212, %struct.lean_object** %4, align 8
  %213 = load i32, i32* %41, align 4
  store i32 %213, i32* %5, align 4
  br label %79

214:                                              ; preds = %166
  %215 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %216 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %217 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %218 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %215, %struct.lean_object* %216, %struct.lean_object* %217)
  store %struct.lean_object* %218, %struct.lean_object** %42, align 8
  %219 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %219)
  %220 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %220, %struct.lean_object** %43, align 8
  %221 = load %struct.lean_object*, %struct.lean_object** %43, align 8
  %222 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %223 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %224 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %221, %struct.lean_object* %222, %struct.lean_object* %223)
  store %struct.lean_object* %224, %struct.lean_object** %44, align 8
  %225 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_dec(%struct.lean_object* %225)
  %226 = load %struct.lean_object*, %struct.lean_object** %44, align 8
  %227 = call i32 @lean_unbox_uint32(%struct.lean_object* %226)
  store i32 %227, i32* %45, align 4
  %228 = load %struct.lean_object*, %struct.lean_object** %44, align 8
  call void @lean_dec(%struct.lean_object* %228)
  %229 = load i32, i32* %6, align 4
  %230 = load i32, i32* %45, align 4
  %231 = load %struct.lean_object*, %struct.lean_object** %42, align 8
  %232 = load i32, i32* %5, align 4
  %233 = load i32, i32* %5, align 4
  %234 = call %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %229, i32 %230, %struct.lean_object* %231, i32 %232, i32 %233)
  store %struct.lean_object* %234, %struct.lean_object** %46, align 8
  %235 = load %struct.lean_object*, %struct.lean_object** %46, align 8
  %236 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %235, i32 0)
  store %struct.lean_object* %236, %struct.lean_object** %47, align 8
  %237 = load %struct.lean_object*, %struct.lean_object** %47, align 8
  call void @lean_inc(%struct.lean_object* %237)
  %238 = load %struct.lean_object*, %struct.lean_object** %46, align 8
  %239 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %238, i32 1)
  store %struct.lean_object* %239, %struct.lean_object** %48, align 8
  %240 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  call void @lean_inc(%struct.lean_object* %240)
  %241 = load %struct.lean_object*, %struct.lean_object** %46, align 8
  call void @lean_dec(%struct.lean_object* %241)
  %242 = load %struct.lean_object*, %struct.lean_object** %47, align 8
  %243 = call i32 @lean_unbox_uint32(%struct.lean_object* %242)
  store i32 %243, i32* %49, align 4
  %244 = load %struct.lean_object*, %struct.lean_object** %48, align 8
  %245 = load i32, i32* %5, align 4
  %246 = load i32, i32* %49, align 4
  %247 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %244, i32 %245, i32 %246)
  store %struct.lean_object* %247, %struct.lean_object** %50, align 8
  %248 = load %struct.lean_object*, %struct.lean_object** %47, align 8
  %249 = call i32 @lean_unbox_uint32(%struct.lean_object* %248)
  store i32 %249, i32* %51, align 4
  %250 = load %struct.lean_object*, %struct.lean_object** %47, align 8
  call void @lean_dec(%struct.lean_object* %250)
  %251 = load i32, i32* %51, align 4
  %252 = load i32, i32* %21, align 4
  %253 = add i32 %251, %252
  store i32 %253, i32* %52, align 4
  %254 = load %struct.lean_object*, %struct.lean_object** %50, align 8
  store %struct.lean_object* %254, %struct.lean_object** %4, align 8
  %255 = load i32, i32* %52, align 4
  store i32 %255, i32* %5, align 4
  br label %79

256:                                              ; preds = %141
  %257 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %258 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %259 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %260 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %257, %struct.lean_object* %258, %struct.lean_object* %259)
  store %struct.lean_object* %260, %struct.lean_object** %53, align 8
  %261 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_dec(%struct.lean_object* %261)
  %262 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %262, %struct.lean_object** %54, align 8
  %263 = load %struct.lean_object*, %struct.lean_object** %54, align 8
  %264 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %265 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %266 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %263, %struct.lean_object* %264, %struct.lean_object* %265)
  store %struct.lean_object* %266, %struct.lean_object** %55, align 8
  %267 = load %struct.lean_object*, %struct.lean_object** %55, align 8
  %268 = call i32 @lean_unbox_uint32(%struct.lean_object* %267)
  store i32 %268, i32* %56, align 4
  %269 = load %struct.lean_object*, %struct.lean_object** %55, align 8
  call void @lean_dec(%struct.lean_object* %269)
  %270 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %270, %struct.lean_object** %57, align 8
  %271 = load %struct.lean_object*, %struct.lean_object** %57, align 8
  %272 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %273 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %274 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %271, %struct.lean_object* %272, %struct.lean_object* %273)
  store %struct.lean_object* %274, %struct.lean_object** %58, align 8
  %275 = load %struct.lean_object*, %struct.lean_object** %58, align 8
  %276 = call i32 @lean_unbox_uint32(%struct.lean_object* %275)
  store i32 %276, i32* %59, align 4
  %277 = load %struct.lean_object*, %struct.lean_object** %58, align 8
  call void @lean_dec(%struct.lean_object* %277)
  %278 = load i32, i32* %56, align 4
  %279 = load i32, i32* %59, align 4
  %280 = icmp ult i32 %278, %279
  %281 = zext i1 %280 to i32
  %282 = trunc i32 %281 to i8
  store i8 %282, i8* %60, align 1
  %283 = load i8, i8* %60, align 1
  %284 = zext i8 %283 to i32
  %285 = icmp eq i32 %284, 0
  br i1 %285, label %286, label %316

286:                                              ; preds = %256
  %287 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_dec(%struct.lean_object* %287)
  %288 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %288)
  %289 = load i32, i32* %6, align 4
  %290 = load i32, i32* %59, align 4
  %291 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %292 = load i32, i32* %5, align 4
  %293 = load i32, i32* %5, align 4
  %294 = call %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %289, i32 %290, %struct.lean_object* %291, i32 %292, i32 %293)
  store %struct.lean_object* %294, %struct.lean_object** %61, align 8
  %295 = load %struct.lean_object*, %struct.lean_object** %61, align 8
  %296 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %295, i32 0)
  store %struct.lean_object* %296, %struct.lean_object** %62, align 8
  %297 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  call void @lean_inc(%struct.lean_object* %297)
  %298 = load %struct.lean_object*, %struct.lean_object** %61, align 8
  %299 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %298, i32 1)
  store %struct.lean_object* %299, %struct.lean_object** %63, align 8
  %300 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  call void @lean_inc(%struct.lean_object* %300)
  %301 = load %struct.lean_object*, %struct.lean_object** %61, align 8
  call void @lean_dec(%struct.lean_object* %301)
  %302 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  %303 = call i32 @lean_unbox_uint32(%struct.lean_object* %302)
  store i32 %303, i32* %64, align 4
  %304 = load %struct.lean_object*, %struct.lean_object** %63, align 8
  %305 = load i32, i32* %5, align 4
  %306 = load i32, i32* %64, align 4
  %307 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %304, i32 %305, i32 %306)
  store %struct.lean_object* %307, %struct.lean_object** %65, align 8
  %308 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  %309 = call i32 @lean_unbox_uint32(%struct.lean_object* %308)
  store i32 %309, i32* %66, align 4
  %310 = load %struct.lean_object*, %struct.lean_object** %62, align 8
  call void @lean_dec(%struct.lean_object* %310)
  %311 = load i32, i32* %66, align 4
  %312 = load i32, i32* %21, align 4
  %313 = add i32 %311, %312
  store i32 %313, i32* %67, align 4
  %314 = load %struct.lean_object*, %struct.lean_object** %65, align 8
  store %struct.lean_object* %314, %struct.lean_object** %4, align 8
  %315 = load i32, i32* %67, align 4
  store i32 %315, i32* %5, align 4
  br label %79

316:                                              ; preds = %256
  %317 = load %struct.lean_object*, %struct.lean_object** %53, align 8
  %318 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %319 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %320 = call %struct.lean_object* @lean_array_swap(%struct.lean_object* %317, %struct.lean_object* %318, %struct.lean_object* %319)
  store %struct.lean_object* %320, %struct.lean_object** %68, align 8
  %321 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %321)
  %322 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  store %struct.lean_object* %322, %struct.lean_object** %69, align 8
  %323 = load %struct.lean_object*, %struct.lean_object** %69, align 8
  %324 = load %struct.lean_object*, %struct.lean_object** %68, align 8
  %325 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  %326 = call %struct.lean_object* @lean_array_get(%struct.lean_object* %323, %struct.lean_object* %324, %struct.lean_object* %325)
  store %struct.lean_object* %326, %struct.lean_object** %70, align 8
  %327 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_dec(%struct.lean_object* %327)
  %328 = load %struct.lean_object*, %struct.lean_object** %70, align 8
  %329 = call i32 @lean_unbox_uint32(%struct.lean_object* %328)
  store i32 %329, i32* %71, align 4
  %330 = load %struct.lean_object*, %struct.lean_object** %70, align 8
  call void @lean_dec(%struct.lean_object* %330)
  %331 = load i32, i32* %6, align 4
  %332 = load i32, i32* %71, align 4
  %333 = load %struct.lean_object*, %struct.lean_object** %68, align 8
  %334 = load i32, i32* %5, align 4
  %335 = load i32, i32* %5, align 4
  %336 = call %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %331, i32 %332, %struct.lean_object* %333, i32 %334, i32 %335)
  store %struct.lean_object* %336, %struct.lean_object** %72, align 8
  %337 = load %struct.lean_object*, %struct.lean_object** %72, align 8
  %338 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %337, i32 0)
  store %struct.lean_object* %338, %struct.lean_object** %73, align 8
  %339 = load %struct.lean_object*, %struct.lean_object** %73, align 8
  call void @lean_inc(%struct.lean_object* %339)
  %340 = load %struct.lean_object*, %struct.lean_object** %72, align 8
  %341 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %340, i32 1)
  store %struct.lean_object* %341, %struct.lean_object** %74, align 8
  %342 = load %struct.lean_object*, %struct.lean_object** %74, align 8
  call void @lean_inc(%struct.lean_object* %342)
  %343 = load %struct.lean_object*, %struct.lean_object** %72, align 8
  call void @lean_dec(%struct.lean_object* %343)
  %344 = load %struct.lean_object*, %struct.lean_object** %73, align 8
  %345 = call i32 @lean_unbox_uint32(%struct.lean_object* %344)
  store i32 %345, i32* %75, align 4
  %346 = load %struct.lean_object*, %struct.lean_object** %74, align 8
  %347 = load i32, i32* %5, align 4
  %348 = load i32, i32* %75, align 4
  %349 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %346, i32 %347, i32 %348)
  store %struct.lean_object* %349, %struct.lean_object** %76, align 8
  %350 = load %struct.lean_object*, %struct.lean_object** %73, align 8
  %351 = call i32 @lean_unbox_uint32(%struct.lean_object* %350)
  store i32 %351, i32* %77, align 4
  %352 = load %struct.lean_object*, %struct.lean_object** %73, align 8
  call void @lean_dec(%struct.lean_object* %352)
  %353 = load i32, i32* %77, align 4
  %354 = load i32, i32* %21, align 4
  %355 = add i32 %353, %354
  store i32 %355, i32* %78, align 4
  %356 = load %struct.lean_object*, %struct.lean_object** %76, align 8
  store %struct.lean_object* %356, %struct.lean_object** %4, align 8
  %357 = load i32, i32* %78, align 4
  store i32 %357, i32* %5, align 4
  br label %79
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_Nat_forM_loop___at_main___spec__4(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca i8, align 1
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca %struct.lean_object*, align 8
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca i32, align 4
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca %struct.lean_object*, align 8
  %17 = alloca i32, align 4
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca i32, align 4
  %21 = alloca %struct.lean_object*, align 8
  %22 = alloca %struct.lean_object*, align 8
  %23 = alloca %struct.lean_object*, align 8
  %24 = alloca i8, align 1
  %25 = alloca %struct.lean_object*, align 8
  %26 = alloca %struct.lean_object*, align 8
  %27 = alloca %struct.lean_object*, align 8
  %28 = alloca %struct.lean_object*, align 8
  %29 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  br label %30

30:                                               ; preds = %79, %3
  %31 = call %struct.lean_object* @lean_unsigned_to_nat(i32 0)
  store %struct.lean_object* %31, %struct.lean_object** %8, align 8
  %32 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %33 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %34 = call zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %32, %struct.lean_object* %33)
  store i8 %34, i8* %9, align 1
  %35 = load i8, i8* %9, align 1
  %36 = zext i8 %35 to i32
  %37 = icmp eq i32 %36, 0
  br i1 %37, label %38, label %112

38:                                               ; preds = %30
  %39 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %39, %struct.lean_object** %10, align 8
  %40 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %41 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %42 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %40, %struct.lean_object* %41)
  store %struct.lean_object* %42, %struct.lean_object** %11, align 8
  %43 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %43)
  %44 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %45 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  %46 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %44, %struct.lean_object* %45)
  store %struct.lean_object* %46, %struct.lean_object** %12, align 8
  %47 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %48 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %49 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %47, %struct.lean_object* %48)
  store %struct.lean_object* %49, %struct.lean_object** %13, align 8
  %50 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  call void @lean_dec(%struct.lean_object* %50)
  %51 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %52 = call i32 @lean_uint32_of_nat(%struct.lean_object* %51)
  store i32 %52, i32* %14, align 4
  %53 = load %struct.lean_object*, %struct.lean_object** @l_Array_empty___closed__1, align 8
  store %struct.lean_object* %53, %struct.lean_object** %15, align 8
  %54 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  %55 = load i32, i32* %14, align 4
  %56 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  %57 = call %struct.lean_object* @l_mkRandomArray(%struct.lean_object* %54, i32 %55, %struct.lean_object* %56)
  store %struct.lean_object* %57, %struct.lean_object** %16, align 8
  store i32 0, i32* %17, align 4
  %58 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %59 = call %struct.lean_object* @lean_array_get_size(%struct.lean_object* %58)
  store %struct.lean_object* %59, %struct.lean_object** %18, align 8
  %60 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  %61 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %62 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %60, %struct.lean_object* %61)
  store %struct.lean_object* %62, %struct.lean_object** %19, align 8
  %63 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_dec(%struct.lean_object* %63)
  %64 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %65 = call i32 @lean_uint32_of_nat(%struct.lean_object* %64)
  store i32 %65, i32* %20, align 4
  %66 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  call void @lean_dec(%struct.lean_object* %66)
  %67 = load %struct.lean_object*, %struct.lean_object** %16, align 8
  %68 = load i32, i32* %17, align 4
  %69 = load i32, i32* %20, align 4
  %70 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %67, i32 %68, i32 %69)
  store %struct.lean_object* %70, %struct.lean_object** %21, align 8
  %71 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %72 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %73 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %74 = call %struct.lean_object* @l_checkSortedAux(%struct.lean_object* %71, %struct.lean_object* %72, %struct.lean_object* %73)
  store %struct.lean_object* %74, %struct.lean_object** %22, align 8
  %75 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  call void @lean_dec(%struct.lean_object* %75)
  %76 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %77 = call i32 @lean_obj_tag(%struct.lean_object* %76)
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %79, label %86

79:                                               ; preds = %38
  %80 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %81 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %80, i32 1)
  store %struct.lean_object* %81, %struct.lean_object** %23, align 8
  %82 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  call void @lean_inc(%struct.lean_object* %82)
  %83 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  call void @lean_dec(%struct.lean_object* %83)
  %84 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  store %struct.lean_object* %84, %struct.lean_object** %6, align 8
  %85 = load %struct.lean_object*, %struct.lean_object** %23, align 8
  store %struct.lean_object* %85, %struct.lean_object** %7, align 8
  br label %30

86:                                               ; preds = %38
  %87 = load %struct.lean_object*, %struct.lean_object** %11, align 8
  call void @lean_dec(%struct.lean_object* %87)
  %88 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %89 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %88)
  %90 = xor i1 %89, true
  %91 = zext i1 %90 to i32
  %92 = trunc i32 %91 to i8
  store i8 %92, i8* %24, align 1
  %93 = load i8, i8* %24, align 1
  %94 = zext i8 %93 to i32
  %95 = icmp eq i32 %94, 0
  br i1 %95, label %96, label %98

96:                                               ; preds = %86
  %97 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  store %struct.lean_object* %97, %struct.lean_object** %4, align 8
  br label %121

98:                                               ; preds = %86
  %99 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %100 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %99, i32 0)
  store %struct.lean_object* %100, %struct.lean_object** %25, align 8
  %101 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  %102 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %101, i32 1)
  store %struct.lean_object* %102, %struct.lean_object** %26, align 8
  %103 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  call void @lean_inc(%struct.lean_object* %103)
  %104 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_inc(%struct.lean_object* %104)
  %105 = load %struct.lean_object*, %struct.lean_object** %22, align 8
  call void @lean_dec(%struct.lean_object* %105)
  %106 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %106, %struct.lean_object** %27, align 8
  %107 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  %108 = load %struct.lean_object*, %struct.lean_object** %25, align 8
  call void @lean_ctor_set(%struct.lean_object* %107, i32 0, %struct.lean_object* %108)
  %109 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  %110 = load %struct.lean_object*, %struct.lean_object** %26, align 8
  call void @lean_ctor_set(%struct.lean_object* %109, i32 1, %struct.lean_object* %110)
  %111 = load %struct.lean_object*, %struct.lean_object** %27, align 8
  store %struct.lean_object* %111, %struct.lean_object** %4, align 8
  br label %121

112:                                              ; preds = %30
  %113 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %113)
  %114 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %114, %struct.lean_object** %28, align 8
  %115 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %115, %struct.lean_object** %29, align 8
  %116 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  %117 = load %struct.lean_object*, %struct.lean_object** %28, align 8
  call void @lean_ctor_set(%struct.lean_object* %116, i32 0, %struct.lean_object* %117)
  %118 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  %119 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_ctor_set(%struct.lean_object* %118, i32 1, %struct.lean_object* %119)
  %120 = load %struct.lean_object*, %struct.lean_object** %29, align 8
  store %struct.lean_object* %120, %struct.lean_object** %4, align 8
  br label %121

121:                                              ; preds = %112, %98, %96
  %122 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %122
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_Nat_forM_loop___at_main___spec__5(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i8, align 1
  %12 = alloca %struct.lean_object*, align 8
  %13 = alloca %struct.lean_object*, align 8
  %14 = alloca %struct.lean_object*, align 8
  %15 = alloca %struct.lean_object*, align 8
  %16 = alloca i8, align 1
  %17 = alloca %struct.lean_object*, align 8
  %18 = alloca %struct.lean_object*, align 8
  %19 = alloca %struct.lean_object*, align 8
  %20 = alloca %struct.lean_object*, align 8
  %21 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store %struct.lean_object* %3, %struct.lean_object** %9, align 8
  br label %22

22:                                               ; preds = %44, %4
  %23 = call %struct.lean_object* @lean_unsigned_to_nat(i32 0)
  store %struct.lean_object* %23, %struct.lean_object** %10, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %25 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %26 = call zeroext i8 @lean_nat_dec_eq(%struct.lean_object* %24, %struct.lean_object* %25)
  store i8 %26, i8* %11, align 1
  %27 = load i8, i8* %11, align 1
  %28 = zext i8 %27 to i32
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %78

30:                                               ; preds = %22
  %31 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1)
  store %struct.lean_object* %31, %struct.lean_object** %12, align 8
  %32 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %33 = load %struct.lean_object*, %struct.lean_object** %12, align 8
  %34 = call %struct.lean_object* @lean_nat_sub(%struct.lean_object* %32, %struct.lean_object* %33)
  store %struct.lean_object* %34, %struct.lean_object** %13, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_dec(%struct.lean_object* %35)
  %36 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc(%struct.lean_object* %36)
  %37 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %38 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %39 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %40 = call %struct.lean_object* @l_Nat_forM_loop___at_main___spec__4(%struct.lean_object* %37, %struct.lean_object* %38, %struct.lean_object* %39)
  store %struct.lean_object* %40, %struct.lean_object** %14, align 8
  %41 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %42 = call i32 @lean_obj_tag(%struct.lean_object* %41)
  %43 = icmp eq i32 %42, 0
  br i1 %43, label %44, label %51

44:                                               ; preds = %30
  %45 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %46 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %45, i32 1)
  store %struct.lean_object* %46, %struct.lean_object** %15, align 8
  %47 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  call void @lean_inc(%struct.lean_object* %47)
  %48 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  call void @lean_dec(%struct.lean_object* %48)
  %49 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  store %struct.lean_object* %49, %struct.lean_object** %8, align 8
  %50 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  store %struct.lean_object* %50, %struct.lean_object** %9, align 8
  br label %22

51:                                               ; preds = %30
  %52 = load %struct.lean_object*, %struct.lean_object** %13, align 8
  call void @lean_dec(%struct.lean_object* %52)
  %53 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %53)
  %54 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %55 = call zeroext i1 @lean_is_exclusive(%struct.lean_object* %54)
  %56 = xor i1 %55, true
  %57 = zext i1 %56 to i32
  %58 = trunc i32 %57 to i8
  store i8 %58, i8* %16, align 1
  %59 = load i8, i8* %16, align 1
  %60 = zext i8 %59 to i32
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %64

62:                                               ; preds = %51
  %63 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  store %struct.lean_object* %63, %struct.lean_object** %5, align 8
  br label %88

64:                                               ; preds = %51
  %65 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %66 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %65, i32 0)
  store %struct.lean_object* %66, %struct.lean_object** %17, align 8
  %67 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  %68 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %67, i32 1)
  store %struct.lean_object* %68, %struct.lean_object** %18, align 8
  %69 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_inc(%struct.lean_object* %69)
  %70 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_inc(%struct.lean_object* %70)
  %71 = load %struct.lean_object*, %struct.lean_object** %14, align 8
  call void @lean_dec(%struct.lean_object* %71)
  %72 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %72, %struct.lean_object** %19, align 8
  %73 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %74 = load %struct.lean_object*, %struct.lean_object** %17, align 8
  call void @lean_ctor_set(%struct.lean_object* %73, i32 0, %struct.lean_object* %74)
  %75 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  %76 = load %struct.lean_object*, %struct.lean_object** %18, align 8
  call void @lean_ctor_set(%struct.lean_object* %75, i32 1, %struct.lean_object* %76)
  %77 = load %struct.lean_object*, %struct.lean_object** %19, align 8
  store %struct.lean_object* %77, %struct.lean_object** %5, align 8
  br label %88

78:                                               ; preds = %22
  %79 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  call void @lean_dec(%struct.lean_object* %79)
  %80 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %80)
  %81 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %81, %struct.lean_object** %20, align 8
  %82 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %82, %struct.lean_object** %21, align 8
  %83 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %84 = load %struct.lean_object*, %struct.lean_object** %20, align 8
  call void @lean_ctor_set(%struct.lean_object* %83, i32 0, %struct.lean_object* %84)
  %85 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  %86 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_ctor_set(%struct.lean_object* %85, i32 1, %struct.lean_object* %86)
  %87 = load %struct.lean_object*, %struct.lean_object** %21, align 8
  store %struct.lean_object* %87, %struct.lean_object** %5, align 8
  br label %88

88:                                               ; preds = %78, %64, %62
  %89 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  ret %struct.lean_object* %89
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @_lean_main(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  store %struct.lean_object* %1, %struct.lean_object** %4, align 8
  br label %8

8:                                                ; preds = %2
  %9 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %10 = call %struct.lean_object* @l_List_head_x21___at_main___spec__1(%struct.lean_object* %9)
  store %struct.lean_object* %10, %struct.lean_object** %5, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_dec(%struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %13 = call %struct.lean_object* @l_String_toNat_x21(%struct.lean_object* %12)
  store %struct.lean_object* %13, %struct.lean_object** %6, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %14)
  %15 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_inc_n(%struct.lean_object* %15, i64 2)
  %16 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %18 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %19 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %20 = call %struct.lean_object* @l_Nat_forM_loop___at_main___spec__5(%struct.lean_object* %16, %struct.lean_object* %17, %struct.lean_object* %18, %struct.lean_object* %19)
  store %struct.lean_object* %20, %struct.lean_object** %7, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %21)
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %22
}

declare %struct.lean_object* @l_String_toNat_x21(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_inc_n(%struct.lean_object* %0, i64 %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_List_head_x21___at_main___spec__1___boxed(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  br label %4

4:                                                ; preds = %1
  %5 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %6 = call %struct.lean_object* @l_List_head_x21___at_main___spec__1(%struct.lean_object* %5)
  store %struct.lean_object* %6, %struct.lean_object** %3, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_dec(%struct.lean_object* %7)
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %8
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3, %struct.lean_object* %4) #0 {
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca %struct.lean_object*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %6, align 8
  store %struct.lean_object* %1, %struct.lean_object** %7, align 8
  store %struct.lean_object* %2, %struct.lean_object** %8, align 8
  store %struct.lean_object* %3, %struct.lean_object** %9, align 8
  store %struct.lean_object* %4, %struct.lean_object** %10, align 8
  br label %16

16:                                               ; preds = %5
  %17 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %18 = call i32 @lean_unbox_uint32(%struct.lean_object* %17)
  store i32 %18, i32* %11, align 4
  %19 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %19)
  %20 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %21 = call i32 @lean_unbox_uint32(%struct.lean_object* %20)
  store i32 %21, i32* %12, align 4
  %22 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec(%struct.lean_object* %22)
  %23 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %24 = call i32 @lean_unbox_uint32(%struct.lean_object* %23)
  store i32 %24, i32* %13, align 4
  %25 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  call void @lean_dec(%struct.lean_object* %25)
  %26 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  %27 = call i32 @lean_unbox_uint32(%struct.lean_object* %26)
  store i32 %27, i32* %14, align 4
  %28 = load %struct.lean_object*, %struct.lean_object** %10, align 8
  call void @lean_dec(%struct.lean_object* %28)
  %29 = load i32, i32* %11, align 4
  %30 = load i32, i32* %12, align 4
  %31 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %32 = load i32, i32* %13, align 4
  %33 = load i32, i32* %14, align 4
  %34 = call %struct.lean_object* @l___private_qsort_0__partitionAux___at_main___spec__3(i32 %29, i32 %30, %struct.lean_object* %31, i32 %32, i32 %33)
  store %struct.lean_object* %34, %struct.lean_object** %15, align 8
  %35 = load %struct.lean_object*, %struct.lean_object** %15, align 8
  ret %struct.lean_object* %35
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_qsortAux___at_main___spec__2___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %10

10:                                               ; preds = %3
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = call i32 @lean_unbox_uint32(%struct.lean_object* %11)
  store i32 %12, i32* %7, align 4
  %13 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  call void @lean_dec(%struct.lean_object* %13)
  %14 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %15 = call i32 @lean_unbox_uint32(%struct.lean_object* %14)
  store i32 %15, i32* %8, align 4
  %16 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %16)
  %17 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %18 = load i32, i32* %7, align 4
  %19 = load i32, i32* %8, align 4
  %20 = call %struct.lean_object* @l_qsortAux___at_main___spec__2(%struct.lean_object* %17, i32 %18, i32 %19)
  store %struct.lean_object* %20, %struct.lean_object** %9, align 8
  %21 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  ret %struct.lean_object* %21
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_Nat_forM_loop___at_main___spec__4___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2) #0 {
  %4 = alloca %struct.lean_object*, align 8
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %4, align 8
  store %struct.lean_object* %1, %struct.lean_object** %5, align 8
  store %struct.lean_object* %2, %struct.lean_object** %6, align 8
  br label %8

8:                                                ; preds = %3
  %9 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %12 = call %struct.lean_object* @l_Nat_forM_loop___at_main___spec__4(%struct.lean_object* %9, %struct.lean_object* %10, %struct.lean_object* %11)
  store %struct.lean_object* %12, %struct.lean_object** %7, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec(%struct.lean_object* %13)
  %14 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  ret %struct.lean_object* %14
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @l_Nat_forM_loop___at_main___spec__5___boxed(%struct.lean_object* %0, %struct.lean_object* %1, %struct.lean_object* %2, %struct.lean_object* %3) #0 {
  %5 = alloca %struct.lean_object*, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca %struct.lean_object*, align 8
  %9 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %5, align 8
  store %struct.lean_object* %1, %struct.lean_object** %6, align 8
  store %struct.lean_object* %2, %struct.lean_object** %7, align 8
  store %struct.lean_object* %3, %struct.lean_object** %8, align 8
  br label %10

10:                                               ; preds = %4
  %11 = load %struct.lean_object*, %struct.lean_object** %5, align 8
  %12 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %14 = load %struct.lean_object*, %struct.lean_object** %8, align 8
  %15 = call %struct.lean_object* @l_Nat_forM_loop___at_main___spec__5(%struct.lean_object* %11, %struct.lean_object* %12, %struct.lean_object* %13, %struct.lean_object* %14)
  store %struct.lean_object* %15, %struct.lean_object** %9, align 8
  %16 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_dec(%struct.lean_object* %16)
  %17 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  ret %struct.lean_object* %17
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local %struct.lean_object* @initialize_qsort(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %3, align 8
  %5 = load i8, i8* @_G_initialized, align 1
  %6 = trunc i8 %5 to i1
  br i1 %6, label %7, label %10

7:                                                ; preds = %1
  %8 = call %struct.lean_object* @lean_box(i64 0)
  %9 = call %struct.lean_object* @lean_io_result_mk_ok(%struct.lean_object* %8)
  store %struct.lean_object* %9, %struct.lean_object** %2, align 8
  br label %57

10:                                               ; preds = %1
  store i8 1, i8* @_G_initialized, align 1
  %11 = call %struct.lean_object* @lean_io_mk_world()
  %12 = call %struct.lean_object* @initialize_Init(%struct.lean_object* %11)
  store %struct.lean_object* %12, %struct.lean_object** %4, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %14 = call zeroext i1 @lean_io_result_is_error(%struct.lean_object* %13)
  br i1 %14, label %15, label %17

15:                                               ; preds = %10
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  store %struct.lean_object* %16, %struct.lean_object** %2, align 8
  br label %57

17:                                               ; preds = %10
  %18 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  call void @lean_dec_ref(%struct.lean_object* %18)
  %19 = call %struct.lean_object* @_init_l_checkSortedAux___closed__1()
  store %struct.lean_object* %19, %struct.lean_object** @l_checkSortedAux___closed__1, align 8
  %20 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___closed__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %20)
  %21 = call %struct.lean_object* @_init_l_checkSortedAux___closed__2()
  store %struct.lean_object* %21, %struct.lean_object** @l_checkSortedAux___closed__2, align 8
  %22 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___closed__2, align 8
  call void @lean_mark_persistent(%struct.lean_object* %22)
  %23 = call %struct.lean_object* @_init_l_checkSortedAux___boxed__const__1()
  store %struct.lean_object* %23, %struct.lean_object** @l_checkSortedAux___boxed__const__1, align 8
  %24 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___boxed__const__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %24)
  %25 = call %struct.lean_object* @_init_l_term_u2191____1___closed__1()
  store %struct.lean_object* %25, %struct.lean_object** @l_term_u2191____1___closed__1, align 8
  %26 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %26)
  %27 = call %struct.lean_object* @_init_l_term_u2191____1___closed__2()
  store %struct.lean_object* %27, %struct.lean_object** @l_term_u2191____1___closed__2, align 8
  %28 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__2, align 8
  call void @lean_mark_persistent(%struct.lean_object* %28)
  %29 = call %struct.lean_object* @_init_l_term_u2191____1___closed__3()
  store %struct.lean_object* %29, %struct.lean_object** @l_term_u2191____1___closed__3, align 8
  %30 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__3, align 8
  call void @lean_mark_persistent(%struct.lean_object* %30)
  %31 = call %struct.lean_object* @_init_l_term_u2191____1()
  store %struct.lean_object* %31, %struct.lean_object** @l_term_u2191____1, align 8
  %32 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %32)
  %33 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__1()
  store %struct.lean_object* %33, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__1, align 8
  %34 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %34)
  %35 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__2()
  store %struct.lean_object* %35, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__2, align 8
  %36 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__2, align 8
  call void @lean_mark_persistent(%struct.lean_object* %36)
  %37 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__3()
  store %struct.lean_object* %37, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__3, align 8
  %38 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__3, align 8
  call void @lean_mark_persistent(%struct.lean_object* %38)
  %39 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__4()
  store %struct.lean_object* %39, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__4, align 8
  %40 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__4, align 8
  call void @lean_mark_persistent(%struct.lean_object* %40)
  %41 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__5()
  store %struct.lean_object* %41, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__5, align 8
  %42 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__5, align 8
  call void @lean_mark_persistent(%struct.lean_object* %42)
  %43 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__6()
  store %struct.lean_object* %43, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__6, align 8
  %44 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__6, align 8
  call void @lean_mark_persistent(%struct.lean_object* %44)
  %45 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__7()
  store %struct.lean_object* %45, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__7, align 8
  %46 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__7, align 8
  call void @lean_mark_persistent(%struct.lean_object* %46)
  %47 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__8()
  store %struct.lean_object* %47, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__8, align 8
  %48 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__8, align 8
  call void @lean_mark_persistent(%struct.lean_object* %48)
  %49 = call %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__9()
  store %struct.lean_object* %49, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__9, align 8
  %50 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__9, align 8
  call void @lean_mark_persistent(%struct.lean_object* %50)
  %51 = call %struct.lean_object* @_init_l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1()
  store %struct.lean_object* %51, %struct.lean_object** @l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1, align 8
  %52 = load %struct.lean_object*, %struct.lean_object** @l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %52)
  %53 = call %struct.lean_object* @_init_l_qsortAux___at_main___spec__2___boxed__const__1()
  store %struct.lean_object* %53, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  %54 = load %struct.lean_object*, %struct.lean_object** @l_qsortAux___at_main___spec__2___boxed__const__1, align 8
  call void @lean_mark_persistent(%struct.lean_object* %54)
  %55 = call %struct.lean_object* @lean_box(i64 0)
  %56 = call %struct.lean_object* @lean_io_result_mk_ok(%struct.lean_object* %55)
  store %struct.lean_object* %56, %struct.lean_object** %2, align 8
  br label %57

57:                                               ; preds = %17, %15, %7
  %58 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %58
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_io_result_mk_ok(%struct.lean_object* %0) #0 {
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

declare %struct.lean_object* @initialize_Init(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_io_result_is_error(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 1
  ret i1 %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_dec_ref(%struct.lean_object* %0) #0 {
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

declare void @lean_mark_persistent(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define dso_local i32 @main(i32 %0, i8** %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  %6 = alloca %struct.lean_object*, align 8
  %7 = alloca %struct.lean_object*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %struct.lean_object*, align 8
  %10 = alloca i32, align 4
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  call void (...) @lean_initialize_runtime_module()
  %11 = call %struct.lean_object* @lean_io_mk_world()
  %12 = call %struct.lean_object* @initialize_qsort(%struct.lean_object* %11)
  store %struct.lean_object* %12, %struct.lean_object** %7, align 8
  call void (...) @lean_io_mark_end_initialization()
  %13 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %14 = call zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %13)
  br i1 %14, label %15, label %40

15:                                               ; preds = %2
  %16 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec_ref(%struct.lean_object* %16)
  call void (...) @lean_init_task_manager()
  %17 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %17, %struct.lean_object** %6, align 8
  %18 = load i32, i32* %4, align 4
  store i32 %18, i32* %8, align 4
  br label %19

19:                                               ; preds = %22, %15
  %20 = load i32, i32* %8, align 4
  %21 = icmp sgt i32 %20, 1
  br i1 %21, label %22, label %36

22:                                               ; preds = %19
  %23 = load i32, i32* %8, align 4
  %24 = add nsw i32 %23, -1
  store i32 %24, i32* %8, align 4
  %25 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %25, %struct.lean_object** %9, align 8
  %26 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %27 = load i8**, i8*** %5, align 8
  %28 = load i32, i32* %8, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8*, i8** %27, i64 %29
  %31 = load i8*, i8** %30, align 8
  %32 = call %struct.lean_object* @lean_mk_string(i8* %31)
  call void @lean_ctor_set(%struct.lean_object* %26, i32 0, %struct.lean_object* %32)
  %33 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  %34 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  call void @lean_ctor_set(%struct.lean_object* %33, i32 1, %struct.lean_object* %34)
  %35 = load %struct.lean_object*, %struct.lean_object** %9, align 8
  store %struct.lean_object* %35, %struct.lean_object** %6, align 8
  br label %19

36:                                               ; preds = %19
  %37 = load %struct.lean_object*, %struct.lean_object** %6, align 8
  %38 = call %struct.lean_object* @lean_io_mk_world()
  %39 = call %struct.lean_object* @_lean_main(%struct.lean_object* %37, %struct.lean_object* %38)
  store %struct.lean_object* %39, %struct.lean_object** %7, align 8
  br label %40

40:                                               ; preds = %36, %2
  %41 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %42 = call zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %41)
  br i1 %42, label %43, label %50

43:                                               ; preds = %40
  %44 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  %45 = call %struct.lean_object* @lean_io_result_get_value(%struct.lean_object* %44)
  %46 = call i64 @lean_unbox(%struct.lean_object* %45)
  %47 = trunc i64 %46 to i32
  store i32 %47, i32* %10, align 4
  %48 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec_ref(%struct.lean_object* %48)
  %49 = load i32, i32* %10, align 4
  store i32 %49, i32* %3, align 4
  br label %53

50:                                               ; preds = %40
  %51 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_io_result_show_error(%struct.lean_object* %51)
  %52 = load %struct.lean_object*, %struct.lean_object** %7, align 8
  call void @lean_dec_ref(%struct.lean_object* %52)
  store i32 1, i32* %3, align 4
  br label %53

53:                                               ; preds = %50, %43
  %54 = load i32, i32* %3, align 4
  ret i32 %54
}

declare void @lean_initialize_runtime_module(...) #1

declare void @lean_io_mark_end_initialization(...) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 0
  ret i1 %6
}

declare void @lean_init_task_manager(...) #1

declare %struct.lean_object* @lean_mk_string(i8*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_io_result_get_value(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_io_result_is_ok(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.18, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 1845, i8* getelementptr inbounds ([56 x i8], [56 x i8]* @__PRETTY_FUNCTION__.lean_io_result_get_value, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_ctor_get(%struct.lean_object* %8, i32 0)
  ret %struct.lean_object* %9
}

declare void @lean_io_result_show_error(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i64 @lean_array_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %4, i32 0, i32 1
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_array_object* @lean_to_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_array(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 570, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_to_array, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_array_object*
  ret %struct.lean_array_object* %9
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 246
  ret i1 %6
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i8 @lean_ptr_tag(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  %5 = bitcast i64* %4 to i8*
  %6 = getelementptr inbounds i8, i8* %5, i64 7
  %7 = load i8, i8* %6, align 1
  ret i8 %7
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i64 @lean_string_size(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_string_object* @lean_to_string(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_string_object, %struct.lean_string_object* %4, i32 0, i32 1
  %6 = load i64, i64* %5, align 8
  ret i64 %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_string_object* @lean_to_string(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_string(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.2, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 572, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_to_string, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_string_object*
  ret %struct.lean_string_object* %9
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_string(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp eq i32 %5, 249
  ret i1 %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_scalar(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = ptrtoint %struct.lean_object* %3 to i64
  %5 = and i64 %4, 1
  %6 = icmp eq i64 %5, 1
  ret i1 %6
}

declare i32 @lean_uint32_of_big_nat(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_usize_to_nat(i64 %0) #0 {
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

declare %struct.lean_object* @lean_nat_big_add(%struct.lean_object*, %struct.lean_object*) #1

declare %struct.lean_object* @lean_big_usize_to_nat(i64) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_nat_eq(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

declare zeroext i1 @lean_nat_big_eq(%struct.lean_object*, %struct.lean_object*) #1

declare %struct.lean_object* @lean_nat_big_sub(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_uswap(%struct.lean_object* %0, i64 %1, i64 %2) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_ensure_exclusive_array(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object** @lean_array_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_array_object* @lean_to_array(%struct.lean_object* %3)
  %5 = getelementptr inbounds %struct.lean_array_object, %struct.lean_array_object* %4, i32 0, i32 3
  %6 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %5, i64 0, i64 0
  ret %struct.lean_object** %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_copy_array(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call %struct.lean_object* @lean_copy_expand_array(%struct.lean_object* %3, i1 zeroext false)
  ret %struct.lean_object* %4
}

declare %struct.lean_object* @lean_copy_expand_array(%struct.lean_object*, i1 zeroext) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_uget(%struct.lean_object* %0, i64 %1) #0 {
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

declare %struct.lean_object* @lean_array_get_panic(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_array_get_core(%struct.lean_object* %0, i64 %1) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 862, i8* getelementptr inbounds ([59 x i8], [59 x i8]* @__PRETTY_FUNCTION__.lean_array_get_core, i64 0, i64 0)) #3
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_nat_lt(%struct.lean_object* %0, %struct.lean_object* %1) #0 {
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

declare zeroext i1 @lean_nat_big_lt(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_alloc_small_object(i32 %0) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.6, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 322, i8* getelementptr inbounds ([51 x i8], [51 x i8]* @__PRETTY_FUNCTION__.lean_alloc_small_object, i64 0, i64 0)) #3
  unreachable

14:                                               ; preds = %12
  %15 = load i32, i32* %2, align 4
  %16 = load i32, i32* %3, align 4
  %17 = call i8* @lean_alloc_small(i32 %15, i32 %16)
  %18 = bitcast i8* %17 to %struct.lean_object*
  ret %struct.lean_object* %18
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_set_st_header(%struct.lean_object* %0, i32 %1, i32 %2) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i64 @lean_align(i64 %0, i64 %1) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_get_slot_idx(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp ugt i32 %3, 0
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 308, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #3
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
  call void @__assert_fail(i8* getelementptr inbounds ([45 x i8], [45 x i8]* @.str.8, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 309, i8* getelementptr inbounds ([45 x i8], [45 x i8]* @__PRETTY_FUNCTION__.lean_get_slot_idx, i64 0, i64 0)) #3
  unreachable

16:                                               ; preds = %14
  %17 = load i32, i32* %2, align 4
  %18 = udiv i32 %17, 8
  %19 = sub i32 %18, 1
  ret i32 %19
}

declare i8* @lean_alloc_small(i32, i32) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_alloc_ctor_memory(i32 %0) #0 {
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
  call void @__assert_fail(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.10, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 337, i8* getelementptr inbounds ([50 x i8], [50 x i8]* @__PRETTY_FUNCTION__.lean_alloc_ctor_memory, i64 0, i64 0)) #3
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_ctor_num_objs(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 680, i8* getelementptr inbounds ([47 x i8], [47 x i8]* @__PRETTY_FUNCTION__.lean_ctor_num_objs, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call i32 @lean_ptr_other(%struct.lean_object* %8)
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object** @lean_ctor_obj_cptr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 685, i8* getelementptr inbounds ([48 x i8], [48 x i8]* @__PRETTY_FUNCTION__.lean_ctor_obj_cptr, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_ctor_object* @lean_to_ctor(%struct.lean_object* %8)
  %10 = getelementptr inbounds %struct.lean_ctor_object, %struct.lean_ctor_object* %9, i32 0, i32 1
  %11 = getelementptr inbounds [0 x %struct.lean_object*], [0 x %struct.lean_object*]* %10, i64 0, i64 0
  ret %struct.lean_object** %11
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_ctor(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i8 @lean_ptr_tag(%struct.lean_object* %3)
  %5 = zext i8 %4 to i32
  %6 = icmp sle i32 %5, 244
  ret i1 %6
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i32 @lean_ptr_other(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_ctor_object* @lean_to_ctor(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = call zeroext i1 @lean_is_ctor(%struct.lean_object* %3)
  br i1 %4, label %5, label %6

5:                                                ; preds = %1
  br label %7

6:                                                ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.12, i64 0, i64 0), i8* getelementptr inbounds ([56 x i8], [56 x i8]* @.str.1, i64 0, i64 0), i32 568, i8* getelementptr inbounds ([46 x i8], [46 x i8]* @__PRETTY_FUNCTION__.lean_to_ctor, i64 0, i64 0)) #3
  unreachable

7:                                                ; preds = %5
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = bitcast %struct.lean_object* %8 to %struct.lean_ctor_object*
  ret %struct.lean_ctor_object* %9
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_inc_ref(%struct.lean_object* %0) #0 {
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
  %19 = atomicrmw add i64* %17, i64 %18 monotonic
  store i64 %19, i64* %4, align 8
  %20 = load i64, i64* %4, align 8
  br label %21

21:                                               ; preds = %15, %12
  br label %22

22:                                               ; preds = %21, %7
  ret void
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_st(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_is_mt(%struct.lean_object* %0) #0 {
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

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal i64* @lean_get_rc_mt_addr(%struct.lean_object* %0) #0 {
  %2 = alloca %struct.lean_object*, align 8
  store %struct.lean_object* %0, %struct.lean_object** %2, align 8
  %3 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %4 = getelementptr inbounds %struct.lean_object, %struct.lean_object* %3, i32 0, i32 0
  ret i64* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal void @lean_inc_ref_n(%struct.lean_object* %0, i64 %1) #0 {
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
  %23 = atomicrmw add i64* %20, i64 %22 monotonic
  store i64 %23, i64* %6, align 8
  %24 = load i64, i64* %6, align 8
  br label %25

25:                                               ; preds = %18, %15
  br label %26

26:                                               ; preds = %25, %9
  ret void
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @lean_io_mk_world() #0 {
  %1 = call %struct.lean_object* @lean_box(i64 0)
  ret %struct.lean_object* %1
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal zeroext i1 @lean_dec_ref_core(%struct.lean_object* %0) #0 {
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
  %25 = atomicrmw sub i64* %23, i64 %24 acq_rel
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

declare void @lean_del(%struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_checkSortedAux___closed__1() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = call %struct.lean_object* @lean_mk_string(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.13, i64 0, i64 0))
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_checkSortedAux___closed__2() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  br label %3

3:                                                ; preds = %0
  %4 = load %struct.lean_object*, %struct.lean_object** @l_checkSortedAux___closed__1, align 8
  store %struct.lean_object* %4, %struct.lean_object** %1, align 8
  %5 = call %struct.lean_object* @lean_alloc_ctor(i32 18, i32 1, i32 0)
  store %struct.lean_object* %5, %struct.lean_object** %2, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  call void @lean_ctor_set(%struct.lean_object* %6, i32 0, %struct.lean_object* %7)
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %8
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_checkSortedAux___boxed__const__1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.lean_object*, align 8
  br label %3

3:                                                ; preds = %0
  %4 = load i32, i32* @l_instInhabitedUInt32, align 4
  store i32 %4, i32* %1, align 4
  %5 = load i32, i32* %1, align 4
  %6 = call %struct.lean_object* @lean_box_uint32(i32 %5)
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_term_u2191____1___closed__1() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = call %struct.lean_object* @lean_mk_string(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.14, i64 0, i64 0))
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_term_u2191____1___closed__2() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  br label %4

4:                                                ; preds = %0
  %5 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %5, %struct.lean_object** %1, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__1, align 8
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_name_mk_string(%struct.lean_object* %7, %struct.lean_object* %8)
  store %struct.lean_object* %9, %struct.lean_object** %3, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %10
}

declare %struct.lean_object* @lean_name_mk_string(%struct.lean_object*, %struct.lean_object*) #1

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_term_u2191____1___closed__3() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  br label %5

5:                                                ; preds = %0
  %6 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__2, align 8
  store %struct.lean_object* %6, %struct.lean_object** %1, align 8
  %7 = call %struct.lean_object* @lean_unsigned_to_nat(i32 1024)
  store %struct.lean_object* %7, %struct.lean_object** %2, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191_____closed__3, align 8
  store %struct.lean_object* %8, %struct.lean_object** %3, align 8
  %9 = call %struct.lean_object* @lean_alloc_ctor(i32 3, i32 3, i32 0)
  store %struct.lean_object* %9, %struct.lean_object** %4, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  call void @lean_ctor_set(%struct.lean_object* %10, i32 0, %struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %12, i32 1, %struct.lean_object* %13)
  %14 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_ctor_set(%struct.lean_object* %14, i32 2, %struct.lean_object* %15)
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %16
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_term_u2191____1() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = load %struct.lean_object*, %struct.lean_object** @l_term_u2191____1___closed__3, align 8
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__1() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = call %struct.lean_object* @lean_mk_string(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.15, i64 0, i64 0))
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__2() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  br label %3

3:                                                ; preds = %0
  %4 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__1, align 8
  store %struct.lean_object* %4, %struct.lean_object** %1, align 8
  %5 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  %6 = call %struct.lean_object* @lean_string_utf8_byte_size(%struct.lean_object* %5)
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__3() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  %4 = alloca %struct.lean_object*, align 8
  br label %5

5:                                                ; preds = %0
  %6 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__1, align 8
  store %struct.lean_object* %6, %struct.lean_object** %1, align 8
  %7 = call %struct.lean_object* @lean_unsigned_to_nat(i32 0)
  store %struct.lean_object* %7, %struct.lean_object** %2, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__2, align 8
  store %struct.lean_object* %8, %struct.lean_object** %3, align 8
  %9 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 3, i32 0)
  store %struct.lean_object* %9, %struct.lean_object** %4, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  call void @lean_ctor_set(%struct.lean_object* %10, i32 0, %struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %13 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %12, i32 1, %struct.lean_object* %13)
  %14 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  %15 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  call void @lean_ctor_set(%struct.lean_object* %14, i32 2, %struct.lean_object* %15)
  %16 = load %struct.lean_object*, %struct.lean_object** %4, align 8
  ret %struct.lean_object* %16
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__4() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = call %struct.lean_object* @lean_mk_string(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.16, i64 0, i64 0))
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__5() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  br label %4

4:                                                ; preds = %0
  %5 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %5, %struct.lean_object** %1, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__4, align 8
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_name_mk_string(%struct.lean_object* %7, %struct.lean_object* %8)
  store %struct.lean_object* %9, %struct.lean_object** %3, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %10
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__6() #0 {
  %1 = alloca %struct.lean_object*, align 8
  br label %2

2:                                                ; preds = %0
  %3 = call %struct.lean_object* @lean_mk_string(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.17, i64 0, i64 0))
  store %struct.lean_object* %3, %struct.lean_object** %1, align 8
  %4 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  ret %struct.lean_object* %4
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__7() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  br label %4

4:                                                ; preds = %0
  %5 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__5, align 8
  store %struct.lean_object* %5, %struct.lean_object** %1, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__6, align 8
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  %9 = call %struct.lean_object* @lean_name_mk_string(%struct.lean_object* %7, %struct.lean_object* %8)
  store %struct.lean_object* %9, %struct.lean_object** %3, align 8
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %10
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__8() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  br label %4

4:                                                ; preds = %0
  %5 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %5, %struct.lean_object** %1, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__7, align 8
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = call %struct.lean_object* @lean_alloc_ctor(i32 0, i32 2, i32 0)
  store %struct.lean_object* %7, %struct.lean_object** %3, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %8, i32 0, %struct.lean_object* %9)
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  call void @lean_ctor_set(%struct.lean_object* %10, i32 1, %struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %12
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_myMacro____x40_qsort___hyg_178____closed__9() #0 {
  %1 = alloca %struct.lean_object*, align 8
  %2 = alloca %struct.lean_object*, align 8
  %3 = alloca %struct.lean_object*, align 8
  br label %4

4:                                                ; preds = %0
  %5 = call %struct.lean_object* @lean_box(i64 0)
  store %struct.lean_object* %5, %struct.lean_object** %1, align 8
  %6 = load %struct.lean_object*, %struct.lean_object** @l_myMacro____x40_qsort___hyg_178____closed__8, align 8
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = call %struct.lean_object* @lean_alloc_ctor(i32 1, i32 2, i32 0)
  store %struct.lean_object* %7, %struct.lean_object** %3, align 8
  %8 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %9 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  call void @lean_ctor_set(%struct.lean_object* %8, i32 0, %struct.lean_object* %9)
  %10 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  %11 = load %struct.lean_object*, %struct.lean_object** %1, align 8
  call void @lean_ctor_set(%struct.lean_object* %10, i32 1, %struct.lean_object* %11)
  %12 = load %struct.lean_object*, %struct.lean_object** %3, align 8
  ret %struct.lean_object* %12
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l___private_qsort_0__partitionAux___at_main___spec__3___boxed__const__1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.lean_object*, align 8
  br label %3

3:                                                ; preds = %0
  %4 = load i32, i32* @l_instInhabitedUInt32, align 4
  store i32 %4, i32* %1, align 4
  %5 = load i32, i32* %1, align 4
  %6 = call %struct.lean_object* @lean_box_uint32(i32 %5)
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %7
}

; Function Attrs: noinline nounwind optnone sspstrong uwtable
define internal %struct.lean_object* @_init_l_qsortAux___at_main___spec__2___boxed__const__1() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.lean_object*, align 8
  br label %3

3:                                                ; preds = %0
  %4 = load i32, i32* @l_instInhabitedUInt32, align 4
  store i32 %4, i32* %1, align 4
  %5 = load i32, i32* %1, align 4
  %6 = call %struct.lean_object* @lean_box_uint32(i32 %5)
  store %struct.lean_object* %6, %struct.lean_object** %2, align 8
  %7 = load %struct.lean_object*, %struct.lean_object** %2, align 8
  ret %struct.lean_object* %7
}

attributes #0 = { noinline nounwind optnone sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{!"clang version 11.1.0"}
