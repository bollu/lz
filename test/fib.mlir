// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// RUN: ../build/bin/hask-opt %s -lower-std -lower-llvm | FileCheck %s || true
// RUN: ../build/bin/hask-opt %s  | ../build/bin/hask-opt -lower-std -lower-llvm |  FileCheck %s || true
// CHECK: 8
// Core2MLIR: GenMLIR BeforeCorePrep
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type

  // plus :: SimpleInt -> SimpleInt -> SimpleInt
  // plus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival +# jval)
  lz.func @plus (%i : !lz.thunk<!lz.value>, %j: !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i): !lz.value
      %reti = lz.case @SimpleInt %icons 
           [@SimpleInt -> { ^entry(%ival: !lz.value):
              %jcons = lz.force(%j):!lz.value
              %retj = lz.case @SimpleInt %jcons 
                  [@SimpleInt -> { ^entry(%jval: !lz.value):
                        %sum_v = lz.primop_add(%ival, %jval)
                        %boxed = lz.construct(@SimpleInt, %sum_v: !lz.value)
                        lz.return(%boxed) : !lz.value
                  }]
              lz.return(%retj): !lz.value
           }]
      lz.return(%reti): !lz.value
  }

  // minus :: SimpleInt -> SimpleInt -> SimpleInt
  // minus i j = case i of SimpleInt ival -> case j of SimpleInt jval -> SimpleInt (ival -# jval)
  lz.func @minus (%i : !lz.thunk<!lz.value>, %j: !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i):!lz.value
      %reti = lz.case @SimpleInt %icons 
           [@SimpleInt -> { ^entry(%ival: !lz.value):
              %jcons = lz.force(%j):!lz.value
              %retj = lz.case @SimpleInt %jcons 
                  [@SimpleInt -> { ^entry(%jval: !lz.value):
                        %diff_v = lz.primop_sub(%ival, %jval)
                        %boxed = lz.construct(@SimpleInt, %diff_v: !lz.value) 
                        lz.return(%boxed) : !lz.value

                  }]
              lz.return(%retj):!lz.value
           }]
      lz.return(%reti): !lz.value
  }


  lz.func @zero() -> !lz.value {
    %v = lz.make_i64(0)
    %boxed = lz.construct(@SimpleInt, %v:!lz.value)
    lz.return(%boxed): !lz.value
  }
  
  lz.func @one () -> !lz.value  {
       %v = lz.make_i64(1)
       %boxed = lz.construct(@SimpleInt, %v:!lz.value)
       lz.return(%boxed): !lz.value 
     }


  lz.func @two () -> !lz.value  {
     %v = lz.make_i64(2)
     %boxed = lz.construct(@SimpleInt, %v:!lz.value) 
     lz.return(%boxed): !lz.value 
  }

  lz.func @eight () -> !lz.value  {
       %v = lz.make_i64(8)
       %boxed = lz.construct(@SimpleInt, %v:!lz.value)
       lz.return(%boxed): !lz.value
  }


  // fib :: SimpleInt -> SimpleInt
  // fib i = 
  //     case i of
  //        SimpleInt ihash -> 
  //            case ihash of 
  //               0# -> zero
  //               1# -> one
  //               _ -> plus (fib i) (fib (minus i one))
  lz.func @fib (%i: !lz.thunk<!lz.value>) -> !lz.value  {
        %icons = lz.force(%i):!lz.value
        %ret = lz.case @SimpleInt %icons
               [@SimpleInt -> { ^entry(%ihash: !lz.value):
                     %ret = lz.caseint %ihash 
                     [0 -> { ^entry:
                                %z = lz.ref(@zero) : !lz.fn<() -> !lz.value>
                                %z_t = lz.ap(%z: !lz.fn<() -> !lz.value>)
                                %z_v = lz.force(%z_t): !lz.value
                                lz.return (%z_v): !lz.value
                     }]
                     [1 -> { ^entry:
                                %o = lz.ref(@one):!lz.fn<() -> !lz.value>
                                %o_t = lz.ap(%o: !lz.fn<() -> !lz.value>)
                                %o_v = lz.force(%o_t): !lz.value
                                lz.return (%o_v): !lz.value
                     }]
                     [@default -> { ^entry:
                                %fib = lz.ref(@fib):  !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
                                %minus = lz.ref(@minus): !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value> 
                                %one = lz.ref(@one): !lz.fn<() -> !lz.value>
                                %one_t = lz.ap(%one: !lz.fn<() -> !lz.value>)

                                %i_minus_one_t = lz.ap(%minus: !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, %i, %one_t)

                                %fib_i_minus_one_t = lz.ap(%fib: !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %i_minus_one_t)
                                %fib_i_minus_one_v = lz.force(%fib_i_minus_one_t) : !lz.value


                                %two = lz.ref(@two): !lz.fn<() -> !lz.value>
                                %two_t = lz.ap(%two: !lz.fn<() -> !lz.value>)

                                %i_minus_two_t = lz.ap(%minus: !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, 
                                   %i, %two_t)

                                %fib_i_minus_two_t = lz.ap(%fib: !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %i_minus_two_t)
                                %fib_i_minus_two_v = lz.force(%fib_i_minus_two_t) : !lz.value

                                %fib_i_minus_one_v_t = lz.thunkify(%fib_i_minus_one_v: !lz.value): !lz.thunk<!lz.value>
                                %fib_i_minus_two_v_t = lz.thunkify(%fib_i_minus_two_v: !lz.value): !lz.thunk<!lz.value>

                                 %plus = lz.ref(@plus) : !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
                                 %sum = 
                                     lz.ap(%plus: !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, 
                                         %fib_i_minus_one_v_t, %fib_i_minus_two_v_t)
                                 %sum_v = lz.force(%sum): !lz.value
                                 lz.return (%sum_v): !lz.value
                     }]
                     lz.return(%ret): !lz.value
               }]
        lz.return (%ret):!lz.value
    }


  // ix:  0 1 2 3 4 5 6
  // val: 0 1 1 2 3 5 8
  lz.func@main () -> !lz.value {
      %number = lz.make_i64(6)
      %boxed_number = lz.construct(@SimpleInt, %number: !lz.value)
      %thunk_number = lz.thunkify(%boxed_number: !lz.value) : !lz.thunk<!lz.value>

      %fib = lz.ref(@fib)  : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
      %out_t = lz.ap(%fib : !lz.fn<(!lz.thunk<!lz.value>) ->  !lz.value>, %thunk_number)
      %out_v = lz.force(%out_t): !lz.value
      lz.return(%out_v) : !lz.value
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
