// A simple recursive function: f(Int 0) = Int 42; f(Int x) = f(x-1)
// We need to worker wrapper optimise this into:
// f(Int y) = Int (g# y)
// g# 0 = 1; g# x = g (x - 1) -- g# is strict.
// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: constructor(SimpleInt 42)
module {

  func @f(%i: !lz.thunk<!lz.value>) -> !lz.value {
    %icons = lz.force(%i):!lz.value
    %ihash = lz.case  @SimpleInt %icons [@SimpleInt -> { ^entry(%ihash: i64): lz.return %ihash : i64 }]
    %ret = lz.caseint %ihash
             [0 -> { ^entry:
               %v = constant 42: i64
               %boxed = lz.construct(@SimpleInt, %v: i64)
               lz.return %boxed : !lz.value
             }]
             [@default -> { ^entry:
               %f = constant @f :  (!lz.thunk<!lz.value>) -> !lz.value
               %onehash = constant 1: i64
               %prev = subi %ihash, %onehash: i64
               %box_prev_v = lz.construct(@SimpleInt, %prev: i64)
               %box_prev_t = lz.thunkify(%box_prev_v :!lz.value) : !lz.thunk<!lz.value>
               %fprev_t = lz.ap(%f: (!lz.thunk<!lz.value>) -> !lz.value, %box_prev_t)
               %prev_v = lz.force(%fprev_t): !lz.value
               lz.return %prev_v : !lz.value
             }]
    return %ret : !lz.value
  }


  func @main() -> !lz.value {
    %n = constant 6: i64
    %box_n_v = lz.construct(@SimpleInt, %n: i64)
    %box_n_t = lz.thunkify(%box_n_v: !lz.value) : !lz.thunk<!lz.value>
    %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
    %out_t = lz.ap(%f: (!lz.thunk<!lz.value>) -> !lz.value, %box_n_t)
    %out_v = lz.force(%out_t): !lz.value
    return %out_v : !lz.value
  }
}
