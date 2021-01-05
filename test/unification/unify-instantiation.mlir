// forall x. Foo(x, x)
func @double(%x: !unf.node) : !unf.node {
  %r = unf.root
  %out = unf.constructor("Foo", %x, %x)
  return %out : !unf.node 
}

// forall x. Foo(x, x) ~ Foo(Foo(Int, Int), Foo(Int, Int))
// x ~ Foo(Int, Int)
func @main() {
   %r = unf.root
   %x = unf.var  %r
   %lhs = unf.constructor("Foo", %x, %x)
   %int = unf.leaf "Int"
   %rhs_int = unf.constructor("Foo", %int, %int)
   %rhs_int2 = unf.constructor("Foo", %int, %int)
   %rhs = unf.constructor("Foo", %rhs_int, %rhs_int2)
   %result = unf.unify(%lhs, %rhs)
   return  %result
}

