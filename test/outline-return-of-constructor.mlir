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
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // f :: SimpleInt -> SimpleInt
  // f i = case i of SimpleInt i# ->
  //          case i# of
  //            0 -> SimpleInt 5;
  //            _ -> case f ( SimpleInt(i# -# 1#)) of
  //                  SimpleInt j# -> SimpleInt (j# +# 1)
  func @f (%icons : !lz.value) -> !lz.value {
    %reti = lz.case @SimpleInt %icons
              [@SimpleInt -> { ^entry(%i: !lz.value):
                %retj = lz.caseint %i
                [0 -> {
                  %five = lz.make_i64(5)
                  lz.return %five : !lz.value
                }]
                [@default ->  {
                  %one = lz.make_i64(1)
                  %idecr = lz.primop_sub(%i, %one)
                  %idecrbox = lz.construct(@SimpleInt, %idecr: !lz.value)
                  %f = constant @f: (!lz.value) -> !lz.value
                  %recv = lz.apEager(%f : (!lz.value) -> !lz.value , %idecrbox)
                  %out = lz.case @SimpleInt %recv
                           [@SimpleInt -> { ^entry(%jhash: !lz.value):
                             %onej = lz.make_i64(1)
                             %jincr = lz.primop_add(%jhash, %onej)
                             lz.return %jincr : !lz.value
                           }]
                  lz.return %out : !lz.value
                }]
                lz.return %retj :!lz.value
              }]
    %retibox = lz.construct(@SimpleInt, %reti: !lz.value)
    return %retibox : !lz.value
  }

  // 37 + 5 = 42
  func @main() -> !lz.value {
    %v = lz.make_i64(37)
    %vbox = lz.construct(@SimpleInt, %v:!lz.value)
    %f = constant @f : (!lz.value) -> !lz.value
    %outv = lz.apEager(%f : (!lz.value) -> !lz.value, %vbox)
    return %outv : !lz.value
  }
}
