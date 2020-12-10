// RUN: hask-opt %s  -lz-interpret | FileCheck %s
// RUN: hask-opt %s  | hask-opt -lz-interpret |  FileCheck %s
// CHECK: constructor(X 8)
module {
  // lz.make_data_constructor @"+#"
  // lz.make_data_constructor @"-#"
  // lz.make_data_constructor @"()"

  func @fibstrict (%i: i64) -> i64 {
    %retval = lz.caseint  %i
                [@default -> { ^entry: // todo: remove this defult
                  %fib = constant @fibstrict : (i64) -> i64
                  %lit_one = constant 1: i64
                  %i_minus_one_v = subi %i, %lit_one : i64

                  %fib_i_minus_one_t = lz.ap(%fib: (i64) ->  i64, %i_minus_one_v)
                  %fib_i_minus_one_v = lz.force(%fib_i_minus_one_t) : i64

                  %lit_two = constant 2: i64
                  %i_minus_two_v = subi %i, %lit_two : i64
                  %fib_i_minus_two_t = lz.ap(%fib: (i64) -> i64, %i_minus_two_v)
                  %fib_i_minus_two_v = lz.force(%fib_i_minus_two_t) : i64

                  %fib_sum  = addi %fib_i_minus_one_v, %fib_i_minus_two_v: i64
                  lz.return %fib_sum : i64
                }]
                [0 -> { ^entry:
                  lz.return %i :i64
                }]
                [1 -> { ^entry:
                  lz.return %i :i64
                }]

    return %retval: i64
  }

  // i:      0 1 2 3 4 5 6
  // fib(i): 0 1 1 2 3 5 8
  func @main () -> !lz.value {
    %lit_6 = std.constant 6 : i64
    %fib = constant @fibstrict   : (i64) -> i64
    %out_v = lz.ap(%fib : (i64) -> i64, %lit_6)
    %out_v_forced = lz.force(%out_v): i64
    %x = lz.construct(@X, %out_v_forced: i64)
    return %x : !lz.value
  }
}
