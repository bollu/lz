#include "Pointer/PointerOps.h"
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

#define DEBUG_TYPE "ptr-ops"
#include "llvm/Support/Debug.h"

using namespace mlir;
using namespace mlir::ptr;

// %ptr = inttoptr %i
class PtrIntToPtrOp
    : public Op<PtrIntToPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.inttoptr"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};



// %ptr = ptrtoint %i
class PtrPtrToIntOp
    : public Op<PtrIntToPtrOp, OpTrait::OneResult, OpTrait::OneOperand> {
public:
  using Op::Op;
  static StringRef getOperationName() { return "ptr.ptrtoint"; };
  static ParseResult parse(OpAsmParser &parser, OperationState &result);
  void print(OpAsmPrinter &p);
};

