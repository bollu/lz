// A simple recursive function: f(Int 0) = Int 42; f(Int x) = f(x-1)
// We need to worker wrapper optimise this into:
// f(Int y) = Int (g# y)
// g# 0 = 1; g# x = g (x - 1) -- g# is strict.
// RUN: ../build/bin/hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: constructor(SimpleInt 42)
module {

  lz.func @f(%i: !lz.thunk<!lz.value>) -> !lz.value {
        %icons = lz.force(%i):!lz.value
        %ihash = lz.defaultcase(@SimpleInt, %icons) : !lz.value
        %ret = lz.caseint %ihash 
            [0 -> { ^entry: 
                      %v = lz.make_i64(42)
                      %boxed = lz.construct(@SimpleInt, %v:!lz.value) 
                      lz.return (%boxed): !lz.value
            }]
            [@default -> { ^entry:
                       %f = lz.ref(@f):  !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
                       %onehash = lz.make_i64(1)
                       %prev = lz.primop_sub(%ihash, %onehash)
                       %box_prev_v = lz.construct(@SimpleInt, %prev: !lz.value)
                       %box_prev_t = lz.thunkify(%box_prev_v :!lz.value) : !lz.thunk<!lz.value>
                       %fprev_t = lz.ap(%f: !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, 
                           %box_prev_t) 
                       %prev_v = lz.force(%fprev_t): !lz.value
                       lz.return(%prev_v): !lz.value
            }]
        lz.return (%ret):!lz.value
    }


  lz.func@main() -> !lz.value {
      %n = lz.make_i64(6)
      %box_n_v = lz.construct(@SimpleInt, %n: !lz.value) 
      %box_n_t = lz.thunkify(%box_n_v: !lz.value) : !lz.thunk<!lz.value>
      %f = lz.ref(@f)  : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
      %out_t = lz.ap(%f : !lz.fn<(!lz.thunk<!lz.value>) ->  !lz.value>, %box_n_t)
      %out_v = lz.force(%out_t): !lz.value
      lz.return(%out_v) : !lz.value
    }
    
}
