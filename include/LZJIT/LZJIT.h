// lzjit
#ifndef LZJIT
#define LZJIT
#include "mlir/IR/Dialect.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/InliningUtils.h"
#include <llvm/ADT/ArrayRef.h>

void registerLZJITPass();
#endif
