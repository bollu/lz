import Lean.Parser
import Lean.Parser.Extra

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


-- | Bug with MLIR type system: does not have a notion of unit v/s void.
inductive MLIRType
| MLIRTypeInt : Int -> MLIRType
| MLIRTypeFn : MLIRType -> MLIRType -> MLIRType
| MLIRTypeUnit : MLIRType 
open MLIRType


structure Op where
    name : String
    args: List SSAVal
    attributes: List Attribute
    ty : MLIRType



structure Binding where
    lhs: SSAVal
    Op: Op

structure BasicBlock where
  name: String
  args: List SSAVal
  ops : List Binding



structure MLIRModule where 
    name: String
    regions: List Binding


declare_syntax_cat mlircat

syntax "@module" term "{" term "}" : term

-- | TODO: figure out how to get curly brackets to work.
macro_rules
| `(module $name [ $inst ]) => `(MLIRModule.mk $name [$inst])

-- | I can't use the syntax '=' for whatever reason in the binding.
prefix:300 "%" => SSAVal.mk
-- syntax:300 "%" term : term
-- macro_rules | `(% $a) => `(SSAVal.mk $a)


syntax:30 (name := bindingkv) term "=:=" term : term
macro_rules (kind := bindingkv) | `($a =:= $b) => `(Binding.mk $a $b)

-- infix:50 "=:="  => Binding.mk

syntax (name := attrkv) term "=" term : term
macro_rules (kind := attrkv) | `($a = $b) => `(Attribute.mk $a $b)

syntax term "(" sepBy(term, ", ") ")" ("{" sepBy(term, ",") "}")? ":" term : term


macro_rules
-- -- | `($a ( $args,* ) {} : $b) => `(Op.mk $a [ $args,*] [] $b)
| `($a ( $args,* ) { $attrs,* } : $b) => `(Op.mk $a [ $args,*] [ $attrs,* ] $b)
| `($a ( $args,* ) : $b) => `(Op.mk $a [ $args,*] [] $b)

syntax "[[[" sepBy(term, ", ") "]]]" : term
macro_rules
  | `([[[ $elems,* ]]]) => `([ $elems,* ])


syntax  "call" term "(" sepBy(term, ", ") ")" ":" term : term


syntax "i"num : term
macro_rules 
| `(i $x) => `(MLIRTypeInt $x)

-- 
-- -- #check module "foo" [ "bar" ]
-- | TODO: figure out how to get 'i64' working.
#check %"x" =:= "foo"(%"y", %"z") {"key" = "value", "key2" = "value2"} : i 64

-- #check "foo"(%"1", %"2", %"3") {} : i 64
-- -- #check (("key" = "value") :: Attribute)
-- #check (%"x") = "foo"(%"y", %"z") {"key" = "value", "key2" = "value2"} : i 64


-- -- # TODO: find a way to separate elements by newlines.
-- syntax "^" term ("(" sepBy(term, ",") ")")? ":" sepBy(term, ";"): term
-- macro_rules
-- | `(^ $bbname : $ops  ) => `(BasicBlock.mk $bbname [] [ $ops ] )

-- -- #check   ^"entry":  ((%"x") =  "foo"() : i 64); ((%"y") =  "bar"() : i 64)
-- #check   ^"entry":  ((%"x") =  "foo"() : i 64)
