func @app_to_node(%node: !lambdapure.Object) (%f: !lambdapure.Object) -> !lambdapure.Object {
  "lambdapure.ResetOp"(%x) ( {
    %0 = "lambdapure.ProjectionOp"(%node) {index = 0 : i64} :(!lambdapure.Object) -> !lambdapure.Object
    "lambdapure.IncOp"(%0) : (!lambdapure.Object) -> ()
    %1 = "lambdapure.ProjectionOp"(%node) {index = 1 : i64} :(!lambdapure.Object) -> !lambdapure.Object
    "lambdapure.IncOp"(%1) : (!lambdapure.Object) -> ()
    %2 = "lambdapure.ConstructorOp"(%0, %1) {tag = 1 : i64} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object
    "lambdapure.DecOp"(%node) : (!lambdapure.Object) -> ()
    "lambdapure.ReturnOp"(%2) : (!lambdapure.Object) -> ()
  },  {
    %0 = "lambdapure.ProjectionOp"(%node) {index = 0 : i64} :(!lambdapure.Object) -> !lambdapure.Object
    %1 = "lambdapure.ProjectionOp"(%node) {index = 1 : i64} :(!lambdapure.Object) -> !lambdapure.Object
    %2 = "lambdapure.ReuseConstructorOp"(%0, %1) {tag = 1 : i64} : (!lambdapure.Object, !lambdapure.Object) -> !lambdapure.Object

    "lambdapure.ReturnOp"(%2) : (!lambdapure.Object) -> ()
  }) : (!lambdapure.Object) -> ()
}
