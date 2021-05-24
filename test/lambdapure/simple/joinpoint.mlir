func @foo() -> !lz.value {
    %0 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
    "lz.joinpoint"() ( {
      ^bb0(%arg: !lz.value):  // no predecessors
      "lz.caseRet"(%arg) ( {
              %2 = "lz.construct"() {dataconstructor = @"42", size = 0 : i64} : () -> !lz.value
              lz.return %2 : !lz.value
          },  {
              %2 = "lz.construct"() {dataconstructor = @"43", size = 0 : i64} : () -> !lz.value
              lz.return %2 : !lz.value
          }) : (!lz.value) -> ()
      }, {
      "lz.caseRet"(%0) ( {
           %2 = "lz.construct"() {dataconstructor = @"0", size = 0 : i64} : () -> !lz.value
           "lz.jump"(%2) {value = 12 : i64} : (!lz.value) -> ()
         },  {
           %2 = "lz.construct"() {dataconstructor = @"1", size = 0 : i64} : () -> !lz.value
           "lz.jump"(%2) {value = 12 : i64} : (!lz.value) -> ()
         }) : (!lz.value) -> ()
      }) : () -> ()
}
