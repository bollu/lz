module  {
  func @map(%arg0: !λ.obj, %arg1: !λ.obj) -> !λ.obj {
    %0 = "λ.TagGetOp"(%arg1) : (!λ.obj) -> i8
    "λ.CaseOp"(%0) ( {
      %1 = "λ.construct"() {tag = 0 : i64} : () -> !λ.obj
      "λ.inc"(%1) : (!λ.obj) -> ()
      "λ.dec"(%arg0) : (!λ.obj) -> ()
      "λ.dec"(%arg1) : (!λ.obj) -> ()
      "λ.return"(%1) : (!λ.obj) -> ()
    },  {
      "λ.ResetOp"(%arg1) ( {
        ...
        %5 = "λ.ReuseConstructorOp"[1](%arg1, %3, %4) {tag = 1 : i64} : (!λ.obj, !λ.obj, !λ.obj) -> !λ.obj
        "λ.return"(%5) : (!λ.obj) -> ()
      },  {
        %1 = "λ.π"(%arg1) {index = 0 : i64} : (!λ.obj) -> !λ.obj
        %2 = "λ.π"(%arg1) {index = 1 : i64} : (!λ.obj) -> !λ.obj
        "λ.inc"(%1) : (!λ.obj) -> ()
        %3 = "λ.app"(%arg0, %1) : (!λ.obj, !λ.obj) -> !λ.obj
        "λ.inc"(%arg0) : (!λ.obj) -> ()
        "λ.inc"(%2) : (!λ.obj) -> ()
        %4 = "λ.call"@map(%arg0, %2) (!λ.obj, !λ.obj) -> !λ.obj
        "λ.inc"(%3) : (!λ.obj) -> ()
        "λ.inc"(%4) : (!λ.obj) -> ()
        %5 = "λ.construct"[1](%3, %4) 
        "λ.inc"(%5) : (!λ.obj) -> ()
        "λ.dec"(%arg1) : (!λ.obj) -> ()
        "λ.return"(%5) : (!λ.obj) -> ()
      }) : (!λ.obj) -> ()
    }) : (i8) -> ()
  }
}
