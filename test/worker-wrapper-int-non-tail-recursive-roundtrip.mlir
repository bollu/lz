

module {
  "lz.func"() ( {
  ^bb0(%arg0: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
    %1 = "lz.case"(%0) ( {
    ^bb0(%arg1: !lz.value):  // no predecessors
      %2 = lz.caseint %arg1 [0 : i64 ->  {
        %3 = "lz.make_i64"() {value = 5 : i64} : () -> !lz.value
        %4 = "lz.construct"(%3) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
        "lz.return"(%4) : (!lz.value) -> ()
      }]
 [@default ->  {
        %3 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
        %4 = lz.primop_sub(%arg1,%3)
        %5 = "lz.construct"(%4) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
        %6 = lz.thunkify(%5 :!lz.value):!lz.thunk<!lz.value>
        %7 = "lz.ref"() {sym_name = "f"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
        %8 = "lz.ap"(%7, %6) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %9 = "lz.force"(%8) : (!lz.thunk<!lz.value>) -> !lz.value
        %10 = "lz.case"(%9) ( {
        ^bb0(%arg2: !lz.value):  // no predecessors
          %11 = lz.primop_add(%arg2,%3)
          %12 = "lz.construct"(%11) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
          "lz.return"(%12) : (!lz.value) -> ()
        }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
        "lz.return"(%10) : (!lz.value) -> ()
      }]

      "lz.return"(%2) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "f"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 37 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    %2 = lz.thunkify(%1 :!lz.value):!lz.thunk<!lz.value>
    %3 = "lz.ref"() {sym_name = "f"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
    %4 = "lz.ap"(%3, %2) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %5 = "lz.force"(%4) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%5) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}