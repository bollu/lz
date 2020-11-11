

module {
  "lz.func"() ( {
  ^bb0(%arg0: !lz.value):  // no predecessors
    %0 = lz.caseint %arg0 [0 : i64 ->  {
    ^bb0(%arg1: !lz.value):  // no predecessors
      "lz.return"(%arg1) : (!lz.value) -> ()
    }]
 [@default ->  {
      %1 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
      %2 = lz.primop_sub(%arg0,%1)
      "lz.return"(%2) : (!lz.value) -> ()
    }]

    "lz.return"(%0) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "prec"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 42 : i64} : () -> !lz.value
    %1 = "lz.ref"() {sym_name = "prec"} : () -> !lz.fn<(!lz.value) -> !lz.value>
    %2 = "lz.ap"(%1, %0) : (!lz.fn<(!lz.value) -> !lz.value>, !lz.value) -> !lz.thunk<!lz.value>
    %3 = "lz.force"(%2) : (!lz.thunk<!lz.value>) -> !lz.value
    %4 = "lz.construct"(%3) {dataconstructor = @X} : (!lz.value) -> !lz.value
    "lz.return"(%4) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}