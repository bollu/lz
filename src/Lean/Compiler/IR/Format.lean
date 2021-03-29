/-
Copyright (c) 2019 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
import Lean.Compiler.IR.Basic
import Lean.Compiler.ExportAttr
import Lean.Data.Name
namespace Lean
namespace IR

def escape  {a : Type} [ToFormat a] : a -> Format
  | a => "\"" ++ format a ++ "\""

private def formatVar {a: Type} [ToFormat a] : a -> Format
  | a => "%" ++ format a
private def formatSymbol {a : Type} [ToFormat a] : a -> Format 
  | a => "@" ++ escape a


private def formatArg : Arg → Format
  | Arg.var id     => formatVar id
  -- | how to get my hands on an irrelevant value?
  | Arg.irrelevant => "%irrelevant"

instance : ToFormat Arg := ⟨formatArg⟩

inductive arrpos 
 | first: arrpos
 | rest: arrpos
 deriving Inhabited, DecidableEq, Repr


def formatArray {α : Type} [ToFormat α] : Array α -> Format
  | #[] => ""
  | args => (args.foldl (fun (ix, r) a => 
         (arrpos.rest, r ++ (if ix == arrpos.first then "" else ", ") ++ format a)) (arrpos.first, Format.nil)).snd

-- | format an array that should "hang", so it should start with a comma
def formatArrayHanging {α : Type} [ToFormat α] : Array α -> Format
  | #[] => ""
  | args => args.foldl (fun r a => (r ++ ", " ++ format a)) Format.nil

private def formatLitVal : LitVal → Format
  | LitVal.num v => format v
  | LitVal.str v => format (repr v)

instance : ToFormat LitVal := ⟨formatLitVal⟩


private def formatCtorInfo : CtorInfo → Format
  | { name := name, cidx := cidx, usize := usize, ssize := ssize, .. } => do
    let mut r := f!"{cidx}"; -- what is the monad?
    r

instance : ToFormat CtorInfo := ⟨formatCtorInfo⟩

def formatMLIRType : Nat -> Nat -> Format
| nin, nout => "(" ++ formatArray (mkArray nin "!lz.value") ++ ")" ++ 
               format "->" ++ 
               "(" ++ formatArray (mkArray nout "!lz.value") ++ ")"


-- func private @panic(!lz.value, !lz.value, !lz.value) -> !lz.value
def mlirPreamble1 : Format := 
  "func private" ++ "@" ++ (escape "panic") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.repr") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "String.push") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "IO.print._at.IO.println._spec_1") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Int.decLt") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Int.natAbs") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.decEq") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.decLt") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.add") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.mul") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.max") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Nat.sub") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "String.toNat!") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "UInt32.ofNat") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "UInt32.decLt") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "UInt32.add") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "UInt32.div") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.empty._closed_1") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.mkArray") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.set!") ++ formatMLIRType 4 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.get") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Float.ofScientific") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Float.ofNat") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.size") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "UInt32.toNat") ++ formatMLIRType 1 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "instInhabitedUInt32") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.get!") ++ formatMLIRType 4 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.push") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Array.swap!") ++ formatMLIRType 4 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "String.instInhabitedString") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "List.head!._rarg._closed_3") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Lean.Syntax.isOfKind") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Lean.Syntax.getArg") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "String.append") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "IO.println._at.Lean.instEval._spec_1") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "instInhabitedNat") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "USize.ofNat") ++ formatMLIRType 1 1 ++ Format.line

def mlirPreambleJunk : Format := 
  -- from render.lean. Where do these come from?
  "func private" ++ "@" ++ (escape "Lean.instInhabitedParserDescr._closed_1") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "_private.Init.Data.Format.Basic.0.Std.Format.be._closed_") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "_private.Init.Data.Format.Basic.0.Std.Format.be._closed_1") ++ formatMLIRType 0 1 ++ Format.line
  -- from const_fold.lean. Where do these come from?
  -- TODO: write a pass that collects this stuff and emits it before every function.
  -- Notice that every such function takes 0 inputs and produces an output. Unclear what this means.
  -- It's like a constant function.
  ++ "func private" ++ "@" ++ (escape "Lean.Parser.Syntax.addPrec._closed_11") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "term_*_._closed_3") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "prec(_)._closed_7") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "prec(_)._closed_3") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "term_^_._closed_3") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Int.instInhabitedInt._closed_1") ++ formatMLIRType 0 1 ++ Format.line
  -- From bench/qsort.lean
  ++ "func private" ++ "@" ++ (escape "Lean.MonadRef.mkInfoFromRefPos._at.myMacro._@.Init.Notation._hyg.109._spec_1") ++ formatMLIRType 2 1 ++ Format.line
  -- ++ "func private" ++ "@" ++ (escape "term↑__1._closed_3") ++ formatMLIRType 0 1 ++ Format.line
  -- ++ "func private" ++ "@" ++ (escape "term↑__1._closed_2") ++ formatMLIRType 0 1 ++ Format.line
  -- ++ "func private" ++ "@" ++ (escape "term↑__1._closed_1") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Lean.addMacroScope") ++ formatMLIRType 3 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Lean.nullKind._closed_2") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "myMacro._@.Init.Notation._hyg.2191._closed_4") ++ formatMLIRType 0 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "Lean.Name.mkStr") ++ formatMLIRType 2 1 ++ Format.line
  ++ "func private" ++ "@" ++ (escape "String.utf8ByteSize") ++ formatMLIRType 1 1 ++ Format.line

-- | definitions for render.
-- func private@"Float.add"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.div"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Nat.decLe"(!lz.value, !lz.value)->(!lz.value)
-- func private@"IO.Prim.Handle.putStr"(!lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"IO.Prim.fopenFlags"(!lz.value, !lz.value)->(!lz.value)
-- func private@"IO.Prim.Handle.mk"(!lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"USize.decLt"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Array.uget"(!lz.value, !lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"IO.wait"(!lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"USize.add"(!lz.value, !lz.value)->(!lz.value)
-- func private@"IO.Error.toString"(!lz.value)->(!lz.value)
-- func private@"Task.Priority.default"()->(!lz.value)
-- func private@"IO.asTask"(!lz.value, !lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"Float.neg"(!lz.value)->(!lz.value)
-- func private@"Float.sub"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.mul"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.decLt"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.decLe"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.sqrt"(!lz.value)->(!lz.value)
-- func private@"Float.pow"(!lz.value, !lz.value)->(!lz.value)
-- func private@"Float.tan"(!lz.value)->(!lz.value)
-- func private@"Float.toUInt8"(!lz.value)->(!lz.value)
-- func private@"UInt8.toNat"(!lz.value)->(!lz.value)
-- func private@"Array.findSomeM?._rarg._closed_1"()->(!lz.value)
-- func private@"IO.stdGenRef"()->(!lz.value)
-- func private@"ST.Prim.Ref.get"(!lz.value, !lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"ST.Prim.Ref.set"(!lz.value, !lz.value, !lz.value, !lz.value, !lz.value)->(!lz.value)
-- func private@"stdNext"(!lz.value)->!lz.value
-- func private@"stdRange"()->!lz.value
def mlirPreamble : Format := mlirPreamble1 ++ mlirPreambleJunk

-- f : a -> b -> c -> o
-- g a =  fun b c => f a b c 
-- (Lambda lifting)
--  /- Full application. -/ | full_ap(f, a, b, c) 
--  | fap (c : FunId) (ys : Array Arg) -> std.call
--  /- Partial application that creates a `pap` value (aka closure in our nonstandard terminology). -/
--  | pap (c : FunId) (ys : Array Arg) -- closure = pap(f, a)
--  /- Application. `x` must be a `pap` value. -/
--  | ap  (x : VarId) (ys : Array Arg) -- d = ap(closure, b, c)

private def formatExpr : Expr → Format
  -- v this is a hack, I should instead just give the constructor index.
  | Expr.ctor i ys      => (escape "lz.construct") ++  "(" ++  formatArray ys ++ ")"  ++
                           " {dataconstructor=" ++ "@" ++ escape (format i) ++ "}" ++
                           ":" ++ formatMLIRType (ys.size) 1
  | Expr.reset n x      => "// ERR: reset[" ++ format n ++ "] " ++ format x
  | Expr.reuse x i u ys => "// ERR: reuse" ++ (if u then "!" else "") ++ " " ++ format x ++ " in " ++ format i ++ formatArray ys
  | Expr.proj i x       => (escape "lz.project") ++ "(" ++ "%" ++ format x ++ ")" ++ "{value=" ++ format i ++ "}" ++ ":" ++ formatMLIRType 1 1
  | Expr.uproj i x      => "// ERR: uproj[" ++ format i ++ "] " ++ format x
  | Expr.sproj ix o x    => (escape "lz.sproj") ++ "(" ++ (formatVar x) ++ ")"
                           ++ "{ix=" ++ (format ix) ++ ", offset=" ++ (format o) ++"}" ++ ":" ++ formatMLIRType 1 1
                           -- | Hypothesis is wrong. Eg: |@IO.println._at.Lean.instEval._spec_1| is an internal name
  | Expr.fap c ys       => if False -- Hypothesis: internal names are unsued at runtime(Name.isInternal c)
                           then (escape "lz.erasedvalue") ++ "()" ++ "{value=" ++ "@" ++ (escape c) ++ "}" ++   ":" ++ formatMLIRType 0 1 
                           else (escape "lz.call") ++ "(" ++ formatArray ys ++ ")" 
                                  ++ "{value=" ++  "@" ++ (escape (format c)) ++ "}"
                                  ++ ":" ++ formatMLIRType (ys.size) 1
  | Expr.pap c ys       => (escape "lz.pap") ++ "(" ++  formatArray ys ++ ")" ++
                           "{value=" ++ "@" ++ escape (format c) ++ "}" ++
                           ":" ++ (formatMLIRType ys.size) 1
  | Expr.ap x ys        =>  (escape "lz.papExtend") ++ "(" ++  formatVar x ++ formatArrayHanging (Array.map formatArg ys) ++ ")"
                           ++ ":" ++ formatMLIRType (1 + ys.size) 1
  | Expr.box _ x        => "// ERR: box " ++ format x
  | Expr.unbox x        => "// ERR: unbox " ++ format x
  -- | Expr.lit v          => (escape "lz.int") ++ "(){value=" ++ format v  ++ "}" ++ ": () -> !lz.value"
  | Expr.lit (LitVal.num n) => (escape "lz.int") ++ "(){value=" ++ format n  ++ "}" ++ ": () -> !lz.value"
  | Expr.lit (LitVal.str s) => (escape "ptr.string") ++ "(){value=" ++ (escape (format s))  ++ "}" ++ ": () -> !lz.value"
  | Expr.isShared x     => "// ERR: isShared " ++ format x
  | Expr.isTaggedPtr x  => "// ERR: isTaggedPtr " ++ format x

instance : ToFormat Expr := ⟨formatExpr⟩
instance : ToString Expr := ⟨fun e => Format.pretty (format e)⟩

private partial def formatIRType : IRType → Format
  | IRType.float        => "!lz.value"
  | IRType.uint8        => "!lz.value"
  | IRType.uint16       => "!lz.value"
  | IRType.uint32       => "!lz.value"
  | IRType.uint64       => "!lz.value"
  | IRType.usize        => "!lz.value"
  | IRType.irrelevant   => "!lz.value"
  | IRType.object       => "!lz.value"
  | IRType.tobject      => "!lz.value"
  | IRType.struct _ tys => "!lz.value" -- "struct " ++ Format.bracket "{" (@Format.joinSep _ ⟨formatIRType⟩ tys.toList ", ") "}"
  | IRType.union _ tys  => "!lz.value"  -- "union " ++ Format.bracket "{" (@Format.joinSep _ ⟨formatIRType⟩ tys.toList ", ") "}"


instance : ToFormat IRType := ⟨formatIRType⟩
instance : ToString IRType := ⟨toString ∘ format⟩


private def formatParamWithType : Param → Format
  | { x := name, borrow := b, ty := ty } => formatVar name ++ " : " ++ (if b then "@& " else "") ++ format ty

private def formatParamWithoutType : Param -> Format
  | { x := name, borrow := b, ty := ty } => formatVar name 

instance : ToFormat Param := ⟨formatParamWithType⟩

-- def formatAlt (fmt : FnBody → Format) (indent : Nat) : Alt → Format
--   | Alt.ctor i b  =>  format i.name --format i.name ++ " →" ++ Format.nest indent (Format.line ++ fmt b)
--   | Alt.default b => format "@default" -- "default →" ++ Format.nest indent (Format.line ++ fmt b)

-- format "{" ++ Format.line ++  Format.nest indent (formatAltRHS loop indent c) ++ Format.line ++  "}"
def formatAltRHS (fmtBody : FnBody → Format) (indent : Nat) : Alt → Format
  | Alt.ctor i b  =>  "{" ++ Format.line ++ 
                      Format.nest indent (Format.line ++ fmtBody b) ++ Format.line ++
                      "}"
  | Alt.default b => "{" ++ Format.line ++ 
                      Format.nest indent (Format.line ++ fmtBody b) ++
                      "}"

def formatAltLHS (nalts: Nat) (indent : Nat) : Alt → Format
| Alt.ctor i b  =>  "alt" ++ (format i.cidx) ++ "=" ++ "@" ++ (escape (format i.cidx)) --format i.name ++ " →" ++ Format.nest indent (Format.line ++ fmt b)
| Alt.default b => "alt" ++ (format (1 + nalts)) ++ "=" ++  "@default" -- "default →" ++ Format.nest indent (Format.line ++ fmt b)

def formatParams (ps : Array Param) : Format :=
  formatArray ps

-- | UNUSED BY US
@[export lean_ir_format_fn_body_head]
def formatFnBodyHead : FnBody → Format
  | FnBody.vdecl x ty e b      => "%\"" ++  format x ++ "\"" ++ " = " ++ format e
  | FnBody.jdecl j xs v b      => "// ERR: " ++ format j ++ formatParams xs ++ " := ..."
  | FnBody.set x i y b         => "// ERR: " ++ "set " ++ format x ++ "[" ++ format i ++ "] := " ++ format y
  | FnBody.uset x i y b        => "// ERR: " ++ "uset " ++ format x ++ "[" ++ format i ++ "] := " ++ format y
  /- Store `y : ty` at Position `sizeof(void*)*i + offset` in `x`. `x` must be a Constructor object and `RC(x)` must be 1.
     `ty` must not be `object`, `tobject`, `irrelevant` nor `Usize`. -/
  | FnBody.sset x i o y ty b   => (escape "lz.sset")  ++ "(" ++ (formatVar x) ++ "," ++ (formatVar y) ++ ")" ++ 
                                   "{" ++ "ix=" ++ (format i) ++ ", offset=" ++ (format o) ++ "}" ++ ":" ++ formatMLIRType 2 0
   
  | FnBody.setTag x cidx b     => "// ERR: " ++ "setTag " ++ format x ++ " := " ++ format cidx
  | FnBody.inc x n c _ b       => "// ERR: " ++ "inc" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x
  | FnBody.dec x n c _ b       => "// ERR: " ++ "dec" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x
  | FnBody.del x b             => "// ERR: " ++ "del " ++ format x
  | FnBody.mdata d b           => "// ERR: " ++ "mdata " ++ format d
  | FnBody.case tid x xType cs => "case " ++ format x ++ " of ..."
  | FnBody.jmp j ys            => "jmp " ++ format j ++ formatArray ys
  | FnBody.ret x               => "ret " ++ format x
  | FnBody.unreachable         => "// ERR: " ++  "⊥" ++ Format.nil

-- case format:
-- %1 = "lz.case"(%0) ( {
-- ^bb0(%arg1: i64):  // no predecessors
--   %2 = "lz.caseint"(%arg1) ( {
--     %c42_i64 = constant 42 : i64
--     %3 = "lz.construct"(%c42_i64) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
--     lz.return %3 : !lz.value
--   },  {
--     %c1_i64 = constant 1 : i64
--     %3 = subi %arg1, %c1_i64 : i64
--     %4 = "lz.construct"(%3) {dataconstructor = @SimpleInt} : (i64) -> !lz.value
--     %5 = lz.thunkify(%4 :!lz.value)
--     %f = constant @f : (!lz.thunk<!lz.value>) -> !lz.value
--     %6 = "lz.ap"(%f, %5) : ((!lz.thunk<!lz.value>) -> !lz.value, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
--     %7 = "lz.force"(%6) : (!lz.thunk<!lz.value>) -> !lz.value
--     lz.return %7 : !lz.value
--   }) {alt0 = 0 : i64, alt1 = @default} : (i64) -> !lz.value
--   lz.return %2 : !lz.value
-- }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value


-- This is what is used by us
partial def formatFnBody (fnBody : FnBody) (indent : Nat := 2) : Format :=
  let rec loop : FnBody → Format
    -- v it is fine to call format on variables because vars are literally IDs. They are formatted as `x_id`.
    | FnBody.vdecl x ty e b      => "%" ++  (format x) ++ " = " ++ format e  ++ Format.line ++ loop b
    -- v join point | I'm not sure what the "xs" are. I don't seen to need it?
    | FnBody.jdecl j xs v b      =>  -- (escape "lz.block") ++ "("  ++ formatArray (Array.map formatParamWithoutType xs) ++  ")"
                                    escape ("lz.block") ++ "()" 
      				    ++ "(" -- TODO: add arguments xs ++ Format.line 
    				    ++ "{" 
                                    ++ Format.nest indent (Format.line
                                           ++ "^entry" ++ "(" ++ formatArray (Array.map formatParamWithType xs) ++ ")" ++ ":" ++ Format.line
                                           ++ loop v)  
                                    ++ Format.line ++  "}, {" ++ Format.nest indent (Format.line ++ loop b) ++ Format.line
				    -- ++  "})" ++ ":" ++ (formatMLIRType xs.size 1)
				    ++  "})" ++ ":" ++ (formatMLIRType 0 0)
    | FnBody.set x i y b         => "//ERR: set " --  ++ "set " ++ format x ++ "[" ++ format i ++ "] := " ++ format y ++ ";" ++ Format.line ++ loop b
    | FnBody.uset x i y b        => "//ERR: uset" -- ++ "uset " ++ format x ++ "[" ++ format i ++ "] := " ++ format y ++ ";" ++ Format.line ++ loop b
    | FnBody.sset x i o y ty b   => (escape "lz.sset")  ++ "(" ++ (formatVar x) ++ "," ++ (formatVar y) ++ ")" ++ 
                                    "{" ++ "ix=" ++ (format i) ++ ", offset=" ++ (format o) ++ "}" ++ ":" ++ formatMLIRType 2 0
    | FnBody.setTag x cidx b     => "//ERR: setTag" --  ++ "setTag " ++ format x ++ " := " ++ format cidx ++ ";" ++ Format.line ++ loop b
    | FnBody.inc x n c _ b       => "//ERR: inc"
                                 --  ++ "inc" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.dec x n c _ b       => "//ERR: dec"
                                  --  ++ "dec" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.del x b             => "//ERR: del" --  ++ "del " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.mdata d b           => "//ERR: mdata" --  ++ "mdata " ++ format d ++ ";" ++ Format.line ++ loop b
    --  "//ERR:" ++ "case " ++ format x ++ " : " ++ format xType ++ " of" ++ cs.foldl (fun r c => r ++ Format.line ++ formatAlt loop indent c) Format.nil
    -- | TODO: consider generating this differently?
    | FnBody.case tid x xType cs => (escape "lz.caseRet") ++ "(%" ++ format x ++ ")" ++
                                    "("  ++ formatArray (Array.map (formatAltRHS loop indent) cs) ++ ")" 
                                    ++ "{" ++ formatArray (Array.map (formatAltLHS (cs.size) indent) cs)  ++ "}" 
                                    ++ ":" ++ formatMLIRType 1 0
                                   
 
    | FnBody.jmp j ys            => (escape "lz.jump") ++ "("  ++ formatArray ys ++ ")"
                                    ++ "{value=" ++ format j.idx ++ "}"
                                    ++ ":" ++ (formatMLIRType ys.size 0)
    | FnBody.ret x               => (escape "lz.return") ++ "(" ++  format x ++ ")" ++ ": (!lz.value) -> ()"
    | FnBody.unreachable         => (escape "lz.bottom") ++ "()" ++ ":" ++  formatMLIRType 0 0
  loop fnBody

instance : ToFormat FnBody := ⟨formatFnBody⟩
instance : ToString FnBody := ⟨fun b => (format b).pretty⟩

def declareIrrelevant : Format := "%irrelevant = " ++ escape ("lz.erasedvalue") ++ "() : () -> !lz.value"

def formatDecl (decl : Decl) (indent : Nat := 2) : Format :=
  match decl with
  | Decl.fdecl f xs ty b _  =>
        if False  then "// IrrelevantDecl: " ++ format f
        else  
  	"func " ++ 
	formatSymbol f ++ 
	"(" ++ formatArray (Array.map formatParamWithType xs) ++ ")"
	++ "-> " ++ format ty
	++ " { " ++ Format.nest indent (Format.line ++ declareIrrelevant ++ Format.line ++ formatFnBody b indent) ++ Format.line ++  "}"
  | Decl.extern f xs ty _   => "// extern " ++ format f ++ formatArray (Array.map formatParamWithType  xs) ++ format " : " ++ format ty

instance : ToFormat Decl := ⟨formatDecl⟩

@[export lean_ir_decl_to_string]
def declToString (d : Decl) : String :=
  (format d).pretty

instance : ToString Decl := ⟨declToString⟩

end Lean.IR
