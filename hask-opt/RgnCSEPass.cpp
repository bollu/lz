#include "RgnDialect.h"
#include "mlir/IR/Block.h"
#include "mlir/IR/BuiltinOps.h"
#include "mlir/IR/Dominance.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/IR/Operation.h"
#include "mlir/IR/OperationSupport.h"
#include "mlir/IR/Region.h"
#include "mlir/IR/Value.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Transforms/Passes.h"
#include "mlir/Transforms/Utils.h"
#include "llvm/ADT/DenseMapInfo.h"
#include "llvm/ADT/Hashing.h"
#include "llvm/ADT/Optional.h"
#include "llvm/ADT/ScopedHashTable.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Support/Allocator.h"
#include "llvm/Support/RecyclingAllocator.h"
#include <set>
#include <deque>

using namespace mlir;

namespace {
struct SimpleOperationInfo : public llvm::DenseMapInfo<Operation *> {

  static llvm::hash_code computeRegionHash(Region &rgn) {
    if (rgn.getBlocks().size() == 0 || rgn.getBlocks().size() > 1) {
      assert(false && "should never reach this case!");
    }

    // llvm::hash_code hash = llvm::hash_combine(
    //   op->getName(), op->getAttrDictionary(), op->getResultTypes());
    llvm::hash_code rollingHash(42);
    for (Operation &inst : rgn.getBlocks().front()) {
      llvm::hash_code curhash = computeOpHashToplevel(&inst);
      rollingHash = llvm::hash_combine(rollingHash, curhash);
    }
    return rollingHash;
  }


  static llvm::hash_code computeOpHashToplevel(const Operation *opC) {
    Operation *op = const_cast<Operation *>(opC);
    RgnValOp rgnval = dyn_cast<RgnValOp>(op);
    if (!rgnval) {
      // dispatch to regular hash function.
      return OperationEquivalence::computeHash(op); 
    }
      // assert(false && "hashing rgn");
    Region &rgn = rgnval.getRegion();
    return computeRegionHash(rgn);
  };

  static unsigned getHashValue(const Operation *opC) {
    return computeOpHashToplevel(opC);
    // return OperationEquivalence::computeHash(const_cast<Operation *>(opC));
  }

  static bool isEqual(const Operation *lhsC, const Operation *rhsC) {
    auto *lhs = const_cast<Operation *>(lhsC);
    auto *rhs = const_cast<Operation *>(rhsC);
    if (lhs == rhs)
      return true;
    if (lhs == getTombstoneKey() || lhs == getEmptyKey() ||
        rhs == getTombstoneKey() || rhs == getEmptyKey())
      return false;
    if (isa<RgnValOp>(lhs) && isa<RgnValOp>(rhs)) {
      assert(false  && "comparing regions");
    }
    return OperationEquivalence::isEquivalentTo(const_cast<Operation *>(lhsC),
                                                const_cast<Operation *>(rhsC));
  }
};
} // end anonymous namespace

namespace {
/// Simple common sub-expression elimination.
// struct CSE : public CSEBase<CSE> {
struct RgnCSE : public mlir::Pass {
  /// Shared implementation of operation elimination and scoped map definitions.
  using AllocatorTy = llvm::RecyclingAllocator<
      llvm::BumpPtrAllocator,
      llvm::ScopedHashTableVal<Operation *, Operation *>>;
  using ScopedMapTy = llvm::ScopedHashTable<Operation *, Operation *,
                                            SimpleOperationInfo, AllocatorTy>;

  /// Represents a single entry in the depth first traversal of a CFG.
  struct CFGStackNode {
    CFGStackNode(std::set<RgnValOp> seen, ScopedMapTy &knownValues, DominanceInfoNode *node)
        : seen(seen), scope(knownValues), node(node), childIterator(node->begin()),
          processed(false) {}

    std::set<RgnValOp> seen;
    /// Scope for the known values.
    ScopedMapTy::ScopeTy scope;

    DominanceInfoNode *node;
    DominanceInfoNode::const_iterator childIterator;

    /// If this node has been fully processed yet or not.
    bool processed;
  };


  RgnCSE() : Pass(mlir::TypeID::get<RgnCSE>()){};

  RgnCSE(const RgnCSE &other) : Pass(::mlir::TypeID::get<RgnCSE>()) {}

  /// Attempt to eliminate a redundant operation. Returns success if the
  /// operation was marked for removal, failure otherwise.
  LogicalResult simplifyOperation(std::set<RgnValOp >&seen, ScopedMapTy &knownValues, DominanceInfo &domInfo, Operation *op);

  bool isRgnValOpEqual(ScopedMapTy &knownValues, RgnValOp us, RgnValOp other);

  void simplifyBlock(std::set<RgnValOp >&seen, ScopedMapTy &knownValues, DominanceInfo &domInfo,
                     Block *bb);
  void simplifyRegion(std::set<RgnValOp >&seen, ScopedMapTy &knownValues, DominanceInfo &domInfo,
                      Region &region);
  StringRef getName() const override { return "rgn-cse"; };

  std::unique_ptr<Pass> clonePass() const override {
    // https://github.com/llvm/llvm-project/blob/5d613e42d3761e106e5dd8d1731517f410605144/mlir/tools/mlir-tblgen/PassGen.cpp#L90
    auto pass = std::make_unique<RgnCSE>(*static_cast<const RgnCSE *>(this));
    pass->copyOptionValuesFrom(this);
    return pass;
  }

  void runOnOperation() override;

private:
  /// Operations marked as dead and to be erased.
  std::vector<Operation *> opsToErase;
};
} // end anonymous namespace

llvm::hash_code rgnValHashOp(RgnCSE::ScopedMapTy &knownValues, Operation *op) {
    Operation *v = knownValues.lookup(op);
    if(v) { return llvm::hash_value(v); }
    llvm::hash_code h = llvm::hash_combine(
      op->getName(), op->getAttrDictionary(), op->getResultTypes());

    SmallVector<llvm::hash_code, 4> operandHashes;
    for(Value rand : op->getOperands()) {
      if (Operation *randOp = rand.getDefiningOp()) {
        operandHashes.push_back(rgnValHashOp(knownValues, randOp));
      } else {
        BlockArgument randArg = rand.cast<BlockArgument>();
        // block argument is uniqued by BB and arg index.
        operandHashes.push_back(llvm::hash_combine(randArg.getOwner(), randArg.getArgNumber()));
      }
    }
    // TODO: Allow commutative operations to have different ordering.
    h = llvm::hash_combine(
        h, llvm::hash_combine_range(operandHashes.begin(), operandHashes.end()));
    return h;

}
bool RgnCSE::isRgnValOpEqual(ScopedMapTy &knownValues, RgnValOp us, RgnValOp other) {
  ScopedMapTy::ScopeTy scope(knownValues);

  llvm::errs() << "comparing region vals\n";

  Region &r = us.getRegion();
  Region &s = other.getRegion();
  assert(r.getBlocks().size() == 1);
  assert(s.getBlocks().size() == 1);
  Block &b = r.getBlocks().front();
  Block &c = s.getBlocks().front();
  Block::iterator it = b.begin();
  Block::iterator it2 = c.begin();

  while(it != b.end() && it2 !=c.end()) {
    llvm::errs() << "\tcomparing: " << *it << " =?= " << *it2 << "\n";
    // llvm::errs() << "\t\trepr1: " << repr1 << " | repr2: " << repr2 << "\n";
    if (rgnValHashOp(knownValues, &*it) != rgnValHashOp(knownValues, &*it2)) { 
        llvm::errs() << "\t\tNOT EQUAL!\n";
        // assert(false);
        return false;
    }
    it++;
    it2++;
  }
  // didn't reach end
  if (it != b.end() || it2 !=c.end()) { 
    if (it == b.end()) {
      llvm::errs() << "\tRAN OUT of 1st!.\n";
    } else {
      llvm::errs() << "\tRAN OUT of 2nd!.\n";
    }
    return false;
  }

  // reached end.
  llvm::errs() << "\tEQUAL!\n";
  return true;
}



/// Attempt to eliminate a redundant operation.
LogicalResult RgnCSE::simplifyOperation(std::set<RgnValOp >&seen,
  ScopedMapTy &knownValues,
                                        DominanceInfo &domInfo, Operation *op) {
  llvm::errs() << "op:\n===\n"; 
  llvm::errs() << *op; 
  llvm::errs() << "\n\thash: " << SimpleOperationInfo::computeOpHashToplevel(op) << "\n\n";

  // Don't simplify terminator operations.
  if (op->hasTrait<OpTrait::IsTerminator>())
    return failure();

  // If the operation is already trivially dead just add it to the erase list.
  if (isOpTriviallyDead(op)) {
    opsToErase.push_back(op);
    // ++numDCE;
    return success();
  }

  // Don't simplify operations with nested blocks. We don't currently model
  // equality comparisons correctly among other things. It is also unclear
  // whether we would want to CSE such operations.
  if ((op->getNumRegions() != 0) && !isa<RgnValOp>(op)) {
    return failure();
  }

  if (RgnValOp rgnval = dyn_cast<RgnValOp>(op)) {
    Region &rgn = rgnval.getRegion();
    if (rgn.getBlocks().size() == 0 || rgn.getBlocks().size() > 2) {
      assert(false && "found illegal rgn val op");
      return failure();
    }

    for(RgnValOp other: seen) {
      if (isRgnValOpEqual(knownValues, rgnval, other)) {
        rgnval->replaceAllUsesWith(other);
        opsToErase.push_back(rgnval);
        return success();
      }
    }
    seen.insert(rgnval);
    return failure();
  }

  // TODO: We currently only eliminate non side-effecting
  // operations.
  if (!MemoryEffectOpInterface::hasNoEffect(op))
    return failure();

  // Look for an existing definition for the operation.
  if (auto *existing = knownValues.lookup(op)) {
    // If we find one then replace all uses of the current operation with the
    // existing one and mark it for deletion.
    op->replaceAllUsesWith(existing);
    opsToErase.push_back(op);

    // If the existing operation has an unknown location and the current
    // operation doesn't, then set the existing op's location to that of the
    // current op.
    if (existing->getLoc().isa<UnknownLoc>() &&
        !op->getLoc().isa<UnknownLoc>()) {
      existing->setLoc(op->getLoc());
    }

    // ++numCSE;
    return success();
  }

  // Otherwise, we add this operation to the known values map.
  knownValues.insert(op, op);
  return failure();
}

void RgnCSE::simplifyBlock(std::set<RgnValOp >&seen,
  ScopedMapTy &knownValues, DominanceInfo &domInfo,
                           Block *bb) {
  for (auto &inst : *bb) {
    auto _ = simplifyOperation(seen, knownValues, domInfo, &inst);

    // If this operation is isolated above, we can't process nested regions with
    // the given 'knownValues' map. This would cause the insertion of implicit
    // captures in explicit capture only regions.
    if (inst.mightHaveTrait<OpTrait::IsIsolatedFromAbove>()) {
      ScopedMapTy nestedKnownValues;
      std::set<RgnValOp> nestedSeen;
      for (auto &region : inst.getRegions())
        simplifyRegion(nestedSeen, nestedKnownValues, domInfo, region);
      continue;
    }

    // Otherwise, process nested regions normally.
    for (auto &region : inst.getRegions()) {
      simplifyRegion(seen, knownValues, domInfo, region);
    }



  }
}

void RgnCSE::simplifyRegion(std::set<RgnValOp >&seen,
    ScopedMapTy &knownValues, DominanceInfo &domInfo,
                            Region &region) {
  // If the region is empty there is nothing to do.
  if (region.empty())
    return;

  // If the region only contains one block, then simplify it directly.
  if (std::next(region.begin()) == region.end()) {
    ScopedMapTy::ScopeTy scope(knownValues);
    simplifyBlock(seen, knownValues, domInfo, &region.front());
    return;
  }

  // If the region does not have dominanceInfo, then skip it.
  // TODO: Regions without SSA dominance should define a different
  // traversal order which is appropriate and can be used here.
  if (!domInfo.hasDominanceInfo(&region))
    return;

  // Note, deque is being used here because there was significant performance
  // gains over vector when the container becomes very large due to the
  // specific access patterns. If/when these performance issues are no
  // longer a problem we can change this to vector. For more information see
  // the llvm mailing list discussion on this:
  // http://lists.llvm.org/pipermail/llvm-commits/Week-of-Mon-20120116/135228.html
  std::deque<std::unique_ptr<CFGStackNode>> stack;

  // Process the nodes of the dom tree for this region.
  stack.emplace_back(std::make_unique<CFGStackNode>(
      seen, knownValues, domInfo.getRootNode(&region)));

  while (!stack.empty()) {
    auto &currentNode = stack.back();

    // Check to see if we need to process this node.
    if (!currentNode->processed) {
      currentNode->processed = true;
      simplifyBlock(seen, knownValues, domInfo, currentNode->node->getBlock());
    }

    // Otherwise, check to see if we need to process a child node.
    if (currentNode->childIterator != currentNode->node->end()) {
      auto *childNode = *(currentNode->childIterator++);
      stack.emplace_back(
          std::make_unique<CFGStackNode>(seen, knownValues, childNode));
    } else {
      // Finally, if the node and all of its children have been processed
      // then we delete the node.
      stack.pop_back();
    }
  }
}

void RgnCSE::runOnOperation() {
  /// A scoped hash table of defining operations within a region.
  ScopedMapTy knownValues;
  std::set<RgnValOp > seen;
  DominanceInfo &domInfo = getAnalysis<DominanceInfo>();
  for (Region &region : getOperation()->getRegions())
    simplifyRegion(seen, knownValues, domInfo, region);

  // If no operations were erased, then we mark all analyses as preserved.
  if (opsToErase.empty())
    return markAllAnalysesPreserved();

  /// Erase any operations that were marked as dead during simplification.
  for (auto *op : opsToErase)
    op->erase();
  opsToErase.clear();

  // We currently don't remove region operations, so mark dominance as
  // preserved.
  markAnalysesPreserved<DominanceInfo, PostDominanceInfo>();
}

std::unique_ptr<Pass> createRgnCSEPass() { return std::make_unique<RgnCSE>(); }
void registerRgnCSEPass() {
  ::mlir::registerPass(
      "rgn-cse", "CSE rgn",
      []() -> std::unique_ptr<::mlir::Pass> { return createRgnCSEPass(); });
}
