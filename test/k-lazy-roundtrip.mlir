

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
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 42 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @X} : (!lz.value) -> !lz.value
    %2 = lz.thunkify(%1 :!lz.value):!lz.thunk<!lz.value>
    %3 = "lz.ref"() {sym_name = "loop"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
    %4 = "lz.ap"(%3, %2) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %5 = "lz.ref"() {sym_name = "k"} : () -> !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
    %6 = "lz.ap"(%5, %2, %4) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %7 = "lz.force"(%6) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%7) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}