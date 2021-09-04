module  {
  func private @lean_mk_string(!lz.value) -> !lz.value
  func private @lean_apply_3(!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
  func private @lean_ctor_get(!lz.value, i32) -> !lz.value
  func private @lean_closure_set(!lz.value, i32, !lz.value)
  func private @lean_alloc_closure(!lz.value, i32, i32) -> !lz.value
  func private @lean_apply_1(!lz.value, !lz.value) -> !lz.value
  func private @lean_apply_2(!lz.value, !lz.value, !lz.value) -> !lz.value
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
  "ptr.global"() {type = !lz.value, value = @l_Expr_pow___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_main___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_pow___closed__5} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_pow___closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_main___closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_instToStringExpr} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_pown___closed__1} : () -> ()
  func private @lean_string_append(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Expr_pow___closed__4} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_term___x5e_____closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_deriv___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__6} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_deriv___closed__1} : () -> ()
  func private @lean_nat_add(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Expr_instToStringExpr___closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_pow___closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Int_Int_pow___closed__1} : () -> ()
  func private @lean_uint32_add(i32, i32) -> i32
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__2} : () -> ()
  func private @lean_int_mod(!lz.value, !lz.value) -> !lz.value
  func private @lean_nat_dec_eq(!lz.value, !lz.value) -> i8
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__4} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__1} : () -> ()
  func private @lean_int_mul(!lz.value, !lz.value) -> !lz.value
  func private @lean_nat_sub(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_main___closed__1} : () -> ()
  func private @l_Nat_repr(!lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_term___x2a_____closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__7} : () -> ()
  func private @lean_int_neg(!lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_term_x2d_____closed__3} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_Expr_toString___closed__1} : () -> ()
  func private @lean_int_dec_lt(!lz.value, !lz.value) -> i8
  "ptr.global"() {type = !lz.value, value = @l_Int_instInhabitedInt___closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__8} : () -> ()
  func private @lean_nat_abs(!lz.value) -> !lz.value
  func private @lean_int_div(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__9} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_d___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_prec_x28___x29___closed__7} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_d___closed__1} : () -> ()
  func private @l_IO_println___at_Lean_instEval___spec__1(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_prec_x28___x29___closed__3} : () -> ()
  func private @lean_int_add(!lz.value, !lz.value) -> !lz.value
  "ptr.global"() {type = !lz.value, value = @l_Expr_add___closed__1} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Expr_add___closed__2} : () -> ()
  "ptr.global"() {type = !lz.value, value = @l_Lean_Parser_Syntax_addPrec___closed__11} : () -> ()
  func private @lean_int_dec_eq(!lz.value, !lz.value) -> i8
  "ptr.global"() {type = !lz.value, value = @l_Expr_mul___closed__5} : () -> ()
  func private @lean_uint32_to_nat(i32) -> !lz.value
  func private @lean_nat_to_int(!lz.value) -> !lz.value
  func private @lean_string_dec_eq(!lz.value, !lz.value) -> i8
  func @l_Expr_pown_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = call @lean_int_dec_lt(%arg1, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %6 = call @lean_nat_abs(%arg1) : (!lz.value) -> !lz.value
      %c0_i32_0 = constant 0 : i32
      %7 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
      %8 = call @lean_nat_dec_eq(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        call @lean_dec(%arg2) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%6, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%6) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          call @lean_dec(%arg3) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg4, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg4) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %17 = call @lean_apply_1(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%6) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        call @lean_dec(%arg3) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %12 = call @lean_apply_1(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
        "rgn.return"(%12) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %6 = call @lean_apply_2(%arg4, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%6) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_pown_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_pown_match__1___rarg} : () -> !lz.value
    %c5_i32 = constant 5 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c5_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pown___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c2_i32 = constant 2 : i32
    %1 = call @lean_unsigned_to_nat(%c2_i32) : (i32) -> !lz.value
    %2 = call @lean_nat_to_int(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_pown(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = call @lean_int_dec_lt(%arg1, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %6 = call @lean_nat_abs(%arg1) : (!lz.value) -> !lz.value
      %c0_i32_0 = constant 0 : i32
      %7 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
      %8 = call @lean_nat_dec_eq(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        %c1_i32 = constant 1 : i32
        %12 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%6, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%6) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          %17 = "ptr.loadglobal"() {value = @l_Expr_pown___closed__1} : () -> !lz.value
          %18 = call @lean_int_div(%arg1, %17) : (!lz.value, !lz.value) -> !lz.value
          %19 = call @l_Expr_pown(%arg0, %18) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          call @lean_dec(%18) : (!lz.value) -> ()
          %20 = call @lean_int_mul(%19, %19) : (!lz.value, !lz.value) -> !lz.value
          call @lean_dec(%19) : (!lz.value) -> ()
          %21 = call @lean_int_mod(%arg1, %17) : (!lz.value, !lz.value) -> !lz.value
          %22 = call @lean_int_dec_eq(%21, %1) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%21) : (!lz.value) -> ()
          %23 = "rgn.val"() ( {
            %26 = call @lean_int_mul(%20, %arg0) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%20) : (!lz.value) -> ()
            "rgn.return"(%26) : (!lz.value) -> ()
          }) : () -> i42
          %24 = "rgn.val"() ( {
            %26 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
            %27 = call @lean_int_mul(%20, %26) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%20) : (!lz.value) -> ()
            "rgn.return"(%27) : (!lz.value) -> ()
          }) : () -> i42
          %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%25) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_inc(%arg0) : (!lz.value) -> ()
          "rgn.return"(%arg0) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%6) : (!lz.value) -> ()
        %12 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
        "rgn.return"(%12) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      %6 = "ptr.loadglobal"() {value = @l_Expr_pown___closed__1} : () -> !lz.value
      %7 = call @lean_int_div(%arg1, %6) : (!lz.value, !lz.value) -> !lz.value
      %8 = call @l_Expr_pown(%arg0, %7) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%7) : (!lz.value) -> ()
      %9 = call @lean_int_mul(%8, %8) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%8) : (!lz.value) -> ()
      %10 = call @lean_int_mod(%arg1, %6) : (!lz.value, !lz.value) -> !lz.value
      %11 = call @lean_int_dec_eq(%10, %1) : (!lz.value, !lz.value) -> i8
      call @lean_dec(%10) : (!lz.value) -> ()
      %12 = "rgn.val"() ( {
        %15 = call @lean_int_mul(%9, %arg0) : (!lz.value, !lz.value) -> !lz.value
        call @lean_dec(%9) : (!lz.value) -> ()
        "rgn.return"(%15) : (!lz.value) -> ()
      }) : () -> i42
      %13 = "rgn.val"() ( {
        %15 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
        %16 = call @lean_int_mul(%9, %15) : (!lz.value, !lz.value) -> !lz.value
        call @lean_dec(%9) : (!lz.value) -> ()
        "rgn.return"(%16) : (!lz.value) -> ()
      }) : () -> i42
      %14 = "rgn.select"(%11, %12, %13) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%14) : (i42) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_pown___boxed(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_pown(%arg0, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg1) : (!lz.value) -> ()
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_Expr_add_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value, %arg5: !lz.value, %arg6: !lz.value, %arg7: !lz.value, %arg8: !lz.value, %arg9: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      call @lean_dec(%arg8) : (!lz.value) -> ()
      call @lean_dec(%arg7) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %7 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %8 = call @lean_int_dec_lt(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        %12 = call @lean_nat_abs(%6) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %14 = call @lean_nat_dec_eq(%12, %13) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%12) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg3) : (!lz.value) -> ()
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg9) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %24 = call @lean_int_dec_lt(%23, %7) : (!lz.value, !lz.value) -> i8
            %25 = "rgn.val"() ( {
              %28 = call @lean_nat_abs(%23) : (!lz.value) -> !lz.value
              %29 = call @lean_nat_dec_eq(%28, %13) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%28) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                %33 = call @lean_apply_2(%arg2, %6, %23) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%23) : (!lz.value) -> ()
                %33 = call @lean_apply_2(%arg2, %6, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              %28 = call @lean_apply_2(%arg2, %6, %23) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            %c1_i32 = constant 1 : i32
            %24 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%24) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              call @lean_dec(%arg9) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              call @lean_dec(%arg0) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %29 = call @lean_ctor_get(%23, %c0_i32_3) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%29) : (!lz.value) -> ()
              call @lean_dec(%23) : (!lz.value) -> ()
              %30 = call @lean_apply_3(%arg6, %6, %29, %24) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%30) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%24) : (!lz.value) -> ()
              call @lean_dec(%23) : (!lz.value) -> ()
              call @lean_dec(%6) : (!lz.value) -> ()
              call @lean_dec(%arg6) : (!lz.value) -> ()
              %29 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %27 = call @lean_obj_tag(%23) : (!lz.value) -> i32
            %28 = "rgn.select"(%27, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
            "rgn.jumpval"(%28) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%6) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %23 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %18, %19, %20) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg9) : (!lz.value) -> ()
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg3) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %22 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%22) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %23 = call @lean_int_dec_lt(%22, %7) : (!lz.value, !lz.value) -> i8
            %24 = "rgn.val"() ( {
              %27 = call @lean_nat_abs(%22) : (!lz.value) -> !lz.value
              %28 = call @lean_nat_dec_eq(%27, %13) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%27) : (!lz.value) -> ()
              %29 = "rgn.val"() ( {
                %32 = call @lean_apply_2(%arg2, %7, %22) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                call @lean_dec(%22) : (!lz.value) -> ()
                %32 = call @lean_apply_2(%arg2, %7, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              %27 = call @lean_apply_2(%arg2, %7, %22) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.select"(%23, %24, %25) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %22 = call @lean_apply_1(%arg3, %arg1) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%22) : (!lz.value) -> ()
          }) : () -> i42
          %20 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %21 = "rgn.select"(%20, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.select"(%14, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%17) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg3) : (!lz.value) -> ()
        %12 = "rgn.val"() ( {
          call @lean_dec(%arg9) : (!lz.value) -> ()
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %18 = call @lean_int_dec_lt(%17, %7) : (!lz.value, !lz.value) -> i8
          %19 = "rgn.val"() ( {
            %22 = call @lean_nat_abs(%17) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%22, %23) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%22) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              %28 = call @lean_apply_2(%arg2, %6, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%17) : (!lz.value) -> ()
              %28 = call @lean_apply_2(%arg2, %6, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            %22 = call @lean_apply_2(%arg2, %6, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%22) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.select"(%18, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg2) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          %c1_i32 = constant 1 : i32
          %18 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%18) : (!lz.value) -> ()
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg9) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%17, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            %24 = call @lean_apply_3(%arg6, %6, %23, %18) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%24) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%18) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            %23 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%17) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg2) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %12, %13, %14) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg9) : (!lz.value) -> ()
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %7 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%7) : (!lz.value) -> ()
      %8 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%6) : (!lz.value) -> ()
        call @lean_dec(%arg8) : (!lz.value) -> ()
        call @lean_dec(%arg7) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %14 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %15 = call @lean_int_dec_lt(%13, %14) : (!lz.value, !lz.value) -> i8
        %16 = "rgn.val"() ( {
          %19 = call @lean_nat_abs(%13) : (!lz.value) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          %20 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
          %21 = call @lean_nat_dec_eq(%19, %20) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%19) : (!lz.value) -> ()
          %22 = "rgn.val"() ( {
            call @lean_dec(%arg4) : (!lz.value) -> ()
            %25 = call @lean_apply_2(%arg5, %arg0, %13) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%25) : (!lz.value) -> ()
          }) : () -> i42
          %23 = "rgn.val"() ( {
            call @lean_dec(%13) : (!lz.value) -> ()
            call @lean_dec(%arg5) : (!lz.value) -> ()
            %25 = call @lean_apply_1(%arg4, %arg0) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%25) : (!lz.value) -> ()
          }) : () -> i42
          %24 = "rgn.select"(%21, %22, %23) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%24) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.val"() ( {
          call @lean_dec(%arg4) : (!lz.value) -> ()
          %19 = call @lean_apply_2(%arg5, %arg0, %13) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%19) : (!lz.value) -> ()
        }) : () -> i42
        %18 = "rgn.select"(%15, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        call @lean_dec(%arg5) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %14 = call @lean_ctor_get(%arg1, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          call @lean_dec(%7) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg8) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_3 = constant 0 : i32
          %19 = call @lean_ctor_get(%13, %c0_i32_3) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%19) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          %20 = call @lean_apply_3(%arg7, %arg0, %19, %14) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%14) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          call @lean_dec(%arg7) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %19 = call @lean_apply_3(%arg8, %6, %7, %arg1) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%19) : (!lz.value) -> ()
        }) : () -> i42
        %17 = call @lean_obj_tag(%13) : (!lz.value) -> i32
        %18 = "rgn.select"(%17, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg5) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        call @lean_dec(%arg0) : (!lz.value) -> ()
        %13 = call @lean_apply_3(%arg8, %6, %7, %arg1) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%13) : (!lz.value) -> ()
      }) : () -> i42
      %11 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %12 = "rgn.select"(%11, %8, %9, %10) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg8) : (!lz.value) -> ()
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %6 = "rgn.val"() ( {
        call @lean_dec(%arg9) : (!lz.value) -> ()
        call @lean_dec(%arg7) : (!lz.value) -> ()
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %12 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %13 = call @lean_int_dec_lt(%11, %12) : (!lz.value, !lz.value) -> i8
        %14 = "rgn.val"() ( {
          %17 = call @lean_nat_abs(%11) : (!lz.value) -> !lz.value
          %c0_i32_1 = constant 0 : i32
          %18 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%17, %18) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%17) : (!lz.value) -> ()
          %20 = "rgn.val"() ( {
            call @lean_dec(%arg4) : (!lz.value) -> ()
            %23 = call @lean_apply_2(%arg5, %arg0, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%11) : (!lz.value) -> ()
            call @lean_dec(%arg5) : (!lz.value) -> ()
            %23 = call @lean_apply_1(%arg4, %arg0) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg4) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg5, %arg0, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %7 = "rgn.val"() ( {
        call @lean_dec(%arg5) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%12) : (!lz.value) -> ()
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg9) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%11, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %18 = call @lean_apply_3(%arg7, %arg0, %17, %12) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%18) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          call @lean_dec(%arg7) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%11) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %13, %14) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %8 = "rgn.val"() ( {
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg5) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %11 = call @lean_apply_2(%arg9, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %9 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %10 = "rgn.select"(%9, %6, %7, %8) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %4 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %5 = "rgn.select"(%4, %1, %2, %3) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_add_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_add_match__1___rarg} : () -> !lz.value
    %c10_i32 = constant 10 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c10_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_add___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = call @lean_int_add(%1, %1) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_add___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_add___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_add(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %7 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %8 = call @lean_int_dec_lt(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        %12 = call @lean_nat_abs(%6) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %14 = call @lean_nat_dec_eq(%12, %13) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%12) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %24 = call @lean_int_dec_lt(%23, %7) : (!lz.value, !lz.value) -> i8
            %25 = "rgn.val"() ( {
              %28 = call @lean_nat_abs(%23) : (!lz.value) -> !lz.value
              %29 = call @lean_nat_dec_eq(%28, %13) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%28) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                %33 = call @lean_int_add(%6, %23) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%23) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32 = constant 1 : i32
                %c1_i32_4 = constant 1 : i32
                %34 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
                %c0_i32_5 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_5, %33) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%23) : (!lz.value) -> ()
                %33 = call @lean_int_add(%6, %7) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32 = constant 1 : i32
                %c1_i32_4 = constant 1 : i32
                %34 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
                %c0_i32_5 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_5, %33) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              %28 = call @lean_int_add(%6, %23) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%23) : (!lz.value) -> ()
              call @lean_dec(%6) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %29 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%29, %c0_i32_5, %28) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            %c1_i32 = constant 1 : i32
            %24 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%24) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              call @lean_dec(%arg1) : (!lz.value) -> ()
              call @lean_dec(%arg0) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %29 = call @lean_ctor_get(%23, %c0_i32_3) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%29) : (!lz.value) -> ()
              call @lean_dec(%23) : (!lz.value) -> ()
              %30 = call @lean_int_add(%6, %29) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%29) : (!lz.value) -> ()
              call @lean_dec(%6) : (!lz.value) -> ()
              %c0_i32_4 = constant 0 : i32
              %c1_i32_5 = constant 1 : i32
              %c1_i32_6 = constant 1 : i32
              %31 = call @lean_alloc_ctor(%c0_i32_4, %c1_i32_5, %c1_i32_6) : (i32, i32, i32) -> !lz.value
              %c0_i32_7 = constant 0 : i32
              call @lean_ctor_set(%31, %c0_i32_7, %30) : (!lz.value, i32, !lz.value) -> ()
              %32 = call @l_Expr_add(%31, %24) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%32) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%24) : (!lz.value) -> ()
              call @lean_dec(%23) : (!lz.value) -> ()
              call @lean_dec(%6) : (!lz.value) -> ()
              %c2_i32 = constant 2 : i32
              %c2_i32_3 = constant 2 : i32
              %c2_i32_4 = constant 2 : i32
              %29 = call @lean_alloc_ctor(%c2_i32, %c2_i32_3, %c2_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%29, %c0_i32_5, %arg0) : (!lz.value, i32, !lz.value) -> ()
              %c1_i32_6 = constant 1 : i32
              call @lean_ctor_set(%29, %c1_i32_6, %arg1) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %27 = call @lean_obj_tag(%23) : (!lz.value) -> i32
            %28 = "rgn.select"(%27, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
            "rgn.jumpval"(%28) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%6) : (!lz.value) -> ()
            %c2_i32 = constant 2 : i32
            %c2_i32_2 = constant 2 : i32
            %c2_i32_3 = constant 2 : i32
            %23 = call @lean_alloc_ctor(%c2_i32, %c2_i32_2, %c2_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_4, %arg0) : (!lz.value, i32, !lz.value) -> ()
            %c1_i32 = constant 1 : i32
            call @lean_ctor_set(%23, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %18, %19, %20) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %18 = "rgn.val"() ( {
            %c0_i32_2 = constant 0 : i32
            %22 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%22) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %23 = call @lean_int_dec_lt(%22, %7) : (!lz.value, !lz.value) -> i8
            %24 = "rgn.val"() ( {
              %27 = call @lean_nat_abs(%22) : (!lz.value) -> !lz.value
              %28 = call @lean_nat_dec_eq(%27, %13) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%27) : (!lz.value) -> ()
              %29 = "rgn.val"() ( {
                %32 = call @lean_int_add(%7, %22) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%22) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32 = constant 1 : i32
                %c1_i32_4 = constant 1 : i32
                %33 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
                %c0_i32_5 = constant 0 : i32
                call @lean_ctor_set(%33, %c0_i32_5, %32) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                call @lean_dec(%22) : (!lz.value) -> ()
                %32 = "ptr.loadglobal"() {value = @l_Expr_add___closed__2} : () -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              %27 = call @lean_int_add(%7, %22) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%22) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %28 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%28, %c0_i32_5, %27) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.select"(%23, %24, %25) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            "rgn.return"(%arg1) : (!lz.value) -> ()
          }) : () -> i42
          %20 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %21 = "rgn.select"(%20, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.select"(%14, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%17) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        %12 = "rgn.val"() ( {
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %18 = call @lean_int_dec_lt(%17, %7) : (!lz.value, !lz.value) -> i8
          %19 = "rgn.val"() ( {
            %22 = call @lean_nat_abs(%17) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%22, %23) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%22) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              %28 = call @lean_int_add(%6, %17) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%17) : (!lz.value) -> ()
              call @lean_dec(%6) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %29 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%29, %c0_i32_5, %28) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%17) : (!lz.value) -> ()
              %28 = call @lean_int_add(%6, %7) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%6) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %29 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%29, %c0_i32_5, %28) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            %22 = call @lean_int_add(%6, %17) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %c1_i32 = constant 1 : i32
            %c1_i32_3 = constant 1 : i32
            %23 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32, %c1_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_4, %22) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.select"(%18, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          %c1_i32 = constant 1 : i32
          %18 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%18) : (!lz.value) -> ()
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg1) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%17, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            %24 = call @lean_int_add(%6, %23) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%23) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c0_i32_3 = constant 0 : i32
            %c1_i32_4 = constant 1 : i32
            %c1_i32_5 = constant 1 : i32
            %25 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
            %c0_i32_6 = constant 0 : i32
            call @lean_ctor_set(%25, %c0_i32_6, %24) : (!lz.value, i32, !lz.value) -> ()
            %26 = call @l_Expr_add(%25, %18) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%26) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%18) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c2_i32 = constant 2 : i32
            %c2_i32_2 = constant 2 : i32
            %c2_i32_3 = constant 2 : i32
            %23 = call @lean_alloc_ctor(%c2_i32, %c2_i32_2, %c2_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_4, %arg0) : (!lz.value, i32, !lz.value) -> ()
            %c1_i32_5 = constant 1 : i32
            call @lean_ctor_set(%23, %c1_i32_5, %arg1) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%17) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %c2_i32_2 = constant 2 : i32
          %17 = call @lean_alloc_ctor(%c2_i32, %c2_i32_1, %c2_i32_2) : (i32, i32, i32) -> !lz.value
          %c0_i32_3 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32 = constant 1 : i32
          call @lean_ctor_set(%17, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %12, %13, %14) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %7 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%7) : (!lz.value) -> ()
      %8 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%6) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %14 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %15 = call @lean_int_dec_lt(%13, %14) : (!lz.value, !lz.value) -> i8
        %16 = "rgn.val"() ( {
          %19 = call @lean_nat_abs(%13) : (!lz.value) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          %20 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
          %21 = call @lean_nat_dec_eq(%19, %20) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%19) : (!lz.value) -> ()
          %22 = "rgn.val"() ( {
            %c0_i32_3 = constant 0 : i32
            %c1_i32_4 = constant 1 : i32
            %c1_i32_5 = constant 1 : i32
            %25 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
            %c0_i32_6 = constant 0 : i32
            call @lean_ctor_set(%25, %c0_i32_6, %13) : (!lz.value, i32, !lz.value) -> ()
            %26 = call @l_Expr_add(%25, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%26) : (!lz.value) -> ()
          }) : () -> i42
          %23 = "rgn.val"() ( {
            call @lean_dec(%13) : (!lz.value) -> ()
            "rgn.return"(%arg0) : (!lz.value) -> ()
          }) : () -> i42
          %24 = "rgn.select"(%21, %22, %23) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%24) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.val"() ( {
          %c0_i32_2 = constant 0 : i32
          %c1_i32_3 = constant 1 : i32
          %c1_i32_4 = constant 1 : i32
          %19 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32_3, %c1_i32_4) : (i32, i32, i32) -> !lz.value
          %c0_i32_5 = constant 0 : i32
          call @lean_ctor_set(%19, %c0_i32_5, %13) : (!lz.value, i32, !lz.value) -> ()
          %20 = call @l_Expr_add(%19, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %18 = "rgn.select"(%15, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %14 = call @lean_ctor_get(%arg1, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          call @lean_dec(%7) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_3 = constant 0 : i32
          %19 = call @lean_ctor_get(%13, %c0_i32_3) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%19) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          %c0_i32_4 = constant 0 : i32
          %c1_i32_5 = constant 1 : i32
          %c1_i32_6 = constant 1 : i32
          %20 = call @lean_alloc_ctor(%c0_i32_4, %c1_i32_5, %c1_i32_6) : (i32, i32, i32) -> !lz.value
          %c0_i32_7 = constant 0 : i32
          call @lean_ctor_set(%20, %c0_i32_7, %19) : (!lz.value, i32, !lz.value) -> ()
          %21 = call @l_Expr_add(%arg0, %14) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %22 = call @l_Expr_add(%20, %21) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%22) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%14) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %19 = call @l_Expr_add(%7, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %20 = call @l_Expr_add(%6, %19) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %17 = call @lean_obj_tag(%13) : (!lz.value) -> i32
        %18 = "rgn.select"(%17, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg0) : (!lz.value) -> ()
        %13 = call @l_Expr_add(%7, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
        %14 = call @l_Expr_add(%6, %13) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
        "rgn.return"(%14) : (!lz.value) -> ()
      }) : () -> i42
      %11 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %12 = "rgn.select"(%11, %8, %9, %10) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %6 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %12 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %13 = call @lean_int_dec_lt(%11, %12) : (!lz.value, !lz.value) -> i8
        %14 = "rgn.val"() ( {
          %17 = call @lean_nat_abs(%11) : (!lz.value) -> !lz.value
          %c0_i32_1 = constant 0 : i32
          %18 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%17, %18) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%17) : (!lz.value) -> ()
          %20 = "rgn.val"() ( {
            %c0_i32_2 = constant 0 : i32
            %c1_i32 = constant 1 : i32
            %c1_i32_3 = constant 1 : i32
            %23 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32, %c1_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_4, %11) : (!lz.value, i32, !lz.value) -> ()
            %24 = call @l_Expr_add(%23, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%24) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%11) : (!lz.value) -> ()
            "rgn.return"(%arg0) : (!lz.value) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          %c0_i32_1 = constant 0 : i32
          %c1_i32 = constant 1 : i32
          %c1_i32_2 = constant 1 : i32
          %17 = call @lean_alloc_ctor(%c0_i32_1, %c1_i32, %c1_i32_2) : (i32, i32, i32) -> !lz.value
          %c0_i32_3 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_3, %11) : (!lz.value, i32, !lz.value) -> ()
          %18 = call @l_Expr_add(%17, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%18) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %7 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%12) : (!lz.value) -> ()
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%11, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %c0_i32_2 = constant 0 : i32
          %c1_i32_3 = constant 1 : i32
          %c1_i32_4 = constant 1 : i32
          %18 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32_3, %c1_i32_4) : (i32, i32, i32) -> !lz.value
          %c0_i32_5 = constant 0 : i32
          call @lean_ctor_set(%18, %c0_i32_5, %17) : (!lz.value, i32, !lz.value) -> ()
          %19 = call @l_Expr_add(%arg0, %12) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %20 = call @l_Expr_add(%18, %19) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %c2_i32_2 = constant 2 : i32
          %17 = call @lean_alloc_ctor(%c2_i32, %c2_i32_1, %c2_i32_2) : (i32, i32, i32) -> !lz.value
          %c0_i32_3 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32_4 = constant 1 : i32
          call @lean_ctor_set(%17, %c1_i32_4, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%11) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %13, %14) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %8 = "rgn.val"() ( {
        %c2_i32 = constant 2 : i32
        %c2_i32_0 = constant 2 : i32
        %c2_i32_1 = constant 2 : i32
        %11 = call @lean_alloc_ctor(%c2_i32, %c2_i32_0, %c2_i32_1) : (i32, i32, i32) -> !lz.value
        %c0_i32_2 = constant 0 : i32
        call @lean_ctor_set(%11, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32 = constant 1 : i32
        call @lean_ctor_set(%11, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %9 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %10 = "rgn.select"(%9, %6, %7, %8) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %4 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %5 = "rgn.select"(%4, %1, %2, %3) {case0 = 0 : i64, case1 = 2 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_mul_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value, %arg5: !lz.value, %arg6: !lz.value, %arg7: !lz.value, %arg8: !lz.value, %arg9: !lz.value, %arg10: !lz.value, %arg11: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      call @lean_dec(%arg10) : (!lz.value) -> ()
      call @lean_dec(%arg9) : (!lz.value) -> ()
      call @lean_dec(%arg7) : (!lz.value) -> ()
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %7 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %8 = call @lean_int_dec_lt(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        %12 = call @lean_nat_abs(%6) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %14 = call @lean_nat_dec_eq(%12, %13) : (!lz.value, !lz.value) -> i8
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg3) : (!lz.value) -> ()
          %c1_i32 = constant 1 : i32
          %18 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%12, %18) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%12) : (!lz.value) -> ()
          %20 = "rgn.val"() ( {
            call @lean_dec(%arg5) : (!lz.value) -> ()
            %23 = "rgn.val"() ( {
              call @lean_dec(%arg11) : (!lz.value) -> ()
              call @lean_dec(%arg8) : (!lz.value) -> ()
              call @lean_dec(%arg0) : (!lz.value) -> ()
              %c0_i32_2 = constant 0 : i32
              %28 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%28) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              %29 = call @lean_int_dec_lt(%28, %7) : (!lz.value, !lz.value) -> i8
              %30 = "rgn.val"() ( {
                %33 = call @lean_nat_abs(%28) : (!lz.value) -> !lz.value
                %34 = call @lean_nat_dec_eq(%33, %13) : (!lz.value, !lz.value) -> i8
                %35 = "rgn.val"() ( {
                  %38 = call @lean_nat_dec_eq(%33, %18) : (!lz.value, !lz.value) -> i8
                  call @lean_dec(%33) : (!lz.value) -> ()
                  %39 = "rgn.val"() ( {
                    %42 = call @lean_apply_2(%arg2, %6, %28) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                    "rgn.return"(%42) : (!lz.value) -> ()
                  }) : () -> i42
                  %40 = "rgn.val"() ( {
                    call @lean_dec(%28) : (!lz.value) -> ()
                    %42 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                    %43 = call @lean_apply_2(%arg2, %6, %42) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                    "rgn.return"(%43) : (!lz.value) -> ()
                  }) : () -> i42
                  %41 = "rgn.select"(%38, %39, %40) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                  "rgn.jumpval"(%41) : (i42) -> ()
                }) : () -> i42
                %36 = "rgn.val"() ( {
                  call @lean_dec(%33) : (!lz.value) -> ()
                  call @lean_dec(%28) : (!lz.value) -> ()
                  %38 = call @lean_apply_2(%arg2, %6, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%38) : (!lz.value) -> ()
                }) : () -> i42
                %37 = "rgn.select"(%34, %35, %36) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%37) : (i42) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                %33 = call @lean_apply_2(%arg2, %6, %28) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%arg2) : (!lz.value) -> ()
              %c0_i32_2 = constant 0 : i32
              %28 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%28) : (!lz.value) -> ()
              %c1_i32_3 = constant 1 : i32
              %29 = call @lean_ctor_get(%arg1, %c1_i32_3) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%29) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                call @lean_dec(%arg11) : (!lz.value) -> ()
                call @lean_dec(%arg1) : (!lz.value) -> ()
                call @lean_dec(%arg0) : (!lz.value) -> ()
                %c0_i32_4 = constant 0 : i32
                %34 = call @lean_ctor_get(%28, %c0_i32_4) : (!lz.value, i32) -> !lz.value
                call @lean_inc(%34) : (!lz.value) -> ()
                call @lean_dec(%28) : (!lz.value) -> ()
                %35 = call @lean_apply_3(%arg8, %6, %34, %29) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%35) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%29) : (!lz.value) -> ()
                call @lean_dec(%28) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                call @lean_dec(%arg8) : (!lz.value) -> ()
                %34 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %32 = call @lean_obj_tag(%28) : (!lz.value) -> i32
              %33 = "rgn.select"(%32, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
              "rgn.jumpval"(%33) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              call @lean_dec(%6) : (!lz.value) -> ()
              call @lean_dec(%arg8) : (!lz.value) -> ()
              call @lean_dec(%arg2) : (!lz.value) -> ()
              %28 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
            %27 = "rgn.select"(%26, %23, %24, %25) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%6) : (!lz.value) -> ()
            call @lean_dec(%arg11) : (!lz.value) -> ()
            call @lean_dec(%arg8) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %23 = "rgn.val"() ( {
              call @lean_dec(%arg5) : (!lz.value) -> ()
              %c0_i32_2 = constant 0 : i32
              %27 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%27) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              %28 = call @lean_int_dec_lt(%27, %7) : (!lz.value, !lz.value) -> i8
              %29 = "rgn.val"() ( {
                %32 = call @lean_nat_abs(%27) : (!lz.value) -> !lz.value
                %33 = call @lean_nat_dec_eq(%32, %13) : (!lz.value, !lz.value) -> i8
                %34 = "rgn.val"() ( {
                  %37 = call @lean_nat_dec_eq(%32, %18) : (!lz.value, !lz.value) -> i8
                  call @lean_dec(%32) : (!lz.value) -> ()
                  %38 = "rgn.val"() ( {
                    %41 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                    %42 = call @lean_apply_2(%arg2, %41, %27) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                    "rgn.return"(%42) : (!lz.value) -> ()
                  }) : () -> i42
                  %39 = "rgn.val"() ( {
                    call @lean_dec(%27) : (!lz.value) -> ()
                    %41 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                    %42 = call @lean_apply_2(%arg2, %41, %41) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                    "rgn.return"(%42) : (!lz.value) -> ()
                  }) : () -> i42
                  %40 = "rgn.select"(%37, %38, %39) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                  "rgn.jumpval"(%40) : (i42) -> ()
                }) : () -> i42
                %35 = "rgn.val"() ( {
                  call @lean_dec(%32) : (!lz.value) -> ()
                  call @lean_dec(%27) : (!lz.value) -> ()
                  %37 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                  %38 = call @lean_apply_2(%arg2, %37, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%38) : (!lz.value) -> ()
                }) : () -> i42
                %36 = "rgn.select"(%33, %34, %35) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%36) : (i42) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                %32 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %33 = call @lean_apply_2(%arg2, %32, %27) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%arg2) : (!lz.value) -> ()
              %27 = call @lean_apply_1(%arg5, %arg1) : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %25 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
            %26 = "rgn.select"(%25, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg11) : (!lz.value) -> ()
          call @lean_dec(%arg8) : (!lz.value) -> ()
          call @lean_dec(%arg5) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg3) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %22 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%22) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %23 = call @lean_int_dec_lt(%22, %7) : (!lz.value, !lz.value) -> i8
            %24 = "rgn.val"() ( {
              %27 = call @lean_nat_abs(%22) : (!lz.value) -> !lz.value
              %28 = call @lean_nat_dec_eq(%27, %13) : (!lz.value, !lz.value) -> i8
              %29 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %32 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %33 = call @lean_nat_dec_eq(%27, %32) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%27) : (!lz.value) -> ()
                %34 = "rgn.val"() ( {
                  %37 = call @lean_apply_2(%arg2, %7, %22) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.val"() ( {
                  call @lean_dec(%22) : (!lz.value) -> ()
                  %37 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                  %38 = call @lean_apply_2(%arg2, %7, %37) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%38) : (!lz.value) -> ()
                }) : () -> i42
                %36 = "rgn.select"(%33, %34, %35) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%36) : (i42) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                call @lean_dec(%27) : (!lz.value) -> ()
                call @lean_dec(%22) : (!lz.value) -> ()
                %32 = call @lean_apply_2(%arg2, %7, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              %27 = call @lean_apply_2(%arg2, %7, %22) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.select"(%23, %24, %25) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %22 = call @lean_apply_1(%arg3, %arg1) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%22) : (!lz.value) -> ()
          }) : () -> i42
          %20 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %21 = "rgn.select"(%20, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.select"(%14, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%17) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg5) : (!lz.value) -> ()
        call @lean_dec(%arg3) : (!lz.value) -> ()
        %12 = "rgn.val"() ( {
          call @lean_dec(%arg11) : (!lz.value) -> ()
          call @lean_dec(%arg8) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %18 = call @lean_int_dec_lt(%17, %7) : (!lz.value, !lz.value) -> i8
          %19 = "rgn.val"() ( {
            %22 = call @lean_nat_abs(%17) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%22, %23) : (!lz.value, !lz.value) -> i8
            %25 = "rgn.val"() ( {
              %c1_i32 = constant 1 : i32
              %28 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
              %29 = call @lean_nat_dec_eq(%22, %28) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%22) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                %33 = call @lean_apply_2(%arg2, %6, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%17) : (!lz.value) -> ()
                %33 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %34 = call @lean_apply_2(%arg2, %6, %33) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%22) : (!lz.value) -> ()
              call @lean_dec(%17) : (!lz.value) -> ()
              %28 = call @lean_apply_2(%arg2, %6, %7) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            %22 = call @lean_apply_2(%arg2, %6, %17) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%22) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.select"(%18, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg2) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          %c1_i32 = constant 1 : i32
          %18 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%18) : (!lz.value) -> ()
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg11) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%17, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            %24 = call @lean_apply_3(%arg8, %6, %23, %18) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%24) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%18) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            call @lean_dec(%arg8) : (!lz.value) -> ()
            %23 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%17) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg8) : (!lz.value) -> ()
          call @lean_dec(%arg2) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %12, %13, %14) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg11) : (!lz.value) -> ()
      call @lean_dec(%arg8) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %7 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%7) : (!lz.value) -> ()
      %8 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%6) : (!lz.value) -> ()
        call @lean_dec(%arg10) : (!lz.value) -> ()
        call @lean_dec(%arg9) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %14 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %15 = call @lean_int_dec_lt(%13, %14) : (!lz.value, !lz.value) -> i8
        %16 = "rgn.val"() ( {
          %19 = call @lean_nat_abs(%13) : (!lz.value) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          %20 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
          %21 = call @lean_nat_dec_eq(%19, %20) : (!lz.value, !lz.value) -> i8
          %22 = "rgn.val"() ( {
            call @lean_dec(%arg4) : (!lz.value) -> ()
            %c1_i32_3 = constant 1 : i32
            %25 = call @lean_unsigned_to_nat(%c1_i32_3) : (i32) -> !lz.value
            %26 = call @lean_nat_dec_eq(%19, %25) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%19) : (!lz.value) -> ()
            %27 = "rgn.val"() ( {
              call @lean_dec(%arg6) : (!lz.value) -> ()
              %30 = call @lean_apply_2(%arg7, %arg0, %13) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%30) : (!lz.value) -> ()
            }) : () -> i42
            %28 = "rgn.val"() ( {
              call @lean_dec(%13) : (!lz.value) -> ()
              call @lean_dec(%arg7) : (!lz.value) -> ()
              %30 = call @lean_apply_1(%arg6, %arg0) : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%30) : (!lz.value) -> ()
            }) : () -> i42
            %29 = "rgn.select"(%26, %27, %28) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%29) : (i42) -> ()
          }) : () -> i42
          %23 = "rgn.val"() ( {
            call @lean_dec(%19) : (!lz.value) -> ()
            call @lean_dec(%13) : (!lz.value) -> ()
            call @lean_dec(%arg7) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            %25 = call @lean_apply_1(%arg4, %arg0) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%25) : (!lz.value) -> ()
          }) : () -> i42
          %24 = "rgn.select"(%21, %22, %23) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%24) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.val"() ( {
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg4) : (!lz.value) -> ()
          %19 = call @lean_apply_2(%arg7, %arg0, %13) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%19) : (!lz.value) -> ()
        }) : () -> i42
        %18 = "rgn.select"(%15, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg6) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %14 = call @lean_ctor_get(%arg1, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          call @lean_dec(%7) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg10) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_3 = constant 0 : i32
          %19 = call @lean_ctor_get(%13, %c0_i32_3) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%19) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          %20 = call @lean_apply_3(%arg9, %arg0, %19, %14) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%14) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          call @lean_dec(%arg9) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %19 = call @lean_apply_3(%arg10, %6, %7, %arg1) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%19) : (!lz.value) -> ()
        }) : () -> i42
        %17 = call @lean_obj_tag(%13) : (!lz.value) -> i32
        %18 = "rgn.select"(%17, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg9) : (!lz.value) -> ()
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg6) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        call @lean_dec(%arg0) : (!lz.value) -> ()
        %13 = call @lean_apply_3(%arg10, %6, %7, %arg1) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%13) : (!lz.value) -> ()
      }) : () -> i42
      %11 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %12 = "rgn.select"(%11, %8, %9, %10) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg10) : (!lz.value) -> ()
      call @lean_dec(%arg8) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %6 = "rgn.val"() ( {
        call @lean_dec(%arg11) : (!lz.value) -> ()
        call @lean_dec(%arg9) : (!lz.value) -> ()
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %12 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %13 = call @lean_int_dec_lt(%11, %12) : (!lz.value, !lz.value) -> i8
        %14 = "rgn.val"() ( {
          %17 = call @lean_nat_abs(%11) : (!lz.value) -> !lz.value
          %c0_i32_1 = constant 0 : i32
          %18 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%17, %18) : (!lz.value, !lz.value) -> i8
          %20 = "rgn.val"() ( {
            call @lean_dec(%arg4) : (!lz.value) -> ()
            %c1_i32 = constant 1 : i32
            %23 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%17, %23) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%17) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              call @lean_dec(%arg6) : (!lz.value) -> ()
              %28 = call @lean_apply_2(%arg7, %arg0, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%11) : (!lz.value) -> ()
              call @lean_dec(%arg7) : (!lz.value) -> ()
              %28 = call @lean_apply_1(%arg6, %arg0) : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%11) : (!lz.value) -> ()
            call @lean_dec(%arg7) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            %23 = call @lean_apply_1(%arg4, %arg0) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg4) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg7, %arg0, %11) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %7 = "rgn.val"() ( {
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg6) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%12) : (!lz.value) -> ()
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg11) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%11, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %18 = call @lean_apply_3(%arg9, %arg0, %17, %12) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%18) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          call @lean_dec(%arg9) : (!lz.value) -> ()
          %17 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%11) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %13, %14) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %8 = "rgn.val"() ( {
        call @lean_dec(%arg9) : (!lz.value) -> ()
        call @lean_dec(%arg7) : (!lz.value) -> ()
        call @lean_dec(%arg6) : (!lz.value) -> ()
        call @lean_dec(%arg4) : (!lz.value) -> ()
        %11 = call @lean_apply_2(%arg11, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %9 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %10 = "rgn.select"(%9, %6, %7, %8) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %4 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %5 = "rgn.select"(%4, %1, %2, %3) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_mul_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_mul_match__1___rarg} : () -> !lz.value
    %c12_i32 = constant 12 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c12_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %2 = call @lean_int_mul(%1, %1) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__3() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %3 = call @lean_int_mul(%1, %2) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__4() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__3} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__5() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %3 = call @lean_int_mul(%1, %2) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__6() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__5} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__7() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = call @lean_int_mul(%1, %1) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__8() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__7} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_mul___closed__9() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_mul(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %7 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %8 = call @lean_int_dec_lt(%6, %7) : (!lz.value, !lz.value) -> i8
      %9 = "rgn.val"() ( {
        %12 = call @lean_nat_abs(%6) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %14 = call @lean_nat_dec_eq(%12, %13) : (!lz.value, !lz.value) -> i8
        %15 = "rgn.val"() ( {
          %c1_i32 = constant 1 : i32
          %18 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%12, %18) : (!lz.value, !lz.value) -> i8
          call @lean_dec(%12) : (!lz.value) -> ()
          %20 = "rgn.val"() ( {
            %23 = "rgn.val"() ( {
              call @lean_dec(%arg0) : (!lz.value) -> ()
              %c0_i32_2 = constant 0 : i32
              %28 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%28) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              %29 = call @lean_int_dec_lt(%28, %7) : (!lz.value, !lz.value) -> i8
              %30 = "rgn.val"() ( {
                %33 = call @lean_nat_abs(%28) : (!lz.value) -> !lz.value
                %34 = call @lean_nat_dec_eq(%33, %13) : (!lz.value, !lz.value) -> i8
                %35 = "rgn.val"() ( {
                  %38 = call @lean_nat_dec_eq(%33, %18) : (!lz.value, !lz.value) -> i8
                  call @lean_dec(%33) : (!lz.value) -> ()
                  %39 = "rgn.val"() ( {
                    %42 = call @lean_int_mul(%6, %28) : (!lz.value, !lz.value) -> !lz.value
                    call @lean_dec(%28) : (!lz.value) -> ()
                    call @lean_dec(%6) : (!lz.value) -> ()
                    %c0_i32_3 = constant 0 : i32
                    %c1_i32_4 = constant 1 : i32
                    %c1_i32_5 = constant 1 : i32
                    %43 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                    %c0_i32_6 = constant 0 : i32
                    call @lean_ctor_set(%43, %c0_i32_6, %42) : (!lz.value, i32, !lz.value) -> ()
                    "rgn.return"(%43) : (!lz.value) -> ()
                  }) : () -> i42
                  %40 = "rgn.val"() ( {
                    call @lean_dec(%28) : (!lz.value) -> ()
                    %42 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                    %43 = call @lean_int_mul(%6, %42) : (!lz.value, !lz.value) -> !lz.value
                    call @lean_dec(%6) : (!lz.value) -> ()
                    %c0_i32_3 = constant 0 : i32
                    %c1_i32_4 = constant 1 : i32
                    %c1_i32_5 = constant 1 : i32
                    %44 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                    %c0_i32_6 = constant 0 : i32
                    call @lean_ctor_set(%44, %c0_i32_6, %43) : (!lz.value, i32, !lz.value) -> ()
                    "rgn.return"(%44) : (!lz.value) -> ()
                  }) : () -> i42
                  %41 = "rgn.select"(%38, %39, %40) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                  "rgn.jumpval"(%41) : (i42) -> ()
                }) : () -> i42
                %36 = "rgn.val"() ( {
                  call @lean_dec(%33) : (!lz.value) -> ()
                  call @lean_dec(%28) : (!lz.value) -> ()
                  %38 = call @lean_int_mul(%6, %7) : (!lz.value, !lz.value) -> !lz.value
                  call @lean_dec(%6) : (!lz.value) -> ()
                  %c0_i32_3 = constant 0 : i32
                  %c1_i32_4 = constant 1 : i32
                  %c1_i32_5 = constant 1 : i32
                  %39 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                  %c0_i32_6 = constant 0 : i32
                  call @lean_ctor_set(%39, %c0_i32_6, %38) : (!lz.value, i32, !lz.value) -> ()
                  "rgn.return"(%39) : (!lz.value) -> ()
                }) : () -> i42
                %37 = "rgn.select"(%34, %35, %36) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%37) : (i42) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                %33 = call @lean_int_mul(%6, %28) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%28) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %34 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_6, %33) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              %c0_i32_2 = constant 0 : i32
              %28 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%28) : (!lz.value) -> ()
              %c1_i32_3 = constant 1 : i32
              %29 = call @lean_ctor_get(%arg1, %c1_i32_3) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%29) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                call @lean_dec(%arg1) : (!lz.value) -> ()
                call @lean_dec(%arg0) : (!lz.value) -> ()
                %c0_i32_4 = constant 0 : i32
                %34 = call @lean_ctor_get(%28, %c0_i32_4) : (!lz.value, i32) -> !lz.value
                call @lean_inc(%34) : (!lz.value) -> ()
                call @lean_dec(%28) : (!lz.value) -> ()
                %35 = call @lean_int_mul(%6, %34) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%34) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_5 = constant 0 : i32
                %c1_i32_6 = constant 1 : i32
                %c1_i32_7 = constant 1 : i32
                %36 = call @lean_alloc_ctor(%c0_i32_5, %c1_i32_6, %c1_i32_7) : (i32, i32, i32) -> !lz.value
                %c0_i32_8 = constant 0 : i32
                call @lean_ctor_set(%36, %c0_i32_8, %35) : (!lz.value, i32, !lz.value) -> ()
                %37 = call @l_Expr_mul(%36, %29) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
                "rgn.return"(%37) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%29) : (!lz.value) -> ()
                call @lean_dec(%28) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                %c3_i32 = constant 3 : i32
                %c2_i32 = constant 2 : i32
                %c2_i32_4 = constant 2 : i32
                %34 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_4) : (i32, i32, i32) -> !lz.value
                %c0_i32_5 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_5, %arg0) : (!lz.value, i32, !lz.value) -> ()
                %c1_i32_6 = constant 1 : i32
                call @lean_ctor_set(%34, %c1_i32_6, %arg1) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %32 = call @lean_obj_tag(%28) : (!lz.value) -> i32
              %33 = "rgn.select"(%32, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
              "rgn.jumpval"(%33) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              call @lean_dec(%6) : (!lz.value) -> ()
              %c3_i32 = constant 3 : i32
              %c2_i32 = constant 2 : i32
              %c2_i32_2 = constant 2 : i32
              %28 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
              %c0_i32_3 = constant 0 : i32
              call @lean_ctor_set(%28, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
              %c1_i32_4 = constant 1 : i32
              call @lean_ctor_set(%28, %c1_i32_4, %arg1) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
            %27 = "rgn.select"(%26, %23, %24, %25) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%6) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %23 = "rgn.val"() ( {
              %c0_i32_2 = constant 0 : i32
              %27 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
              call @lean_inc(%27) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              %28 = call @lean_int_dec_lt(%27, %7) : (!lz.value, !lz.value) -> i8
              %29 = "rgn.val"() ( {
                %32 = call @lean_nat_abs(%27) : (!lz.value) -> !lz.value
                %33 = call @lean_nat_dec_eq(%32, %13) : (!lz.value, !lz.value) -> i8
                %34 = "rgn.val"() ( {
                  %37 = call @lean_nat_dec_eq(%32, %18) : (!lz.value, !lz.value) -> i8
                  call @lean_dec(%32) : (!lz.value) -> ()
                  %38 = "rgn.val"() ( {
                    %41 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                    %42 = call @lean_int_mul(%41, %27) : (!lz.value, !lz.value) -> !lz.value
                    call @lean_dec(%27) : (!lz.value) -> ()
                    %c0_i32_3 = constant 0 : i32
                    %c1_i32_4 = constant 1 : i32
                    %c1_i32_5 = constant 1 : i32
                    %43 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                    %c0_i32_6 = constant 0 : i32
                    call @lean_ctor_set(%43, %c0_i32_6, %42) : (!lz.value, i32, !lz.value) -> ()
                    "rgn.return"(%43) : (!lz.value) -> ()
                  }) : () -> i42
                  %39 = "rgn.val"() ( {
                    call @lean_dec(%27) : (!lz.value) -> ()
                    %41 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__2} : () -> !lz.value
                    "rgn.return"(%41) : (!lz.value) -> ()
                  }) : () -> i42
                  %40 = "rgn.select"(%37, %38, %39) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                  "rgn.jumpval"(%40) : (i42) -> ()
                }) : () -> i42
                %35 = "rgn.val"() ( {
                  call @lean_dec(%32) : (!lz.value) -> ()
                  call @lean_dec(%27) : (!lz.value) -> ()
                  %37 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__4} : () -> !lz.value
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %36 = "rgn.select"(%33, %34, %35) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%36) : (i42) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                %32 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %33 = call @lean_int_mul(%32, %27) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%27) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %34 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_6, %33) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              "rgn.return"(%arg1) : (!lz.value) -> ()
            }) : () -> i42
            %25 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
            %26 = "rgn.select"(%25, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %18 = "rgn.val"() ( {
            %c0_i32_2 = constant 0 : i32
            %22 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%22) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %23 = call @lean_int_dec_lt(%22, %7) : (!lz.value, !lz.value) -> i8
            %24 = "rgn.val"() ( {
              %27 = call @lean_nat_abs(%22) : (!lz.value) -> !lz.value
              %28 = call @lean_nat_dec_eq(%27, %13) : (!lz.value, !lz.value) -> i8
              %29 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %32 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %33 = call @lean_nat_dec_eq(%27, %32) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%27) : (!lz.value) -> ()
                %34 = "rgn.val"() ( {
                  %37 = call @lean_int_mul(%7, %22) : (!lz.value, !lz.value) -> !lz.value
                  call @lean_dec(%22) : (!lz.value) -> ()
                  %c0_i32_3 = constant 0 : i32
                  %c1_i32_4 = constant 1 : i32
                  %c1_i32_5 = constant 1 : i32
                  %38 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                  %c0_i32_6 = constant 0 : i32
                  call @lean_ctor_set(%38, %c0_i32_6, %37) : (!lz.value, i32, !lz.value) -> ()
                  "rgn.return"(%38) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.val"() ( {
                  call @lean_dec(%22) : (!lz.value) -> ()
                  %37 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__6} : () -> !lz.value
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %36 = "rgn.select"(%33, %34, %35) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%36) : (i42) -> ()
              }) : () -> i42
              %30 = "rgn.val"() ( {
                call @lean_dec(%27) : (!lz.value) -> ()
                call @lean_dec(%22) : (!lz.value) -> ()
                %32 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__8} : () -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.select"(%28, %29, %30) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%31) : (i42) -> ()
            }) : () -> i42
            %25 = "rgn.val"() ( {
              %27 = call @lean_int_mul(%7, %22) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%22) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %28 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%28, %c0_i32_5, %27) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%28) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.select"(%23, %24, %25) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%26) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %22 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
            "rgn.return"(%22) : (!lz.value) -> ()
          }) : () -> i42
          %20 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %21 = "rgn.select"(%20, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.select"(%14, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%17) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        %12 = "rgn.val"() ( {
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %18 = call @lean_int_dec_lt(%17, %7) : (!lz.value, !lz.value) -> i8
          %19 = "rgn.val"() ( {
            %22 = call @lean_nat_abs(%17) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%22, %23) : (!lz.value, !lz.value) -> i8
            %25 = "rgn.val"() ( {
              %c1_i32 = constant 1 : i32
              %28 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
              %29 = call @lean_nat_dec_eq(%22, %28) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%22) : (!lz.value) -> ()
              %30 = "rgn.val"() ( {
                %33 = call @lean_int_mul(%6, %17) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%17) : (!lz.value) -> ()
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %34 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%34, %c0_i32_6, %33) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%34) : (!lz.value) -> ()
              }) : () -> i42
              %31 = "rgn.val"() ( {
                call @lean_dec(%17) : (!lz.value) -> ()
                %33 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %34 = call @lean_int_mul(%6, %33) : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%6) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %35 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%35, %c0_i32_6, %34) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%35) : (!lz.value) -> ()
              }) : () -> i42
              %32 = "rgn.select"(%29, %30, %31) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%32) : (i42) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%22) : (!lz.value) -> ()
              call @lean_dec(%17) : (!lz.value) -> ()
              %28 = call @lean_int_mul(%6, %7) : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%6) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %29 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%29, %c0_i32_5, %28) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            %22 = call @lean_int_mul(%6, %17) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %c1_i32 = constant 1 : i32
            %c1_i32_3 = constant 1 : i32
            %23 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32, %c1_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_4, %22) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = "rgn.select"(%18, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%21) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          %c1_i32 = constant 1 : i32
          %18 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%18) : (!lz.value) -> ()
          %19 = "rgn.val"() ( {
            call @lean_dec(%arg1) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %23 = call @lean_ctor_get(%17, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%23) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            %24 = call @lean_int_mul(%6, %23) : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%23) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c0_i32_3 = constant 0 : i32
            %c1_i32_4 = constant 1 : i32
            %c1_i32_5 = constant 1 : i32
            %25 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
            %c0_i32_6 = constant 0 : i32
            call @lean_ctor_set(%25, %c0_i32_6, %24) : (!lz.value, i32, !lz.value) -> ()
            %26 = call @l_Expr_mul(%25, %18) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%26) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.val"() ( {
            call @lean_dec(%18) : (!lz.value) -> ()
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%6) : (!lz.value) -> ()
            %c3_i32 = constant 3 : i32
            %c2_i32 = constant 2 : i32
            %c2_i32_2 = constant 2 : i32
            %23 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
            %c0_i32_3 = constant 0 : i32
            call @lean_ctor_set(%23, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
            %c1_i32_4 = constant 1 : i32
            call @lean_ctor_set(%23, %c1_i32_4, %arg1) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %21 = call @lean_obj_tag(%17) : (!lz.value) -> i32
          %22 = "rgn.select"(%21, %19, %20) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%6) : (!lz.value) -> ()
          %c3_i32 = constant 3 : i32
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %17 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32 = constant 1 : i32
          call @lean_ctor_set(%17, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %12, %13, %14) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %11 = "rgn.select"(%8, %9, %10) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%11) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %6 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%6) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %7 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%7) : (!lz.value) -> ()
      %8 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%6) : (!lz.value) -> ()
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %14 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %15 = call @lean_int_dec_lt(%13, %14) : (!lz.value, !lz.value) -> i8
        %16 = "rgn.val"() ( {
          %19 = call @lean_nat_abs(%13) : (!lz.value) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          %20 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
          %21 = call @lean_nat_dec_eq(%19, %20) : (!lz.value, !lz.value) -> i8
          %22 = "rgn.val"() ( {
            %c1_i32_3 = constant 1 : i32
            %25 = call @lean_unsigned_to_nat(%c1_i32_3) : (i32) -> !lz.value
            %26 = call @lean_nat_dec_eq(%19, %25) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%19) : (!lz.value) -> ()
            %27 = "rgn.val"() ( {
              %c0_i32_4 = constant 0 : i32
              %c1_i32_5 = constant 1 : i32
              %c1_i32_6 = constant 1 : i32
              %30 = call @lean_alloc_ctor(%c0_i32_4, %c1_i32_5, %c1_i32_6) : (i32, i32, i32) -> !lz.value
              %c0_i32_7 = constant 0 : i32
              call @lean_ctor_set(%30, %c0_i32_7, %13) : (!lz.value, i32, !lz.value) -> ()
              %31 = call @l_Expr_mul(%30, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%31) : (!lz.value) -> ()
            }) : () -> i42
            %28 = "rgn.val"() ( {
              call @lean_dec(%13) : (!lz.value) -> ()
              "rgn.return"(%arg0) : (!lz.value) -> ()
            }) : () -> i42
            %29 = "rgn.select"(%26, %27, %28) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%29) : (i42) -> ()
          }) : () -> i42
          %23 = "rgn.val"() ( {
            call @lean_dec(%19) : (!lz.value) -> ()
            call @lean_dec(%13) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %25 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
            "rgn.return"(%25) : (!lz.value) -> ()
          }) : () -> i42
          %24 = "rgn.select"(%21, %22, %23) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%24) : (i42) -> ()
        }) : () -> i42
        %17 = "rgn.val"() ( {
          %c0_i32_2 = constant 0 : i32
          %c1_i32_3 = constant 1 : i32
          %c1_i32_4 = constant 1 : i32
          %19 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32_3, %c1_i32_4) : (i32, i32, i32) -> !lz.value
          %c0_i32_5 = constant 0 : i32
          call @lean_ctor_set(%19, %c0_i32_5, %13) : (!lz.value, i32, !lz.value) -> ()
          %20 = call @l_Expr_mul(%19, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %18 = "rgn.select"(%15, %16, %17) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        %c0_i32_1 = constant 0 : i32
        %13 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%13) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %14 = call @lean_ctor_get(%arg1, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %15 = "rgn.val"() ( {
          call @lean_dec(%7) : (!lz.value) -> ()
          call @lean_dec(%6) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_3 = constant 0 : i32
          %19 = call @lean_ctor_get(%13, %c0_i32_3) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%19) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          %c0_i32_4 = constant 0 : i32
          %c1_i32_5 = constant 1 : i32
          %c1_i32_6 = constant 1 : i32
          %20 = call @lean_alloc_ctor(%c0_i32_4, %c1_i32_5, %c1_i32_6) : (i32, i32, i32) -> !lz.value
          %c0_i32_7 = constant 0 : i32
          call @lean_ctor_set(%20, %c0_i32_7, %19) : (!lz.value, i32, !lz.value) -> ()
          %21 = call @l_Expr_mul(%arg0, %14) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %22 = call @l_Expr_mul(%20, %21) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%22) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.val"() ( {
          call @lean_dec(%14) : (!lz.value) -> ()
          call @lean_dec(%13) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %19 = call @l_Expr_mul(%7, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %20 = call @l_Expr_mul(%6, %19) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %17 = call @lean_obj_tag(%13) : (!lz.value) -> i32
        %18 = "rgn.select"(%17, %15, %16) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%18) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.val"() ( {
        call @lean_dec(%arg0) : (!lz.value) -> ()
        %13 = call @l_Expr_mul(%7, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
        %14 = call @l_Expr_mul(%6, %13) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
        "rgn.return"(%14) : (!lz.value) -> ()
      }) : () -> i42
      %11 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %12 = "rgn.select"(%11, %8, %9, %10) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%12) : (i42) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %6 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %12 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %13 = call @lean_int_dec_lt(%11, %12) : (!lz.value, !lz.value) -> i8
        %14 = "rgn.val"() ( {
          %17 = call @lean_nat_abs(%11) : (!lz.value) -> !lz.value
          %c0_i32_1 = constant 0 : i32
          %18 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %19 = call @lean_nat_dec_eq(%17, %18) : (!lz.value, !lz.value) -> i8
          %20 = "rgn.val"() ( {
            %c1_i32 = constant 1 : i32
            %23 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
            %24 = call @lean_nat_dec_eq(%17, %23) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%17) : (!lz.value) -> ()
            %25 = "rgn.val"() ( {
              %c0_i32_2 = constant 0 : i32
              %c1_i32_3 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %28 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32_3, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%28, %c0_i32_5, %11) : (!lz.value, i32, !lz.value) -> ()
              %29 = call @l_Expr_mul(%28, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%29) : (!lz.value) -> ()
            }) : () -> i42
            %26 = "rgn.val"() ( {
              call @lean_dec(%11) : (!lz.value) -> ()
              "rgn.return"(%arg0) : (!lz.value) -> ()
            }) : () -> i42
            %27 = "rgn.select"(%24, %25, %26) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%27) : (i42) -> ()
          }) : () -> i42
          %21 = "rgn.val"() ( {
            call @lean_dec(%17) : (!lz.value) -> ()
            call @lean_dec(%11) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %23 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
            "rgn.return"(%23) : (!lz.value) -> ()
          }) : () -> i42
          %22 = "rgn.select"(%19, %20, %21) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%22) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          %c0_i32_1 = constant 0 : i32
          %c1_i32 = constant 1 : i32
          %c1_i32_2 = constant 1 : i32
          %17 = call @lean_alloc_ctor(%c0_i32_1, %c1_i32, %c1_i32_2) : (i32, i32, i32) -> !lz.value
          %c0_i32_3 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_3, %11) : (!lz.value, i32, !lz.value) -> ()
          %18 = call @l_Expr_mul(%17, %arg0) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%18) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %7 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %11 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%11) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%12) : (!lz.value) -> ()
        %13 = "rgn.val"() ( {
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_ctor_get(%11, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%17) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %c0_i32_2 = constant 0 : i32
          %c1_i32_3 = constant 1 : i32
          %c1_i32_4 = constant 1 : i32
          %18 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32_3, %c1_i32_4) : (i32, i32, i32) -> !lz.value
          %c0_i32_5 = constant 0 : i32
          call @lean_ctor_set(%18, %c0_i32_5, %17) : (!lz.value, i32, !lz.value) -> ()
          %19 = call @l_Expr_mul(%arg0, %12) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
          %20 = call @l_Expr_mul(%18, %19) {musttail = "true"} : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%20) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.val"() ( {
          call @lean_dec(%12) : (!lz.value) -> ()
          call @lean_dec(%11) : (!lz.value) -> ()
          %c3_i32 = constant 3 : i32
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %17 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32_3 = constant 1 : i32
          call @lean_ctor_set(%17, %c1_i32_3, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = call @lean_obj_tag(%11) : (!lz.value) -> i32
        %16 = "rgn.select"(%15, %13, %14) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %8 = "rgn.val"() ( {
        %c3_i32 = constant 3 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_0 = constant 2 : i32
        %11 = call @lean_alloc_ctor(%c3_i32, %c2_i32, %c2_i32_0) : (i32, i32, i32) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        call @lean_ctor_set(%11, %c0_i32_1, %arg0) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32 = constant 1 : i32
        call @lean_ctor_set(%11, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %9 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %10 = "rgn.select"(%9, %6, %7, %8) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %4 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %5 = "rgn.select"(%4, %1, %2, %3) {case0 = 0 : i64, case1 = 3 : i64, case2 = 42 : i64} : (i32, i42, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_pow_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value, %arg5: !lz.value, %arg6: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %5 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%5) : (!lz.value) -> ()
      %6 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %7 = call @lean_int_dec_lt(%5, %6) : (!lz.value, !lz.value) -> i8
      %8 = "rgn.val"() ( {
        %11 = call @lean_nat_abs(%5) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %12 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%11, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%11) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          call @lean_dec(%arg5) : (!lz.value) -> ()
          %17 = "rgn.val"() ( {
            call @lean_dec(%arg6) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%21) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %22 = call @lean_int_dec_lt(%21, %6) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %26 = call @lean_nat_abs(%21) : (!lz.value) -> !lz.value
              %27 = call @lean_nat_dec_eq(%26, %12) : (!lz.value, !lz.value) -> i8
              %28 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %31 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %32 = call @lean_nat_dec_eq(%26, %31) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%26) : (!lz.value) -> ()
                %33 = "rgn.val"() ( {
                  %36 = call @lean_apply_2(%arg2, %5, %21) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%36) : (!lz.value) -> ()
                }) : () -> i42
                %34 = "rgn.val"() ( {
                  call @lean_dec(%21) : (!lz.value) -> ()
                  %36 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                  %37 = call @lean_apply_2(%arg2, %5, %36) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.select"(%32, %33, %34) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%35) : (i42) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%26) : (!lz.value) -> ()
                call @lean_dec(%21) : (!lz.value) -> ()
                %31 = call @lean_apply_2(%arg2, %5, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%31) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              %26 = call @lean_apply_2(%arg2, %5, %21) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            call @lean_dec(%5) : (!lz.value) -> ()
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %21 = call @lean_apply_2(%arg6, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %19 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %20 = "rgn.select"(%19, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%5) : (!lz.value) -> ()
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %17 = "rgn.val"() ( {
            call @lean_dec(%arg5) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%21) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %22 = call @lean_int_dec_lt(%21, %6) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %26 = call @lean_nat_abs(%21) : (!lz.value) -> !lz.value
              %27 = call @lean_nat_dec_eq(%26, %12) : (!lz.value, !lz.value) -> i8
              %28 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %31 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %32 = call @lean_nat_dec_eq(%26, %31) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%26) : (!lz.value) -> ()
                %33 = "rgn.val"() ( {
                  %36 = call @lean_apply_2(%arg2, %6, %21) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%36) : (!lz.value) -> ()
                }) : () -> i42
                %34 = "rgn.val"() ( {
                  call @lean_dec(%21) : (!lz.value) -> ()
                  %36 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                  %37 = call @lean_apply_2(%arg2, %6, %36) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.select"(%32, %33, %34) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%35) : (i42) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%26) : (!lz.value) -> ()
                call @lean_dec(%21) : (!lz.value) -> ()
                %31 = call @lean_apply_2(%arg2, %6, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%31) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              %26 = call @lean_apply_2(%arg2, %6, %21) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg2) : (!lz.value) -> ()
            %21 = call @lean_apply_1(%arg5, %arg1) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %19 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %20 = "rgn.select"(%19, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        call @lean_dec(%arg5) : (!lz.value) -> ()
        %11 = "rgn.val"() ( {
          call @lean_dec(%arg6) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %15 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%15) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %16 = call @lean_int_dec_lt(%15, %6) : (!lz.value, !lz.value) -> i8
          %17 = "rgn.val"() ( {
            %20 = call @lean_nat_abs(%15) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %22 = call @lean_nat_dec_eq(%20, %21) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %c1_i32 = constant 1 : i32
              %26 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
              %27 = call @lean_nat_dec_eq(%20, %26) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%20) : (!lz.value) -> ()
              %28 = "rgn.val"() ( {
                %31 = call @lean_apply_2(%arg2, %5, %15) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%31) : (!lz.value) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%15) : (!lz.value) -> ()
                %31 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %32 = call @lean_apply_2(%arg2, %5, %31) : (!lz.value, !lz.value, !lz.value) -> !lz.value
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%20) : (!lz.value) -> ()
              call @lean_dec(%15) : (!lz.value) -> ()
              %26 = call @lean_apply_2(%arg2, %5, %6) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            %20 = call @lean_apply_2(%arg2, %5, %15) : (!lz.value, !lz.value, !lz.value) -> !lz.value
            "rgn.return"(%20) : (!lz.value) -> ()
          }) : () -> i42
          %19 = "rgn.select"(%16, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%19) : (i42) -> ()
        }) : () -> i42
        %12 = "rgn.val"() ( {
          call @lean_dec(%5) : (!lz.value) -> ()
          call @lean_dec(%arg2) : (!lz.value) -> ()
          %15 = call @lean_apply_2(%arg6, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%15) : (!lz.value) -> ()
        }) : () -> i42
        %13 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %14 = "rgn.select"(%13, %11, %12) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%14) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.select"(%7, %8, %9) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %5 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%9) : (!lz.value) -> ()
        %10 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %11 = call @lean_int_dec_lt(%9, %10) : (!lz.value, !lz.value) -> i8
        %12 = "rgn.val"() ( {
          %15 = call @lean_nat_abs(%9) : (!lz.value) -> !lz.value
          call @lean_dec(%9) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %16 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %17 = call @lean_nat_dec_eq(%15, %16) : (!lz.value, !lz.value) -> i8
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg3) : (!lz.value) -> ()
            %c1_i32 = constant 1 : i32
            %21 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
            %22 = call @lean_nat_dec_eq(%15, %21) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%15) : (!lz.value) -> ()
            %23 = "rgn.val"() ( {
              call @lean_dec(%arg4) : (!lz.value) -> ()
              %26 = call @lean_apply_2(%arg6, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%arg6) : (!lz.value) -> ()
              call @lean_dec(%arg1) : (!lz.value) -> ()
              %26 = call @lean_apply_1(%arg4, %arg0) : (!lz.value, !lz.value) -> !lz.value
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%15) : (!lz.value) -> ()
            call @lean_dec(%arg6) : (!lz.value) -> ()
            call @lean_dec(%arg4) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %21 = call @lean_apply_1(%arg3, %arg0) : (!lz.value, !lz.value) -> !lz.value
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.select"(%17, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          call @lean_dec(%9) : (!lz.value) -> ()
          call @lean_dec(%arg4) : (!lz.value) -> ()
          call @lean_dec(%arg3) : (!lz.value) -> ()
          %15 = call @lean_apply_2(%arg6, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
          "rgn.return"(%15) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.select"(%11, %12, %13) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%14) : (i42) -> ()
      }) : () -> i42
      %6 = "rgn.val"() ( {
        call @lean_dec(%arg4) : (!lz.value) -> ()
        call @lean_dec(%arg3) : (!lz.value) -> ()
        %9 = call @lean_apply_2(%arg6, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%9) : (!lz.value) -> ()
      }) : () -> i42
      %7 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %8 = "rgn.select"(%7, %5, %6) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
      "rgn.jumpval"(%8) : (i42) -> ()
    }) : () -> i42
    %3 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %4 = "rgn.select"(%3, %1, %2) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_Expr_pow_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_pow_match__1___rarg} : () -> !lz.value
    %c7_i32 = constant 7 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c7_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pow___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %3 = call @l_Expr_pown(%1, %2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%3) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pow___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pow___closed__3() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
    %2 = call @l_Expr_pown(%1, %1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pow___closed__4() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__3} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_pow___closed__5() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_pow(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %5 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%5) : (!lz.value) -> ()
      %6 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %7 = call @lean_int_dec_lt(%5, %6) : (!lz.value, !lz.value) -> i8
      %8 = "rgn.val"() ( {
        %11 = call @lean_nat_abs(%5) : (!lz.value) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        %12 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%11, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%11) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          %17 = "rgn.val"() ( {
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%21) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %22 = call @lean_int_dec_lt(%21, %6) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %26 = call @lean_nat_abs(%21) : (!lz.value) -> !lz.value
              %27 = call @lean_nat_dec_eq(%26, %12) : (!lz.value, !lz.value) -> i8
              %28 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %31 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %32 = call @lean_nat_dec_eq(%26, %31) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%26) : (!lz.value) -> ()
                %33 = "rgn.val"() ( {
                  %36 = call @l_Expr_pown(%5, %21) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                  call @lean_dec(%21) : (!lz.value) -> ()
                  call @lean_dec(%5) : (!lz.value) -> ()
                  %c0_i32_3 = constant 0 : i32
                  %c1_i32_4 = constant 1 : i32
                  %c1_i32_5 = constant 1 : i32
                  %37 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                  %c0_i32_6 = constant 0 : i32
                  call @lean_ctor_set(%37, %c0_i32_6, %36) : (!lz.value, i32, !lz.value) -> ()
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %34 = "rgn.val"() ( {
                  call @lean_dec(%21) : (!lz.value) -> ()
                  %36 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                  %37 = call @l_Expr_pown(%5, %36) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                  call @lean_dec(%5) : (!lz.value) -> ()
                  %c0_i32_3 = constant 0 : i32
                  %c1_i32_4 = constant 1 : i32
                  %c1_i32_5 = constant 1 : i32
                  %38 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                  %c0_i32_6 = constant 0 : i32
                  call @lean_ctor_set(%38, %c0_i32_6, %37) : (!lz.value, i32, !lz.value) -> ()
                  "rgn.return"(%38) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.select"(%32, %33, %34) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%35) : (i42) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%26) : (!lz.value) -> ()
                call @lean_dec(%21) : (!lz.value) -> ()
                %31 = call @l_Expr_pown(%5, %6) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%5) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32 = constant 1 : i32
                %c1_i32_4 = constant 1 : i32
                %32 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
                %c0_i32_5 = constant 0 : i32
                call @lean_ctor_set(%32, %c0_i32_5, %31) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              %26 = call @l_Expr_pown(%5, %21) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%21) : (!lz.value) -> ()
              call @lean_dec(%5) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %27 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%27, %c0_i32_5, %26) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            call @lean_dec(%5) : (!lz.value) -> ()
            %c4_i32 = constant 4 : i32
            %c2_i32 = constant 2 : i32
            %c2_i32_2 = constant 2 : i32
            %21 = call @lean_alloc_ctor(%c4_i32, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
            %c0_i32_3 = constant 0 : i32
            call @lean_ctor_set(%21, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
            %c1_i32 = constant 1 : i32
            call @lean_ctor_set(%21, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %19 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %20 = "rgn.select"(%19, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%5) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %17 = "rgn.val"() ( {
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_ctor_get(%arg1, %c0_i32_2) : (!lz.value, i32) -> !lz.value
            call @lean_inc(%21) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %22 = call @lean_int_dec_lt(%21, %6) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %26 = call @lean_nat_abs(%21) : (!lz.value) -> !lz.value
              %27 = call @lean_nat_dec_eq(%26, %12) : (!lz.value, !lz.value) -> i8
              %28 = "rgn.val"() ( {
                %c1_i32 = constant 1 : i32
                %31 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
                %32 = call @lean_nat_dec_eq(%26, %31) : (!lz.value, !lz.value) -> i8
                call @lean_dec(%26) : (!lz.value) -> ()
                %33 = "rgn.val"() ( {
                  %36 = call @l_Expr_pown(%6, %21) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                  call @lean_dec(%21) : (!lz.value) -> ()
                  %c0_i32_3 = constant 0 : i32
                  %c1_i32_4 = constant 1 : i32
                  %c1_i32_5 = constant 1 : i32
                  %37 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                  %c0_i32_6 = constant 0 : i32
                  call @lean_ctor_set(%37, %c0_i32_6, %36) : (!lz.value, i32, !lz.value) -> ()
                  "rgn.return"(%37) : (!lz.value) -> ()
                }) : () -> i42
                %34 = "rgn.val"() ( {
                  call @lean_dec(%21) : (!lz.value) -> ()
                  %36 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__2} : () -> !lz.value
                  "rgn.return"(%36) : (!lz.value) -> ()
                }) : () -> i42
                %35 = "rgn.select"(%32, %33, %34) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
                "rgn.jumpval"(%35) : (i42) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%26) : (!lz.value) -> ()
                call @lean_dec(%21) : (!lz.value) -> ()
                %31 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__4} : () -> !lz.value
                "rgn.return"(%31) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              %26 = call @l_Expr_pown(%6, %21) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%21) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %27 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%27, %c0_i32_5, %26) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            call @lean_dec(%arg1) : (!lz.value) -> ()
            %21 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %19 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
          %20 = "rgn.select"(%19, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        %11 = "rgn.val"() ( {
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %15 = call @lean_ctor_get(%arg1, %c0_i32_1) : (!lz.value, i32) -> !lz.value
          call @lean_inc(%15) : (!lz.value) -> ()
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %16 = call @lean_int_dec_lt(%15, %6) : (!lz.value, !lz.value) -> i8
          %17 = "rgn.val"() ( {
            %20 = call @lean_nat_abs(%15) : (!lz.value) -> !lz.value
            %c0_i32_2 = constant 0 : i32
            %21 = call @lean_unsigned_to_nat(%c0_i32_2) : (i32) -> !lz.value
            %22 = call @lean_nat_dec_eq(%20, %21) : (!lz.value, !lz.value) -> i8
            %23 = "rgn.val"() ( {
              %c1_i32 = constant 1 : i32
              %26 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
              %27 = call @lean_nat_dec_eq(%20, %26) : (!lz.value, !lz.value) -> i8
              call @lean_dec(%20) : (!lz.value) -> ()
              %28 = "rgn.val"() ( {
                %31 = call @l_Expr_pown(%5, %15) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%15) : (!lz.value) -> ()
                call @lean_dec(%5) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %32 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%32, %c0_i32_6, %31) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%32) : (!lz.value) -> ()
              }) : () -> i42
              %29 = "rgn.val"() ( {
                call @lean_dec(%15) : (!lz.value) -> ()
                %31 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
                %32 = call @l_Expr_pown(%5, %31) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
                call @lean_dec(%5) : (!lz.value) -> ()
                %c0_i32_3 = constant 0 : i32
                %c1_i32_4 = constant 1 : i32
                %c1_i32_5 = constant 1 : i32
                %33 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32_4, %c1_i32_5) : (i32, i32, i32) -> !lz.value
                %c0_i32_6 = constant 0 : i32
                call @lean_ctor_set(%33, %c0_i32_6, %32) : (!lz.value, i32, !lz.value) -> ()
                "rgn.return"(%33) : (!lz.value) -> ()
              }) : () -> i42
              %30 = "rgn.select"(%27, %28, %29) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
              "rgn.jumpval"(%30) : (i42) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%20) : (!lz.value) -> ()
              call @lean_dec(%15) : (!lz.value) -> ()
              %26 = call @l_Expr_pown(%5, %6) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
              call @lean_dec(%5) : (!lz.value) -> ()
              %c0_i32_3 = constant 0 : i32
              %c1_i32 = constant 1 : i32
              %c1_i32_4 = constant 1 : i32
              %27 = call @lean_alloc_ctor(%c0_i32_3, %c1_i32, %c1_i32_4) : (i32, i32, i32) -> !lz.value
              %c0_i32_5 = constant 0 : i32
              call @lean_ctor_set(%27, %c0_i32_5, %26) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%27) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %18 = "rgn.val"() ( {
            %20 = call @l_Expr_pown(%5, %15) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
            call @lean_dec(%15) : (!lz.value) -> ()
            call @lean_dec(%5) : (!lz.value) -> ()
            %c0_i32_2 = constant 0 : i32
            %c1_i32 = constant 1 : i32
            %c1_i32_3 = constant 1 : i32
            %21 = call @lean_alloc_ctor(%c0_i32_2, %c1_i32, %c1_i32_3) : (i32, i32, i32) -> !lz.value
            %c0_i32_4 = constant 0 : i32
            call @lean_ctor_set(%21, %c0_i32_4, %20) : (!lz.value, i32, !lz.value) -> ()
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %19 = "rgn.select"(%16, %17, %18) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%19) : (i42) -> ()
        }) : () -> i42
        %12 = "rgn.val"() ( {
          call @lean_dec(%5) : (!lz.value) -> ()
          %c4_i32 = constant 4 : i32
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %15 = call @lean_alloc_ctor(%c4_i32, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          call @lean_ctor_set(%15, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32 = constant 1 : i32
          call @lean_ctor_set(%15, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%15) : (!lz.value) -> ()
        }) : () -> i42
        %13 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
        %14 = "rgn.select"(%13, %11, %12) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
        "rgn.jumpval"(%14) : (i42) -> ()
      }) : () -> i42
      %10 = "rgn.select"(%7, %8, %9) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %5 = "rgn.val"() ( {
        %c0_i32_0 = constant 0 : i32
        %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%9) : (!lz.value) -> ()
        %10 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
        %11 = call @lean_int_dec_lt(%9, %10) : (!lz.value, !lz.value) -> i8
        %12 = "rgn.val"() ( {
          %15 = call @lean_nat_abs(%9) : (!lz.value) -> !lz.value
          call @lean_dec(%9) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %16 = call @lean_unsigned_to_nat(%c0_i32_1) : (i32) -> !lz.value
          %17 = call @lean_nat_dec_eq(%15, %16) : (!lz.value, !lz.value) -> i8
          %18 = "rgn.val"() ( {
            %c1_i32 = constant 1 : i32
            %21 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
            %22 = call @lean_nat_dec_eq(%15, %21) : (!lz.value, !lz.value) -> i8
            call @lean_dec(%15) : (!lz.value) -> ()
            %23 = "rgn.val"() ( {
              %c4_i32 = constant 4 : i32
              %c2_i32 = constant 2 : i32
              %c2_i32_2 = constant 2 : i32
              %26 = call @lean_alloc_ctor(%c4_i32, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
              %c0_i32_3 = constant 0 : i32
              call @lean_ctor_set(%26, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
              %c1_i32_4 = constant 1 : i32
              call @lean_ctor_set(%26, %c1_i32_4, %arg1) : (!lz.value, i32, !lz.value) -> ()
              "rgn.return"(%26) : (!lz.value) -> ()
            }) : () -> i42
            %24 = "rgn.val"() ( {
              call @lean_dec(%arg1) : (!lz.value) -> ()
              "rgn.return"(%arg0) : (!lz.value) -> ()
            }) : () -> i42
            %25 = "rgn.select"(%22, %23, %24) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
            "rgn.jumpval"(%25) : (i42) -> ()
          }) : () -> i42
          %19 = "rgn.val"() ( {
            call @lean_dec(%15) : (!lz.value) -> ()
            call @lean_dec(%arg1) : (!lz.value) -> ()
            call @lean_dec(%arg0) : (!lz.value) -> ()
            %21 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__5} : () -> !lz.value
            "rgn.return"(%21) : (!lz.value) -> ()
          }) : () -> i42
          %20 = "rgn.select"(%17, %18, %19) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
          "rgn.jumpval"(%20) : (i42) -> ()
        }) : () -> i42
        %13 = "rgn.val"() ( {
          call @lean_dec(%9) : (!lz.value) -> ()
          %c4_i32 = constant 4 : i32
          %c2_i32 = constant 2 : i32
          %c2_i32_1 = constant 2 : i32
          %15 = call @lean_alloc_ctor(%c4_i32, %c2_i32, %c2_i32_1) : (i32, i32, i32) -> !lz.value
          %c0_i32_2 = constant 0 : i32
          call @lean_ctor_set(%15, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
          %c1_i32 = constant 1 : i32
          call @lean_ctor_set(%15, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%15) : (!lz.value) -> ()
        }) : () -> i42
        %14 = "rgn.select"(%11, %12, %13) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%14) : (i42) -> ()
      }) : () -> i42
      %6 = "rgn.val"() ( {
        %c4_i32 = constant 4 : i32
        %c2_i32 = constant 2 : i32
        %c2_i32_0 = constant 2 : i32
        %9 = call @lean_alloc_ctor(%c4_i32, %c2_i32, %c2_i32_0) : (i32, i32, i32) -> !lz.value
        %c0_i32_1 = constant 0 : i32
        call @lean_ctor_set(%9, %c0_i32_1, %arg0) : (!lz.value, i32, !lz.value) -> ()
        %c1_i32 = constant 1 : i32
        call @lean_ctor_set(%9, %c1_i32, %arg1) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%9) : (!lz.value) -> ()
      }) : () -> i42
      %7 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
      %8 = "rgn.select"(%7, %5, %6) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
      "rgn.jumpval"(%8) : (i42) -> ()
    }) : () -> i42
    %3 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %4 = "rgn.select"(%3, %1, %2) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_Expr_ln_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %5 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%5) : (!lz.value) -> ()
      %6 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %7 = call @lean_int_dec_lt(%5, %6) : (!lz.value, !lz.value) -> i8
      %8 = "rgn.val"() ( {
        %11 = call @lean_nat_abs(%5) : (!lz.value) -> !lz.value
        call @lean_dec(%5) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%11, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%11) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          call @lean_dec(%arg1) : (!lz.value) -> ()
          %17 = call @lean_apply_1(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg2) : (!lz.value) -> ()
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %c0_i32_1 = constant 0 : i32
          %17 = call @lean_box(%c0_i32_1) : (i32) -> !lz.value
          %18 = call @lean_apply_1(%arg1, %17) : (!lz.value, !lz.value) -> !lz.value
          "rgn.return"(%18) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        call @lean_dec(%5) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
        %11 = call @lean_apply_1(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %10 = "rgn.select"(%7, %8, %9) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %5 = call @lean_apply_1(%arg2, %arg0) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%5) : (!lz.value) -> ()
    }) : () -> i42
    %3 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %4 = "rgn.select"(%3, %1, %2) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_Expr_ln_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_ln_match__1___rarg} : () -> !lz.value
    %c3_i32 = constant 3 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c3_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_ln(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %5 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%5) : (!lz.value) -> ()
      %6 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %7 = call @lean_int_dec_lt(%5, %6) : (!lz.value, !lz.value) -> i8
      %8 = "rgn.val"() ( {
        %11 = call @lean_nat_abs(%5) : (!lz.value) -> !lz.value
        call @lean_dec(%5) : (!lz.value) -> ()
        %c1_i32 = constant 1 : i32
        %12 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
        %13 = call @lean_nat_dec_eq(%11, %12) : (!lz.value, !lz.value) -> i8
        call @lean_dec(%11) : (!lz.value) -> ()
        %14 = "rgn.val"() ( {
          %c5_i32 = constant 5 : i32
          %c1_i32_1 = constant 1 : i32
          %c1_i32_2 = constant 1 : i32
          %17 = call @lean_alloc_ctor(%c5_i32, %c1_i32_1, %c1_i32_2) : (i32, i32, i32) -> !lz.value
          %c0_i32_3 = constant 0 : i32
          call @lean_ctor_set(%17, %c0_i32_3, %arg0) : (!lz.value, i32, !lz.value) -> ()
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %15 = "rgn.val"() ( {
          call @lean_dec(%arg0) : (!lz.value) -> ()
          %17 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
          "rgn.return"(%17) : (!lz.value) -> ()
        }) : () -> i42
        %16 = "rgn.select"(%13, %14, %15) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
        "rgn.jumpval"(%16) : (i42) -> ()
      }) : () -> i42
      %9 = "rgn.val"() ( {
        call @lean_dec(%5) : (!lz.value) -> ()
        %c5_i32 = constant 5 : i32
        %c1_i32 = constant 1 : i32
        %c1_i32_1 = constant 1 : i32
        %11 = call @lean_alloc_ctor(%c5_i32, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
        %c0_i32_2 = constant 0 : i32
        call @lean_ctor_set(%11, %c0_i32_2, %arg0) : (!lz.value, i32, !lz.value) -> ()
        "rgn.return"(%11) : (!lz.value) -> ()
      }) : () -> i42
      %10 = "rgn.select"(%7, %8, %9) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%10) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c5_i32 = constant 5 : i32
      %c1_i32 = constant 1 : i32
      %c1_i32_0 = constant 1 : i32
      %5 = call @lean_alloc_ctor(%c5_i32, %c1_i32, %c1_i32_0) : (i32, i32, i32) -> !lz.value
      %c0_i32_1 = constant 0 : i32
      call @lean_ctor_set(%5, %c0_i32_1, %arg0) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%5) : (!lz.value) -> ()
    }) : () -> i42
    %3 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %4 = "rgn.select"(%3, %1, %2) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%4) : (i42) -> ()
  }
  func @l_Expr_d_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value, %arg5: !lz.value, %arg6: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %10 = call @lean_apply_1(%arg1, %9) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%10) : (!lz.value) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %10 = call @lean_apply_1(%arg2, %9) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%10) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %11 = call @lean_apply_2(%arg3, %9, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %11 = call @lean_apply_2(%arg4, %9, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.val"() ( {
      call @lean_dec(%arg6) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %11 = call @lean_apply_2(%arg5, %9, %10) : (!lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %6 = "rgn.val"() ( {
      call @lean_dec(%arg5) : (!lz.value) -> ()
      call @lean_dec(%arg4) : (!lz.value) -> ()
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %10 = call @lean_apply_1(%arg6, %9) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%10) : (!lz.value) -> ()
    }) : () -> i42
    %7 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %8 = "rgn.select"(%7, %1, %2, %3, %4, %5, %6) {case0 = 0 : i64, case1 = 1 : i64, case2 = 2 : i64, case3 = 3 : i64, case4 = 4 : i64, case5 = 42 : i64} : (i32, i42, i42, i42, i42, i42, i42) -> i42
    "rgn.jumpval"(%8) : (i42) -> ()
  }
  func @l_Expr_d_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_d_match__1___rarg} : () -> !lz.value
    %c7_i32 = constant 7 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c7_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_d___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Int_Int_pow___closed__1} : () -> !lz.value
    %2 = call @lean_int_neg(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_d___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_d___closed__1} : () -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %c1_i32 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c0_i32_0, %c1_i32, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_d(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %9 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %10 = call @lean_string_dec_eq(%arg0, %9) : (!lz.value, !lz.value) -> i8
      call @lean_dec(%9) : (!lz.value) -> ()
      %11 = "rgn.val"() ( {
        %14 = "ptr.loadglobal"() {value = @l_Expr_mul___closed__9} : () -> !lz.value
        "rgn.return"(%14) : (!lz.value) -> ()
      }) : () -> i42
      %12 = "rgn.val"() ( {
        %14 = "ptr.loadglobal"() {value = @l_Expr_pow___closed__5} : () -> !lz.value
        "rgn.return"(%14) : (!lz.value) -> ()
      }) : () -> i42
      %13 = "rgn.select"(%10, %11, %12) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%13) : (i42) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %11 = call @l_Expr_d(%arg0, %9) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %12 = call @l_Expr_d(%arg0, %10) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %13 = call @l_Expr_add(%11, %12) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%13) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_inc(%10) : (!lz.value) -> ()
      %11 = call @l_Expr_d(%arg0, %10) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %12 = call @l_Expr_mul(%9, %11) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %13 = call @l_Expr_d(%arg0, %9) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %14 = call @l_Expr_mul(%10, %13) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %15 = call @l_Expr_add(%12, %14) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%15) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg1, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_inc(%9) : (!lz.value) -> ()
      %11 = call @l_Expr_pow(%9, %10) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %12 = call @l_Expr_d(%arg0, %9) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      %13 = call @l_Expr_mul(%10, %12) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %14 = "ptr.loadglobal"() {value = @l_Expr_d___closed__2} : () -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %15 = call @l_Expr_pow(%9, %14) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %16 = call @l_Expr_mul(%13, %15) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %17 = call @l_Expr_ln(%9) {musttail = "false"} : (!lz.value) -> !lz.value
      %18 = call @l_Expr_d(%arg0, %10) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %19 = call @l_Expr_mul(%17, %18) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %20 = call @l_Expr_add(%16, %19) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %21 = call @l_Expr_mul(%11, %20) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%21) : (!lz.value) -> ()
    }) : () -> i42
    %6 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg1, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      call @lean_inc(%9) : (!lz.value) -> ()
      %10 = call @l_Expr_d(%arg0, %9) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %11 = "ptr.loadglobal"() {value = @l_Expr_d___closed__2} : () -> !lz.value
      %12 = call @l_Expr_pow(%9, %11) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      %13 = call @l_Expr_mul(%10, %12) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%13) : (!lz.value) -> ()
    }) : () -> i42
    %7 = call @lean_obj_tag(%arg1) : (!lz.value) -> i32
    %8 = "rgn.select"(%7, %1, %2, %3, %4, %5, %6) {case0 = 0 : i64, case1 = 1 : i64, case2 = 2 : i64, case3 = 3 : i64, case4 = 4 : i64, case5 = 42 : i64} : (i32, i42, i42, i42, i42, i42, i42) -> i42
    "rgn.jumpval"(%8) : (i42) -> ()
  }
  func @l_Expr_d___boxed(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_d(%arg0, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_Expr_count(%arg0: !lz.value) -> i32 {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      "rgn.return"(%c1_i32) : (i32) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      "rgn.return"(%c1_i32) : (i32) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %7 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %8 = call @l_Expr_count(%7) {musttail = "true"} : (!lz.value) -> i32
      "rgn.return"(%8) : (i32) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %7 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %8 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      %9 = call @l_Expr_count(%7) {musttail = "false"} : (!lz.value) -> i32
      %10 = call @l_Expr_count(%8) {musttail = "false"} : (!lz.value) -> i32
      %11 = call @lean_uint32_add(%9, %10) : (i32, i32) -> i32
      "rgn.return"(%11) : (i32) -> ()
    }) : () -> i42
    %5 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %6 = "rgn.select"(%5, %1, %2, %3, %4) {case0 = 0 : i64, case1 = 1 : i64, case2 = 5 : i64, case3 = 42 : i64} : (i32, i42, i42, i42, i42) -> i42
    "rgn.jumpval"(%6) : (i42) -> ()
  }
  func @l_Expr_count___boxed(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_count(%arg0) {musttail = "false"} : (!lz.value) -> i32
    call @lean_dec(%arg0) : (!lz.value) -> ()
    %2 = call @lean_box_uint32(%1) : (i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_Expr_toString___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "ln("} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_Expr_toString(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %10 = "ptr.loadglobal"() {value = @l_Int_instInhabitedInt___closed__1} : () -> !lz.value
      %11 = call @lean_int_dec_lt(%9, %10) : (!lz.value, !lz.value) -> i8
      %12 = "rgn.val"() ( {
        %15 = call @lean_nat_abs(%9) : (!lz.value) -> !lz.value
        %16 = call @l_Nat_repr(%15) {musttail = "false"} : (!lz.value) -> !lz.value
        "rgn.return"(%16) : (!lz.value) -> ()
      }) : () -> i42
      %13 = "rgn.val"() ( {
        %15 = call @lean_nat_abs(%9) : (!lz.value) -> !lz.value
        %c1_i32 = constant 1 : i32
        %16 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
        %17 = call @lean_nat_sub(%15, %16) : (!lz.value, !lz.value) -> !lz.value
        call @lean_dec(%15) : (!lz.value) -> ()
        %18 = call @lean_nat_add(%17, %16) : (!lz.value, !lz.value) -> !lz.value
        call @lean_dec(%17) : (!lz.value) -> ()
        %19 = call @l_Nat_repr(%18) {musttail = "false"} : (!lz.value) -> !lz.value
        %20 = "ptr.loadglobal"() {value = @l_term_x2d_____closed__3} : () -> !lz.value
        %21 = call @lean_string_append(%20, %19) : (!lz.value, !lz.value) -> !lz.value
        call @lean_dec(%19) : (!lz.value) -> ()
        "rgn.return"(%21) : (!lz.value) -> ()
      }) : () -> i42
      %14 = "rgn.select"(%11, %12, %13) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
      "rgn.jumpval"(%14) : (i42) -> ()
    }) : () -> i42
    %2 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      "rgn.return"(%9) : (!lz.value) -> ()
    }) : () -> i42
    %3 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      %11 = call @l_Expr_Expr_toString(%9) {musttail = "false"} : (!lz.value) -> !lz.value
      %12 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__3} : () -> !lz.value
      %13 = call @lean_string_append(%12, %11) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%11) : (!lz.value) -> ()
      %14 = "ptr.loadglobal"() {value = @l_Lean_Parser_Syntax_addPrec___closed__11} : () -> !lz.value
      %15 = call @lean_string_append(%13, %14) : (!lz.value, !lz.value) -> !lz.value
      %16 = call @l_Expr_Expr_toString(%10) {musttail = "false"} : (!lz.value) -> !lz.value
      %17 = call @lean_string_append(%15, %16) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%16) : (!lz.value) -> ()
      %18 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__7} : () -> !lz.value
      %19 = call @lean_string_append(%17, %18) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%19) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      %11 = call @l_Expr_Expr_toString(%9) {musttail = "false"} : (!lz.value) -> !lz.value
      %12 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__3} : () -> !lz.value
      %13 = call @lean_string_append(%12, %11) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%11) : (!lz.value) -> ()
      %14 = "ptr.loadglobal"() {value = @l_term___x2a_____closed__3} : () -> !lz.value
      %15 = call @lean_string_append(%13, %14) : (!lz.value, !lz.value) -> !lz.value
      %16 = call @l_Expr_Expr_toString(%10) {musttail = "false"} : (!lz.value) -> !lz.value
      %17 = call @lean_string_append(%15, %16) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%16) : (!lz.value) -> ()
      %18 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__7} : () -> !lz.value
      %19 = call @lean_string_append(%17, %18) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%19) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%arg0, %c1_i32) : (!lz.value, i32) -> !lz.value
      %11 = call @l_Expr_Expr_toString(%9) {musttail = "false"} : (!lz.value) -> !lz.value
      %12 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__3} : () -> !lz.value
      %13 = call @lean_string_append(%12, %11) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%11) : (!lz.value) -> ()
      %14 = "ptr.loadglobal"() {value = @l_term___x5e_____closed__3} : () -> !lz.value
      %15 = call @lean_string_append(%13, %14) : (!lz.value, !lz.value) -> !lz.value
      %16 = call @l_Expr_Expr_toString(%10) {musttail = "false"} : (!lz.value) -> !lz.value
      %17 = call @lean_string_append(%15, %16) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%16) : (!lz.value) -> ()
      %18 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__7} : () -> !lz.value
      %19 = call @lean_string_append(%17, %18) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%19) : (!lz.value) -> ()
    }) : () -> i42
    %6 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%arg0, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      %10 = call @l_Expr_Expr_toString(%9) {musttail = "false"} : (!lz.value) -> !lz.value
      %11 = "ptr.loadglobal"() {value = @l_Expr_Expr_toString___closed__1} : () -> !lz.value
      %12 = call @lean_string_append(%11, %10) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%10) : (!lz.value) -> ()
      %13 = "ptr.loadglobal"() {value = @l_prec_x28___x29___closed__7} : () -> !lz.value
      %14 = call @lean_string_append(%12, %13) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%14) : (!lz.value) -> ()
    }) : () -> i42
    %7 = call @lean_obj_tag(%arg0) : (!lz.value) -> i32
    %8 = "rgn.select"(%7, %1, %2, %3, %4, %5, %6) {case0 = 0 : i64, case1 = 1 : i64, case2 = 2 : i64, case3 = 3 : i64, case4 = 4 : i64, case5 = 42 : i64} : (i32, i42, i42, i42, i42, i42, i42) -> i42
    "rgn.jumpval"(%8) : (i42) -> ()
  }
  func @l_Expr_Expr_toString___boxed(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_Expr_toString(%arg0) {musttail = "false"} : (!lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @_init_l_Expr_instToStringExpr___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value) -> !lz.value, value = @l_Expr_Expr_toString___boxed} : () -> !lz.value
    %c1_i32 = constant 1 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c1_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_instToStringExpr() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_instToStringExpr___closed__1} : () -> !lz.value
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_Expr_nestAux_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg0, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      call @lean_dec(%arg2) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg0, %6) : (!lz.value, !lz.value) -> !lz.value
      %8 = call @lean_apply_3(%arg3, %arg0, %7, %arg1) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
      "rgn.return"(%8) : (!lz.value) -> ()
    }) : () -> i42
    %4 = "rgn.val"() ( {
      call @lean_dec(%arg3) : (!lz.value) -> ()
      call @lean_dec(%arg0) : (!lz.value) -> ()
      %6 = call @lean_apply_1(%arg2, %arg1) : (!lz.value, !lz.value) -> !lz.value
      "rgn.return"(%6) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_nestAux_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_nestAux_match__1___rarg} : () -> !lz.value
    %c4_i32 = constant 4 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c4_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_nestAux(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c0_i32_0 = constant 0 : i32
    %1 = call @lean_unsigned_to_nat(%c0_i32_0) : (i32) -> !lz.value
    %2 = call @lean_nat_dec_eq(%arg2, %1) : (!lz.value, !lz.value) -> i8
    %3 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %6 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
      %7 = call @lean_nat_sub(%arg2, %6) : (!lz.value, !lz.value) -> !lz.value
      %8 = call @lean_nat_sub(%arg0, %arg2) : (!lz.value, !lz.value) -> !lz.value
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_inc(%arg1) : (!lz.value) -> ()
      %9 = call @lean_apply_3(%arg1, %8, %arg3, %arg4) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
      %10 = "rgn.val"() ( {
        %c0_i32_1 = constant 0 : i32
        %14 = call @lean_ctor_get(%9, %c0_i32_1) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%14) : (!lz.value) -> ()
        %c1_i32_2 = constant 1 : i32
        %15 = call @lean_ctor_get(%9, %c1_i32_2) : (!lz.value, i32) -> !lz.value
        call @lean_inc(%15) : (!lz.value) -> ()
        call @lean_dec(%9) : (!lz.value) -> ()
        %16 = call @l_Expr_nestAux(%arg0, %arg1, %7, %14, %15) {musttail = "true"} : (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
        "rgn.return"(%16) : (!lz.value) -> ()
      }) : () -> i42
      %11 = "rgn.val"() ( {
        call @lean_dec(%7) : (!lz.value) -> ()
        call @lean_dec(%arg1) : (!lz.value) -> ()
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
      call @lean_dec(%arg2) : (!lz.value) -> ()
      call @lean_dec(%arg1) : (!lz.value) -> ()
      %c0_i32_1 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_2 = constant 2 : i32
      %6 = call @lean_alloc_ctor(%c0_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
      %c0_i32_3 = constant 0 : i32
      call @lean_ctor_set(%6, %c0_i32_3, %arg3) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32 = constant 1 : i32
      call @lean_ctor_set(%6, %c1_i32, %arg4) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%6) : (!lz.value) -> ()
    }) : () -> i42
    %5 = "rgn.select"(%2, %3, %4) {case0 = 0 : i64, case1 = 42 : i64} : (i8, i42, i42) -> i42
    "rgn.jumpval"(%5) : (i42) -> ()
  }
  func @l_Expr_nestAux___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_nestAux(%arg0, %arg1, %arg2, %arg3, %arg4) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_Expr_nest(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    call @lean_inc(%arg1) : (!lz.value) -> ()
    %1 = call @l_Expr_nestAux(%arg1, %arg0, %arg1, %arg2, %arg3) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg1) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @_init_l_Expr_deriv___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = "x"} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_Expr_deriv___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.string"() {value = " count: "} : () -> !lz.value
    %2 = call @lean_mk_string(%1) : (!lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @l_Expr_deriv(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_deriv___closed__1} : () -> !lz.value
    %2 = call @l_Expr_d(%1, %arg1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    %c1_i32 = constant 1 : i32
    %3 = call @lean_unsigned_to_nat(%c1_i32) : (i32) -> !lz.value
    %4 = call @lean_nat_add(%arg0, %3) : (!lz.value, !lz.value) -> !lz.value
    %5 = call @l_Nat_repr(%4) {musttail = "false"} : (!lz.value) -> !lz.value
    %6 = "ptr.loadglobal"() {value = @l_Expr_deriv___closed__2} : () -> !lz.value
    %7 = call @lean_string_append(%5, %6) : (!lz.value, !lz.value) -> !lz.value
    %8 = call @l_Expr_count(%2) {musttail = "false"} : (!lz.value) -> i32
    %9 = call @lean_uint32_to_nat(%8) : (i32) -> !lz.value
    %10 = call @l_Nat_repr(%9) {musttail = "false"} : (!lz.value) -> !lz.value
    %11 = call @lean_string_append(%7, %10) : (!lz.value, !lz.value) -> !lz.value
    call @lean_dec(%10) : (!lz.value) -> ()
    %12 = call @l_IO_println___at_Lean_instEval___spec__1(%11, %arg2) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    %13 = "rgn.val"() ( {
      %c1_i32_0 = constant 1 : i32
      %17 = call @lean_ctor_get(%12, %c1_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%17) : (!lz.value) -> ()
      call @lean_dec(%12) : (!lz.value) -> ()
      %c0_i32_1 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_2 = constant 2 : i32
      %18 = call @lean_alloc_ctor(%c0_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
      %c0_i32_3 = constant 0 : i32
      call @lean_ctor_set(%18, %c0_i32_3, %2) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_4 = constant 1 : i32
      call @lean_ctor_set(%18, %c1_i32_4, %17) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%18) : (!lz.value) -> ()
    }) : () -> i42
    %14 = "rgn.val"() ( {
      call @lean_dec(%2) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %17 = call @lean_ctor_get(%12, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%17) : (!lz.value) -> ()
      %c1_i32_1 = constant 1 : i32
      %18 = call @lean_ctor_get(%12, %c1_i32_1) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%18) : (!lz.value) -> ()
      call @lean_dec(%12) : (!lz.value) -> ()
      %c1_i32_2 = constant 1 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_3 = constant 2 : i32
      %19 = call @lean_alloc_ctor(%c1_i32_2, %c2_i32, %c2_i32_3) : (i32, i32, i32) -> !lz.value
      %c0_i32_4 = constant 0 : i32
      call @lean_ctor_set(%19, %c0_i32_4, %17) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_5 = constant 1 : i32
      call @lean_ctor_set(%19, %c1_i32_5, %18) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%19) : (!lz.value) -> ()
    }) : () -> i42
    %15 = call @lean_obj_tag(%12) : (!lz.value) -> i32
    %16 = "rgn.select"(%15, %13, %14) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%16) : (i42) -> ()
  }
  func @l_Expr_deriv___boxed(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @l_Expr_deriv(%arg0, %arg1, %arg2) {musttail = "false"} : (!lz.value, !lz.value, !lz.value) -> !lz.value
    call @lean_dec(%arg0) : (!lz.value) -> ()
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_main_match__1___rarg(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = call @lean_apply_1(%arg1, %arg0) : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%1) : (!lz.value) -> ()
  }
  func @l_main_match__1(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value) -> !lz.value, value = @l_main_match__1___rarg} : () -> !lz.value
    %c2_i32 = constant 2 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c2_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_main___closed__1() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_Expr_deriv___closed__1} : () -> !lz.value
    %c1_i32 = constant 1 : i32
    %c1_i32_0 = constant 1 : i32
    %c1_i32_1 = constant 1 : i32
    %2 = call @lean_alloc_ctor(%c1_i32, %c1_i32_0, %c1_i32_1) : (i32, i32, i32) -> !lz.value
    %c0_i32_2 = constant 0 : i32
    call @lean_ctor_set(%2, %c0_i32_2, %1) : (!lz.value, i32, !lz.value) -> ()
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_main___closed__2() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.loadglobal"() {value = @l_main___closed__1} : () -> !lz.value
    %2 = call @l_Expr_pow(%1, %1) {musttail = "false"} : (!lz.value, !lz.value) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @_init_l_main___closed__3() -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %1 = "ptr.fnptr"() {type = (!lz.value, !lz.value, !lz.value) -> !lz.value, value = @l_Expr_deriv___boxed} : () -> !lz.value
    %c3_i32 = constant 3 : i32
    %c0_i32_0 = constant 0 : i32
    %2 = call @lean_alloc_closure(%1, %c3_i32, %c0_i32_0) : (!lz.value, i32, i32) -> !lz.value
    "rgn.return"(%2) : (!lz.value) -> ()
  }
  func @main_lean_custom_entrypoint_hack(%arg0: !lz.value) -> !lz.value {
    %c0_i32 = constant 0 : i32
    %0 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %c4_i32 = constant 4 : i32
    %1 = call @lean_unsigned_to_nat(%c4_i32) : (i32) -> !lz.value
    %2 = "ptr.loadglobal"() {value = @l_main___closed__3} : () -> !lz.value
    %3 = "ptr.loadglobal"() {value = @l_main___closed__2} : () -> !lz.value
    %4 = call @l_Expr_nestAux(%1, %2, %1, %3, %arg0) {musttail = "false"} : (!lz.value, !lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    %5 = "rgn.val"() ( {
      %c1_i32 = constant 1 : i32
      %9 = call @lean_ctor_get(%4, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      call @lean_dec(%4) : (!lz.value) -> ()
      %c0_i32_0 = constant 0 : i32
      %10 = call @lean_box(%c0_i32_0) : (i32) -> !lz.value
      %c0_i32_1 = constant 0 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_2 = constant 2 : i32
      %11 = call @lean_alloc_ctor(%c0_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
      %c0_i32_3 = constant 0 : i32
      call @lean_ctor_set(%11, %c0_i32_3, %10) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_4 = constant 1 : i32
      call @lean_ctor_set(%11, %c1_i32_4, %9) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %6 = "rgn.val"() ( {
      %c0_i32_0 = constant 0 : i32
      %9 = call @lean_ctor_get(%4, %c0_i32_0) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%9) : (!lz.value) -> ()
      %c1_i32 = constant 1 : i32
      %10 = call @lean_ctor_get(%4, %c1_i32) : (!lz.value, i32) -> !lz.value
      call @lean_inc(%10) : (!lz.value) -> ()
      call @lean_dec(%4) : (!lz.value) -> ()
      %c1_i32_1 = constant 1 : i32
      %c2_i32 = constant 2 : i32
      %c2_i32_2 = constant 2 : i32
      %11 = call @lean_alloc_ctor(%c1_i32_1, %c2_i32, %c2_i32_2) : (i32, i32, i32) -> !lz.value
      %c0_i32_3 = constant 0 : i32
      call @lean_ctor_set(%11, %c0_i32_3, %9) : (!lz.value, i32, !lz.value) -> ()
      %c1_i32_4 = constant 1 : i32
      call @lean_ctor_set(%11, %c1_i32_4, %10) : (!lz.value, i32, !lz.value) -> ()
      "rgn.return"(%11) : (!lz.value) -> ()
    }) : () -> i42
    %7 = call @lean_obj_tag(%4) : (!lz.value) -> i32
    %8 = "rgn.select"(%7, %5, %6) {case0 = 0 : i64, case1 = 42 : i64} : (i32, i42, i42) -> i42
    "rgn.jumpval"(%8) : (i42) -> ()
  }
  func private @initialize_Init(!lz.value) -> !lz.value
  func private @init_lean_custom_entrypoint_hack(%arg0: !lz.value) -> !lz.value {
    %0 = call @lean_io_mk_world() : () -> !lz.value
    %1 = call @initialize_Init(%0) : (!lz.value) -> !lz.value
    call @lean_dec_ref(%1) : (!lz.value) -> ()
    %2 = call @_init_l_Expr_pown___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%2) {value = @l_Expr_pown___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%2) : (!lz.value) -> ()
    %3 = call @_init_l_Expr_add___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%3) {value = @l_Expr_add___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%3) : (!lz.value) -> ()
    %4 = call @_init_l_Expr_add___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%4) {value = @l_Expr_add___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%4) : (!lz.value) -> ()
    %5 = call @_init_l_Expr_mul___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%5) {value = @l_Expr_mul___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%5) : (!lz.value) -> ()
    %6 = call @_init_l_Expr_mul___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%6) {value = @l_Expr_mul___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%6) : (!lz.value) -> ()
    %7 = call @_init_l_Expr_mul___closed__3() : () -> !lz.value
    "ptr.storeglobal"(%7) {value = @l_Expr_mul___closed__3} : (!lz.value) -> ()
    call @lean_mark_persistent(%7) : (!lz.value) -> ()
    %8 = call @_init_l_Expr_mul___closed__4() : () -> !lz.value
    "ptr.storeglobal"(%8) {value = @l_Expr_mul___closed__4} : (!lz.value) -> ()
    call @lean_mark_persistent(%8) : (!lz.value) -> ()
    %9 = call @_init_l_Expr_mul___closed__5() : () -> !lz.value
    "ptr.storeglobal"(%9) {value = @l_Expr_mul___closed__5} : (!lz.value) -> ()
    call @lean_mark_persistent(%9) : (!lz.value) -> ()
    %10 = call @_init_l_Expr_mul___closed__6() : () -> !lz.value
    "ptr.storeglobal"(%10) {value = @l_Expr_mul___closed__6} : (!lz.value) -> ()
    call @lean_mark_persistent(%10) : (!lz.value) -> ()
    %11 = call @_init_l_Expr_mul___closed__7() : () -> !lz.value
    "ptr.storeglobal"(%11) {value = @l_Expr_mul___closed__7} : (!lz.value) -> ()
    call @lean_mark_persistent(%11) : (!lz.value) -> ()
    %12 = call @_init_l_Expr_mul___closed__8() : () -> !lz.value
    "ptr.storeglobal"(%12) {value = @l_Expr_mul___closed__8} : (!lz.value) -> ()
    call @lean_mark_persistent(%12) : (!lz.value) -> ()
    %13 = call @_init_l_Expr_mul___closed__9() : () -> !lz.value
    "ptr.storeglobal"(%13) {value = @l_Expr_mul___closed__9} : (!lz.value) -> ()
    call @lean_mark_persistent(%13) : (!lz.value) -> ()
    %14 = call @_init_l_Expr_pow___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%14) {value = @l_Expr_pow___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%14) : (!lz.value) -> ()
    %15 = call @_init_l_Expr_pow___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%15) {value = @l_Expr_pow___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%15) : (!lz.value) -> ()
    %16 = call @_init_l_Expr_pow___closed__3() : () -> !lz.value
    "ptr.storeglobal"(%16) {value = @l_Expr_pow___closed__3} : (!lz.value) -> ()
    call @lean_mark_persistent(%16) : (!lz.value) -> ()
    %17 = call @_init_l_Expr_pow___closed__4() : () -> !lz.value
    "ptr.storeglobal"(%17) {value = @l_Expr_pow___closed__4} : (!lz.value) -> ()
    call @lean_mark_persistent(%17) : (!lz.value) -> ()
    %18 = call @_init_l_Expr_pow___closed__5() : () -> !lz.value
    "ptr.storeglobal"(%18) {value = @l_Expr_pow___closed__5} : (!lz.value) -> ()
    call @lean_mark_persistent(%18) : (!lz.value) -> ()
    %19 = call @_init_l_Expr_d___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%19) {value = @l_Expr_d___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%19) : (!lz.value) -> ()
    %20 = call @_init_l_Expr_d___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%20) {value = @l_Expr_d___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%20) : (!lz.value) -> ()
    %21 = call @_init_l_Expr_Expr_toString___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%21) {value = @l_Expr_Expr_toString___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%21) : (!lz.value) -> ()
    %22 = call @_init_l_Expr_instToStringExpr___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%22) {value = @l_Expr_instToStringExpr___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%22) : (!lz.value) -> ()
    %23 = call @_init_l_Expr_instToStringExpr() : () -> !lz.value
    "ptr.storeglobal"(%23) {value = @l_Expr_instToStringExpr} : (!lz.value) -> ()
    call @lean_mark_persistent(%23) : (!lz.value) -> ()
    %24 = call @_init_l_Expr_deriv___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%24) {value = @l_Expr_deriv___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%24) : (!lz.value) -> ()
    %25 = call @_init_l_Expr_deriv___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%25) {value = @l_Expr_deriv___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%25) : (!lz.value) -> ()
    %26 = call @_init_l_main___closed__1() : () -> !lz.value
    "ptr.storeglobal"(%26) {value = @l_main___closed__1} : (!lz.value) -> ()
    call @lean_mark_persistent(%26) : (!lz.value) -> ()
    %27 = call @_init_l_main___closed__2() : () -> !lz.value
    "ptr.storeglobal"(%27) {value = @l_main___closed__2} : (!lz.value) -> ()
    call @lean_mark_persistent(%27) : (!lz.value) -> ()
    %28 = call @_init_l_main___closed__3() : () -> !lz.value
    "ptr.storeglobal"(%28) {value = @l_main___closed__3} : (!lz.value) -> ()
    call @lean_mark_persistent(%28) : (!lz.value) -> ()
    %c0_i32 = constant 0 : i32
    %29 = call @lean_box(%c0_i32) : (i32) -> !lz.value
    %30 = call @lean_io_result_mk_ok(%29) : (!lz.value) -> !lz.value
    return %30 : !lz.value
  }
}

