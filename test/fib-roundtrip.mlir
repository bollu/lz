

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
  ^bb0(%arg0: !lz.thunk<!lz.value>, %arg1: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
    %1 = "lz.case"(%0) ( {
    ^bb0(%arg2: !lz.value):  // no predecessors
      %2 = "lz.force"(%arg1) : (!lz.thunk<!lz.value>) -> !lz.value
      %3 = "lz.case"(%2) ( {
      ^bb0(%arg3: !lz.value):  // no predecessors
        %4 = lz.primop_sub(%arg2,%arg3)
        %5 = "lz.construct"(%4) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
        "lz.return"(%5) : (!lz.value) -> ()
      }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
      "lz.return"(%3) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "minus"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 0 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "zero"} : () -> ()
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
    %0 = "lz.make_i64"() {value = 8 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "eight"} : () -> ()
  "lz.func"() ( {
  ^bb0(%arg0: !lz.thunk<!lz.value>):  // no predecessors
    %0 = "lz.force"(%arg0) : (!lz.thunk<!lz.value>) -> !lz.value
    %1 = "lz.case"(%0) ( {
    ^bb0(%arg1: !lz.value):  // no predecessors
      %2 = lz.caseint %arg1 [0 : i64 ->  {
        %3 = "lz.ref"() {sym_name = "zero"} : () -> !lz.fn<() -> !lz.value>
        %4 = "lz.ap"(%3) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
        %5 = "lz.force"(%4) : (!lz.thunk<!lz.value>) -> !lz.value
        "lz.return"(%5) : (!lz.value) -> ()
      }]
 [1 : i64 ->  {
        %3 = "lz.ref"() {sym_name = "one"} : () -> !lz.fn<() -> !lz.value>
        %4 = "lz.ap"(%3) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
        %5 = "lz.force"(%4) : (!lz.thunk<!lz.value>) -> !lz.value
        "lz.return"(%5) : (!lz.value) -> ()
      }]
 [@default ->  {
        %3 = "lz.ref"() {sym_name = "fib"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
        %4 = "lz.ref"() {sym_name = "minus"} : () -> !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
        %5 = "lz.ref"() {sym_name = "one"} : () -> !lz.fn<() -> !lz.value>
        %6 = "lz.ap"(%5) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
        %7 = "lz.ap"(%4, %arg0, %6) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %8 = "lz.ap"(%3, %7) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %9 = "lz.force"(%8) : (!lz.thunk<!lz.value>) -> !lz.value
        %10 = "lz.ref"() {sym_name = "two"} : () -> !lz.fn<() -> !lz.value>
        %11 = "lz.ap"(%10) : (!lz.fn<() -> !lz.value>) -> !lz.thunk<!lz.value>
        %12 = "lz.ap"(%4, %arg0, %11) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %13 = "lz.ap"(%3, %12) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %14 = "lz.force"(%13) : (!lz.thunk<!lz.value>) -> !lz.value
        %15 = lz.thunkify(%9 :!lz.value):!lz.thunk<!lz.value>
        %16 = lz.thunkify(%14 :!lz.value):!lz.thunk<!lz.value>
        %17 = "lz.ref"() {sym_name = "plus"} : () -> !lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>
        %18 = "lz.ap"(%17, %15, %16) : (!lz.fn<(!lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
        %19 = "lz.force"(%18) : (!lz.thunk<!lz.value>) -> !lz.value
        "lz.return"(%19) : (!lz.value) -> ()
      }]

      "lz.return"(%2) : (!lz.value) -> ()
    }) {alt0 = @SimpleInt, constructorName = @SimpleInt} : (!lz.value) -> !lz.value
    "lz.return"(%1) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "fib"} : () -> ()
  "lz.func"() ( {
    %0 = "lz.make_i64"() {value = 6 : i64} : () -> !lz.value
    %1 = "lz.construct"(%0) {dataconstructor = @SimpleInt} : (!lz.value) -> !lz.value
    %2 = lz.thunkify(%1 :!lz.value):!lz.thunk<!lz.value>
    %3 = "lz.ref"() {sym_name = "fib"} : () -> !lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>
    %4 = "lz.ap"(%3, %2) : (!lz.fn<(!lz.thunk<!lz.value>) -> !lz.value>, !lz.thunk<!lz.value>) -> !lz.thunk<!lz.value>
    %5 = "lz.force"(%4) : (!lz.thunk<!lz.value>) -> !lz.value
    "lz.return"(%5) : (!lz.value) -> ()
  }) {retty = !lz.value, sym_name = "main"} : () -> ()
}