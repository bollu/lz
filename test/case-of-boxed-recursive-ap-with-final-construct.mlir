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
              [@SimpleInt ->  { ^entry(%n: !lz.value):
                %v = lz.caseint %n
                [0 : i64 -> {
                  %forty_two = lz.make_i64(42)
                  %forty_two_si = lz.construct(@SimpleInt, %forty_two: !lz.value)
                  lz.return %forty_two_si : !lz.value
                }]
                [@default ->  {
                  %one = lz.make_i64(1)
                  %n_minus_1 = lz.primop_sub(%n, %one)
                  %si_n_minus_1 = lz.construct(@SimpleInt, %n_minus_1: !lz.value)
                  %f = constant @f : (!lz.value) -> !lz.value
                  %ret = lz.apEager(%f: (!lz.value) -> !lz.value, %si_n_minus_1)
                  lz.return %ret :!lz.value
                }]

                lz.return %v : !lz.value
              }]

    return %reti : !lz.value
  }

  func @main() -> !lz.value {
    %three = lz.make_i64(3)
    %n = lz.construct(@SimpleInt, %three:!lz.value)
    %f = constant @f : (!lz.value) -> !lz.value
    %out = lz.apEager(%f: (!lz.value) -> !lz.value, %n)
    return %out : !lz.value
  }
}

