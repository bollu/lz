@[parser]
def set_lit.parser : term_parser :=
  node! set_lit ["{", elems: sep_by ", " term.parser, "}"]

@[transformer]
def set_lit.transformer : transformer :=
λ stx,
let v := view set_lit stx in
pure $ v.elems.foldr (λ x xs, `(set.insert %%x %%xs)) `(∅)
