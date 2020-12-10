// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// CHECK: 42
module {
  // k x y = x
  func @k (%x: !lz.thunk<!lz.value>, %y: !lz.thunk<!lz.value>) -> !lz.value {
    %x_v = lz.force(%x):!lz.value
    return %x_v : !lz.value
  }

  // loop a = loop a
  func @loop (%a: !lz.thunk<!lz.value>) -> !lz.value {
    %loop = constant @loop  : (!lz.thunk<!lz.value>) ->  !lz.value
    %out_t = lz.ap(%loop : (!lz.thunk<!lz.value>) -> !lz.value, %a)
    %out_v = lz.force(%out_t) : !lz.value
    return %out_v : !lz.value
  }

  // k (x:(X 42)) (y:(loop (X 42))) = x
  // main =
  //     let y = loop x -- builds a closure.
  //     in (k x y)
  func @main () -> !lz.value {
    %lit_42 = constant 42 : i64
    // TODO: I need a think to transmute to different types.
    // Because we may want to "downcast" a ADT to a raw value
    %xv = lz.construct(@X, %lit_42 : i64)
    %x_t = lz.thunkify(%xv : !lz.value) :!lz.thunk<!lz.value>

    %loop = constant @loop : (!lz.thunk<!lz.value>) -> !lz.value
    %y = lz.ap(%loop : (!lz.thunk<!lz.value>) -> !lz.value, %x_t)


    %k = constant @k : (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value
    %out_t = lz.ap(%k: (!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value, %x_t, %y)
    %out = lz.force(%out_t) : !lz.value
    return %out : !lz.value
  }
}
