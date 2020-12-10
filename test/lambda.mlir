// RUN: hask-opt %s  --lz-interpret | FileCheck %s
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 2)
module {
  // should it be Attr Attr, with the "list" embedded as an attribute,
  // or should it be Attr [Attr]? Who really knows :(
  // define the algebraic data type
  // TODO: setup constructors properly.

  // k :: SimpleInt -> (SimpleInt -> SimpleInt); (k x) y = x

  func @k(%i: !lz.thunk<!lz.value>) -> ((!lz.thunk<!lz.value>) -> !lz.value) {
    %lam = lz.lambda [%i: !lz.thunk<!lz.value>] (%j: !lz.thunk<!lz.value>) -> !lz.value {
      %iv = lz.force(%i): !lz.value
      lz.return %iv : !lz.value
    }
    return %lam : (!lz.thunk<!lz.value>) -> !lz.value
  }

  func @one() -> !lz.value {
    %v = std.constant 1: i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }

  func @two() -> !lz.value {
    %v = std.constant 2: i64
    %boxed = lz.construct(@SimpleInt, %v: i64)
    return %boxed : !lz.value
  }

  // 1 + 2 = 3
  func @main() -> !lz.value {
    %onef = constant @one : () -> !lz.value
    %onet = lz.ap(%onef: () -> !lz.value)

    %twof = constant @two : () -> !lz.value
    %twot = lz.ap(%twof : () -> !lz.value)

    %kf = constant @k : (!lz.thunk<!lz.value>) -> ((!lz.thunk<!lz.value>) -> !lz.value)
    %k2t = lz.ap(%kf: (!lz.thunk<!lz.value>) -> ((!lz.thunk<!lz.value>) -> !lz.value), %twot)
    %k2v = lz.force(%k2t): (!lz.thunk<!lz.value>) -> !lz.value

    %k21t = lz.ap(%k2v: (!lz.thunk<!lz.value>) -> !lz.value, %onet)

    %outv = lz.force(%k21t): !lz.value
    return %outv : !lz.value
  }
}
