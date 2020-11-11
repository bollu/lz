// RUN: ../build/bin/hask-opt %s  -interpret | FileCheck %s
// RUN: ../build/bin/hask-opt %s -lower-std -lower-llvm | FileCheck %s || true
// RUN: ../build/bin/hask-opt %s  | ../build/bin/hask-opt -lower-std -lower-llvm |  FileCheck %s || true
// CHECK: 42
module {
  // k x y = x
  lz.func @k (%x: !lz.thunk<!lz.value>, %y: !lz.thunk<!lz.value>) -> !lz.value {
      %x_v = lz.force(%x):!lz.value
      lz.return(%x_v) : !lz.value
    }

  // loop a = loop a
  lz.func @loop (%a: !lz.thunk<!lz.value>) -> !lz.value {
      %loop = lz.ref(@loop) : !lz.fn<(!lz.thunk<!lz.value>) ->  !lz.value>
      %out_t = lz.ap(%loop : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %a)
      %out_v = lz.force(%out_t) : !lz.value
      lz.return(%out_v) : !lz.value
    }

  // k (x:(X 42)) (y:(loop (X 42))) = x
  // main = 
  //     let y = loop x -- builds a closure.
  //     in (k x y)
  lz.func @main ()  -> !lz.value {
      %lit_42 = lz.make_i64(42)
      // TODO: I need a think to transmute to different types.
      // Because we may want to "downcast" a ADT to a raw value
      %xv = lz.construct(@X, %lit_42 : !lz.value)
      %x_t = lz.thunkify(%xv : !lz.value) :!lz.thunk<!lz.value>

      %loop = lz.ref(@loop) :  !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
      %y = lz.ap(%loop : !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, %x_t)


      %k = lz.ref(@k) : !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
      %out_t = lz.ap(%k: !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, 
        %x_t, %y)
      %out = lz.force(%out_t) : !lz.value
      lz.return(%out) : !lz.value
    }
}
