

module {
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 43 : i64} : () -> !lz.value
    %1 = lz.caseint %0 [0 : i64 ->  {
    ^bb0(%arg0: !lz.value):  // no predecessors
      "lz.return"(%arg0) : (!lz.value) -> ()
    }]
 [@default ->  {
      %3 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
      %4 = lz.primop_sub(%0,%3)
      "lz.return"(%4) : (!lz.value) -> ()
    }]

    %2 = "lz.construct"(%1) {dataconstructor = @X} : (!lz.value) -> !lz.value
    "lz.return"(%2) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}