
structure inst where
  name : String


declare_syntax_cat mycat

syntax ident  : mycat
syntax "(" mycat ")" : mycat

syntax "to_term"  mycat : term

macro_rules
  | `(to_term $a:ident)  => `($a)
  | `(to_term ($a))      => `(to_term $a)

syntax "`[foo|" mycat "]" : term

macro_rules
  | `(`[foo| $m]) => `(to_term($m))

#check `[foo| ((Nat.add))]

