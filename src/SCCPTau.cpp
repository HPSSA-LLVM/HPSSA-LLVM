//===- SCCP.cpp - Sparse Conditional Constant Propagation -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file implements sparse conditional constant propagation and merging:
//
// Specifically, this:
//   * Assumes values are constant unless proven otherwise
//   * Assumes BasicBlocks are dead unless proven otherwise
//   * Proves values to be constant, and replaces them with constants
//   * Proves conditional branches to be unconditional
//
//===----------------------------------------------------------------------===//
#include "../include/SCCPTau.h"
#include "../include/SCCPSolverTau.h"
#include "../include/HPSSA.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include <bits/stdc++.h>
#include <llvm/IR/Value.h>
#include "../include/SpecValueLattice.h"
#include "../include/InsertSpecValues.h"
#include "llvm/ADT/ArrayRef.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/DenseSet.h"
#include "llvm/ADT/MapVector.h"
#include "llvm/ADT/PointerIntPair.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallPtrSet.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/ConstantFolding.h"
#include "llvm/Analysis/DomTreeUpdater.h"
#include "llvm/Analysis/GlobalsModRef.h"
#include "llvm/Analysis/InstructionSimplify.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueLatticeUtils.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/GlobalVariable.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Type.h"
#include "llvm/IR/User.h"
#include "llvm/IR/Value.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/PredicateInfo.h"
#include <cassert>
#include <utility>
#include <vector>

using namespace llvm;

#define DEBUG_TYPE "tausccp"

STATISTIC(NumInstRemoved, "Number of instructions removed");
STATISTIC(NumDeadBlocks , "Number of basic blocks unreachable");
STATISTIC(NumInstReplaced,
          "Number of instructions replaced with (simpler) instruction");

STATISTIC(IPNumInstRemoved, "Number of instructions removed by IPSCCP");
STATISTIC(IPNumArgsElimed ,"Number of arguments constant propagated by IPSCCP");
STATISTIC(IPNumGlobalConst, "Number of globals found to be constant by IPSCCP");
STATISTIC(
    IPNumInstReplaced,
    "Number of instructions replaced with (simpler) instruction by IPSCCP");

// Helper to check if \p LV is either a constant or a constant
// range with a single element. This should cover exactly the same cases as the
// old ValueLatticeElement::isConstant() and is intended to be used in the
// transition to ValueLatticeElement.
static bool isConstant(const SpecValueLatticeElement &LV) {
  return LV.isConstant() ||
         (LV.isConstantRange() && LV.getConstantRange().isSingleElement());
}

static bool isSpeculative(const SpecValueLatticeElement &LV) {
  return LV.isFullySpeculative();
}

// Helper to check if \p LV is either overdefined or a constant range with more
// than a single element. This should cover exactly the same cases as the old
// ValueLatticeElement::isOverdefined() and is intended to be used in the
// transition to ValueLatticeElement.
static bool isOverdefined(const SpecValueLatticeElement &LV) {
  return !LV.isUnknownOrUndef() && !isConstant(LV);
}

static bool tryToReplaceWithConstant(SCCPTauSolver &Solver, Value *V, Function &F) {
  Constant *Const = nullptr;
  if (V->getType()->isStructTy()) {
    std::vector<SpecValueLatticeElement> IVs = Solver.getStructLatticeValueFor(V);
    if (any_of(IVs,
               [](const SpecValueLatticeElement &LV) { return isOverdefined(LV); }))
      return false;
    std::vector<Constant *> ConstVals;
    auto *ST = cast<StructType>(V->getType());
    for (unsigned i = 0, e = ST->getNumElements(); i != e; ++i) {
      SpecValueLatticeElement V = IVs[i];
      ConstVals.push_back(isConstant(V)
                              ? Solver.getConstant(V)
                              : UndefValue::get(ST->getElementType(i)));
    }
    Const = ConstantStruct::get(ST, ConstVals);
    if (any_of(IVs,
            [](const SpecValueLatticeElement &LV) { return isSpeculative(LV); })) {
      LLVM_DEBUG(dbgs() << "  Speculative Constant: " << *Const << " = " << *V << '\n');
      insertSpeculativeValues(F, V, (Const)->getUniqueInteger().getZExtValue());
    }
    else
      LLVM_DEBUG(dbgs() << "  Constant: " << *Const << " = " << *V << '\n');
  } else {
    const SpecValueLatticeElement &IV = Solver.getLatticeValueFor(V);
    if (isOverdefined(IV))
      return false;

    Const =
        isConstant(IV) ? Solver.getConstant(IV) : UndefValue::get(V->getType());
    if (isSpeculative(IV)) {
      LLVM_DEBUG(dbgs() << "  Speculative Constant: " << *Const << " = " << *V << '\n');
      insertSpeculativeValues(F, V, (Const)->getUniqueInteger().getZExtValue());
    }
    else
      LLVM_DEBUG(dbgs() << "  Constant: " << *Const << " = " << *V << '\n');
  }
  assert(Const && "Constant is nullptr here!");

  // Replacing `musttail` instructions with constant breaks `musttail` invariant
  // unless the call itself can be removed.
  // Calls with "clang.arc.attachedcall" implicitly use the return value and
  // those uses cannot be updated with a constant.
  CallBase *CB = dyn_cast<CallBase>(V);
  if (CB && ((CB->isMustTailCall() && !CB->isSafeToRemove()) ||
             CB->getOperandBundle(LLVMContext::OB_clang_arc_attachedcall))) {
    Function *F = CB->getCalledFunction();

    // Don't zap returns of the callee
    if (F)
      Solver.addToMustPreserveReturnsInFunctions(F);

    LLVM_DEBUG(dbgs() << "  Can\'t treat the result of call " << *CB
                      << " as a constant\n");
    return false;
  }

  // Replaces all of the uses of a variable with uses of the constant.
  V->replaceAllUsesWith(Const);
  return true;
}

static bool simplifyInstsInBlock(SCCPTauSolver &Solver, BasicBlock &BB,
                                 SmallPtrSetImpl<Value *> &InsertedValues,
                                 Statistic &InstRemovedStat,
                                 Statistic &InstReplacedStat,
                                 Function &F) {
  bool MadeChanges = false;
  for (Instruction &Inst : make_early_inc_range(BB)) {
    if (Inst.getType()->isVoidTy())
      continue;
    if (tryToReplaceWithConstant(Solver, &Inst, F)) {
      if (Inst.isSafeToRemove())
        Inst.eraseFromParent();

      MadeChanges = true;
      ++InstRemovedStat;
    } else if (isa<SExtInst>(&Inst)) {
      Value *ExtOp = Inst.getOperand(0);
      if (isa<Constant>(ExtOp) || InsertedValues.count(ExtOp))
        continue;
      const SpecValueLatticeElement &IV = Solver.getLatticeValueFor(ExtOp);
      if (!IV.isConstantRange(/*UndefAllowed=*/false))
        continue;
      if (IV.getConstantRange().isAllNonNegative()) {
        auto *ZExt = new ZExtInst(ExtOp, Inst.getType(), "", &Inst);
        InsertedValues.insert(ZExt);
        Inst.replaceAllUsesWith(ZExt);
        Solver.removeLatticeValueFor(&Inst);
        Inst.eraseFromParent();
        InstReplacedStat++;
        MadeChanges = true;
      }
    }
  }
  return MadeChanges;
}

// runSCCP() - Run the Sparse Conditional Constant Propagation algorithm,
// and return true if the function was modified.
static bool runSCCP(Function &F, const DataLayout &DL,
                    const TargetLibraryInfo *TLI) {
  LLVM_DEBUG(dbgs() << "Speculative SCCP on function '" << F.getName() << "'\n");
  SCCPTauSolver Solver(
      DL, [TLI](Function &F) -> const TargetLibraryInfo & { return *TLI; },
      F.getContext());

  // Mark the first block of the function as being executable.
  Solver.markBlockExecutable(&F.front());

  // Mark all arguments to the function as being overdefined.
  for (Argument &AI : F.args())
    Solver.markOverdefined(&AI);

  // Solve for constants.
  bool ResolvedUndefs = true;
  while (ResolvedUndefs) {
    Solver.solve();
    LLVM_DEBUG(dbgs() << "RESOLVING UNDEFs\n");
    ResolvedUndefs = Solver.resolvedUndefsIn(F);
  }

  bool MadeChanges = false;

  // If we decided that there are basic blocks that are dead in this function,
  // delete their contents now.  Note that we cannot actually delete the blocks,
  // as we cannot modify the CFG of the function.

  SmallPtrSet<Value *, 32> InsertedValues;
  
  // Why not use RPOT I ask?
  ReversePostOrderTraversal<Function *> RPOT(&F);
  for (BasicBlock *BB : RPOT) {
    if (!Solver.isBlockExecutable(BB)) {
      LLVM_DEBUG(dbgs() << "  BasicBlock Dead : " << BB);

      ++NumDeadBlocks;
      NumInstRemoved += removeAllNonTerminatorAndEHPadInstructions(BB).first;

      MadeChanges = true;
      continue;
    }

    MadeChanges |= simplifyInstsInBlock(Solver, *BB, InsertedValues,
                                        NumInstRemoved, NumInstReplaced, F);
  }

  return MadeChanges;
}

PreservedAnalyses SCCPTauPass::run(Function &F, FunctionAnalysisManager &AM) {
  if (F.getName() != "main")
    return PreservedAnalyses::all();
  
  /* Insert a Spec Value Return Function */
  createSpeculativeFunctionVal(F);

  HPSSAPass hpssaUtil;
  hpssaUtil.run(F, AM);

  const DataLayout &DL = F.getParent()->getDataLayout();
  auto &TLI = AM.getResult<TargetLibraryAnalysis>(F);
  if (!runSCCP(F, DL, &TLI))
    return PreservedAnalyses::all();

  auto PA = PreservedAnalyses();
  PA.preserveSet<CFGAnalyses>();
  return PA;
}


llvm::PassPluginLibraryInfo getSCCPTauPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "SCCPTauPass", "v0.1", [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager& FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "tausccp") {
                    FPM.addPass(SCCPTauPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HPSSA Pass when added to the pass pipeline on the
// command line, i.e. via '-passes=tausccp'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getSCCPTauPluginInfo();
}