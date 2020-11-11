

module {
  "lz.func"() ( {
  ^bb0(%arg0: !lz.thunk<!lz.value>, %arg1: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%0) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "k"} : () -> ()
  "lz.func"() ( {
  ^bb0(%arg0: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.ref"() {sym_name = "loop"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
    %1 = "lz.ap"(%0, %arg0) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %2 = "lz.force"(%1) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%2) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "loop"} : () -> ()
  lz.adt @X [#lz.data_constructor<@MkX []>]
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 42 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @X} : (!lz.value) -> !lz.adt<@X>
    %2 = lz.transmute(%1 :!lz.adt<@X>):!lz.value
    %3 = lz.thunkify(%2 :!lz.value):!lz.thunk<!lz.value>
    %4 = "lz.ref"() {sym_name = "loop"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
    %5 = "lz.ap"(%4, %3) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %6 = "lz.ref"() {sym_name = "k"} : () -> !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
    %7 = "lz.ap"(%6, %3, %5) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %8 = "lz.force"(%7) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%8) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}