module  {
  func @filter_dot__main(%arg0: !lambdapure.Object) -> !lambdapure.Object {
    %0 = "lambdapure.TagGetOp"(%arg0) : (!lambdapure.Object) -> i8
    "lambdapure.CaseOp"(%0) ( {
      "lambdapure.ReturnOp"(%arg0) : (!lambdapure.Object) -> ()
    },  {
      %1 = "lambdapure.ProjectionOp"(%arg0) {index = 0 : i64} : (!lambdapure.Object) -> !lambdapure.Object
      %2 = "lambdapure.ProjectionOp"(%arg0) {index = 1 : i64} : (!lambdapure.Object) -> !lambdapure.Object
      %3 = "lambdapure.IntegerConst"() {value = 5 : i64} : () -> !lambdapure.Object
      %4 = "lambdapure.CallOp"(%3, %1) {callee = @Nat_dot_decLt} : (!lambdapure.Object, !lambdapure.Object) -> i8
      "lambdapure.CaseOp"(%4) ( {
        %5 = "lambdapure.CallOp"(%2) {callee = @filter_dot__main} : (!lambdapure.Object) -> !lambdapure.Object
        %6 = "lambdapure.ConstructorOp"(%1, %5) {tag = 1 : i64} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%6) : (!lambdapure.Object) -> ()
      },  {
        %5 = "lambdapure.CallOp"(%2) {callee = @filter_dot__main} : (!lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%5) : (!lambdapure.Object) -> ()
      }) : (i8) -> ()
    }) : (i8) -> ()
  }
  func @filter(%arg0: !lambdapure.Object) -> !lambdapure.Object {
    %0 = "lambdapure.CallOp"(%arg0) {callee = @filter_dot__main} : (!lambdapure.Object) -> !lambdapure.Object
    "lambdapure.ReturnOp"(%0) : (!lambdapure.Object) -> ()
  }
}
