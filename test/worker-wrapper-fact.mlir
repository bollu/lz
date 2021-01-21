// Test lowering of ap & force.
// RUN: hask-opt %s --lz-interpret  | FileCheck %s
// RUN: hask-opt %s --lz-worker-wrapper --lz-interpret | FileCheck %s --check-prefix=CHECK-WW
// CHECK: 40320
// CHECK: num_thunkify_calls(18)
// CHECK: num_force_calls(18)
// CHECk-WW: 40320
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)
module {
  // fact 0 = 1
  // fact n = n*fact(n-1)
  func @f (%i : !lz.thunk<i64>) -> i64 {
    %ival = lz.force(%i):i64
    %out = lz.caseint %ival 
        [0 ->   { 
            ^entry:
            %c1 = constant 1 : i64
            lz.return %c1 : i64
        }]
        [@default -> {
            ^entry:
            %c1 = constant 1 : i64
            %idec = subi %ival, %c1 : i64
            %idecthnk = lz.thunkify(%idec : i64) 
            %f = constant @f : (!lz.thunk<i64>) -> i64
            %f_idec_thnk = lz.ap(%f: (!lz.thunk<i64>) -> i64, %idecthnk)
            %f_idec_val = lz.force(%f_idec_thnk) : i64
            %prod = muli %ival, %f_idec_val : i64
            lz.return %prod : i64
        }]
    return %out : i64
  }

  func @c8 () -> i64 {
    %v = std.constant 8 : i64
    return %v: i64
  }

  func @main() -> i64 {
    %f = constant @f : (!lz.thunk<i64>) -> i64
    %c8f = constant @c8 : () -> i64
    %c8t = lz.ap(%c8f : () -> i64)
    %outt = lz.ap(%f: (!lz.thunk<i64>) -> i64, %c8t)
    %out = lz.force(%outt) : i64
    return %out : i64
  }
}

