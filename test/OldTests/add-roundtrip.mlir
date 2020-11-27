

module {
  "lz.func"() ( {
  ^bb0(%arg0: !lz.thunk<!lz.value>, %arg1: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
    %1 = "lz.case"(%0) ( {
    ^bb0(%arg2: !lz.value):  // no predecessors
      %2 = "lz.force"(%arg1) : (!lz.thunk<!lz.value>) -> !lz.value
      %3 = "lz.case"(%2) ( {
      ^bb0(%arg3: !lz.value):  // no predecessors
        %4 = lz.primop_add(%arg2,%arg3)
        %5 = "lz.construct"(%4) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
        "lz.return"(%5) : (!lz.value) -> ()
      }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
      "lz.return"(%3) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "plus"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 1 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "one"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 2 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "two"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.ref"() {sym_name = "one"} : () -> !lz.fn<() -> !lz.value>
    %1 = "lz.ap"(%0) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
    %2 = "lz.ref"() {sym_name = "two"} : () -> !lz.fn<() -> !lz.value>
    %3 = "lz.ap"(%2) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
    %4 = "lz.ref"() {sym_name = "plus"} : () -> !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
    %5 = "lz.ap"(%4, %1, %3) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %6 = "lz.force"(%5) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%6) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}