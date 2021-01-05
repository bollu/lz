// Foo(a, B) ~ Foo(A, b)
func @main() {
  %r = unf.root
  %B = unf.leaf "B"
  %a = unf.var "a" %unk
  %b = unf.var "b" %unk
  %A = unf.leaf "A"

  %lhs = unf.constructor("Foo", %a, %B)
  %rhs = unf.constructor("Foo", %B, %a)

  %result = unf.unify(%lhs, %rhs)
  return %result
}


