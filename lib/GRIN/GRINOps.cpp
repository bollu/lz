#include "GRIN/GRINOps.h"
#include "mlir/IR/Attributes.h"
#include "mlir/IR/BlockAndValueMapping.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/OpImplementation.h"
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

using namespace mlir;
using namespace mlir::grin;

// STORE OP
// STORE OP
// STORE OP
// STORE OP
// STORE OP

ParseResult GRINStoreOp::parse(OpAsmParser &parser, OperationState &result) {
  return failure();
};

void GRINStoreOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};

// UNBOX OP
// UNBOX OP
// UNBOX OP
// UNBOX OP
// UNBOX OP
ParseResult GRINUnboxOp::parse(OpAsmParser &parser, OperationState &result) {
  FlatSymbolRefAttr boxname;
  parser.parseAttribute<FlatSymbolRefAttr>(boxname);
  result.addAttribute("value", boxname);
  SmallVector<OpAsmParser::OperandType, 8> ops;
  SmallVector<Type, 8> tys;

  if (parser.parseOperandList(ops, OpAsmParser::Delimiter::None) ||
      parser.parseColonTypeList(tys) ||
      parser.resolveOperands(ops, tys, parser.getCurrentLocation(),
                             result.operands)) {
    return failure();
  }
  return success();
};

void GRINUnboxOp::print(OpAsmPrinter &p) {
  p.printGenericOp(this->getOperation());
  return;
};
