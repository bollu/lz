module {
  func private @fnt (%i : !lz.thunk<i64>) -> i64
  func private @fnv (%i: !lz.value) -> i64

  func @main(%i: !lz.value) -> i64 {
    // %fnt = constant @fnt : (!lz.thunk<i64>) -> i64
    // %fnv = constant @fnv : (!lz.value) -> i64
    %j = constant 10 : i64
    return %j : i64
  }
}
