// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// RUN: hask-opt %s  |  hask-opt --lz-interpret | FileCheck %s
// RUN: hask-opt %s  --lz-worker-wrapper --lz-interpret | FileCheck %s --check-prefix=CHECK-WW 
// RUN: hask-opt %s  --lz-worker-wrapper | hask-opt --lz-interpret | FileCheck %s --check-prefix=CHECK-WW 

// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 42)
// CHECK: num_thunkify_calls(12)
// CHECK: num_force_calls(12)
// CHECK: num_construct_calls(7)

// CHECK-WW: constructor(SimpleInt 42)
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)
// CHECK-WW: num_construct_calls(1)
module {
  // f :: SimpleInt -> SimpleInt
  // f i = case i of SimpleInt i# -> case i# of 0 -> SimpleInt 42; _ -> f ( SimpleInt(i# -# 1#))
  func @f (%i : !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i): !lz.value
      %reti = lz.case @SimpleInt %icons 
           [@SimpleInt -> { ^entry(%ihash: !lz.value):
              %retj = lz.caseint %ihash
                  [0 -> {
                        %fortytwo = lz.make_i64(42)
                        %boxed = lz.construct(@SimpleInt, %fortytwo:!lz.value)
                        lz.return %boxed : !lz.value
                  }]
                  [@default ->  {
                        %one = lz.make_i64(1)
                        %isub = lz.primop_sub(%ihash, %one)
                        %boxed_isub = lz.construct(@SimpleInt, %isub: !lz.value)
                        %boxed_isub_t = lz.thunkify(%boxed_isub : !lz.value) : !lz.thunk<!lz.value>
                        %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
                        %rec_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value , %boxed_isub_t)
                        %rec_v = lz.force(%rec_t): !lz.value
                        lz.return %rec_v: !lz.value
                  }]
              lz.return %retj:!lz.value
           }]
      lz.return %reti: !lz.value
    }

  // 1 + 2 = 3
  func @main () -> !lz.value {
      %v = lz.make_i64(5)
      %v_box = lz.construct(@SimpleInt, %v:!lz.value)
      %v_thunk = lz.thunkify(%v_box: !lz.value): !lz.thunk<!lz.value>
      %f = constant @f: (!lz.thunk<!lz.value>) -> !lz.value
      %out_t = lz.ap(%f : (!lz.thunk<!lz.value>) -> !lz.value, %v_thunk)
      %out_v = lz.force(%out_t): !lz.value
      lz.return %out_v : !lz.value
    }
}
