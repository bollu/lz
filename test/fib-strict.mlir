// RUN: hask-opt %s  -lz-interpret | FileCheck %s
// RUN: hask-opt %s  | hask-opt -lz-interpret |  FileCheck %s
// CHECK: constructor(X 8)
module {
  // lz.make_data_constructor @"+#"
  // lz.make_data_constructor @"-#"
  // lz.make_data_constructor @"()"

  func @fibstrict (%i: !lz.value) -> !lz.value {
    %retval = lz.caseint  %i
                [@default -> { ^entry: // todo: remove this defult
                  %fib_rec = constant @fibstrict : (!lz.value) -> !lz.value
                  %lit_one = lz.make_i64(1)
                  %i_minus_one_v = lz.primop_sub(%i, %lit_one)

                  %fib_i_minus_one_t = lz.ap(%fib_rec: (!lz.value) ->  !lz.value, %i_minus_one_v)
                  %fib_i_minus_one_v = lz.force(%fib_i_minus_one_t) : !lz.value

                  %lit_two = lz.make_i64(2)
                  %i_minus_two_v = lz.primop_sub(%i, %lit_two)
                  %fib_i_minus_two_t = lz.ap(%fib_rec: (!lz.value) -> !lz.value, %i_minus_two_v)
                  %fib_i_minus_two_v = lz.force(%fib_i_minus_two_t) : !lz.value

                  %fib_sum  = lz.primop_add(%fib_i_minus_one_v, %fib_i_minus_two_v)
                  lz.return %fib_sum : !lz.value
                }]
                [0 -> { ^entry:
                  lz.return %i :!lz.value
                }]
                [1 -> { ^entry:
                  lz.return %i :!lz.value
                }]

    return %retval  : !lz.value
  }

  // i:      0 1 2 3 4 5 6
  // fib(i): 0 1 1 2 3 5 8
  func @main () -> !lz.value {
    %lit_6 = lz.make_i64(6)
    %fib = constant @fibstrict   : (!lz.value) -> !lz.value
    %out_v = lz.ap(%fib : (!lz.value) -> !lz.value, %lit_6)
    %out_v_forced = lz.force(%out_v): !lz.value
    %x = lz.construct(@X, %out_v_forced: !lz.value)
    return %x : !lz.value
  }
}
