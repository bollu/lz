//  RUN: hask-opt %s --lz-lazify --verify-each --verify-region-info


// The output that we ought to get from the ackermann.lean, but don't yet.
module  {
  func private @panic(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @UInt32_dot_decEq(!lz.value, !lz.value) -> !lz.value
  func private @UInt32_dot_add(!lz.value, !lz.value) -> !lz.value
  func private @"UInt32_dot_sub    "(!lz.value, !lz.value) -> !lz.value
  func private @UInt32_dot_ofNat(!lz.value) -> !lz.value
  func private @UInt32_dot_toNat(!lz.value) -> !lz.value
  func private @Nat_dot_add(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_sub(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_mul(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_max(!lz.value, !lz.value) -> !lz.value
  func private @instInhabitedNat() -> !lz.value
  func private @Nat_dot_repr(!lz.value) -> !lz.value
  func private @Nat_dot_decLt(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_decLe(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_pow(!lz.value, !lz.value) -> !lz.value
  func private @Nat_dot_decEq(!lz.value, !lz.value) -> !lz.value
  func private @String_dot_instInhabitedString() -> !lz.value
  func private @String_dot_toNat_bang_(!lz.value) -> !lz.value
  func private @String_dot_append(!lz.value, !lz.value) -> !lz.value
  func private @Array_dot_empty_dot__closed_1() -> !lz.value
  func private @Array_dot_set_bang_(!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
  func private @Array_dot_get_bang_(!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
  func private @Array_dot_push(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @Array_dot_size(!lz.value, !lz.value) -> !lz.value
  func private @Array_dot_get(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @List_dot_head_bang__dot__rarg_dot__closed_3() -> !lz.value
  func private @IO_dot_println_dot__at_dot_Lean_dot_instEval_dot__spec_1(!lz.value, !lz.value) -> !lz.value
  func private @String_dot_push(!lz.value, !lz.value) -> !lz.value
  func private @IO_dot_print_dot__at_dot_IO_dot_println_dot__spec_1(!lz.value, !lz.value) -> !lz.value
  func private @term__star___dot__closed_3() -> !lz.value
  func private @Lean_dot_Parser_dot_Syntax_dot_addPrec_dot__closed_11() -> !lz.value
  func private @Task_dot_get(!lz.value, !lz.value) -> !lz.value
  func private @Task_dot_spawn(!lz.value, !lz.value, !lz.value) -> !lz.value
  func private @Task_dot_Priority_dot_default() -> !lz.value
  func @ackermann_dot_match_1_dot__rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value, %arg4: !lz.value) -> !lz.value {
    %0 = "lz.int"() {value = 0 : i64} : () -> !lz.value
    %1 = call @Nat_dot_decEq(%arg0, %0) : (!lz.value, !lz.value) -> !lz.value
    %2 = "lz.tagget"(%1) : (!lz.value) -> i64
    %3 = "lz.case"(%2) ( {
      %4 = "lz.int"() {value = 1 : i64} : () -> !lz.value
      %5 = call @Nat_dot_sub(%arg0, %4) : (!lz.value, !lz.value) -> !lz.value
      %6 = call @Nat_dot_decEq(%arg1, %0) : (!lz.value, !lz.value) -> !lz.value
      %7 = "lz.tagget"(%6) : (!lz.value) -> i64
      %8 = "lz.case"(%7) ( {
        %9 = call @Nat_dot_sub(%arg1, %4) : (!lz.value, !lz.value) -> !lz.value
        %10 = "lz.apEager"(%arg4, %5, %9) : (!lz.value, !lz.value, !lz.value) -> !lz.value
        lz.return %10 : !lz.value
      },  {
        %9 = "lz.apEager"(%arg3, %5) : (!lz.value, !lz.value) -> !lz.value
        lz.return %9 : !lz.value
      }) {alt0 = @"0", alt1 = @"1"} : (i64) -> !lz.value
      lz.return %8 : !lz.value
    },  {
        %9 = "lz.apEager"(%arg2, %arg1) : (!lz.value, !lz.value) -> !lz.value
        lz.return %9 : !lz.value
      }) {alt0 = @"0", alt1 = @"1"} : (i64) -> !lz.value
    lz.return %3 : !lz.value
  }
  func @ackermann_dot_match_1(%arg0: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @ackermann_dot_match_1_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @ackermann(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %0 = "lz.int"() {value = 0 : i64} : () -> !lz.value
    %1 = call @Nat_dot_decEq(%arg0, %0) : (!lz.value, !lz.value) -> !lz.value
    %2 = "lz.tagget"(%1) : (!lz.value) -> i64
    %3 = "lz.case"(%2) ( {
      %4 = "lz.int"() {value = 1 : i64} : () -> !lz.value
      %5 = call @Nat_dot_sub(%arg0, %4) : (!lz.value, !lz.value) -> !lz.value
      %6 = call @Nat_dot_decEq(%arg1, %0) : (!lz.value, !lz.value) -> !lz.value
      %7 = "lz.tagget"(%6) : (!lz.value) -> i64
      %8 = "lz.case"(%7) ( {
        %9 = call @Nat_dot_sub(%arg1, %4) : (!lz.value, !lz.value) -> !lz.value
        %10 = call @Nat_dot_add(%5, %4) : (!lz.value, !lz.value) -> !lz.value
        %11 = call @ackermann(%10, %9) : (!lz.value, !lz.value) -> !lz.value
        %12 = call @ackermann(%5, %11) : (!lz.value, !lz.value) -> !lz.value
        lz.return %12 : !lz.value
      },  {
        %9 = call @ackermann(%5, %4) : (!lz.value, !lz.value) -> !lz.value
        lz.return %9 : !lz.value
      }) {alt0 = @"0", alt1 = @"1"} : (i64) -> !lz.value
      lz.return %8 : !lz.value
    },  {
        %9 = "lz.int"() {value = 1 : i64} : () -> !lz.value
        %10 = call @Nat_dot_add(%arg1, %9) : (!lz.value, !lz.value) -> !lz.value
        lz.return %10 : !lz.value
      }) {alt0 = @"0", alt1=@"1"} : (i64) -> !lz.value
    lz.return %3 : !lz.value
  }
  func @k_dot_match_1_dot__rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %0 = "lz.apEager"(%arg2, %arg0, %arg1) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %0 : !lz.value
  }
  func @k_dot_match_1(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @k_dot_match_1_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @k_dot__rarg(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    lz.return %arg0 : !lz.value
  }
  func @k(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @k_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @s_dot_match_1_dot__rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %0 = "lz.apEager"(%arg3, %arg0, %arg1, %arg2) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %0 : !lz.value
  }
  func @s_dot_match_1(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @s_dot_match_1_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @s_dot__rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %0 = "lz.apEager"(%arg1, %arg2) : (!lz.value, !lz.value) -> !lz.value
    %1 = "lz.apEager"(%arg0, %arg2, %0) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %1 : !lz.value
  }
  func @s(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @s_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @foo_dot_match_1_dot__rarg(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value, %arg3: !lz.value) -> !lz.value {
    %0 = "lz.apEager"(%arg3, %arg0, %arg1, %arg2) : (!lz.value, !lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %0 : !lz.value
  }
  func @foo_dot_match_1(%arg0: !lz.value) -> !lz.value {
    %0 = "lz.pap"() {value = @foo_dot_match_1_dot__rarg} : () -> !lz.value
    lz.return %0 : !lz.value
  }
  func @foo(%arg0: !lz.value, %arg1: !lz.value, %arg2: !lz.value) -> !lz.value {
    %0 = "lz.int"() {value = 0 : i64} : () -> !lz.value
    %1 = call @Nat_dot_decEq(%arg2, %0) : (!lz.value, !lz.value) -> !lz.value
    %2 = "lz.tagget"(%1) : (!lz.value) -> i64
    %3 = "lz.case"(%2) ( {
      lz.return %arg1 : !lz.value
    },  {
      lz.return %arg0 : !lz.value
    }) {alt0 = @"0", alt1 = @"1"} : (i64) -> !lz.value
    lz.return %3 : !lz.value
  }
  func @IO_dot_println_dot__at_dot_main_dot__spec_1(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %0 = call @Nat_dot_repr(%arg0) : (!lz.value) -> !lz.value
    %1 = "lz.int"() {value = 10 : i64} : () -> !lz.value
    %2 = call @String_dot_push(%0, %1) : (!lz.value, !lz.value) -> !lz.value
    %3 = call @IO_dot_print_dot__at_dot_IO_dot_println_dot__spec_1(%2, %arg1) : (!lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  }
  func @main_dot__closed_1() -> !lz.value {
    %0 = "lz.int"() {value = 4 : i64} : () -> !lz.value
    %1 = "lz.int"() {value = 1 : i64} : () -> !lz.value
    %2 = call @ackermann(%0, %1) : (!lz.value, !lz.value) -> !lz.value
    lz.return %2 : !lz.value
  }
  func @main_dot__closed_2() -> !lz.value {
    %0 = "lz.int"() {value = 3 : i64} : () -> !lz.value
    %1 = call @ackermann(%0, %0) : (!lz.value, !lz.value) -> !lz.value
    lz.return %1 : !lz.value
  }
  func @main_dot__closed_3() -> !lz.value {
    %0 = call @main_dot__closed_2() : () -> !lz.value
    %1 = call @main_dot__closed_1() : () -> !lz.value
    %2 = "lz.int"() {value = 0 : i64} : () -> !lz.value
    %3 = call @foo(%0, %1, %2) : (!lz.value, !lz.value, !lz.value) -> !lz.value
    lz.return %3 : !lz.value
  }
  func @_lean_main(%arg0: !lz.value, %arg1: !lz.value) -> !lz.value {
    %0 = call @main_dot__closed_3() : () -> !lz.value
    %1 = call @IO_dot_println_dot__at_dot_main_dot__spec_1(%0, %arg1) : (!lz.value, !lz.value) -> !lz.value
    lz.return %1 : !lz.value
  }
}
