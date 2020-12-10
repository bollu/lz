// RUN: hask-opt --lz-interpret %s  | FileCheck %s
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 3)
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // plus :: SimpleInt -> SimpleInt -> SimpleInt
  // plus i j = case i of MkSimpleInt ival -> case j of MkSimpleInt jval -> MkSimpleInt (ival +# jval)
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
                lz.return %retj:!lz.value
              }]
    return %reti: !lz.value
  }

  func @one () -> !lz.value {
    %v = constant 1 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed: !lz.value
  }


  func @two () -> !lz.value {
    %v = constant 2 : i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed: !lz.value
  }


  // 1 + 2 = 3
  func @main () -> !lz.value {
    %input = constant @one : () -> !lz.value
    %input_t = lz.ap(%input: () -> !lz.value)

    %input2 = constant @two : () -> !lz.value
    %input2_t = lz.ap(%input2 : () -> !lz.value)

    %plus = constant @plus  : (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) ->  !lz.value
    %out_t = lz.ap(%plus : (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value, %input_t, %input2_t)
    %out_v = lz.force(%out_t): !lz.value
    return %out_v : !lz.value
  }
}


