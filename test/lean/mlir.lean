import Lean.Parser

-- set_option trace.Elab.command true

structure Inst where
    name: String

structure Binding where
    lhs: String
    rhs: String

structure MLIRModule where 
    name: String
    regions: List Binding

declare_syntax_cat mlircat

syntax "@module" term "{" term "}" : term

-- | TODO: figure out how to get curly brackets to work.
macro_rules
| `(module $name [ $inst ]) => `(MLIRModule.mk $name [$inst])


syntax "BINDING" term "EQUAL" term : term

macro_rules
| `(BINDING $a EQUAL $b) => `(Binding.mk)
-- 
-- -- #check module "foo" [ "bar" ]
-- #check BINDING "0" "foo"

