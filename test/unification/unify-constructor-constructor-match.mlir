// Test lowering of ap & force.
// RUN: hask-opt %s --lz-unifier
// Foo(a, B) ~ Foo(A, b)
func @main() -> !unif.node {
  %r = unif.root
  %B = unif.constructor("B")
  %a = unif.var("a", %r)
  %b = unif.var("b", %r)
  %A = unif.constructor("A")

  %lhs = unif.constructor("Foo", %a, %B)
  %rhs = unif.constructor("Foo", %B, %a)

  %result = unif.unify(%lhs, %rhs)
  return %result : !unif.node
}


