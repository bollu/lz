/-
Copyright (c) 2019 Microsoft Corporation. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Leonardo de Moura
-/
import Lean.Compiler.IR.Basic
import Lean.Compiler.ExportAttr

namespace Lean
namespace IR



private def escape  {a : Type} [ToFormat a] : a -> Format
  | a => "\"" ++ format a ++ "\""

private def formatVar {a: Type} [ToFormat a] : a -> Format
  | a => "%" ++ format a
private def formatSymbol {a : Type} [ToFormat a] : a -> Format 
  | a => "@" ++ escape a


private def formatArg : Arg → Format
  | Arg.var id     => formatVar id
  | Arg.irrelevant => "irrelevant"

instance : ToFormat Arg := ⟨formatArg⟩

inductive arrpos 
 | first: arrpos
 | rest: arrpos
 deriving Inhabited, DecidableEq, Repr


def formatArray {α : Type} [ToFormat α] : Array α -> Format
  | #[] => ""
  | args => (args.foldl (fun (ix, r) a => (arrpos.rest, r ++ (if ix == arrpos.first then "" else ", ") ++ format a)) (arrpos.first, Format.nil)).snd

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
    let mut r := f!"ctor_{cidx}"
    if usize > 0 || ssize > 0 then
      r := f!"{r}.{usize}.{ssize}"
    if name != Name.anonymous then
      r := f!"{r}[{name}]"
    r

instance : ToFormat CtorInfo := ⟨formatCtorInfo⟩

private def formatExpr : Expr → Format
  | Expr.ctor i ys      => "ctor(" ++ format i ++ formatArrayHanging ys ++ ")"
  | Expr.reset n x      => "// ERR: reset[" ++ format n ++ "] " ++ format x
  | Expr.reuse x i u ys => "// ERR: reuse" ++ (if u then "!" else "") ++ " " ++ format x ++ " in " ++ format i ++ formatArray ys
  | Expr.proj i x       => (escape "lz.projection") ++ "(" ++ format x ++ ")" ++ "{ value = " ++ format i ++ "}"
  | Expr.uproj i x      => "// ERR: uproj[" ++ format i ++ "] " ++ format x
  | Expr.sproj n o x    => "// ERR: sproj[" ++ format n ++ ", " ++ format o ++ "] " ++ format x
  | Expr.fap c ys       => "// ERR: fap " ++ format c ++ formatArrayHanging ys
  | Expr.pap c ys       => "lz.pap(" ++ format c ++ formatArrayHanging ys ++ ")"
  | Expr.ap x ys        => let ys2 := (Array.map formatArg ys); (escape "lz.apEager") ++ "(" ++  formatVar x ++ formatArrayHanging ys2 ++ ")"
  | Expr.box _ x        => "// ERR: box " ++ format x
  | Expr.unbox x        => "// ERR: unbox " ++ format x
  | Expr.lit v          => (escape "lz.int") ++ "(" ++ format v  ++ ")" ++ ": () -> !lz.value"
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


private def formatParam : Param → Format
  | { x := name, borrow := b, ty := ty } => formatVar name ++ " : " ++ (if b then "@& " else "") ++ format ty

instance : ToFormat Param := ⟨formatParam⟩

def formatAlt (fmt : FnBody → Format) (indent : Nat) : Alt → Format
  | Alt.ctor i b  => format i.name ++ " →" ++ Format.nest indent (Format.line ++ fmt b)
  | Alt.default b => "default →" ++ Format.nest indent (Format.line ++ fmt b)

def formatParams (ps : Array Param) : Format :=
  formatArray ps

-- | UNUSED BY US
@[export lean_ir_format_fn_body_head]
def formatFnBodyHead : FnBody → Format
  | FnBody.vdecl x ty e b      => "%\"" ++  format x ++ "\"" ++ " = " ++ format e
  | FnBody.jdecl j xs v b      => "// ERR: " ++ format j ++ formatParams xs ++ " := ..."
  | FnBody.set x i y b         => "// ERR: " ++ "set " ++ format x ++ "[" ++ format i ++ "] := " ++ format y
  | FnBody.uset x i y b        => "// ERR: " ++ "uset " ++ format x ++ "[" ++ format i ++ "] := " ++ format y
  | FnBody.sset x i o y ty b   => "// ERR: " ++ "sset " ++ format x ++ "[" ++ format i ++ ", " ++ format o ++ "] : " ++ format ty ++ " := " ++ format y
  | FnBody.setTag x cidx b     => "// ERR: " ++ "setTag " ++ format x ++ " := " ++ format cidx
  | FnBody.inc x n c _ b       => "// ERR: " ++ "inc" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x
  | FnBody.dec x n c _ b       => "// ERR: " ++ "dec" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x
  | FnBody.del x b             => "// ERR: " ++ "del " ++ format x
  | FnBody.mdata d b           => "// ERR: " ++ "mdata " ++ format d
  | FnBody.case tid x xType cs => "case " ++ format x ++ " of ..."
  | FnBody.jmp j ys            => "jmp " ++ format j ++ formatArray ys
  | FnBody.ret x               => "ret " ++ format x
  | FnBody.unreachable         => "// ERR: " ++  "⊥" ++ Format.nil


-- This is what is used by us
partial def formatFnBody (fnBody : FnBody) (indent : Nat := 2) : Format :=
  let rec loop : FnBody → Format
    -- | it is fine to call format on variables because vars are literally IDs. They are formatted as `x_id`.
    | FnBody.vdecl x ty e b      => "%" ++  (format x) ++ " = " ++ format e  ++ Format.line ++ loop b
    | FnBody.jdecl j xs v b      => "//ERR:" ++ format j ++ formatParams xs ++ " :=" ++ Format.nest indent (Format.line ++ loop v) ++ ";" ++ Format.line ++ loop b
    | FnBody.set x i y b         => "//ERR:" ++ "set " ++ format x ++ "[" ++ format i ++ "] := " ++ format y ++ ";" ++ Format.line ++ loop b
    | FnBody.uset x i y b        => "//ERR:" ++ "uset " ++ format x ++ "[" ++ format i ++ "] := " ++ format y ++ ";" ++ Format.line ++ loop b
    | FnBody.sset x i o y ty b   => "//ERR:" ++ "sset " ++ format x ++ "[" ++ format i ++ ", " ++ format o ++ "] : " ++ format ty ++ " := " ++ format y ++ ";" ++ Format.line ++ loop b
    | FnBody.setTag x cidx b     => "//ERR:" ++ "setTag " ++ format x ++ " := " ++ format cidx ++ ";" ++ Format.line ++ loop b
    | FnBody.inc x n c _ b       => "//ERR:" ++ "inc" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.dec x n c _ b       => "//ERR:" ++ "dec" ++ (if n != 1 then Format.sbracket (format n) else "") ++ " " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.del x b             => "//ERR:" ++ "del " ++ format x ++ ";" ++ Format.line ++ loop b
    | FnBody.mdata d b           => "//ERR:" ++ "mdata " ++ format d ++ ";" ++ Format.line ++ loop b
    | FnBody.case tid x xType cs => "//ERR:" ++ "case " ++ format x ++ " : " ++ format xType ++ " of" ++ cs.foldl (fun r c => r ++ Format.line ++ formatAlt loop indent c) Format.nil
    | FnBody.jmp j ys            => "//ERR:" ++ "jmp " ++ format j ++ formatArray ys
    | FnBody.ret x               => (escape "lz.return") ++ "(" ++  format x ++ ")" ++ ": (!lz.value) -> ()"
    | FnBody.unreachable         => "bottom"
  loop fnBody

instance : ToFormat FnBody := ⟨formatFnBody⟩
instance : ToString FnBody := ⟨fun b => (format b).pretty⟩

def formatDecl (decl : Decl) (indent : Nat := 2) : Format :=
  match decl with
  | Decl.fdecl f xs ty b _  => 
  	"func " ++ formatSymbol f ++ "(" ++ formatParams xs ++ ") -> " ++ format ty ++ " { " ++ Format.nest indent (Format.line ++ formatFnBody b indent) ++ Format.line ++  "}"
  | Decl.extern f xs ty _   => "// extern " ++ format f ++ formatParams xs ++ format " : " ++ format ty

instance : ToFormat Decl := ⟨formatDecl⟩

@[export lean_ir_decl_to_string]
def declToString (d : Decl) : String :=
  (format d).pretty

instance : ToString Decl := ⟨declToString⟩

end Lean.IR
