module  {
  func @map(%arg0: !λ.obj, %arg1: !λ.obj) -> !λ.obj {
    %0 = "λ.tag"(%arg1) : (!λ.obj) -> i8
    "λ.CaseOp"(%0) ( {
      ...
      %1 = "λ.allocCtor"() {size = 0 : i64, tag = 0 : i64} : () -> !λ.obj
      ...
      "λ.return"(%1) : (!λ.obj) -> ()
    },  {
      "λ.ResetOp"(%arg1) ( {
        %5 = "λ.reuseAllocCtor"[1](%arg1, size=2) (!λ.obj) -> !λ.obj
        "λ.ctorSet"[0](%5, %3) 
        "λ.ctorSet"[0](%5, %4) 
        "λ.return"(%5) : (!λ.obj) -> ()
      },  {
        ...
        %5 = "λ.allocCtor"[1](size=2) () -> !λ.obj
        "λ.ctorSet"[0](%5, %3)  : (!λ.obj, !λ.obj) -> ()
        "λ.ctorSet"[1](%5, %4)  : (!λ.obj, !λ.obj) -> ()
       ...
      }) 
    }) 
  }
}
