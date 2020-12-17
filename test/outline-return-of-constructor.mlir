// This is the exmple worker-wrapper-int-non-tail-recursive minus all the fluff
// with thunking and whatnot, along with a simplified program with the 
// constructor already at the bottom. We want to check that we peel the
// constructor correctly.
// TODO: make this *one* pass creatable as a separate pass and use that
// fo writing this test.
// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// RUN: hask-opt %s  --lz-worker-wrapper --lz-interpret | FileCheck %s --check-prefix=CHECK-WW
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 42)
// CHECK: num_thunkify_calls(0)
// CHECK: num_force_calls(0)
// CHECK: num_construct_calls(76)

// CHECK-WW: constructor(SimpleInt 42)
// CHECK-WW: num_thunkify_calls(0)
// CHECK-WW: num_force_calls(0)
// CHECK-WW: num_construct_calls(1)

module {        
  // f :: SimpleInt -> SimpleInt
  // f i = SimpleInt (case i of SimpleInt i# ->
  //          case i# of
  //            0 ->  5;
  //            _ -> case f ( SimpleInt(i# -# 1#)) of
  //                  SimpleInt j# -> (j# +# 1))
  func @f (%icons : !lz.value) -> !lz.value {
    %reti = lz.case @SimpleInt %icons
              [@SimpleInt -> { ^entry(%i: i64):
                %retj = lz.caseint %i
                [0 -> {
                  %five = constant 5: i64
                  lz.return %five : i64
                }]
                [@default ->  {
                  %one = constant 1: i64
                  %idecr = subi %i, %one: i64
                  %idecrbox = lz.construct(@SimpleInt, %idecr: i64)
                  %f = constant @f: (!lz.value) -> !lz.value
                  %recv = std.call @f (%idecrbox) : (!lz.value) -> !lz.value
                  %out = lz.case @SimpleInt %recv
                           [@SimpleInt -> { ^entry(%jhash: i64):
                             %onej = constant 1: i64
                             %jincr = addi %jhash, %onej : i64
                             lz.return %jincr : i64
                           }]
                  lz.return %out : i64
                }]
                lz.return %retj: i64
              }]
    %retibox = lz.construct(@SimpleInt, %reti: i64)
    lz.return %retibox : !lz.value
  }

  // 37 + 5 = 42
  func @main() -> !lz.value {
    %v = constant 37: i64
    %vbox = lz.construct(@SimpleInt, %v: i64)
    %f = constant @f : (!lz.value) -> !lz.value
    %outv = std.call @f (%vbox) : (!lz.value) -> !lz.value
    lz.return %outv : !lz.value
  }
}
