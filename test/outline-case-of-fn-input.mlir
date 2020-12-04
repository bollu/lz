// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// RUN: hask-opt %s  | hask-opt --lz-interpret |  FileCheck %s
// RUN: hask-opt %s  --lz-worker-wrapper --lz-interpret | FileCheck %s --check-prefix=CHECK-WW
// RUN: hask-opt %s -lz-worker-wrapper | hask-opt  -lz-interpret | FileCheck %s --check-prefix=CHECK-WW
// CHECK: 42
// CHECK: num_construct_calls(38)
// CHECK-WW: 42
// CHECK-WW: num_construct_calls(0)

// Check that we are able to worker/wrapper the SimpleInt recursion
// f :: SimpleInt -> i64
// f si = case si of SimpleInt i -> case i of 0 -> 5; _ -> f (SimpleInt(i - 1))
func @f(%arg0: !lz.value) -> !lz.value {
  %f = constant @f : (!lz.value) -> !lz.value
  %0 = "lz.case"(%arg0) ( {
  ^bb0(%arg1: !lz.value):  // no predecessors
    %1 = "lz.caseint"(%arg1) ( {
      %2 = "lz.make_i64"() {value = 5 : i64} : () -> !lz.value
      lz.return %2 : !lz.value
    },  {
      %2 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
      %3 = lz.primop_sub(%arg1,%2)
      %4 = "lz.construct"(%3) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
      %5 = "lz.apEager"(%f, %4) : ((!lz.value) -> !lz.value, !lz.value) -> !lz.value
      %6 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
      %7 = lz.primop_add(%5,%6)
      lz.return %7 : !lz.value
    }) {alt0 = 0 : i64, alt1 = @default} : (!lz.value) -> !lz.value
    lz.return %1 : !lz.value
  }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
  lz.return %0 : !lz.value
}

// 37 + 5 = 42
// main = f (SimpleInt 37)
func @main() -> !lz.value {
  %i = lz.make_i64(37)
  %ibox = lz.construct(@SimpleInt, %i:!lz.value)
  %f = constant @f : (!lz.value) -> !lz.value
  %out = lz.apEager(%f : (!lz.value) -> !lz.value, %ibox)
  return %out: !lz.value
}

