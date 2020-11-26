// RUN: ../build/bin/hask-opt -interpret %s  | FileCheck %s
// dont-RUN: ../build/bin/hask-opt %s -lower-std -lower-llvm | FileCheck %s || true
// dont-RUN: ../build/bin/hask-opt %s  | ../build/bin/hask-opt -lower-std -lower-llvm |  FileCheck %s || true
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 3)
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // plus :: SimpleInt -> SimpleInt -> SimpleInt
  // plus i j = case i of MkSimpleInt ival -> case j of MkSimpleInt jval -> MkSimpleInt (ival +# jval)
  lz.func @plus (%i : !lz.thunk<!lz.value>, %j: !lz.thunk<!lz.value>) -> !lz.value {
      %icons = lz.force(%i): !lz.value
      %reti = lz.case @SimpleInt %icons 
           [@SimpleInt -> { ^entry(%ival: !lz.value):
              %jcons = lz.force(%j):!lz.value
              %retj = lz.case @SimpleInt %jcons 
                  [@SimpleInt -> { ^entry(%jval: !lz.value):
                        %sum_v = lz.primop_add(%ival, %jval)
                        %boxed = lz.construct(@SimpleInt, %sum_v:!lz.value)
                        lz.return(%boxed) : !lz.value
                  }]
              lz.return(%retj):!lz.value
           }]
      lz.return(%reti): !lz.value
    }

  
  
  lz.func @one () -> !lz.value {
       %v = lz.make_i64(1)
       %boxed = lz.construct(@SimpleInt, %v:!lz.value)
       lz.return(%boxed): !lz.value
     }


  lz.func @two () -> !lz.value {
       %v = lz.make_i64(2)
       %boxed = lz.construct(@SimpleInt, %v:!lz.value)
       lz.return(%boxed): !lz.value
     }


  // 1 + 2 = 3
  lz.func@main () -> !lz.value {
      %input = lz.ref(@one) : !lz.fn<() -> !lz.value>
      %input_t = lz.ap(%input: !lz.fn<() -> !lz.value>)

      %input2 = lz.ref(@two) :!lz.fn<() -> !lz.value>
      %input2_t = lz.ap(%input2 : !lz.fn<() -> !lz.value>)

      %plus = lz.ref(@plus)  : !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) ->  !lz.value>
      %out_t = lz.ap(%plus : !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, 
        %input_t, %input2_t)
      %out_v = lz.force(%out_t): !lz.value
      lz.return(%out_v) : !lz.value
    }
}


