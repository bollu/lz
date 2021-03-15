set_option trace.compiler.ir.init true
def main (xs: List String) : IO UInt32 := let l := 7; let m := 42; IO.println (toString l) *> pure (m - l)
