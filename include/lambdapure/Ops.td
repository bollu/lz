#ifndef LAMBDAPURE_OPS
#define LAMBDAPURE_OPS
include "mlir/IR/OpBase.td"
include "mlir/IR/BuiltinTypes.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def Lambdapure_Dialect  : Dialect {
  let name = "lambdapure";
  let cppNamespace = "lambdapure";
}


class Lambdapure_OP<string mnemonic, list<OpTrait> traits = []> :
  Op<Lambdapure_Dialect, mnemonic,traits>;


def lambdapure_ObjectType :
    Type<CPred<"$_self.isa<ObjectType>()">, "Lambdapure object type">;

def IntegerConstOp : Lambdapure_OP<"IntegerConst", [NoSideEffect]>{
  let summary = "IntegerConst";
  let description = [{
      Constant operation assigns an integer contstant to an SSA value
    }];

  let arguments = (ins I64Attr:$value);
  let results = (outs lambdapure_ObjectType);

  let builders = [
    OpBuilderDAG<(ins "int":$value)>
  ];
}


def AppOp : Lambdapure_OP<"AppOp",[]>{
  let summary = "function application op";
  let description = [{
      function application op applied to a listing of variable
    }];

  let arguments = (ins AnyType:$callee, Variadic<AnyType>:$operands);
  let results = (outs AnyType);
  let builders = [
    OpBuilderDAG<(ins "::mlir::Value":$func, "llvm::ArrayRef<::mlir::Value>":$args, "::mlir::Type":$ty)>
  ];
}

def PapOp : Lambdapure_OP<"PapOp",[]>{
  let summary = "function partial applciation, creating closure";
  let arguments = (ins FlatSymbolRefAttr:$callee, Variadic<lambdapure_ObjectType>:$operands);
  let results = (outs lambdapure_ObjectType);
  let builders = [
    OpBuilderDAG<(ins "StringRef":$callee, "ArrayRef<::mlir::Value>":$args)>
  ];
}

def CallOp : Lambdapure_OP<"CallOp",[]>{
  let summary = "function call operation";
  let description = [{
      function application op applied to a listing of variable
    }];

  let arguments = (ins FlatSymbolRefAttr:$callee, Variadic<AnyType>:$inputs);
  let results = (outs AnyType);
  let builders = [
    OpBuilderDAG<(ins "StringRef":$callee, "ArrayRef<::mlir::Value>":$args, "::mlir::Type":$ty)>
  ];
}
def ReturnOp : Lambdapure_OP<"ReturnOp",[NoSideEffect,Terminator]>{
  let summary = "return operation";
  let description = [{
      ReturnOp returns strictly one or none variable
    }];
  let arguments = (ins AnyType:$input);
}

def ConstructorOp : Lambdapure_OP<"ConstructorOp",[]>{
  let summary = "Constructor Operation";
  let description = [{
      Construction
    }];
  let arguments = (ins I64Attr:$tag, Variadic<lambdapure_ObjectType>:$operands);
  let results = (outs lambdapure_ObjectType);
  let builders = [
    OpBuilderDAG<(ins "int":$tag, "ArrayRef<::mlir::Value>":$operands, "::mlir::Type":$ty)>
  ];
}


def ReuseConstructorOp : Lambdapure_OP<"ReuseConstructorOp",[]>{
  let summary = "Reuse Operation";
  let description = [{
      Reuse for destructive updates
    }];
  let arguments = (ins I64Attr:$tag,Variadic<lambdapure_ObjectType>:$operands);
  let results = (outs lambdapure_ObjectType);
  let builders = [
    OpBuilderDAG<(ins "int":$tag, "ArrayRef<::mlir::Value>":$operands)>
  ];
}

def ProjectionOp : Lambdapure_OP<"ProjectionOp", [NoSideEffect]>{
  let summary = "Projection Operation";
  let description = [{
      Projection into ith construction argument
    }];
  let arguments = (ins I64Attr:$index,lambdapure_ObjectType:$operand);
  let results = (outs lambdapure_ObjectType);
  let builders = [
    OpBuilderDAG<(ins "int":$index, "::mlir::Value":$operand, "::mlir::Type":$ty)>
  ];
}

def CaseOp : Lambdapure_OP<"CaseOp", [NoSideEffect,Terminator]>{
  let summary = "Case operation mapping to regions";
  let arguments = (ins I8:$operand);
  let regions = (region VariadicRegion<AnyRegion>:$region);
}

def ResetOp : Lambdapure_OP<"ResetOp",[NoSideEffect,Terminator]>{
  let summary = "Reset Op for destructive updates";
  let arguments = (ins  lambdapure_ObjectType:$object);
  let regions = (region VariadicRegion<AnyRegion>:$region);
}



//Helper Operations
// These operations have matching Runtime functions and assist in lowering ot C

def TagGetOp : Lambdapure_OP<"TagGetOp", [NoSideEffect]>{
  let summary = "get tag from object";
  let arguments = (ins  lambdapure_ObjectType:$object);
  let results = (outs I8);

}


def TagSetOp : Lambdapure_OP<"TagSetOp",[NoSideEffect]>{
  let summary = "set tag of an object";
  let arguments = (ins I8Attr:$tag, lambdapure_ObjectType:$object);
}


def BoxOp : Lambdapure_OP<"BoxOp",[NoSideEffect]>{
  let summary = "Box op corresponding to lean runtime 'lean_box(size t x)'";
  let arguments = (ins I64Attr:$value);
  let results = (outs lambdapure_ObjectType);
}

def UnboxOp : Lambdapure_OP<"UnboxOp",[NoSideEffect]>{
  let summary = "Box op corresponding to lean runtime 'lean_unbox(lean_object* o)'";
  let arguments = (ins lambdapure_ObjectType:$object);
  let results = (outs I64);
}


def AllocCtorOp : Lambdapure_OP<"AllocCtorOp", []>{
  let summary = "alloc_ctor";
  let arguments = (ins I64Attr:$tag, I64Attr:$size);
  let results = (outs lambdapure_ObjectType);
}

def ReuseAllocCtorOp : Lambdapure_OP<"ReuseAllocCtorOp", []>{
  let summary = "reuseAlloca";
  let arguments = (ins I64Attr:$tag, I64Attr:$size, lambdapure_ObjectType:$object );
  let results = (outs lambdapure_ObjectType);

}

def CtorSetOp : Lambdapure_OP<"CtorSetOp",[]>{
  let summary = "set_ctor_obj";
  let arguments = (ins I64Attr:$index,lambdapure_ObjectType:$ctor_obj,lambdapure_ObjectType:$set_obj);

}


def IncOp : Lambdapure_OP<"IncOp",[]>{
  let summary = "add incrementing Operation for reference counting";
  let arguments = (ins lambdapure_ObjectType:$object);

}

def DecOp : Lambdapure_OP<"DecOp",[]>{
  let summary = "add decrementing Operation for reference counting";
  let arguments = (ins lambdapure_ObjectType:$object);

}


#endif // LAMBDAPURE_OPS
