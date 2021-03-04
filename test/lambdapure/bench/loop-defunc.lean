--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates | FileCheck %s
--  RUN: lean %s 2>&1 1>/dev/null | lambdapure-translate --import-lambdapure | hask-opt  --lz-lambdapure-destructive-updates --lz-lambdapure-reference-rewriter | FileCheck %s

-- CHECK: func @main

set_option trace.compiler.ir.init true

@[parser]
def set_lit.parser : term_parser :=
  node! set_lit ["{", elems: sep_by ", " term.parser, "}"]

@[transformer]
def set_lit.transformer : transformer :=
λ stx,
let v := view set_lit stx in
pure $ v.elems.foldr (λ x xs, `(set.insert %%x %%xs)) `(∅)


unsafe def main : List String → IO UInt32
| _ => pure 0
