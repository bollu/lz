// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 3)
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // k :: SimpleInt -> (SimpleInt -> SimpleInt); (k x) y = x
  // explicitly return a lambda that captures the first variable
  // lz.func @k(%i: !lz.thunk<!lz.value>) -> !lz.value { // -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value> {
  lz.func @k(%i: !lz.thunk<!lz.value>) -> !lz.fn<( !lz.thunk<!lz.value> ) -> !lz.value > {
        lz.lambda(%i: !lz.thunk<!lz.value> ) {
            ^entry(%j: !lz.thunk<!lz.value>):
                  %iv = lz.force(%i): !lz.value
                  lz.return(%iv): !lz.value 
        }
        // lz.return(%i): !lz.thunk<!lz.value>
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
      
      %k = lz.ref(@k): !lz.fn<( !lz.thunk<!lz.value> ) ->  !lz.fn<( !lz.thunk<!lz.value> ) -> !lz.thunk<!lz.value> >>
      // %k = lz.ref(@k): !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value >
      // %callf = lz.ap(%k)
      %out_v = lz.force(%input2_t): !lz.value
      // lz.return(%out_v) : !lz.value
      lz.return(%out_v) : !lz.value
    }
}


