import Lean.Parser
-- vim Lean/Parser/Syntax.lean
-- ~/work/lean4hack/stage1/bin/lean syntax.lean
-- src/Leanpkg/Toml.lean
-- Fileworker.lean
structure inst where
  name : String
  arg: String

structure MLIRModule where 
    name: String
    regions: String

declare_syntax_cat newstxcat
declare_syntax_cat newstxcatregion

syntax ident  : newstxcat
syntax "(" newstxcat ")" : newstxcat

syntax "to_term" newstxcat : term

macro_rules
  | `(to_term $a:ident)  => `($a)
  | `(to_term ($a))      => `(to_term $a)

syntax "`[foo|" newstxcat "]" : term

macro_rules
  | `(`[foo| $m]) => `(to_term($m))

-- src/Init/Notation.lean
-- macro_rules | `(tactic| trivial) => `(tactic| assumption)
macro_rules 
  | `(RE ER) => `("region")

macro_rules
  | `(module $rgn) => `(MLIRModule.mk $rgn)

macro_rules
  | `(XXX $m) => `($m)

macro_rules
  -- | `(@inst $name:ident ($as:strLit)) => `(inst.mk  $name.getId.toString $as)
  | `(@inst $name ($as:strLit)) => `(inst.mk  $name $as)

#check `[foo| ((Nat.add))]
#check XXX Nat.add
#check @inst "Nat.add" ("foo")
#check (inst.mk "foo" "bar")

#check (RE   ER)
#check (MLIRModule.mk "mod" (RE ER))

