// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 3)
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.
  hask.adt @SimpleInt [#hask.data_constructor<@MkSimpleInt [@"Int#"]>]

  // k :: SimpleInt -> (SimpleInt -> SimpleInt); (k x) y = x
  // explicitly return a lambda that captures the first variable
  // hask.func @k(%i: !hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt> { // -> !hask.fn<(!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt>> {
  hask.func @k(%i: !hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.fn<( !hask.thunk<!hask.adt<@SimpleInt>> ) -> !hask.adt<@SimpleInt> > {
        hask.lambda(%i: !hask.thunk<!hask.adt<@SimpleInt>> ) {
            ^entry(%j: !hask.thunk<!hask.adt<@SimpleInt>>):
                  %iv = hask.force(%i): !hask.adt<@SimpleInt>
                  hask.return(%iv): !hask.adt<@SimpleInt> 
        }
        // hask.return(%i): !hask.thunk<!hask.adt<@SimpleInt>>
  }

  hask.func @one () -> !hask.adt<@SimpleInt> {
       %v = hask.make_i64(1)
       %boxed = hask.construct(@SimpleInt, %v:!hask.value): !hask.adt<@SimpleInt>
       hask.return(%boxed): !hask.adt<@SimpleInt>
     }


  hask.func @two () -> !hask.adt<@SimpleInt> {
       %v = hask.make_i64(2)
       %boxed = hask.construct(@SimpleInt, %v:!hask.value): !hask.adt<@SimpleInt>
       hask.return(%boxed): !hask.adt<@SimpleInt>
     }


  // 1 + 2 = 3
  hask.func@main () -> !hask.adt<@SimpleInt> {
      %input = hask.ref(@one) : !hask.fn<() -> !hask.adt<@SimpleInt>>
      %input_t = hask.ap(%input: !hask.fn<() -> !hask.adt<@SimpleInt>>)

      %input2 = hask.ref(@two) :!hask.fn<() -> !hask.adt<@SimpleInt>>
      %input2_t = hask.ap(%input2 : !hask.fn<() -> !hask.adt<@SimpleInt>>)
      
      %k = hask.ref(@k): !hask.fn<( !hask.thunk<!hask.adt<@SimpleInt>> ) ->  !hask.fn<( !hask.thunk<!hask.adt<@SimpleInt>> ) -> !hask.thunk<!hask.adt<@SimpleInt>> >>
      // %k = hask.ref(@k): !hask.fn<(!hask.thunk<!hask.adt<@SimpleInt>>) -> !hask.adt<@SimpleInt> >
      // %callf = hask.ap(%k)
      %out_v = hask.force(%input2_t): !hask.adt<@SimpleInt>
      // hask.return(%out_v) : !hask.adt<@SimpleInt>
      hask.return(%out_v) : !hask.adt<@SimpleInt>
    }
}


