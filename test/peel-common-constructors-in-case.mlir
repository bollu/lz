// The common hask.construct(...) should be peeled out of  the `case`, 
// leaving us with the control flow to decide on the `int` followed by a boxing.
// TODO: really we want *anything* that is common in control flow to be 
//        pulled out.
// RUN: ../build/bin/hask-opt %s  --lz-interpret | FileCheck %s
// RUN: ../build/bin/hask-opt %s  --lz-worker-wrapper | FileCheck %s -check-prefix='CHECK-WW-IR'
// RUN: ../build/bin/hask-opt %s  --lz-interpret --lz-worker-wrapper | FileCheck %s -check-prefix='CHECK-WW-OUTPUT'
// Check that @plus works with Maybe works.
// CHECK-WW-IR: %1 = hask.case @Maybe %0 
// CHECK-WW-IR: %2 = hask.construct(@Just, %1 : !lz.value) : !lz.value
// CHECK-WW-OUTPUT: constructor(Just 0)
// CHECK: constructor(Just 0)



module {
  // f :: Maybe -> Maybe
  // f mi = case i of Maybe _ -> Maybe 1; Nothing -> Maybe 0;
  lz.func @f (%i : !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i): !lz.value
      %reti = lz.case @Maybe %icons 
           [@Nothing -> {
              %zero = lz.make_i64(0)
              %just0 = lz.construct(@Just, %zero: !lz.value)
              lz.return (%just0):!lz.value
           }]
           [@Just -> { ^entry(%_: !lz.value):
              %one = lz.make_i64(1)
              %just1 = lz.construct(@Just, %one: !lz.value)
              lz.return (%just1):!lz.value
           }]
      lz.return(%reti): !lz.value
    }


    lz.func @main() -> !lz.value {
        %n = lz.construct(@Nothing)
        %f = lz.ref(@f): !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
        %nt = lz.thunkify(%n : !lz.value) :!lz.thunk<!lz.value>
        %out = lz.apEager(%f: !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %nt)
        lz.return(%out) : !lz.value
    }
}

