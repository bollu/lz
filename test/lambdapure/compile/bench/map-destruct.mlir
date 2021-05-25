module  {
  func @map(%arg0: !λ.obj, %arg1: !λ.obj) -> !λ.obj {
    %0 = "λ.TagGetOp"(%arg1) : (!λ.obj) -> i8
    "λ.CaseOp"(%0) ( {
      %1 = "λ.construct"() {tag = 0 : i64} : () -> !λ.obj
      "λ.return"(%1) : (!λ.obj) -> ()
    },  {
      "λ.reset"(%arg1) ( {
        %1 = "λ.π"(%arg1) {index = 0 : i64} : (!λ.obj) -> !λ.obj
        %2 = "λ.π"(%arg1) {index = 1 : i64} : (!λ.obj) -> !λ.obj
        %3 = "λ.app"(%arg0, %1) : (!λ.obj, !λ.obj) -> !λ.obj
        %4 = "λ.call"(%arg0, %2) {callee = @map} : (!λ.obj, !λ.obj) -> !λ.obj
        %5 = "λ.reuseConstruct"(%arg1, %3, %4) {tag = 1 : i64} : (!λ.obj, !λ.obj, !λ.obj) -> !λ.obj
        "λ.return"(%5) : (!λ.obj) -> ()
      },  {
        %1 = "λ.π"(%arg1) {index = 0 : i64} : (!λ.obj) -> !λ.obj
        %2 = "λ.π"(%arg1) {index = 1 : i64} : (!λ.obj) -> !λ.obj
        %3 = "λ.app"(%arg0, %1) : (!λ.obj, !λ.obj) -> !λ.obj
        %4 = "λ.call"(%arg0, %2) {callee = @map} : (!λ.obj, !λ.obj) -> !λ.obj
        %5 = "λ.construct"(%3, %4) {tag = 1 : i64} : (!λ.obj, !λ.obj) -> !λ.obj
        "λ.return"(%5) : (!λ.obj) -> ()
      }) : (!λ.obj) -> ()
    }) : (i8) -> ()
  }
}

module  {
  func @map(%arg0: !λ.obj, %arg1: !λ.obj) -> !λ.obj {
    %0 = "λ.tag"(%arg1) : (!λ.obj) -> i8
    "λ.case"(%0) ( {
      %1 = "λ.construct"() {tag = 0 : i64} : () -> !λ.obj
      "λ.return"(%1) : (!λ.obj) -> ()
    },  {
      "λ.reset"(%arg1) ( {
        %1 = "λ.π"(0, %arg1) 
        %2 = "λ.π"(1, %arg1) 
        %3 = "λ.app"(%arg0, %1) : (!λ.obj, !λ.obj) -> !λ.obj
        %4 = "λ.call"(@map, %arg0, %2)  : (!λ.obj, !λ.obj) -> !λ.obj
        %5 = "λ.reuseConstruct"[1](%arg1, %3, %4) 
        "λ.return"(%5) : (!λ.obj) -> ()
      },  {
        %1 = "λ.π"(0, %arg1) 
        %2 = "λ.π"(1, %arg1) 
        %3 = "λ.app"(%arg0, %1) : (!λ.obj, !λ.obj) -> !λ.obj
        %4 = "λ.call"@map(%arg0, %2) 
        %5 = "λ.construct"[1](%3, %4) 
        "λ.return"(%5) : (!λ.obj) -> ()
      }) : (!λ.obj) -> ()
    }) : (i8) -> ()
  }
}
