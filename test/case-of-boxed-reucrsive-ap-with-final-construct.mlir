// The common lz.construct(...) should be peeled out of  the `case`, 
// leaving us with the control flow to decide on the `int` followed by a boxing.
// TODO: really we want *anything* that is common in control flow to be 
//        pulled out.
// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// RUN: ../build/bin/hask-opt %s  -worker-wrapper | FileCheck %s -check-prefix='CHECK-WW-IR'
// RUN: ../build/bin/hask-opt %s  -interpret -worker-wrapper | FileCheck %s -check-prefix='CHECK-WW-OUTPUT'
// RUN: ../build/bin/hask-opt %s -lower-std -lower-llvm | FileCheck %s || true
// RUN: ../build/bin/hask-opt %s  | ../build/bin/hask-opt -lower-std -lower-llvm |  FileCheck %s || true
// Check that @plus works with SimpleInt works.
// CHECK-WW-OUTPUT: constructor(SimpleInt)
// CHECK: constructor(SimpleInt)



module {
  // f :: SimpleInt -> SimpleInt
  // f mi = case si of SimpleInt n -> case n of 0 -> SimpleInt 42; _ -> f (SimpleInt (ihash - 1))
  lz.func @f (%sn: !lz.value) -> !lz.value {
      %reti = lz.case @SimpleInt %sn 
                  [@SimpleInt ->  {
                     ^entry(%n: !lz.value):

                     %v = lz.caseint %n
                      [0 : i64 -> {
                        %forty_two = lz.make_i64(42)
                        %forty_two_si = lz.construct(@SimpleInt, %forty_two: !lz.value)
                        lz.return(%forty_two_si): !lz.value
                      }]

                      [@default ->  {
                         %one = lz.make_i64(1)
                         %n_minus_1 = lz.primop_sub(%n, %one)
                         %si_n_minus_1 = lz.construct(@SimpleInt, %n_minus_1: !lz.value)
                         %f = lz.ref(@f): !lz.fn<(!lz.value) -> !lz.value>
                         %ret = lz.apEager(%f : !lz.fn<(!lz.value) -> !lz.value> , %si_n_minus_1)
                         lz.return(%ret):!lz.value
                      }]

                     lz.return(%v) : !lz.value
                  }]

      lz.return (%reti): !lz.value
    }


    lz.func @main() -> !lz.value {
        %three = lz.make_i64(3)
        %n = lz.construct(@SimpleInt, %three:!lz.value)
        %f = lz.ref(@f): !lz.fn<(!lz.value) -> !lz.value>
        %out = lz.apEager(%f: !lz.fn<(!lz.value) -> !lz.value>, %n)
        lz.return(%out) : !lz.value
    }
}

