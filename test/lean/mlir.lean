import Lean.Parser

-- set_option trace.Elab.command true

structure SSAVal where
  name: String

structure Inst where
    name: String

structure Op where
    name : String
    args: List SSAVal
    ty : String

structure Binding where
    lhs: SSAVal
    Op: Op

structure MLIRModule where 
    name: String
    regions: List Binding

declare_syntax_cat mlircat

syntax "@module" term "{" term "}" : term

-- | TODO: figure out how to get curly brackets to work.
macro_rules
| `(module $name [ $inst ]) => `(MLIRModule.mk $name [$inst])

-- | I can't use the syntax '=' for whatever reason in the binding.
syntax "%" term : term
macro_rules
| `(% $a) => `(SSAVal.mk $a)

syntax term ":=" term : term
macro_rules
| `($a := $b) => `(Binding.mk $a $b)

syntax term "(" sepBy(term, ", ") ")" ":" term : term
macro_rules
| `($a ( $args,* ): $b) => `(Op.mk $a [ $args,*] $b)

syntax "[[[" sepBy(term, ", ") "]]]" : term
macro_rules
  | `([[[ $elems,* ]]]) => `([ $elems,* ])


-- 
-- -- #check module "foo" [ "bar" ]
#check "foo"("1", "2", "3"): "i64"
#check %"x"
#check (%"x") := "foo"(%"y", %"z") : "i64"

