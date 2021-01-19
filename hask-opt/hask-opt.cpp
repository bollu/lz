//===- standalone-opt.cpp ---------------------------------------*- C++ -*-===//
//
// This file is licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/Dialect.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Support/MlirOptMain.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Mangler.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/InitLLVM.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ToolOutputFile.h"

// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch3/toyc.cpp
#include "mlir/IR/AsmState.h"
#include "mlir/IR/Verifier.h"
#include "mlir/Parser.h"
#include "mlir/Transforms/Passes.h"

#include "llvm/ADT/StringRef.h"
#include "llvm/Support/ErrorOr.h"
#include "llvm/Support/MemoryBuffer.h"
#include "llvm/Support/raw_ostream.h"

#include "GRIN/GRINDialect.h"
#include "Hask/HaskDialect.h"
#include "Hask/HaskOps.h"
#include "Interpreter.h"
#include "Pointer/PointerDialect.h"
#include "Unification/UnificationDialect.h"
#include "Runtime.h"

#include "LZJIT/LZJIT.h"

// conversion
// https://github.com/llvm/llvm-project/blob/80d7ac3bc7c04975fd444e9f2806e4db224f2416/mlir/examples/toy/Ch6/toyc.cpp
#include "mlir/Target/LLVMIR.h"

// Execution
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"

extern "C" {
const char *__asan_default_options() { return "detect_leaks=0"; }
}

using namespace llvm;
using namespace llvm::orc;

int main(int argc, char **argv) {
  mlir::registerAllPasses();

  // mlir::registerInlinerPass();
  // mlir::registerCanonicalizerPass();
  // mlir::registerCSEPass();
  // mlir::registerAffinePasses();
  // mlir::registerAffineLoopFusionPass();
  // mlir::registerConvertStandardToLLVMPass();
  // mlir::registerConvertAffineToStandardPass();
  // mlir::registerSCFToStandardPass();

  mlir::standalone::registerWorkerWrapperPass();
  mlir::standalone::registerLowerHaskPass();
  mlir::ptr::registerLowerPointerPass();
  registerLZJITPass();
  registerLZDumpLLVMPass();
  registerLzInterpretPass();

  mlir::DialectRegistry registry;
  mlir::registerAllDialects(registry);
  registry.insert<mlir::LLVM::LLVMDialect>();
  registry.insert<mlir::standalone::HaskDialect>();
  registry.insert<mlir::grin::GRINDialect>();
  registry.insert<mlir::ptr::PtrDialect>();
  registry.insert<mlir::unif::UnificationDialect>();

  // registry.insert<mlir::StandardOpsDialect>();
  // registry.insert<mlir::AffineDialect>();
  // registry.insert<mlir::scf::SCFDialect>();

  // Add the following to include *all* MLIR Core dialects, or selectively
  // include what you need like above. You only need to register dialects that
  // will be *parsed* by the tool, not the one generated
  // registerAllDialects(registry);

  return failed(mlir::MlirOptMain(argc, argv, "Hask optimizer driver\n",
                                  registry, true));
}
