
#include "lambdapure/TranslateToCpp.h"
#include <fstream>
#include <iostream>

#include "lambdapure/AST.h"
#include "lambdapure/Dialect.h"
#include "lambdapure/Scope.h"
#include "lambdapure/VarTable.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/Block.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/Types.h"
#include "mlir/IR/Value.h"
#include "mlir/IR/Verifier.h"
using namespace mlir;
namespace {
class CppTranslator {
public:
  CppTranslator(mlir::ModuleOp &module) : theModule(module) {}
  void translateModule() {

    // std::string name = theModule.getName().str();
    outFile.open("out.cpp");
    addInitial();
    translateRegion(theModule.getBodyRegion());
    addInitialMain();
    addEnd();
  }

private:
  mlir::ModuleOp theModule;
  std::ofstream outFile;
  CppVarTable varTable;
  std::string typeConverter(mlir::Type t) {
    if (t.isa<::mlir::lambdapure::ObjectType>()) {
      return "lean_object* ";
    } else if (t.isIntOrIndex()) {
      return "int ";
    } else {
      return "uknown type";
    }
  }

  std::string funcConverter(std::string callee) {
    if (callee == "Nat_dot_decLt") {
      return "lean_nat_dec_lt";
    } else if (callee == "Nat_dot_decLe") {
      return "lean_nat_dec_le";
    } else if (callee == "Nat_dot_decEq") {
      return "lean_nat_dec_eq";
    } else if (callee == "Nat_dot_add") {
      return "lean_nat_add";
    } else if (callee == "Nat_dot_add") {
      return "lean_nat_add";
    } else if (callee == "Nat_dot_sub") {
      return "lean_nat_sub";
    } else if (callee == "Nat_dot_mul") {
      return "lean_nat_mul";
    } else if (callee == "Nat_dot_div") {
      return "lean_nat_div";
    } else {
      return callee;
    }
  }

  void translateRegion(Region &region) {
    for (auto op = region.op_begin(); op != region.op_end(); ++op) {
      translateOperation(&*op);
    }
  }

  void translateOperation(Operation *op) {
    auto name = op->getName().getStringRef().str();
    varTable.insert(op);

    if (name == "func") {
      translateFuncOp(op);
    } else if (name == "lambdapure.AllocCtorOp") {
      translateAllocCtorOp(op);
    } else if (name == "lambdapure.CtorSetOp") {
      translateCtorSetOp(op);
    } else if (name == "lambdapure.ReturnOp") {
      translateReturnOP(op);
    } else if (name == "lambdapure.ProjectionOp") {
      translateProjectionOp(op);

    } else if (name == "lambdapure.AppOp") {
      translateAppOp(op);
    } else if (name == "lambdapure.BoxOp") {
      translateBoxOp(op);
    } else if (name == "lambdapure.UnboxOp") {
      translateUnboxOp(op);
    } else if (name == "lambdapure.CallOp") {
      translateCallOp(op);
    } else if (name == "lambdapure.TagGetOp") {
      translateTagGetOp(op);
    }

    else if (name == "lambdapure.ResetOp") {
      translateResetOp(op);
    } else if (name == "lambdapure.ReuseAllocCtorOp") {
      translateReuseAllocCtorOp(op);
    } else if (name == "lambdapure.IncOp") {
      translateInc(op);
    } else if (name == "lambdapure.DecOp") {
      translateDec(op);
    } else if (name == "lambdapure.ExclCheckOp") {
      translateExclCheckOP(op);
    } else if (name == "lambdapure.CaseOp") {
      translateCaseOp(op);
    } else if (name == "lambdapure.ResetOp") {
      translateResetOp(op);
    } else if (name == "lambdapure.PapOp") {
      translatePapOp(op);
    } else {
      // do nothing
    }
  }

  void translateCaseOp(Operation *op) {
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "switch(" << o1 << "){\n";
    for (int i = 0; i < (int)op->getNumRegions(); ++i) {
      auto &region = op->getRegion(i);
      if (i == (int)op->getNumRegions() - 1) {
        outFile << "default:\n{\n";
      } else {
        outFile << "case " << i << ":\n{\n";
      }
      translateRegion(region);
      outFile << "}\n";
    }
    outFile << "}\n";
  }

  void translateReuseAllocCtorOp(Operation *op) {
    std::string o1 = varTable.get(op->getOperand(0));
    std::string varName = varTable.get(op);
    std::string reuseVar = varTable.get(op->getOperand(0));
    outFile << "lean_object* " << varName << " = " << reuseVar << ";\n";
  }

  void translatePapOp(Operation *op) {
    // TODO: arity of function inference
    std::string varName = varTable.get(op);
    std::string callee =
        op->getAttrOfType<FlatSymbolRefAttr>("callee").getValue().str();
    // int size = op -> getNumOperands();
    outFile << "lean_object * " << varName << " = lean_alloc_closure((void*)("
            << callee << "),1,0);\n";
  }
  void translateResetOp(Operation *op) {
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "if(lean_is_exclusive(" << o1 << ")){\n";
    translateRegion(op->getRegion(0));
    outFile << "}else{\n";
    translateRegion(op->getRegion(1));
    outFile << "}\n";
  }

  void translateExclCheckOP(Operation *op) {
    std::string varName = varTable.get(op);
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "uint8_t " << varName << " = lean_is_exclusive(" << o1 << ");\n";
  }

  void translateAllocCtorOp(Operation *op) {
    int tag = op->getAttrOfType<IntegerAttr>("tag").getInt();
    int size = op->getAttrOfType<IntegerAttr>("size").getInt();
    std::string varName = varTable.get(op);
    outFile << "lean_object* " << varName << " = "
            << "lean_alloc_ctor(" << tag << "," << size << ",0);\n";
  }

  void translateCtorSetOp(Operation *op) {
    int index = op->getAttrOfType<IntegerAttr>("index").getInt();
    std ::string o1 = varTable.get(op->getOperand(0));
    std::string o2 = varTable.get(op->getOperand(1));
    outFile << "lean_ctor_set(" << o1 << ", " << index << ", " << o2 << ");\n";
  }
  void translateReturnOP(Operation *op) {
    // auto parentName = op -> getParentOp() ->
    // getAttrOfType<StringAttr>("sym_name").getValue().str(); std::string
    // returnVar = ""; if(parentName != "_lean_main"){
    //   if(op -> getNumOperands() == 1){
    //     returnVar =varTable.get((op ->getOperand(0)));
    //   }
    //   outFile << "return " << returnVar << ";\n";
    //
    // }
    std::string returnVar = varTable.get((op->getOperand(0)));
    outFile << "return " << returnVar << ";\n";
  }
  void translateProjectionOp(Operation *op) {
    int index = op->getAttrOfType<IntegerAttr>("index").getInt();
    std ::string o1 = varTable.get(op->getOperand(0));
    std::string varName = varTable.get(op);
    outFile << "lean_object* " << varName << " = lean_ctor_get(" << o1 << ", "
            << index << ");\n";
  }
  void translateAppOp(Operation *op) {
    std::string varName = varTable.get(op);
    std::string callee = varTable.get(op->getOperand(0));
    std::string arg;
    int n = op->getNumOperands();
    outFile << "lean_object* " << varName << " = "
            << "lean_apply_" << (n - 1) << "(" << callee << ", ";
    assert(n < 17 && "AppOp only handles up to 16 args currently");
    for (int i = 1; i < n; ++i) {
      arg = varTable.get(op->getOperand(i));
      outFile << arg;
      if (i != n - 1) {
        outFile << ", ";
      }
    }
    outFile << ");\n";
  }

  void translateBoxOp(Operation *op) {
    std::string varName = varTable.get(op);
    int value = op->getAttrOfType<IntegerAttr>("value").getInt();
    outFile << "lean_object* " << varName << " = lean_box(" << value << ");\n";
  }

  void translateUnboxOp(Operation *op) {
    std::string varName = varTable.get(op);
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "int " << varName << " = "
            << "lean_unbox(" << o1 << "0;\n";
  }
  void translateCallOp(Operation *op) {
    std::string varName = varTable.get(op);
    std::string callee =
        op->getAttrOfType<FlatSymbolRefAttr>("callee").getValue().str();
    std::string retTy = typeConverter(*(op->result_type_begin()));
    std::string arg;
    outFile << retTy << "" << varName << " = ";
    int n = op->getNumOperands();
    std::string fName = funcConverter(callee);
    outFile << fName << "(";
    for (int i = 0; i < n; ++i) {
      arg = varTable.get(op->getOperand(i));
      outFile << arg;
      if (i != n - 1) {
        outFile << ", ";
      }
    }
    outFile << ");\n";
  }
  void translateTagGetOp(Operation *op) {
    std::string varName = varTable.get(op);
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "int " << varName << " = lean_obj_tag(" << o1 << ");\n";
  }

  void translateDec(Operation *op) {
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "lean_dec(" << o1 << ");\n";
  }
  void translateInc(Operation *op) {
    std::string o1 = varTable.get(op->getOperand(0));
    outFile << "lean_inc(" << o1 << ");\n";
  }

  void translateFuncOp(Operation *op) {
    std::string fName;
    std::string resultType;
    auto &region = op->getRegion(0);
    for (auto it : op->getAttrs()) {
      auto id = it.first;
      mlir::Attribute attr = it.second;
      if (id == "sym_name") {
        fName = attr.dyn_cast<StringAttr>().getValue().str();
      } else if (id == "type") {
        auto fType =
            attr.dyn_cast<TypeAttr>().getValue().dyn_cast<FunctionType>();
        resultType = typeConverter(fType.getResult(0));
        outFile << resultType << fName << "( ";
        for (int i = 0; i < (int)fType.getNumInputs(); ++i) {
          outFile << typeConverter(fType.getInput(i)) << "arg" << i;
          if (i != (int)fType.getNumInputs() - 1)
            outFile << ", ";
        }
        outFile << "){\n";
        translateRegion(region);
        outFile << "}\n";
      }
    }
  }

  void addInitial() {
    outFile <<
        R""""(
#include "runtime/lean.h"
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
void lean_initialize_runtime_module();

)"""";
  }

  void addEnd() {
    outFile <<
        R""""(


#ifdef __cplusplus
}
#endif

)"""";
  }

  void addInitialMain() {
    outFile <<
        R""""(
int main(int argc, char ** argv) {
lean_object* in; lean_object* res;
lean_initialize_runtime_module();
in = lean_box(0);
int i = argc;
while (i > 1) {
 lean_object* n;
 i--;
 n = lean_alloc_ctor(1,2,0); lean_ctor_set(n, 0, lean_mk_string(argv[i])); lean_ctor_set(n, 1, in);
 in = n;
}
//res = _lean_main(in, lean_io_mk_world());
return 0;
}
)"""";
  }
};

} // end anonymous namespace

namespace lambdapure {
void translate(mlir::ModuleOp &module) {
  auto translator = CppTranslator(module);
  translator.translateModule();
}
} // end namespace lambdapure
