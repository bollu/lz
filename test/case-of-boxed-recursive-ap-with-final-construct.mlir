// The common lz.construct(...) should be peeled out of  the `case`,
// leaving us with the control flow to decide on the `int` followed by a boxing.
// TODO: really we want *anything* that is common in control flow to be
//        pulled out.
// RUN: hask-opt %s  -lz-interpret | FileCheck %s
// RUN: hask-opt %s  -lz-interpret -lz-worker-wrapper | FileCheck %s -check-prefix='CHECK-WW-OUTPUT'
// Check that @plus works with SimpleInt works.
// CHECK-WW-OUTPUT: constructor(SimpleInt 42)
// CHECK: constructor(SimpleInt 42)

module {
  // f :: SimpleInt -> SimpleInt
  // f mi = case si of SimpleInt n -> case n of 0 -> SimpleInt 42; _ -> f (SimpleInt (ihash - 1))
  func @f (%sn: !lz.value) -> !lz.value {
    %reti = lz.case @SimpleInt %sn
              [@SimpleInt ->  { ^entry(%n: i64):
                %v = lz.caseint %n
                [0 : i64 -> {
                  %forty_two = constant 42 : i64
                  %forty_two_si = lz.construct(@SimpleInt, %forty_two: i64)
                  lz.return %forty_two_si : !lz.value
                }]
                [@default ->  {
                  %one = constant 1 : i64
                  %n_minus_1 = subi %n, %one : i64
                  %si_n_minus_1 = lz.construct(@SimpleInt, %n_minus_1: i64)
                  %f = constant @f : (!lz.value) -> !lz.value
                  %ret = call @f (%si_n_minus_1) :  (!lz.value) -> !lz.value
                  lz.return %ret :!lz.value
                }]
                lz.return %v : !lz.value
              }]

    return %reti : !lz.value
  }

  func @main() -> !lz.value {
    %three = constant 3 : i64
    %n = lz.construct(@SimpleInt, %three: i64)
    %f = constant @f : (!lz.value) -> !lz.value
    %out = call @f (%n) :  (!lz.value) -> !lz.value
    return %out : !lz.value
  }
}

