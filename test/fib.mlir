// RUN: hask-opt %s  --lz-interpret  | FileCheck %s
// CHECK: constructor(SimpleInt 8)
// Core2MLIR: GenMLIR BeforeCorePrep
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type

  // plus :: SimpleInt -> SimpleInt -> SimpleInt
  // plus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival +# jval)
  func @plus (%i : !lz.thunk<!lz.value>, %j: !lz.thunk<!lz.value>) -> !lz.value {
    %icons = lz.force(%i): !lz.value
    %reti = lz.case @SimpleInt %icons
              [@SimpleInt -> { ^entry(%ival: i64):
                %jcons = lz.force(%j):!lz.value
                %retj = lz.case @SimpleInt %jcons
                  [@SimpleInt -> { ^entry(%jval: i64):
                    %sum_v = addi %ival, %jval : i64
                    %boxed = lz.construct(@SimpleInt, %sum_v: i64)
                    lz.return %boxed : !lz.value
                  }]
                  lz.return %retj : !lz.value
              }]
    return %reti : !lz.value
  }

  // minus :: SimpleInt -> SimpleInt -> SimpleInt
  // minus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival -# jval)
  func @minus (%i : !lz.thunk<!lz.value>, %j: !lz.thunk<!lz.value>) -> !lz.value {
    %icons = lz.force(%i):!lz.value
    %reti = lz.case @SimpleInt %icons
              [@SimpleInt -> { ^entry(%ival: i64):
                %jcons = lz.force(%j):!lz.value
                %retj = lz.case @SimpleInt %jcons
                  [@SimpleInt -> { ^entry(%jval: i64):
                    %diff_v = std.subi %ival, %jval : i64
                    %boxed = lz.construct(@SimpleInt, %diff_v: i64)
                    lz.return %boxed  : !lz.value
                  }]
                lz.return %retj :!lz.value
              }]
    return %reti : !lz.value
  }


  func @zero() -> !lz.value {
    %v = std.constant 0 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }

  func @one () -> !lz.value  {
    %v = std.constant 1 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }


  func @two () -> !lz.value  {
    %v = std.constant 2 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }

  func @eight () -> !lz.value  {
    %v = std.constant 8 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }


  // fib :: SimpleInt -> SimpleInt
  // fib i =
  //     case i of
  //        SimpleInt ihash ->
  //            case ihash of
  //               0# -> zero
  //               1# -> one
  //               _ -> plus (fib i) (fib (minus i one))
  func @fib (%i: !lz.thunk<!lz.value>) -> !lz.value  {
    %icons = lz.force(%i):!lz.value
    %ret = lz.case @SimpleInt %icons
             [@SimpleInt -> { ^entry(%ihash: i64):
               %ret = lz.caseint %ihash
                        [0 -> { ^entry:
                          %z = constant @zero : () -> !lz.value
                          %z_t = lz.ap(%z: () -> !lz.value)
                          %z_v = lz.force(%z_t): !lz.value
                          lz.return %z_v: !lz.value
                        }]
                        [1 -> { ^entry:
                          %o = constant @one : () -> !lz.value
                          %o_t = lz.ap(%o: () -> !lz.value)
                          %o_v = lz.force(%o_t): !lz.value
                          lz.return %o_v: !lz.value
                        }]
                        [@default -> { ^entry:
                          %fib = constant @fib : (!lz.thunk<!lz.value>) -> !lz.value
                          %minus = constant @minus : (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value
                          %one = constant @one : () -> !lz.value
                          %one_t = lz.ap(%one: () -> !lz.value)

                          %i_minus_one_t = lz.ap(%minus: (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value, %i, %one_t)

                          %fib_i_minus_one_t = lz.ap(%fib: (!lz.thunk<!lz.value>) -> !lz.value, %i_minus_one_t)
                          %fib_i_minus_one_v = lz.force(%fib_i_minus_one_t) : !lz.value


                          %two = constant @two: () -> !lz.value
                          %two_t = lz.ap(%two: () -> !lz.value)

                          %i_minus_two_t = lz.ap(%minus: (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value, %i, %two_t)

                          %fib_i_minus_two_t = lz.ap(%fib: (!lz.thunk<!lz.value>) -> !lz.value, %i_minus_two_t)
                          %fib_i_minus_two_v = lz.force(%fib_i_minus_two_t) : !lz.value

                          %fib_i_minus_one_v_t = lz.thunkify(%fib_i_minus_one_v: !lz.value)
                          %fib_i_minus_two_v_t = lz.thunkify(%fib_i_minus_two_v: !lz.value)

                          %plus = constant @plus : (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value
                          %sum = lz.ap(%plus: (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value, %fib_i_minus_one_v_t, %fib_i_minus_two_v_t)
                          %sum_v = lz.force(%sum): !lz.value
                          lz.return %sum_v : !lz.value
                        }]
               lz.return %ret : !lz.value
             }]
    return %ret : !lz.value
  }


  // ix:  0 1 2 3 4 5 6
  // val: 0 1 1 2 3 5 8
  func @main() -> !lz.value {
    %number = std.constant 6 : i64
    %boxed_number = lz.construct(@SimpleInt, %number: i64)
    %thunk_number = lz.thunkify(%boxed_number: !lz.value) 

    %fib = constant @fib : (!lz.thunk<!lz.value>) -> !lz.value
    %out_t = lz.ap(%fib : (!lz.thunk<!lz.value>) -> !lz.value, %thunk_number)
    %out_v = lz.force(%out_t): !lz.value
    return %out_v : !lz.value
  }
}


// module Fib where
// import GHC.Prim
// data SimpleInt = SimpleInt Int#
//
// plus :: SimpleInt -> SimpleInt -> SimpleInt
// plus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival +# jval)
//
//
// minus :: SimpleInt -> SimpleInt -> SimpleInt
// minus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival -# jval)
//
//
// one :: SimpleInt; one = SimpleInt 1#
// zero :: SimpleInt; zero = SimpleInt 0#
//
// fib :: SimpleInt -> SimpleInt
// fib i =
//     case i of
//        SimpleInt ihash -> case ihash of
//                              0# -> zero
//                              1# -> one
//        n -> plus (fib n) (fib (minus n one))
//
// ma
// main = let x = fib one in
