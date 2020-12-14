#include "GRIN/GRINOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
#include "mlir/IR/StandardTypes.h"
#include "mlir/IR/Types.h"
#include "mlir/Support/LLVM.h"
#include "mlir/Support/LogicalResult.h"
#include <mlir/Parser.h>
#include <sstream>

// Standard dialect
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/SCF/SCF.h"
#include "mlir/Dialect/StandardOps/IR/Ops.h"

#define DEBUG_TYPE "grin-ops"
#include "llvm/Support/Debug.h"

namespace mlir {
namespace grin {
ParseResult GRINStoreOp::parse(OpAsmParser &parser, OperationState &result) {
  return failure();
};

void GRINStoreOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

} // namespace grin
} // namespace mlir