set_option trace.compiler.ir.init true
unsafe def main : List String → IO UInt32
| _ => do
  IO.println(0);
  pure 0
