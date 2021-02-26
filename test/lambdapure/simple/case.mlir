module  {
  func @case_dot_match_1_dot__rarg(%arg0: !lambdapure.Object, %arg1: !lambdapure.Object, %arg2: !lambdapure.Object, %arg3: !lambdapure.Object) -> !lambdapure.Object {
    %0 = "lambdapure.IntegerConst"() {value = 0 : i64} : () -> !lambdapure.Object
    %1 = "lambdapure.CallOp"(%arg0, %0) {callee = @Nat_dot_decEq} : (!lambdapure.Object, !lambdapure.Object) -> i8
    "lambdapure.CaseOp"(%1) ( {
      %2 = "lambdapure.IntegerConst"() {value = 1 : i64} : () -> !lambdapure.Object
      %3 = "lambdapure.CallOp"(%arg0, %2) {callee = @Nat_dot_decEq} : (!lambdapure.Object, !lambdapure.Object) -> i8
      "lambdapure.CaseOp"(%3) ( {
        %4 = "lambdapure.AppOp"(%arg3, %arg0) : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%4) : (!lambdapure.Object) -> ()
      },  {
        %4 = "lambdapure.ConstructorOp"() {tag = 0 : i64} : () -> !lambdapure.Object
        %5 = "lambdapure.AppOp"(%arg2, %4) : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%5) : (!lambdapure.Object) -> ()
      },  {
        %4 = "lambdapure.ConstructorOp"() {tag = 0 : i64} : () -> !lambdapure.Object
        %5 = "lambdapure.AppOp"(%arg1, %4) : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%5) : (!lambdapure.Object) -> ()
      }) : (i8) -> ()
    }) : (i8) -> ()
  }
  func @case_dot_match_1(%arg0: i64) -> !lambdapure.Object {
    %0 = "lambdapure.PapOp"() {callee = @case_dot_match_1_dot__rarg} : () -> !lambdapure.Object
    "lambdapure.ReturnOp"(%0) : (!lambdapure.Object) -> ()
  }
  func @case(%arg0: !lambdapure.Object) -> !lambdapure.Object {
    %0 = "lambdapure.IntegerConst"() {value = 0 : i64} : () -> !lambdapure.Object
    %1 = "lambdapure.CallOp"(%arg0, %0) {callee = @Nat_dot_decEq} : (!lambdapure.Object, !lambdapure.Object) -> i8
    "lambdapure.CaseOp"(%1) ( {
      %2 = "lambdapure.IntegerConst"() {value = 1 : i64} : () -> !lambdapure.Object
      %3 = "lambdapure.CallOp"(%arg0, %2) {callee = @Nat_dot_decEq} : (!lambdapure.Object, !lambdapure.Object) -> i8
      "lambdapure.CaseOp"(%3) ( {
        %4 = "lambdapure.CallOp"(%arg0, %2) {callee = @Nat_dot_add} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
        "lambdapure.ReturnOp"(%4) : (!lambdapure.Object) -> ()
      },  {
        %4 = "lambdapure.IntegerConst"() {value = 2 : i64} : () -> !lambdapure.Object
        "lambdapure.ReturnOp"(%4) : (!lambdapure.Object) -> ()
      },  {
        %4 = "lambdapure.IntegerConst"() {value = 1 : i64} : () -> !lambdapure.Object
        "lambdapure.ReturnOp"(%4) : (!lambdapure.Object) -> ()
      }) : (i8) -> ()
    }) : (i8) -> ()
  }
}
