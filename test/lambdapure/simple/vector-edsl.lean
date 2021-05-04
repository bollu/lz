set_option compiler.extract_closed false

inductive Vec : Type
| VecNum (l: Nat) (i: Nat): Vec
| VecAdd (v: Vec) (w: Vec) : Vec
| VecSum (v: Vec): Vec
open Vec

-- | consume all values so the optimiser doesn't remove everything.
def runvec : Vec -> IO Unit
| VecNum _ _ => IO.print "vecnum"
| VecAdd x y => runvec x *> runvec y
| VecSum v => runvec v

def vecnum (l: Nat) (i: Nat): Vec := (VecNum l i)
def vecadd (v: Vec) (w: Vec): Vec := (VecAdd v w)
def vecsum (v: Vec) : Vec := (VecSum v)

def main (xs: List String) : IO Unit := do
  runvec (vecsum (vecadd (vecnum 10 41) (vecnum 10 1)))

