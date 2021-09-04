module  {
  func private @lean_ctor_get(!lz.value, i32) -> !lz.value
  func private @lean_mk_string(!lz.value) -> !lz.value
  func private @lean_closure_set(!lz.value, i32, !lz.value)
  func private @lean_alloc_closure(!lz.value, i32, i32) -> !lz.value
  func private @lean_apply_2(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @lean_apply_3(!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
  func private @lean_unsigned_to_nat(i32) -> !lz.value
  func private @lean_obj_tag(!lz.value) -> i32
  func private @lean_unbox_float(!lz.value) -> f64
  func private @lean_unbox_uint8(!lz.value) -> i8
  func private @lean_unbox_uint16(!lz.value) -> i16
  func private @lean_unbox_uint32(!lz.value) -> i32
  func private @lean_unbox_uint64(!lz.value) -> i32
  func private @lean_unbox_usize(!lz.value) -> i32
  func private @lean_unbox(!lz.value) -> i8
  func private @lean_inc(!lz.value)
  func private @lean_inc_n(!lz.value, i32)
  func private @lean_inc_ref(!lz.value)
  func private @lean_ctor_set(!lz.value, i32, !lz.value)
  func private @lean_dec(!lz.value)
  func private @lean_dec_n(!lz.value, i32)
  func private @lean_dec_ref(!lz.value)
  func private @lean_is_exclusive(!lz.value) -> i1
  func private @lean_is_scalar(!lz.value) -> i1
  func private @lean_io_mk_world() -> !lz.value
  func private @lean_io_result_get_value(!lz.value) -> !lz.value
  func private @lean_io_result_mk_ok(!lz.value) -> !lz.value
  func private @lean_mark_persistent(!lz.value)
  func private @lean_box_float(f64) -> !lz.value
  func private @lean_box_uint8(i8) -> !lz.value
  func private @lean_box_uint16(i16) -> !lz.value
  func private @lean_box_uint32(i32) -> !lz.value
  func private @lean_box_uint64(i32) -> !lz.value
  func private @lean_box_usize(i464) -> !lz.value
  func private @lean_box(i32) -> !lz.value
  func private @lean_ctor_get_float(!lz.value, i32) -> f64
  func private @lean_ctor_get_uint8(!lz.value, i32) -> i8
  func private @lean_ctor_get_uint16(!lz.value, i32) -> i16
  func private @lean_ctor_get_uint32(!lz.value, i32) -> i32
  func private @lean_ctor_get_uint64(!lz.value, i32) -> i32
  func private @lean_ctor_set_float(!lz.value, i32, f64)
  func private @lean_ctor_set_uint8(!lz.value, i32, i8)
  func private @lean_ctor_set_uint16(!lz.value, i32, i16)
  func private @lean_ctor_set_uint32(!lz.value, i32, i32)
  func private @lean_ctor_set_uint64(!lz.value, i32, i32)
  func private @lean_alloc_ctor(i32, i32, i32) -> !lz.value
  func private @lean_ctor_release(!lz.value, i32)
  func private @lean_ctor_set_tag(!lz.value, i32)
  func private @lean_cstr_to_nat(!lz.value) -> !lz.value
  func private @lean_free_object(!lz.value)
  func private @lean_name_mk_string(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Array_empty___closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_term_u2191____1___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_term_u2191____1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__6} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_term_u2191____1___closed__1} : () -> ()
  func private @lean_array_push(!lz.value, !lz.value) -> !lz.value
  func private @lean_array_get_size(!lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_term_u2191_____closed__3} : () -> ()
  func private @lean_string_utf8_byte_size(!lz.value) -> !lz.value
  func private @lean_uint32_of_nat(!lz.value) -> i32
  func private @lean_nat_add(!lz.value, !lz.value) -> !lz.value
  func private @l_Lean_MonadRef_mkInfoFromRefPos___at_myMacro____x40_Init_Notation___hyg_109____spec__1(!lz.value, !lz.value) -> !lz.value
  func private @lean_uint32_add(i32, i32) -> i32
  func private @l_UInt32_div(i32, i32) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_term_u2191____1___closed__3} : () -> ()
  func private @lean_nat_dec_eq(!lz.value, !lz.value) -> i8
  func private @lean_nat_sub(!lz.value, !lz.value) -> !lz.value
  func private @lean_array_swap(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @lean_array_get(!lz.value, !lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__9} : () -> ()
  func private @lean_uint32_lt(i32, i32) -> i8
  "ptr.global"() {type = !lz.value, value = @l___private_qsort_0__partitionAux___at_main___spec__2___boxed__const__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__4} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__8} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__2} : () -> ()
  func private @l_Lean_addMacroScope(!lz.value, !lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Lean_nullKind___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> ()
  "ptr.global"() {type = i32, value = @l_instInhabitedUInt32} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_Init_Notation___hyg_2191____closed__4} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__3} : () -> ()
  func private @lean_uint32_mul(i32, i32) -> i32
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__5} : () -> ()
  func private @l_Lean_Syntax_isOfKind(!lz.value, !lz.value) -> i8
  func private @l_Lean_Syntax_getArg(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_checkSortedAux___boxed__const__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_checkSortedAux___closed__1} : () -> ()
  func private @lean_uint32_le(i32, i32) -> i8
  "ptr.global"() {type = !lz.value, value = @l_myMacro____x40_qsort___hyg_178____closed__7} : () -> ()
  func private @lean_uint32_to_nat(i32) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_checkSortedAux___closed__2} : () -> ()
  func private @lean_nat_dec_lt(!lz.value, !lz.value) -> i8
  func @l_badRand(%arg0: i32) -> i32 {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c1664525_i32 = constant 1664525 : i32
    %1 = call @lean_uint32_mul(%arg0, %c1664525_i32) : (i32, i32) -> i32
    %c1013904223_i32 = constant 1013904223 : i32
    %2 = call @lean_uint32_add(%1, %c1013904223_i32) : (i32, i32) -> i32
    "rgn.return"(%2) : (i32) -> ()
  }
  func @l_badRand___boxed(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg0) : (!lz.value) -> i32
    call @lean_dec(%arg0) : (!lz.value) -> ()
    %2 = call @l_badRand(%1) {musttail = "false"} : (i32) -> i32
    %3 = call @lean_box_uint32(%2) : (i32) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l_mkRandomArray_match__1___rarg(%arg0: !lz.value, %arg1: i32, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg0, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg3) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg0, %6) : (!lz.value, !lz.value) -> !lz.value
      %8 = call @lean_box_uint32(%arg1) : (i32) -> !lz.value
      %9 = call @lean_apply_3(%arg4, %7, %8, %arg2) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg4) : (!lz.value) -> ()
      %6 = call @lean_box_uint32(%arg1) : (i32) -> !lz.value
      %7 = call @lean_apply_2(%arg3, %6, %arg2) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%7) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_mkRandomArray_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_mkRandomArray_match__1___rarg___boxed} : () -> !lz.value
    %c5_i32 = constant 5 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c5_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_mkRandomArray_match__1___rarg___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg1) : (!lz.value) -> i32
    call @lean_dec(%arg1) : (!lz.value) -> ()
    %2 = call @l_mkRandomArray_match__1___rarg(%arg0, %1, %arg2, %arg3, %arg4) {musttail = "false"} : (!lz.value, i32, !lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_mkRandomArray(%arg0: !lz.value, %arg1: i32, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg0, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg0, %6) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %8 = call @l_badRand(%arg1) {musttail = "false"} : (i32) -> i32
      %9 = call @lean_box_uint32(%arg1) : (i32) -> !lz.value
      %10 = call @lean_array_push(%arg2, %9) : (!lz.value, !lz.value) -> !lz.value
      %11 = call @l_mkRandomArray(%7, %8, %10) {musttail = "true"} : (!lz.value, i32, !lz.value) -> !lz.value
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg0) : (!lz.value) -> ()
      "rgn.return"(%arg2) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_mkRandomArray___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg1) : (!lz.value) -> i32
    call @lean_dec(%arg1) : (!lz.value) -> ()
    %2 = call @l_mkRandomArray(%arg0, %1, %arg2) {musttail = "false"} : (!lz.value, i32, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_checkSortedAux___lambda__1(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c1_i32 = constant 1 : i32
    %1 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
    %2 = call @lean_nat_add(%arg0, %1) : (!lz.value, !lz.value) -> !lz.value
    %3 = call @l_checkSortedAux(%arg1, %2, %arg3) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%2) : (!lz.value) -> ()
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_checkSortedAux___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "array is not sorted"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_checkSortedAux___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_checkSortedAux___closed__1} : () -> !lz.value
    %c18_i32 = constant 18 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_0 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c18_i32, %c1_i32, %c1_i32_0) : (i32, i32, i32) -> !lz.value
    %c0_i32_1 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_1, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_checkSortedAux___boxed__const__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_instInhabitedUInt32} : () -> i32
    %2 = call @lean_box_uint32(%1) : (i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_checkSortedAux(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_array_get_size(%arg0) : (!lz.value) -> !lz.value
    %c1_i32 = constant 1 : i32
    %2 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
    %3 = call @lean_nat_sub(%1, %2) : (!lz.value, !lz.value) -> !lz.value
    call @lean_dec(%1) : (!lz.value) -> ()
    %4 = call @lean_nat_dec_lt(%arg1, %3) : (!lz.value, !lz.value) -> i8
    call @lean_dec(%3) : (!lz.value) -> ()
    %5 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %8 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
      %c0_i32_1 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_2 = constant 2 : i32
      %9 = call @lean_alloc_ctor(%c0_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
      %c0_i32_3 = constant 0 : i32
      call @lean_ctor_set(%9, %c0_i32_3, %8) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_4 = constant 1 : i32
      call @lean_ctor_set(%9, %c1_i32_4, %arg2) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %6 = "rgn.val"() ( {
      %8 = "ptr.loadglobal"() {value = @l_checkSortedAux___boxed__const__1} : () -> !lz.value
      %9 = call @lean_array_get(%8, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %10 = call @lean_unbox_uint32(%9) : (!lz.value) -> i32
      call @lean_dec(%9) : (!lz.value) -> ()
      %11 = call @lean_nat_add(%arg1, %2) : (!lz.value, !lz.value) -> !lz.value
      %12 = "ptr.loadglobal"() {value = @l_checkSortedAux___boxed__const__1} : () -> !lz.value
      %13 = call @lean_array_get(%12, %arg0, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_dec(%11) : (!lz.value) -> ()
      %14 = call @lean_unbox_uint32(%13) : (!lz.value) -> i32
      call @lean_dec(%13) : (!lz.value) -> ()
      %15 = call @lean_uint32_le(%10, %14) : (i32, i32) -> i8
      %16 = "rgn.val"() ( {
        %19 = "ptr.loadglobal"() {value = @l_checkSortedAux___closed__2} : () -> !lz.value
        %c1_i32_0 = constant 1 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_1 = constant 2 : i32
        %20 = call @lean_alloc_ctor(%c1_i32_0, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
        %c0_i32_2 = constant 0 : i32
        call @lean_ctor_set(%20, %c0_i32_2, %19) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_3 = constant 1 : i32
        call @lean_ctor_set(%20, %c1_i32_3, %arg2) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%20) : (!lz.value) -> ()
      }) : () -> i42
      %17 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %19 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
        %20 = call @l_checkSortedAux___lambda__1(%arg1, %arg0, %19, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%20) : (!lz.value) -> ()
      }) : () -> i42
      %18 = "rgn.select"(%15, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%18) : (i42) -> ()
    }) : () -> i42
    %7 = "rgn.select"(%4, %5, %6) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%7) : (i42) -> ()
  }
  func @l_checkSortedAux___lambda__1___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_checkSortedAux___lambda__1(%arg0, %arg1, %arg2, %arg3) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg2) : (!lz.value) -> ()
    call @lean_dec(%arg1) : (!lz.value) -> ()
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_checkSortedAux___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_checkSortedAux(%arg0, %arg1, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg1) : (!lz.value) -> ()
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @_init_l_term_u2191____1___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "term\E2\86\91__1"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_term_u2191____1___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_term_u2191____1___closed__1} : () -> !lz.value
    %3 = call @lean_name_mk_string(%1, %2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_term_u2191____1___closed__3() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_term_u2191____1___closed__2} : () -> !lz.value
    %c1024_i32 = constant 1024 : i32
    %2 = call @lean_unsigned_to_nat(%c1024_i32) : (i32) -> !lz.value
    %3 = "ptr.loadglobal"() {value = @l_term_u2191_____closed__3} : () -> !lz.value
    %c3_i32 = constant 3 : i32
    %c3_i32_0 = constant 3 : i32
    %c3_i32_1 = constant 3 : i32
    %4 = call @lean_alloc_ctor(%c3_i32, %c3_i32_0, %c3_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%4, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    %c1_i32 = constant 1 : i32
    call @lean_ctor_set(%4, %c1_i32, %2) : (!lz.value, i32, !lz.value) -> ()
    %c2_i32 = constant 2 : i32
    call @lean_ctor_set(%4, %c2_i32, %3) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%4) : (!lz.value) -> ()
  }
  func @_init_l_term_u2191____1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_term_u2191____1___closed__3} : () -> !lz.value
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "UInt32.toNat"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__1} : () -> !lz.value
    %2 = call @lean_string_utf8_byte_size(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__3() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %3 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__2} : () -> !lz.value
    %c0_i32_1 = constant 0 : i32
    %c3_i32 = constant 3 : i32
    %c3_i32_2 = constant 3 : i32
    %4 = call @lean_alloc_ctor(%c0_i32_1, %c3_i32, %c3_i32_2) : (i32, i32, i32) -> !lz.value
    %c0_i32_3 = constant 0 : i32
    call @lean_ctor_set(%4, %c0_i32_3, %1) : (!lz.value, i32, !lz.value) -> ()
    %c1_i32 = constant 1 : i32
    call @lean_ctor_set(%4, %c1_i32, %2) : (!lz.value, i32, !lz.value) -> ()
    %c2_i32 = constant 2 : i32
    call @lean_ctor_set(%4, %c2_i32, %3) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%4) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__4() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "UInt32"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__5() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__4} : () -> !lz.value
    %3 = call @lean_name_mk_string(%1, %2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__6() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "toNat"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__7() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__5} : () -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__6} : () -> !lz.value
    %3 = call @lean_name_mk_string(%1, %2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__8() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__7} : () -> !lz.value
    %c0_i32_1 = constant 0 : i32
    %c2_i32 = constant 2 : i32
    %c2_i32_2 = constant 2 : i32
    %3 = call @lean_alloc_ctor(%c0_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
    %c0_i32_3 = constant 0 : i32
    call @lean_ctor_set(%3, %c0_i32_3, %2) : (!lz.value, i32, !lz.value) -> ()
    %c1_i32 = constant 1 : i32
    call @lean_ctor_set(%3, %c1_i32, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_myMacro____x40_qsort___hyg_178____closed__9() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__8} : () -> !lz.value
    %c1_i32 = constant 1 : i32
    %c2_i32 = constant 2 : i32
    %c2_i32_1 = constant 2 : i32
    %3 = call @lean_alloc_ctor(%c1_i32, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%3, %c0_i32_2, %2) : (!lz.value, i32, !lz.value) -> ()
    %c1_i32_3 = constant 1 : i32
    call @lean_ctor_set(%3, %c1_i32_3, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l_myMacro____x40_qsort___hyg_178_(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_term_u2191____1___closed__2} : () -> !lz.value
    call @lean_inc(%arg0) : (!lz.value) -> ()
    %2 = call @l_Lean_Syntax_isOfKind(%arg0, %1) {musttail = "false"} : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %6 = call @lean_box(%c1_i32) : (i32) -> !lz.value
      %c1_i32_0 = constant 1 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_1 = constant 2 : i32
      %7 = call @lean_alloc_ctor(%c1_i32_0, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
      %c0_i32_2 = constant 0 : i32
      call @lean_ctor_set(%7, %c0_i32_2, %6) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_3 = constant 1 : i32
      call @lean_ctor_set(%7, %c1_i32_3, %arg2) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%7) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @l_Lean_Syntax_getArg(%arg0, %6) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %8 = call @l_Lean_MonadRef_mkInfoFromRefPos___at_myMacro____x40_Init_Notation___hyg_109____spec__1(%arg1, %arg2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %9 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %13 = call @lean_ctor_get(%8, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_1 = constant 1 : i32
        %14 = call @lean_ctor_get(%8, %c1_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        call @lean_dec(%8) : (!lz.value) -> ()
        %c2_i32 = constant 2 : i32
        %15 = call @lean_ctor_get(%arg1, %c2_i32) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%15) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %16 = call @lean_ctor_get(%arg1, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%16) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %17 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__7} : () -> !lz.value
        %18 = call @l_Lean_addMacroScope(%16, %17, %15) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %19 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__3} : () -> !lz.value
        %20 = "ptr.loadglobal"() {value = @l_myMacro____x40_qsort___hyg_178____closed__9} : () -> !lz.value
        %c3_i32 = constant 3 : i32
        %c4_i32 = constant 4 : i32
        %c4_i32_3 = constant 4 : i32
        %21 = call @lean_alloc_ctor(%c3_i32, %c4_i32, %c4_i32_3) : (i32, i32, i32) -> !lz.value
        %c0_i32_4 = constant 0 : i32
        call @lean_ctor_set(%21, %c0_i32_4, %13) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_5 = constant 1 : i32
        call @lean_ctor_set(%21, %c1_i32_5, %19) : (!lz.value, i32, !lz.value) -> ()
        %c2_i32_6 = constant 2 : i32
        call @lean_ctor_set(%21, %c2_i32_6, %18) : (!lz.value, i32, !lz.value) -> ()
        %c3_i32_7 = constant 3 : i32
        call @lean_ctor_set(%21, %c3_i32_7, %20) : (!lz.value, i32, !lz.value) -> ()
        %22 = "ptr.loadglobal"() {value = @l_Array_empty___closed__1} : () -> !lz.value
        %23 = call @lean_array_push(%22, %21) : (!lz.value, !lz.value) -> !lz.value
        %24 = call @lean_array_push(%22, %7) : (!lz.value, !lz.value) -> !lz.value
        %25 = "ptr.loadglobal"() {value = @l_Lean_nullKind___closed__2} : () -> !lz.value
        %c1_i32_8 = constant 1 : i32
        %c2_i32_9 = constant 2 : i32
        %c2_i32_10 = constant 2 : i32
        %26 = call @lean_alloc_ctor(%c1_i32_8, %c2_i32_9, %c2_i32_10) : (i32, i32, i32) -> !lz.value
        %c0_i32_11 = constant 0 : i32
        call @lean_ctor_set(%26, %c0_i32_11, %25) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_12 = constant 1 : i32
        call @lean_ctor_set(%26, %c1_i32_12, %24) : (!lz.value, i32, !lz.value) -> ()
        %27 = call @lean_array_push(%23, %26) : (!lz.value, !lz.value) -> !lz.value
        %28 = "ptr.loadglobal"() {value = @l_myMacro____x40_Init_Notation___hyg_2191____closed__4} : () -> !lz.value
        %c1_i32_13 = constant 1 : i32
        %c2_i32_14 = constant 2 : i32
        %c2_i32_15 = constant 2 : i32
        %29 = call @lean_alloc_ctor(%c1_i32_13, %c2_i32_14, %c2_i32_15) : (i32, i32, i32) -> !lz.value
        %c0_i32_16 = constant 0 : i32
        call @lean_ctor_set(%29, %c0_i32_16, %28) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_17 = constant 1 : i32
        call @lean_ctor_set(%29, %c1_i32_17, %27) : (!lz.value, i32, !lz.value) -> ()
        %c0_i32_18 = constant 0 : i32
        %c2_i32_19 = constant 2 : i32
        %c2_i32_20 = constant 2 : i32
        %30 = call @lean_alloc_ctor(%c0_i32_18, %c2_i32_19, %c2_i32_20) : (i32, i32, i32) -> !lz.value
        %c0_i32_21 = constant 0 : i32
        call @lean_ctor_set(%30, %c0_i32_21, %29) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_22 = constant 1 : i32
        call @lean_ctor_set(%30, %c1_i32_22, %14) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%30) : (!lz.value) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %c0_i32_0 = constant 0 : i32
        %13 = call @lean_ctor_get(%8, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_1 = constant 1 : i32
        %14 = call @lean_ctor_get(%8, %c1_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        call @lean_dec(%8) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_3 = constant 2 : i32
        %15 = call @lean_alloc_ctor(%c1_i32_2, %c2_i32, %c2_i32_3) : (i32, i32, i32) -> !lz.value
        %c0_i32_4 = constant 0 : i32
        call @lean_ctor_set(%15, %c0_i32_4, %13) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_5 = constant 1 : i32
        call @lean_ctor_set(%15, %c1_i32_5, %14) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%15) : (!lz.value) -> ()
      }) : () -> i42
      %11 = call @lean_obj_tag(%8) : (!lz.value) -> i32
      %12 = "rgn.select"(%11, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l___private_qsort_0__partitionAux_match__1___rarg(%arg0: !lz.value, %arg1: i32, %arg2: i32, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_box_uint32(%arg1) : (i32) -> !lz.value
    %2 = call @lean_box_uint32(%arg2) : (i32) -> !lz.value
    %3 = call @lean_apply_3(%arg3, %arg0, %1, %2) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux_match__1(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l___private_qsort_0__partitionAux_match__1___rarg___boxed} : () -> !lz.value
    %c4_i32 = constant 4 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c4_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux_match__1___rarg___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg1) : (!lz.value) -> i32
    call @lean_dec(%arg1) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg2) : (!lz.value) -> i32
    call @lean_dec(%arg2) : (!lz.value) -> ()
    %3 = call @l___private_qsort_0__partitionAux_match__1___rarg(%arg0, %1, %2, %arg3) {musttail = "false"} : (!lz.value, i32, i32, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: i32, %arg3: !lz.value, %arg4: !lz.value, %arg5: i32, %arg6: i32) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_uint32_lt(%arg6, %arg2) : (i32, i32) -> i8
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %5 = call @lean_uint32_to_nat(%arg5) : (i32) -> !lz.value
      %6 = call @lean_uint32_to_nat(%arg2) : (i32) -> !lz.value
      %7 = call @lean_array_swap(%arg4, %5, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_dec(%6) : (!lz.value) -> ()
      call @lean_dec(%5) : (!lz.value) -> ()
      %8 = call @lean_box_uint32(%arg5) : (i32) -> !lz.value
      %c0_i32_0 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_1 = constant 2 : i32
      %9 = call @lean_alloc_ctor(%c0_i32_0, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
      %c0_i32_2 = constant 0 : i32
      call @lean_ctor_set(%9, %c0_i32_2, %8) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32 = constant 1 : i32
      call @lean_ctor_set(%9, %c1_i32, %7) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %5 = call @lean_uint32_to_nat(%arg6) : (i32) -> !lz.value
      call @lean_inc(%arg0) : (!lz.value) -> ()
      %6 = call @lean_array_get(%arg0, %arg4, %5) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_inc(%arg1) : (!lz.value) -> ()
      call @lean_inc(%arg3) : (!lz.value) -> ()
      %7 = call @lean_apply_2(%arg1, %6, %arg3) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %8 = call @lean_unbox_uint8(%7) : (!lz.value) -> i8
      call @lean_dec(%7) : (!lz.value) -> ()
      %9 = "rgn.val"() ( {
        call @lean_dec(%5) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_uint32_add(%arg6, %c1_i32) : (i32, i32) -> i32
        %13 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg2, %arg3, %arg4, %arg5, %12) {musttail = "true"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
        "rgn.return"(%13) : (!lz.value) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        %12 = call @lean_uint32_to_nat(%arg5) : (i32) -> !lz.value
        %13 = call @lean_array_swap(%arg4, %12, %5) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_dec(%5) : (!lz.value) -> ()
        call @lean_dec(%12) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %14 = call @lean_uint32_add(%arg5, %c1_i32) : (i32, i32) -> i32
        %15 = call @lean_uint32_add(%arg6, %c1_i32) : (i32, i32) -> i32
        %16 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg2, %arg3, %13, %14, %15) {musttail = "true"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
        "rgn.return"(%16) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.select"(%1, %2, %3) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l___private_qsort_0__partitionAux(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l___private_qsort_0__partitionAux___rarg___boxed} : () -> !lz.value
    %c7_i32 = constant 7 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c7_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux___rarg___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value, %arg5: !lz.value, %arg6: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg2) : (!lz.value) -> i32
    call @lean_dec(%arg2) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg5) : (!lz.value) -> i32
    call @lean_dec(%arg5) : (!lz.value) -> ()
    %3 = call @lean_unbox_uint32(%arg6) : (!lz.value) -> i32
    call @lean_dec(%arg6) : (!lz.value) -> ()
    %4 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %1, %arg3, %arg4, %2, %3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
    "rgn.return"(%4) : (!lz.value) -> ()
  }
  func @l_partition___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: i32, %arg4: i32) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_uint32_add(%arg3, %arg4) : (i32, i32) -> i32
    %c2_i32 = constant 2 : i32
    %2 = call @l_UInt32_div(%1, %c2_i32) {musttail = "false"} : (i32, i32) -> !lz.value
    %3 = call @lean_unbox_uint32(%2) : (!lz.value) -> i32
    call @lean_dec(%2) : (!lz.value) -> ()
    %4 = call @lean_uint32_to_nat(%3) : (i32) -> !lz.value
    call @lean_inc(%arg0) : (!lz.value) -> ()
    %5 = call @lean_array_get(%arg0, %arg1, %4) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    %6 = call @lean_uint32_to_nat(%arg3) : (i32) -> !lz.value
    call @lean_inc(%arg0) : (!lz.value) -> ()
    %7 = call @lean_array_get(%arg0, %arg1, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_inc(%arg2) : (!lz.value) -> ()
    %8 = call @lean_apply_2(%arg2, %5, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    %9 = call @lean_unbox_uint8(%8) : (!lz.value) -> i8
    call @lean_dec(%8) : (!lz.value) -> ()
    %10 = call @lean_uint32_to_nat(%arg4) : (i32) -> !lz.value
    %11 = "rgn.val"() ( {
    ^bb0(%arg5: !lz.value):  // no predecessors
      call @lean_inc(%arg0) : (!lz.value) -> ()
      %15 = call @lean_array_get(%arg0, %arg5, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_inc(%arg0) : (!lz.value) -> ()
      %16 = call @lean_array_get(%arg0, %arg5, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_inc(%arg2) : (!lz.value) -> ()
      call @lean_inc(%15) : (!lz.value) -> ()
      %17 = call @lean_apply_2(%arg2, %15, %16) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %18 = call @lean_unbox_uint8(%17) : (!lz.value) -> i8
      call @lean_dec(%17) : (!lz.value) -> ()
      %19 = "rgn.val"() ( {
        call @lean_dec(%6) : (!lz.value) -> ()
        call @lean_inc(%arg0) : (!lz.value) -> ()
        %22 = call @lean_array_get(%arg0, %arg5, %4) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_inc(%arg2) : (!lz.value) -> ()
        call @lean_inc(%15) : (!lz.value) -> ()
        %23 = call @lean_apply_2(%arg2, %22, %15) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %24 = call @lean_unbox_uint8(%23) : (!lz.value) -> i8
        call @lean_dec(%23) : (!lz.value) -> ()
        %25 = "rgn.val"() ( {
          call @lean_dec(%10) : (!lz.value) -> ()
          call @lean_dec(%4) : (!lz.value) -> ()
          %28 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg2, %arg4, %15, %arg5, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
          "rgn.return"(%28) : (!lz.value) -> ()
        }) : () -> i42
        %26 = "rgn.val"() ( {
          call @lean_dec(%15) : (!lz.value) -> ()
          %28 = call @lean_array_swap(%arg5, %4, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%4) : (!lz.value) -> ()
          call @lean_inc(%arg0) : (!lz.value) -> ()
          %29 = call @lean_array_get(%arg0, %28, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%10) : (!lz.value) -> ()
          %30 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg2, %arg4, %29, %28, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
          "rgn.return"(%30) : (!lz.value) -> ()
        }) : () -> i42
        %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%27) : (i42) -> ()
      }) : () -> i42
      %20 = "rgn.val"() ( {
        call @lean_dec(%15) : (!lz.value) -> ()
        %22 = call @lean_array_swap(%arg5, %6, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_dec(%6) : (!lz.value) -> ()
        call @lean_inc(%arg0) : (!lz.value) -> ()
        %23 = call @lean_array_get(%arg0, %22, %4) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_inc(%arg0) : (!lz.value) -> ()
        %24 = call @lean_array_get(%arg0, %22, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_inc(%arg2) : (!lz.value) -> ()
        call @lean_inc(%24) : (!lz.value) -> ()
        %25 = call @lean_apply_2(%arg2, %23, %24) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %26 = call @lean_unbox_uint8(%25) : (!lz.value) -> i8
        call @lean_dec(%25) : (!lz.value) -> ()
        %27 = "rgn.val"() ( {
          call @lean_dec(%10) : (!lz.value) -> ()
          call @lean_dec(%4) : (!lz.value) -> ()
          %30 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg2, %arg4, %24, %22, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
          "rgn.return"(%30) : (!lz.value) -> ()
        }) : () -> i42
        %28 = "rgn.val"() ( {
          call @lean_dec(%24) : (!lz.value) -> ()
          %30 = call @lean_array_swap(%22, %4, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%4) : (!lz.value) -> ()
          call @lean_inc(%arg0) : (!lz.value) -> ()
          %31 = call @lean_array_get(%arg0, %30, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%10) : (!lz.value) -> ()
          %32 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg2, %arg4, %31, %30, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
          "rgn.return"(%32) : (!lz.value) -> ()
        }) : () -> i42
        %29 = "rgn.select"(%26, %27, %28) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%29) : (i42) -> ()
      }) : () -> i42
      %21 = "rgn.select"(%18, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%21) : (i42) -> ()
    }) : () -> i42
    br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = "rgn.val"() ( {
      "rgn.jumpval"(%11, %arg1) : (i42, !lz.value) -> ()
    }) : () -> i42
    %13 = "rgn.val"() ( {
      %15 = call @lean_array_swap(%arg1, %6, %4) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.jumpval"(%11, %15) : (i42, !lz.value) -> ()
    }) : () -> i42
    %14 = "rgn.select"(%9, %12, %13) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%14) : (i42) -> ()
  }
  func @l_partition(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_partition___rarg___boxed} : () -> !lz.value
    %c5_i32 = constant 5 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c5_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_partition___rarg___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg3) : (!lz.value) -> i32
    call @lean_dec(%arg3) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg4) : (!lz.value) -> i32
    call @lean_dec(%arg4) : (!lz.value) -> ()
    %3 = call @l_partition___rarg(%arg0, %arg1, %arg2, %1, %2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l_qsortAux___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: i32, %arg4: i32) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_uint32_lt(%arg3, %arg4) : (i32, i32) -> i8
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      "rgn.return"(%arg2) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %5 = call @lean_uint32_add(%arg3, %arg4) : (i32, i32) -> i32
      %c2_i32 = constant 2 : i32
      %6 = call @l_UInt32_div(%5, %c2_i32) {musttail = "false"} : (i32, i32) -> !lz.value
      %7 = call @lean_unbox_uint32(%6) : (!lz.value) -> i32
      call @lean_dec(%6) : (!lz.value) -> ()
      %8 = call @lean_uint32_to_nat(%7) : (i32) -> !lz.value
      call @lean_inc(%arg0) : (!lz.value) -> ()
      %9 = call @lean_array_get(%arg0, %arg2, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %10 = call @lean_uint32_to_nat(%arg3) : (i32) -> !lz.value
      call @lean_inc(%arg0) : (!lz.value) -> ()
      %11 = call @lean_array_get(%arg0, %arg2, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_inc(%arg1) : (!lz.value) -> ()
      %12 = call @lean_apply_2(%arg1, %9, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %13 = call @lean_unbox_uint8(%12) : (!lz.value) -> i8
      call @lean_dec(%12) : (!lz.value) -> ()
      %14 = call @lean_uint32_to_nat(%arg4) : (i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %15 = "rgn.val"() ( {
      ^bb0(%arg5: !lz.value):  // no predecessors
        call @lean_inc(%arg0) : (!lz.value) -> ()
        %19 = call @lean_array_get(%arg0, %arg5, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_inc(%arg0) : (!lz.value) -> ()
        %20 = call @lean_array_get(%arg0, %arg5, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_inc(%arg1) : (!lz.value) -> ()
        call @lean_inc(%19) : (!lz.value) -> ()
        %21 = call @lean_apply_2(%arg1, %19, %20) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %22 = call @lean_unbox_uint8(%21) : (!lz.value) -> i8
        call @lean_dec(%21) : (!lz.value) -> ()
        %23 = "rgn.val"() ( {
          call @lean_dec(%10) : (!lz.value) -> ()
          call @lean_inc(%arg0) : (!lz.value) -> ()
          %26 = call @lean_array_get(%arg0, %arg5, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_inc(%arg1) : (!lz.value) -> ()
          call @lean_inc(%19) : (!lz.value) -> ()
          %27 = call @lean_apply_2(%arg1, %26, %19) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          %28 = call @lean_unbox_uint8(%27) : (!lz.value) -> i8
          call @lean_dec(%27) : (!lz.value) -> ()
          %29 = "rgn.val"() ( {
            call @lean_dec(%14) : (!lz.value) -> ()
            call @lean_dec(%8) : (!lz.value) -> ()
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %32 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg4, %19, %arg5, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %33 = call @lean_ctor_get(%32, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%33) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %34 = call @lean_ctor_get(%32, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%34) : (!lz.value) -> ()
            call @lean_dec(%32) : (!lz.value) -> ()
            %35 = call @lean_unbox_uint32(%33) : (!lz.value) -> i32
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %36 = call @l_qsortAux___rarg(%arg0, %arg1, %34, %arg3, %35) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            %37 = call @lean_unbox_uint32(%33) : (!lz.value) -> i32
            call @lean_dec(%33) : (!lz.value) -> ()
            %38 = call @lean_uint32_add(%37, %c1_i32) : (i32, i32) -> i32
            %39 = call @l_qsortAux___rarg(%arg0, %arg1, %36, %38, %arg4) {musttail = "true"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            "rgn.return"(%39) : (!lz.value) -> ()
          }) : () -> i42
          %30 = "rgn.val"() ( {
            call @lean_dec(%19) : (!lz.value) -> ()
            %32 = call @lean_array_swap(%arg5, %8, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%8) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %33 = call @lean_array_get(%arg0, %32, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%14) : (!lz.value) -> ()
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %34 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg4, %33, %32, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %35 = call @lean_ctor_get(%34, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%35) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %36 = call @lean_ctor_get(%34, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%36) : (!lz.value) -> ()
            call @lean_dec(%34) : (!lz.value) -> ()
            %37 = call @lean_unbox_uint32(%35) : (!lz.value) -> i32
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %38 = call @l_qsortAux___rarg(%arg0, %arg1, %36, %arg3, %37) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            %39 = call @lean_unbox_uint32(%35) : (!lz.value) -> i32
            call @lean_dec(%35) : (!lz.value) -> ()
            %40 = call @lean_uint32_add(%39, %c1_i32) : (i32, i32) -> i32
            %41 = call @l_qsortAux___rarg(%arg0, %arg1, %38, %40, %arg4) {musttail = "true"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            "rgn.return"(%41) : (!lz.value) -> ()
          }) : () -> i42
          %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%31) : (i42) -> ()
        }) : () -> i42
        %24 = "rgn.val"() ( {
          call @lean_dec(%19) : (!lz.value) -> ()
          %26 = call @lean_array_swap(%arg5, %10, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%10) : (!lz.value) -> ()
          call @lean_inc(%arg0) : (!lz.value) -> ()
          %27 = call @lean_array_get(%arg0, %26, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_inc(%arg0) : (!lz.value) -> ()
          %28 = call @lean_array_get(%arg0, %26, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_inc(%arg1) : (!lz.value) -> ()
          call @lean_inc(%28) : (!lz.value) -> ()
          %29 = call @lean_apply_2(%arg1, %27, %28) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          %30 = call @lean_unbox_uint8(%29) : (!lz.value) -> i8
          call @lean_dec(%29) : (!lz.value) -> ()
          %31 = "rgn.val"() ( {
            call @lean_dec(%14) : (!lz.value) -> ()
            call @lean_dec(%8) : (!lz.value) -> ()
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %34 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg4, %28, %26, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %35 = call @lean_ctor_get(%34, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%35) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %36 = call @lean_ctor_get(%34, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%36) : (!lz.value) -> ()
            call @lean_dec(%34) : (!lz.value) -> ()
            %37 = call @lean_unbox_uint32(%35) : (!lz.value) -> i32
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %38 = call @l_qsortAux___rarg(%arg0, %arg1, %36, %arg3, %37) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            %39 = call @lean_unbox_uint32(%35) : (!lz.value) -> i32
            call @lean_dec(%35) : (!lz.value) -> ()
            %40 = call @lean_uint32_add(%39, %c1_i32) : (i32, i32) -> i32
            %41 = call @l_qsortAux___rarg(%arg0, %arg1, %38, %40, %arg4) {musttail = "true"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            "rgn.return"(%41) : (!lz.value) -> ()
          }) : () -> i42
          %32 = "rgn.val"() ( {
            call @lean_dec(%28) : (!lz.value) -> ()
            %34 = call @lean_array_swap(%26, %8, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%8) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %35 = call @lean_array_get(%arg0, %34, %14) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%14) : (!lz.value) -> ()
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %36 = call @l___private_qsort_0__partitionAux___rarg(%arg0, %arg1, %arg4, %35, %34, %arg3, %arg3) {musttail = "false"} : (!lz.value, !lz.value, i32, !lz.value, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %37 = call @lean_ctor_get(%36, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%37) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %38 = call @lean_ctor_get(%36, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%38) : (!lz.value) -> ()
            call @lean_dec(%36) : (!lz.value) -> ()
            %39 = call @lean_unbox_uint32(%37) : (!lz.value) -> i32
            call @lean_inc(%arg1) : (!lz.value) -> ()
            call @lean_inc(%arg0) : (!lz.value) -> ()
            %40 = call @l_qsortAux___rarg(%arg0, %arg1, %38, %arg3, %39) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            %41 = call @lean_unbox_uint32(%37) : (!lz.value) -> i32
            call @lean_dec(%37) : (!lz.value) -> ()
            %42 = call @lean_uint32_add(%41, %c1_i32) : (i32, i32) -> i32
            %43 = call @l_qsortAux___rarg(%arg0, %arg1, %40, %42, %arg4) {musttail = "true"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
            "rgn.return"(%43) : (!lz.value) -> ()
          }) : () -> i42
          %33 = "rgn.select"(%30, %31, %32) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%33) : (i42) -> ()
        }) : () -> i42
        %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%25) : (i42) -> ()
      }) : () -> i42
      br ^bb1
    ^bb1:  // pred: ^bb0
      %16 = "rgn.val"() ( {
        "rgn.jumpval"(%15, %arg2) : (i42, !lz.value) -> ()
      }) : () -> i42
      %17 = "rgn.val"() ( {
        %19 = call @lean_array_swap(%arg2, %10, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.jumpval"(%15, %19) : (i42, !lz.value) -> ()
      }) : () -> i42
      %18 = "rgn.select"(%13, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%18) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.select"(%1, %2, %3) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_qsortAux(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_qsortAux___rarg___boxed} : () -> !lz.value
    %c5_i32 = constant 5 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c5_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_qsortAux___rarg___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg3) : (!lz.value) -> i32
    call @lean_dec(%arg3) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg4) : (!lz.value) -> i32
    call @lean_dec(%arg4) : (!lz.value) -> ()
    %3 = call @l_qsortAux___rarg(%arg0, %arg1, %arg2, %1, %2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l_qsort___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_array_get_size(%arg1) : (!lz.value) -> !lz.value
    %c1_i32 = constant 1 : i32
    %2 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
    %3 = call @lean_nat_sub(%1, %2) : (!lz.value, !lz.value) -> !lz.value
    call @lean_dec(%1) : (!lz.value) -> ()
    %4 = call @lean_uint32_of_nat(%3) : (!lz.value) -> i32
    call @lean_dec(%3) : (!lz.value) -> ()
    %5 = call @l_qsortAux___rarg(%arg0, %arg2, %arg1, %c0_i32_0, %4) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, i32, i32) -> !lz.value
    "rgn.return"(%5) : (!lz.value) -> ()
  }
  func @l_qsort(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_qsort___rarg} : () -> !lz.value
    %c3_i32 = constant 3 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c3_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l___private_qsort_0__partitionAux___at_main___spec__2___boxed__const__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_instInhabitedUInt32} : () -> i32
    %2 = call @lean_box_uint32(%1) : (i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux___at_main___spec__2(%arg0: i32, %arg1: i32, %arg2: !lz.value, %arg3: i32, %arg4: i32) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_uint32_lt(%arg4, %arg0) : (i32, i32) -> i8
    %2 = "rgn.val"() ( {
      %5 = call @lean_uint32_to_nat(%arg3) : (i32) -> !lz.value
      %6 = call @lean_uint32_to_nat(%arg0) : (i32) -> !lz.value
      %7 = call @lean_array_swap(%arg2, %5, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_dec(%6) : (!lz.value) -> ()
      call @lean_dec(%5) : (!lz.value) -> ()
      %8 = call @lean_box_uint32(%arg3) : (i32) -> !lz.value
      %c0_i32_0 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_1 = constant 2 : i32
      %9 = call @lean_alloc_ctor(%c0_i32_0, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
      %c0_i32_2 = constant 0 : i32
      call @lean_ctor_set(%9, %c0_i32_2, %8) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32 = constant 1 : i32
      call @lean_ctor_set(%9, %c1_i32, %7) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %5 = call @lean_uint32_to_nat(%arg4) : (i32) -> !lz.value
      %6 = "ptr.loadglobal"() {value = @l___private_qsort_0__partitionAux___at_main___spec__2___boxed__const__1} : () -> !lz.value
      %7 = call @lean_array_get(%6, %arg2, %5) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %8 = call @lean_unbox_uint32(%7) : (!lz.value) -> i32
      call @lean_dec(%7) : (!lz.value) -> ()
      %9 = call @lean_uint32_lt(%8, %arg1) : (i32, i32) -> i8
      %10 = "rgn.val"() ( {
        call @lean_dec(%5) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %13 = call @lean_uint32_add(%arg4, %c1_i32) : (i32, i32) -> i32
        %14 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg0, %arg1, %arg2, %arg3, %13) {musttail = "true"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
        "rgn.return"(%14) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.val"() ( {
        %13 = call @lean_uint32_to_nat(%arg3) : (i32) -> !lz.value
        %14 = call @lean_array_swap(%arg2, %13, %5) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        call @lean_dec(%5) : (!lz.value) -> ()
        call @lean_dec(%13) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %15 = call @lean_uint32_add(%arg3, %c1_i32) : (i32, i32) -> i32
        %16 = call @lean_uint32_add(%arg4, %c1_i32) : (i32, i32) -> i32
        %17 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg0, %arg1, %14, %15, %16) {musttail = "true"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
        "rgn.return"(%17) : (!lz.value) -> ()
      }) : () -> i42
      %12 = "rgn.select"(%9, %10, %11) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.select"(%1, %2, %3) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @_init_l_qsortAux___at_main___spec__1___boxed__const__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_instInhabitedUInt32} : () -> i32
    %2 = call @lean_box_uint32(%1) : (i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_qsortAux___at_main___spec__1(%arg0: !lz.value, %arg1: i32, %arg2: i32) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_uint32_lt(%arg1, %arg2) : (i32, i32) -> i8
    %2 = "rgn.val"() ( {
      "rgn.return"(%arg0) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %5 = call @lean_uint32_add(%arg1, %arg2) : (i32, i32) -> i32
      %c2_i32 = constant 2 : i32
      %6 = call @l_UInt32_div(%5, %c2_i32) {musttail = "false"} : (i32, i32) -> !lz.value
      %7 = call @lean_unbox_uint32(%6) : (!lz.value) -> i32
      call @lean_dec(%6) : (!lz.value) -> ()
      %8 = call @lean_uint32_to_nat(%7) : (i32) -> !lz.value
      %9 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
      %10 = call @lean_array_get(%9, %arg0, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %11 = call @lean_unbox_uint32(%10) : (!lz.value) -> i32
      call @lean_dec(%10) : (!lz.value) -> ()
      %12 = call @lean_uint32_to_nat(%arg1) : (i32) -> !lz.value
      %13 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
      %14 = call @lean_array_get(%13, %arg0, %12) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %15 = call @lean_unbox_uint32(%14) : (!lz.value) -> i32
      call @lean_dec(%14) : (!lz.value) -> ()
      %16 = call @lean_uint32_lt(%11, %15) : (i32, i32) -> i8
      %17 = call @lean_uint32_to_nat(%arg2) : (i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %18 = "rgn.val"() ( {
      ^bb0(%arg3: !lz.value):  // no predecessors
        %22 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
        %23 = call @lean_array_get(%22, %arg3, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %24 = call @lean_unbox_uint32(%23) : (!lz.value) -> i32
        call @lean_dec(%23) : (!lz.value) -> ()
        %25 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
        %26 = call @lean_array_get(%25, %arg3, %12) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        %27 = call @lean_unbox_uint32(%26) : (!lz.value) -> i32
        call @lean_dec(%26) : (!lz.value) -> ()
        %28 = call @lean_uint32_lt(%24, %27) : (i32, i32) -> i8
        %29 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          %32 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
          %33 = call @lean_array_get(%32, %arg3, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          %34 = call @lean_unbox_uint32(%33) : (!lz.value) -> i32
          call @lean_dec(%33) : (!lz.value) -> ()
          %35 = call @lean_uint32_lt(%34, %24) : (i32, i32) -> i8
          %36 = "rgn.val"() ( {
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%8) : (!lz.value) -> ()
            %39 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg2, %24, %arg3, %arg1, %arg1) {musttail = "false"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %40 = call @lean_ctor_get(%39, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%40) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %41 = call @lean_ctor_get(%39, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%41) : (!lz.value) -> ()
            call @lean_dec(%39) : (!lz.value) -> ()
            %42 = call @lean_unbox_uint32(%40) : (!lz.value) -> i32
            %43 = call @l_qsortAux___at_main___spec__1(%41, %arg1, %42) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
            %44 = call @lean_unbox_uint32(%40) : (!lz.value) -> i32
            call @lean_dec(%40) : (!lz.value) -> ()
            %45 = call @lean_uint32_add(%44, %c1_i32) : (i32, i32) -> i32
            %46 = call @l_qsortAux___at_main___spec__1(%43, %45, %arg2) {musttail = "true"} : (!lz.value, i32, i32) -> !lz.value
            "rgn.return"(%46) : (!lz.value) -> ()
          }) : () -> i42
          %37 = "rgn.val"() ( {
            %39 = call @lean_array_swap(%arg3, %8, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%8) : (!lz.value) -> ()
            %40 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
            %41 = call @lean_array_get(%40, %39, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%17) : (!lz.value) -> ()
            %42 = call @lean_unbox_uint32(%41) : (!lz.value) -> i32
            call @lean_dec(%41) : (!lz.value) -> ()
            %43 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg2, %42, %39, %arg1, %arg1) {musttail = "false"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %44 = call @lean_ctor_get(%43, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%44) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %45 = call @lean_ctor_get(%43, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%45) : (!lz.value) -> ()
            call @lean_dec(%43) : (!lz.value) -> ()
            %46 = call @lean_unbox_uint32(%44) : (!lz.value) -> i32
            %47 = call @l_qsortAux___at_main___spec__1(%45, %arg1, %46) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
            %48 = call @lean_unbox_uint32(%44) : (!lz.value) -> i32
            call @lean_dec(%44) : (!lz.value) -> ()
            %49 = call @lean_uint32_add(%48, %c1_i32) : (i32, i32) -> i32
            %50 = call @l_qsortAux___at_main___spec__1(%47, %49, %arg2) {musttail = "true"} : (!lz.value, i32, i32) -> !lz.value
            "rgn.return"(%50) : (!lz.value) -> ()
          }) : () -> i42
          %38 = "rgn.select"(%35, %36, %37) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%38) : (i42) -> ()
        }) : () -> i42
        %30 = "rgn.val"() ( {
          %32 = call @lean_array_swap(%arg3, %12, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          call @lean_dec(%12) : (!lz.value) -> ()
          %33 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
          %34 = call @lean_array_get(%33, %32, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          %35 = call @lean_unbox_uint32(%34) : (!lz.value) -> i32
          call @lean_dec(%34) : (!lz.value) -> ()
          %36 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
          %37 = call @lean_array_get(%36, %32, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          %38 = call @lean_unbox_uint32(%37) : (!lz.value) -> i32
          call @lean_dec(%37) : (!lz.value) -> ()
          %39 = call @lean_uint32_lt(%35, %38) : (i32, i32) -> i8
          %40 = "rgn.val"() ( {
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%8) : (!lz.value) -> ()
            %43 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg2, %38, %32, %arg1, %arg1) {musttail = "false"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %44 = call @lean_ctor_get(%43, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%44) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %45 = call @lean_ctor_get(%43, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%45) : (!lz.value) -> ()
            call @lean_dec(%43) : (!lz.value) -> ()
            %46 = call @lean_unbox_uint32(%44) : (!lz.value) -> i32
            %47 = call @l_qsortAux___at_main___spec__1(%45, %arg1, %46) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
            %48 = call @lean_unbox_uint32(%44) : (!lz.value) -> i32
            call @lean_dec(%44) : (!lz.value) -> ()
            %49 = call @lean_uint32_add(%48, %c1_i32) : (i32, i32) -> i32
            %50 = call @l_qsortAux___at_main___spec__1(%47, %49, %arg2) {musttail = "true"} : (!lz.value, i32, i32) -> !lz.value
            "rgn.return"(%50) : (!lz.value) -> ()
          }) : () -> i42
          %41 = "rgn.val"() ( {
            %43 = call @lean_array_swap(%32, %8, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%8) : (!lz.value) -> ()
            %44 = "ptr.loadglobal"() {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : () -> !lz.value
            %45 = call @lean_array_get(%44, %43, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            call @lean_dec(%17) : (!lz.value) -> ()
            %46 = call @lean_unbox_uint32(%45) : (!lz.value) -> i32
            call @lean_dec(%45) : (!lz.value) -> ()
            %47 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%arg2, %46, %43, %arg1, %arg1) {musttail = "false"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
            %c0_i32_0 = constant 0 : i32
            %48 = call @lean_ctor_get(%47, %c0_i32_0) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%48) : (!lz.value) -> ()
            %c1_i32_1 = constant 1 : i32
            %49 = call @lean_ctor_get(%47, %c1_i32_1) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%49) : (!lz.value) -> ()
            call @lean_dec(%47) : (!lz.value) -> ()
            %50 = call @lean_unbox_uint32(%48) : (!lz.value) -> i32
            %51 = call @l_qsortAux___at_main___spec__1(%49, %arg1, %50) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
            %52 = call @lean_unbox_uint32(%48) : (!lz.value) -> i32
            call @lean_dec(%48) : (!lz.value) -> ()
            %53 = call @lean_uint32_add(%52, %c1_i32) : (i32, i32) -> i32
            %54 = call @l_qsortAux___at_main___spec__1(%51, %53, %arg2) {musttail = "true"} : (!lz.value, i32, i32) -> !lz.value
            "rgn.return"(%54) : (!lz.value) -> ()
          }) : () -> i42
          %42 = "rgn.select"(%39, %40, %41) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%42) : (i42) -> ()
        }) : () -> i42
        %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%31) : (i42) -> ()
      }) : () -> i42
      br ^bb1
    ^bb1:  // pred: ^bb0
      %19 = "rgn.val"() ( {
        "rgn.jumpval"(%18, %arg0) : (i42, !lz.value) -> ()
      }) : () -> i42
      %20 = "rgn.val"() ( {
        %22 = call @lean_array_swap(%arg0, %12, %8) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.jumpval"(%18, %22) : (i42, !lz.value) -> ()
      }) : () -> i42
      %21 = "rgn.select"(%16, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%21) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.select"(%1, %2, %3) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_Nat_forM_loop___at_main___spec__3(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg1, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg1, %6) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %8 = call @lean_nat_sub(%arg0, %7) : (!lz.value, !lz.value) -> !lz.value
      %9 = call @lean_nat_sub(%8, %6) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%8) : (!lz.value) -> ()
      %10 = call @lean_uint32_of_nat(%9) : (!lz.value) -> i32
      %11 = "ptr.loadglobal"() {value = @l_Array_empty___closed__1} : () -> !lz.value
      %12 = call @l_mkRandomArray(%9, %10, %11) {musttail = "false"} : (!lz.value, i32, !lz.value) -> !lz.value
      %c0_i32_1 = constant 0 : i32
      %13 = call @lean_array_get_size(%12) : (!lz.value) -> !lz.value
      %14 = call @lean_nat_sub(%13, %6) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%13) : (!lz.value) -> ()
      %15 = call @lean_uint32_of_nat(%14) : (!lz.value) -> i32
      call @lean_dec(%14) : (!lz.value) -> ()
      %16 = call @l_qsortAux___at_main___spec__1(%12, %c0_i32_1, %15) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
      %17 = call @l_checkSortedAux(%16, %1, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
      call @lean_dec(%16) : (!lz.value) -> ()
      %18 = "rgn.val"() ( {
        %c1_i32_2 = constant 1 : i32
        %22 = call @lean_ctor_get(%17, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%22) : (!lz.value) -> ()
        call @lean_dec(%17) : (!lz.value) -> ()
        %23 = call @l_Nat_forM_loop___at_main___spec__3(%arg0, %7, %22) {musttail = "true"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%23) : (!lz.value) -> ()
      }) : () -> i42
      %19 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        %c0_i32_2 = constant 0 : i32
        %22 = call @lean_ctor_get(%17, %c0_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%22) : (!lz.value) -> ()
        %c1_i32_3 = constant 1 : i32
        %23 = call @lean_ctor_get(%17, %c1_i32_3) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%23) : (!lz.value) -> ()
        call @lean_dec(%17) : (!lz.value) -> ()
        %c1_i32_4 = constant 1 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_5 = constant 2 : i32
        %24 = call @lean_alloc_ctor(%c1_i32_4, %c2_i32, %c2_i32_5) : (i32, i32, i32) -> !lz.value
        %c0_i32_6 = constant 0 : i32
        call @lean_ctor_set(%24, %c0_i32_6, %22) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_7 = constant 1 : i32
        call @lean_ctor_set(%24, %c1_i32_7, %23) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%24) : (!lz.value) -> ()
      }) : () -> i42
      %20 = call @lean_obj_tag(%17) : (!lz.value) -> i32
      %21 = "rgn.select"(%20, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
      "rgn.jumpval"(%21) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_1 = constant 0 : i32
      %6 = call @lean_box(%c0_i32_1) : (i32) -> !lz.value
      %c0_i32_2 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_3 = constant 2 : i32
      %7 = call @lean_alloc_ctor(%c0_i32_2, %c2_i32, %c2_i32_3) : (i32, i32, i32) -> !lz.value
      %c0_i32_4 = constant 0 : i32
      call @lean_ctor_set(%7, %c0_i32_4, %6) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32 = constant 1 : i32
      call @lean_ctor_set(%7, %c1_i32, %arg2) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%7) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Nat_forM_loop___at_main___spec__4(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg1, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg1, %6) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c100_i32 = constant 100 : i32
      %8 = call @lean_unsigned_to_nat(%c100_i32) : (i32) -> !lz.value
      %9 = call @l_Nat_forM_loop___at_main___spec__3(%8, %8, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
      %10 = "rgn.val"() ( {
        %c1_i32_1 = constant 1 : i32
        %14 = call @lean_ctor_get(%9, %c1_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        call @lean_dec(%9) : (!lz.value) -> ()
        %15 = call @l_Nat_forM_loop___at_main___spec__4(%arg0, %7, %14) {musttail = "true"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%15) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %14 = call @lean_ctor_get(%9, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %15 = call @lean_ctor_get(%9, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%15) : (!lz.value) -> ()
        call @lean_dec(%9) : (!lz.value) -> ()
        %c1_i32_3 = constant 1 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_4 = constant 2 : i32
        %16 = call @lean_alloc_ctor(%c1_i32_3, %c2_i32, %c2_i32_4) : (i32, i32, i32) -> !lz.value
        %c0_i32_5 = constant 0 : i32
        call @lean_ctor_set(%16, %c0_i32_5, %14) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32_6 = constant 1 : i32
        call @lean_ctor_set(%16, %c1_i32_6, %15) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%16) : (!lz.value) -> ()
      }) : () -> i42
      %12 = call @lean_obj_tag(%9) : (!lz.value) -> i32
      %13 = "rgn.select"(%12, %10, %11) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
      "rgn.jumpval"(%13) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_1 = constant 0 : i32
      %6 = call @lean_box(%c0_i32_1) : (i32) -> !lz.value
      %c0_i32_2 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_3 = constant 2 : i32
      %7 = call @lean_alloc_ctor(%c0_i32_2, %c2_i32, %c2_i32_3) : (i32, i32, i32) -> !lz.value
      %c0_i32_4 = constant 0 : i32
      call @lean_ctor_set(%7, %c0_i32_4, %6) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32 = constant 1 : i32
      call @lean_ctor_set(%7, %c1_i32, %arg2) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%7) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @main_lean_custom_entrypoint_hack(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c100_i32 = constant 100 : i32
    %1 = call @lean_unsigned_to_nat(%c100_i32) : (i32) -> !lz.value
    %2 = call @l_Nat_forM_loop___at_main___spec__4(%1, %1, %arg0) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l___private_qsort_0__partitionAux___at_main___spec__2___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg0) : (!lz.value) -> i32
    call @lean_dec(%arg0) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg1) : (!lz.value) -> i32
    call @lean_dec(%arg1) : (!lz.value) -> ()
    %3 = call @lean_unbox_uint32(%arg3) : (!lz.value) -> i32
    call @lean_dec(%arg3) : (!lz.value) -> ()
    %4 = call @lean_unbox_uint32(%arg4) : (!lz.value) -> i32
    call @lean_dec(%arg4) : (!lz.value) -> ()
    %5 = call @l___private_qsort_0__partitionAux___at_main___spec__2(%1, %2, %arg2, %3, %4) {musttail = "false"} : (i32, i32, !lz.value, i32, i32) -> !lz.value
    "rgn.return"(%5) : (!lz.value) -> ()
  }
  func @l_qsortAux___at_main___spec__1___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_unbox_uint32(%arg1) : (!lz.value) -> i32
    call @lean_dec(%arg1) : (!lz.value) -> ()
    %2 = call @lean_unbox_uint32(%arg2) : (!lz.value) -> i32
    call @lean_dec(%arg2) : (!lz.value) -> ()
    %3 = call @l_qsortAux___at_main___spec__1(%arg0, %1, %2) {musttail = "false"} : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @l_Nat_forM_loop___at_main___spec__3___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Nat_forM_loop___at_main___spec__3(%arg0, %arg1, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_Nat_forM_loop___at_main___spec__4___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Nat_forM_loop___at_main___spec__4(%arg0, %arg1, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func private @initialize_Init(!lz.value) -> !lz.value
  func private @init_lean_custom_entrypoint_hack(%arg0: !lz.value) -> !lz.value {
    %0 = call @lean_io_mk_world() : () -> !lz.value
    %1 = call @initialize_Init(%0) : (!lz.value) -> !lz.value
    call @lean_dec_ref(%1) : (!lz.value) -> ()
    %2 = call @_init_l_checkSortedAux___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%2) {value = @l_checkSortedAux___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%2) : (!lz.value) -> ()
    %3 = call @_init_l_checkSortedAux___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%3) {value = @l_checkSortedAux___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%3) : (!lz.value) -> ()
    %4 = call @_init_l_checkSortedAux___boxed__const__1() : () -> !lz.value
    "ptr.storeglobal"(%4) {value = @l_checkSortedAux___boxed__const__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%4) : (!lz.value) -> ()
    %5 = call @_init_l_term_u2191____1___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%5) {value = @l_term_u2191____1___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%5) : (!lz.value) -> ()
    %6 = call @_init_l_term_u2191____1___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%6) {value = @l_term_u2191____1___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%6) : (!lz.value) -> ()
    %7 = call @_init_l_term_u2191____1___closed__3() : () -> !lz.value
    "ptr.storeglobal"(%7) {value = @l_term_u2191____1___closed__3} : (!lz.value) -> ()
    call @lean_mark_persistent(%7) : (!lz.value) -> ()
    %8 = call @_init_l_term_u2191____1() : () -> !lz.value
    "ptr.storeglobal"(%8) {value = @l_term_u2191____1} : (!lz.value) -> ()
    call @lean_mark_persistent(%8) : (!lz.value) -> ()
    %9 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__1() : () -> !lz.value
    "ptr.storeglobal"(%9) {value = @l_myMacro____x40_qsort___hyg_178____closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%9) : (!lz.value) -> ()
    %10 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__2() : () -> !lz.value
    "ptr.storeglobal"(%10) {value = @l_myMacro____x40_qsort___hyg_178____closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%10) : (!lz.value) -> ()
    %11 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__3() : () -> !lz.value
    "ptr.storeglobal"(%11) {value = @l_myMacro____x40_qsort___hyg_178____closed__3} : (!lz.value) -> ()
    call @lean_mark_persistent(%11) : (!lz.value) -> ()
    %12 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__4() : () -> !lz.value
    "ptr.storeglobal"(%12) {value = @l_myMacro____x40_qsort___hyg_178____closed__4} : (!lz.value) -> ()
    call @lean_mark_persistent(%12) : (!lz.value) -> ()
    %13 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__5() : () -> !lz.value
    "ptr.storeglobal"(%13) {value = @l_myMacro____x40_qsort___hyg_178____closed__5} : (!lz.value) -> ()
    call @lean_mark_persistent(%13) : (!lz.value) -> ()
    %14 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__6() : () -> !lz.value
    "ptr.storeglobal"(%14) {value = @l_myMacro____x40_qsort___hyg_178____closed__6} : (!lz.value) -> ()
    call @lean_mark_persistent(%14) : (!lz.value) -> ()
    %15 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__7() : () -> !lz.value
    "ptr.storeglobal"(%15) {value = @l_myMacro____x40_qsort___hyg_178____closed__7} : (!lz.value) -> ()
    call @lean_mark_persistent(%15) : (!lz.value) -> ()
    %16 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__8() : () -> !lz.value
    "ptr.storeglobal"(%16) {value = @l_myMacro____x40_qsort___hyg_178____closed__8} : (!lz.value) -> ()
    call @lean_mark_persistent(%16) : (!lz.value) -> ()
    %17 = call @_init_l_myMacro____x40_qsort___hyg_178____closed__9() : () -> !lz.value
    "ptr.storeglobal"(%17) {value = @l_myMacro____x40_qsort___hyg_178____closed__9} : (!lz.value) -> ()
    call @lean_mark_persistent(%17) : (!lz.value) -> ()
    %18 = call @_init_l___private_qsort_0__partitionAux___at_main___spec__2___boxed__const__1() : () -> !lz.value
    "ptr.storeglobal"(%18) {value = @l___private_qsort_0__partitionAux___at_main___spec__2___boxed__const__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%18) : (!lz.value) -> ()
    %19 = call @_init_l_qsortAux___at_main___spec__1___boxed__const__1() : () -> !lz.value
    "ptr.storeglobal"(%19) {value = @l_qsortAux___at_main___spec__1___boxed__const__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%19) : (!lz.value) -> ()
    %c0_i32 = constant 0 : i32
    %20 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %21 = call @lean_io_result_mk_ok(%20) : (!lz.value) -> !lz.value
    return %21 : !lz.value
  }
}

