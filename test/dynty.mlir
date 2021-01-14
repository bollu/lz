// RUN: hask-opt --lz-interpret %s  | FileCheck %s
// Check that @plus works with SimpleInt works.
// CHECK: constructor(SimpleInt 3)
module {
  func private @main() -> !hask.dyn<"i64">
  func private @main2() -> !hask.dyn<"(i64, i64)">
  func private @main3(!hask.dyn<"i64">, !hask.dyn<"!f64">) -> !hask.dyn<"(parse whatever you want to?)">
}


