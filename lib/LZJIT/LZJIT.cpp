#include "LZJIT/LZJIT.h"
#include "Runtime.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Support/MlirOptMain.h"
#include "mlir/Target/LLVMIR.h"
#include "mlir/Transforms/DialectConversion.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Mangler.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

// Execution
#include "mlir/Target/LLVMIR/Dialect/LLVMIR/LLVMToLLVMIRTranslation.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

using namespace mlir;
using namespace llvm;
using namespace llvm::orc;
ExitOnError ExitOnErr;

struct LZJITPass : public mlir::Pass {
  LZJITPass() : Pass(mlir::TypeID::get<LZJITPass>()){};
  StringRef getName() const override { return "LZJIT"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst =
        std::make_unique<LZJITPass>(*static_cast<const LZJITPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }
  // https://github.com/bollu/coremlir/blob/7ab044051e62c54e8d3f94a38e3d1ecbf49fb2b0/hask-opt/hask-opt.cpp#L246
  void runOnOperation() override {
    // Lower MLIR-LLVM all the way down to "real LLVM"
    // https://github.com/llvm/llvm-project/blob/670063eb220663b5a42fd4e9bd63f51d379c9aa0/mlir/examples/toy/Ch6/toyc.cpp#L193

    mlir::ModuleOp mod = mlir::cast<ModuleOp>(this->getOperation());
    llvm::errs() << "===Lowering MLIR-LLVM module to LLVM===\n";

    auto llvmContext = std::make_unique<llvm::LLVMContext>();
    std::unique_ptr<llvm::Module> llvmMod =
        mlir::translateModuleToLLVMIR(mod, *llvmContext);

    const bool nativeTargetInitialized = llvm::InitializeNativeTarget();
    LLVMInitializeNativeAsmPrinter();
    LLVMInitializeNativeAsmParser();
    assert(nativeTargetInitialized == false);

    llvm::orc::LLJITBuilder JITbuilder;
    ExitOnErr(JITbuilder.prepareForConstruction());
    std::unique_ptr<llvm::orc::LLJIT> J = ExitOnErr(JITbuilder.create());

    llvm::orc::JITDylib *JD =
        J->getExecutionSession().getJITDylibByName("main");

    llvm::orc::MangleAndInterner Mangle(J->getExecutionSession(),
                                        J->getDataLayout());

    llvm::JITTargetAddress putsAddr = llvm::pointerToJITTargetAddress(&puts);
    llvm::DenseMap<llvm::orc::SymbolStringPtr, llvm::JITEvaluatedSymbol>
        name2symbol;
    name2symbol.insert(
        {Mangle("puts"),
         llvm::JITEvaluatedSymbol(putsAddr, llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("mkClosure_capture0_args2"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&mkClosure_capture0_args2),
             llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("mkClosure_capture0_args1"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&mkClosure_capture0_args1),
             llvm::JITSymbolFlags::Callable)});

    name2symbol.insert(
        {Mangle("mkClosure_capture0_args0"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&mkClosure_capture0_args0),
             llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("mkClosure_thunkify"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&mkClosure_thunkify),
             llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("malloc"),
         llvm::JITEvaluatedSymbol(llvm::pointerToJITTargetAddress(&malloc),
                                  llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("evalClosure"),
         llvm::JITEvaluatedSymbol(llvm::pointerToJITTargetAddress(&evalClosure),
                                  llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("extractConstructorArg"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&extractConstructorArg),
             llvm::JITSymbolFlags::Callable)});
    name2symbol.insert({Mangle("mkConstructor0"),
                        llvm::JITEvaluatedSymbol(
                            llvm::pointerToJITTargetAddress(&mkConstructor0),
                            llvm::JITSymbolFlags::Callable)});
    name2symbol.insert({Mangle("mkConstructor1"),
                        llvm::JITEvaluatedSymbol(
                            llvm::pointerToJITTargetAddress(&mkConstructor1),
                            llvm::JITSymbolFlags::Callable)});
    name2symbol.insert({Mangle("mkConstructor2"),
                        llvm::JITEvaluatedSymbol(
                            llvm::pointerToJITTargetAddress(&mkConstructor2),
                            llvm::JITSymbolFlags::Callable)});
    name2symbol.insert(
        {Mangle("isConstructorTagEq"),
         llvm::JITEvaluatedSymbol(
             llvm::pointerToJITTargetAddress(&isConstructorTagEq),
             llvm::JITSymbolFlags::Callable)});
    ExitOnErr(JD->define(llvm::orc::absoluteSymbols(name2symbol)));
    ExitOnErr(J->addIRModule(llvm::orc::ThreadSafeModule(
        std::move(llvmMod), std::move(llvmContext))));
    // https://llvm.org/docs/ORCv2.html#how-to-add-process-and-library-symbols-to-the-jitdylibs
    // Look up the JIT'd function, cast it to a function pointer, then call it.
    auto mainfnSym = ExitOnErr(J->lookup("main"));
    void *(*mainfn)(void *) = (void *(*)(void *))mainfnSym.getAddress();
    void *result = mainfn(NULL);
    llvm::errs() << "main:  " << __LINE__ << "\n";
    llvm::errs() << "(void*)main(nullptr) = " << (size_t)result << "\n";
    const size_t result2int = (size_t)(((Constructor *)result)->args[0]);
    llvm::outs() << result2int << "\n";
  };
};

std::unique_ptr<mlir::Pass> createLZJITPass() {
  return std::make_unique<LZJITPass>();
}

void registerLZJITPass() {
  ::mlir::registerPass(
      "lz-jit", "JIT LLVM code that's generated from lz+std+scf+affine",
      []() -> std::unique_ptr<::mlir::Pass> { return createLZJITPass(); });
}

// === DUMP LLVM ===
// === DUMP LLVM ===
// === DUMP LLVM ===
// === DUMP LLVM ===
// === DUMP LLVM ===
// === DUMP LLVM ===


struct LZDumpLLVMPass : public mlir::Pass {
  LZDumpLLVMPass() : Pass(mlir::TypeID::get<LZDumpLLVMPass>()){};
  StringRef getName() const override { return "LZDumpLLVM"; }

  std::unique_ptr<Pass> clonePass() const override {
    auto newInst =
        std::make_unique<LZDumpLLVMPass>(*static_cast<const LZDumpLLVMPass *>(this));
    newInst->copyOptionValuesFrom(this);
    return newInst;
  }
  // https://github.com/bollu/coremlir/blob/7ab044051e62c54e8d3f94a38e3d1ecbf49fb2b0/hask-opt/hask-opt.cpp#L246
  void runOnOperation() override {

    mlir::ModuleOp mod = mlir::cast<ModuleOp>(this->getOperation());
    llvm::errs() << "===Lowering MLIR-LLVM module to LLVM===\n";

    auto llvmContext = std::make_unique<llvm::LLVMContext>();
    std::unique_ptr<llvm::Module> llvmMod =
        mlir::translateModuleToLLVMIR(mod, *llvmContext);

    llvm::AssemblyAnnotationWriter *AAW = nullptr;
    llvmMod->print(llvm::outs(), AAW);
  };
};


std::unique_ptr<mlir::Pass> createLZDumpLLVMPass() {
  return std::make_unique<LZDumpLLVMPass>();
}

void registerLZDumpLLVMPass() {
  ::mlir::registerPass(
      "lz-dump-llvm", "JIT LLVM code that's generated from lz+std+scf+affine",
      []() -> std::unique_ptr<::mlir::Pass> { return createLZDumpLLVMPass(); });
}
