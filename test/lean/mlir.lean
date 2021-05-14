import Lean.Parser
open Lean

-- Take a look at choiceMacroRules.lean, CommandExtOverlap.lean, tacticExtOverlap.lean 
-- for the macro_rules [kind] syntax.

-- set_option trace.Elab.command true

structure SSAVal where
  name: String

structure Inst where
    name: String

structure Attribute where
    key: String
    value: String

structure Op where
    name : String
    args: List SSAVal
    attributes: List Attribute
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

syntax (name := bindingkv) term ":=" term : term
macro_rules (kind := bindingkv)
| `($a := $b) => `(Binding.mk $a $b)


declare_syntax_cat attributestx
syntax (name := attributekv) "[@" term "XX" term "@]": attributestx
macro_rules (kind := attributekv)
| `(attributestx| [@ $a XX $b @]) => `(Attribute.mk $a $b)


syntax term ":-" term : term
macro_rules
| `($a :- $b) => `(Attribute.mk $a $b)

syntax term "(" sepBy(term, ", ") ")" ("{" sepBy(term, ",") "}")? ":" term : term


macro_rules
-- -- | `($a ( $args,* ) {} : $b) => `(Op.mk $a [ $args,*] [] $b)
| `($a ( $args,* ) { $attrs,* } : $b) => `(Op.mk $a [ $args,*] [ $attrs,* ] $b)
| `($a ( $args,* ) : $b) => `(Op.mk $a [ $args,*] [] $b)

syntax "[[[" sepBy(term, ", ") "]]]" : term
macro_rules
  | `([[[ $elems,* ]]]) => `([ $elems,* ])


syntax  "call" term "(" sepBy(term, ", ") ")" ":" term : term


-- 
-- -- #check module "foo" [ "bar" ]
#check "foo"(%"1", %"2", %"3") {}: "i64"
#check "foo"(%"1", %"2", %"3") { [@ "key" XX "value" @] }: "i64"
#check %"x"
#check (%"x") := "foo"(%"y", %"z") {"key" :- "value"}: "i64"
-- #check (%"x") := "foo"(%"y", %"z") {"key" :- "value"}: "i64"
-- #check (%"x") := "foo"(%"y", %"z") : "i64"

