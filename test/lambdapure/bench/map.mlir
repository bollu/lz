module  {
  func @map(%arg0: !lambdapure.Object, %arg1: !lambdapure.Object) -> !lambdapure.Object {
    %0 = "lambdapure.TagGetOp"(%arg1) : (!lambdapure.Object) -> i8
    "lambdapure.CaseOp"(%0) ( {
      %1 = "lambdapure.ConstructorOp"() {tag = 0 : i64} : () -> !lambdapure.Object
      "lambdapure.ReturnOp"(%1) : (!lambdapure.Object) -> ()
    },  {
      %1 = "lambdapure.ProjectionOp"(%arg1) {index = 0 : i64} : (!lambdapure.Object) -> !lambdapure.Object
      %2 = "lambdapure.ProjectionOp"(%arg1) {index = 1 : i64} : (!lambdapure.Object) -> !lambdapure.Object
      %3 = "lambdapure.AppOp"(%arg0, %1) : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
      %4 = "lambdapure.CallOp"(%arg0, %2) {callee = @map} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
      %5 = "lambdapure.ConstructorOp"(%3, %4) {tag = 1 : i64} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
      "lambdapure.ReturnOp"(%5) : (!lambdapure.Object) -> ()
    }) : (i8) -> ()
  }
}
