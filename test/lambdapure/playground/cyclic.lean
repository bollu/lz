set_option trace.compiler.ir.init true
inductive foo
| root : foo
| left : foo → foo
| right : foo → foo

open foo

inductive rel : foo → foo → Prop
| glue : rel (left (right root)) (right (left root))


def cyclic_thing := glue (left(right root)) (right(left root))


unsafe def main : List String → IO UInt32
| _ => pure 0
