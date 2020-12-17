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
func @f(%arg0: !lz.value) -> i64 {
  %f = constant @f : (!lz.value) -> i64
  %0 = "lz.case"(%arg0) ( {
  ^bb0(%arg1: i64):  // no predecessors
    %1 = "lz.caseint"(%arg1) ( {
      %2 = constant 5 : i64
      lz.return %2 : i64
    },  {
      %2 = constant 1 : i64
      %3 = subi %arg1, %2: i64
      %4 = "lz.construct"(%3) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
      %5 = std.call @f (%4) : (!lz.value) -> i64
      %6 = constant 1 : i64
      %7 = addi %5, %6: i64
      lz.return %7 : i64
    }) {alt0 = 0 : i64, alt1 = @default} : (i64) -> i64
    lz.return %1 : i64
  }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> i64
  lz.return %0 : i64
}

// 37 + 5 = 42
// main = f (SimpleInt 37)
func @main() -> i64 {
  %i = constant 37: i64
  %ibox = lz.construct(@SimpleInt, %i: i64)
  %f = constant @f : (!lz.value) -> i64
  %out = std.call @f (%ibox) : (!lz.value) -> i64
  lz.return %out: i64
}

