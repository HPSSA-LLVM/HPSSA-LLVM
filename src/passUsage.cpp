// -----------------------------------------------------------
// This code has been adopted and modified from LLVM base repo
// llvm/lib/Transforms/Scalar/DCE.cpp file has been used.
// This demonstrates the use of HPSSA IR form for DCE Pass. 
// Speculative Dead Code Elimination. 
// -----------------------------------------------------------

#include "llvm/ADT/BreadthFirstIterator.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "../include/HPSSA.h"
#include "../include/SDCE.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instruction.h"
#include "llvm/InitializePasses.h"
#include "llvm/Pass.h"
#include "llvm/Support/DebugCounter.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Utils/AssumeBundleBuilder.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/Local.h"
#include <bits/stdc++.h>
#include <llvm/ADT/GraphTraits.h>
using namespace std;
using namespace llvm;

#define DEBUG_TYPE "specdce"

STATISTIC(SpecDCEEliminated, "Number of insts removed");
DEBUG_COUNTER(SpecDCECounter, "spec-dce-transform",
              "Controls which instructions are eliminated");

//===--------------------------------------------------------------------===//
// SpecRedundantDbgInstElimination pass implementation
//

// namespace {
// struct SpecRedundantDbgInstElimination : public FunctionPass {
//   static char ID; // Pass identification, replacement for typeid
//   SpecRedundantDbgInstElimination() : FunctionPass(ID) {
//     initializeSpecRedundantDbgInstEliminationPass(*PassRegistry::getPassRegistry());
//   }
//   bool runOnFunction(Function &F) override {
//     if (skipFunction(F))
//       return false;
//     bool Changed = false;
//     for (auto &BB : F)
//       Changed |= RemoveRedundantDbgInstrs(&BB);
//     return Changed;
//   }

//   void getAnalysisUsage(AnalysisUsage &AU) const override {
//     AU.setPreservesCFG();
//   }
// };
// }

// char SpecRedundantDbgInstElimination::ID = 0;
// INITIALIZE_PASS(SpecRedundantDbgInstElimination, "redundant-dbg-inst-elim",
//                 "Redundant Dbg Instruction Elimination", false, false)

// Pass *llvm::createSpecRedundantDbgInstEliminationPass() {
//   return new SpecRedundantDbgInstElimination();
// }

PreservedAnalyses
SpecRedundantDbgInstElimination::run(Function &F, FunctionAnalysisManager &AM) {
  bool Changed = false;
  for (auto &BB : F)
    Changed |= RemoveRedundantDbgInstrs(&BB);
  if (!Changed)
    return PreservedAnalyses::all();
  PreservedAnalyses PA;
  PA.preserveSet<CFGAnalyses>();
  return PA;
}

//===--------------------------------------------------------------------===//
// DeadCodeElimination pass implementation
//
std::vector<Value*> speculativeOperands;
void printSPECOps() { 
  llvm::errs() << "Speculative Operands : \n";
  for (auto a : speculativeOperands)
    llvm::errs() << a->getName() << ", ";
  llvm::errs() << "\n";
}

static bool SpecDCEInstruction(Instruction *I,
                           SmallSetVector<Instruction *, 16> &WorkList,
                           const TargetLibraryInfo *TLI) {

  CallInst* CI = dyn_cast<CallInst>(&(*I));

  if (CI != NULL) {
    Function* CF = CI->getCalledFunction();
    if (CF != NULL && CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau")) {
      for (unsigned i = 1, e = I->getNumOperands(); i != e; ++i) {
        Value *op = I->getOperand(i);
        speculativeOperands.emplace_back(op);
      }
      printSPECOps();
    }
  }

  if (isInstructionTriviallyDead(I, TLI)) {
    if (!DebugCounter::shouldExecute(SpecDCECounter))
      return false;

    salvageDebugInfo(*I);
    salvageKnowledge(I);

    // Null out all of the instruction's operands to see if any operand becomes
    // dead as we go.
    Value *first = I->getOperand(0);
    for (unsigned i = 0, e = I->getNumOperands(); i != e; ++i) {

      Value *OpV = I->getOperand(i);
      if (std::find(speculativeOperands.begin(), speculativeOperands.end(), OpV) == speculativeOperands.end())
        I->setOperand(i, nullptr);

      if (!OpV->use_empty() || I == OpV)
        continue;

      // If the operand is an instruction that became dead as we nulled out the
      // operand, and if it is 'trivially' dead, delete it in a future loop
      // iteration.
      if (Instruction *OpI = dyn_cast<Instruction>(OpV))
        if (isInstructionTriviallyDead(OpI, TLI))
          WorkList.insert(OpI);
    }

    I->eraseFromParent();
    llvm::errs() << "\t\tInstruction Eliminated : " << I->getOpcodeName() << ", " << first->getNameOrAsOperand() << "\n";
    ++SpecDCEEliminated;
    return true;
  } else {


  }
  return false;
}

static bool eliminateDeadCode(Function &F, TargetLibraryInfo *TLI) {

  bool MadeChange = false;
  SmallSetVector<Instruction *, 16> WorkList;
  // Iterate over the original function, only adding insts to the worklist
  // if they actually need to be revisited. This avoids having to pre-init
  // the worklist with the entire function's worth of instructions.
  for (Instruction &I : llvm::make_early_inc_range(instructions(F))) {
    // We're visiting this instruction now, so make sure it's not in the
    // worklist from an earlier visit.
    if (!WorkList.count(&I))
      MadeChange |= SpecDCEInstruction(&I, WorkList, TLI);
  }

  while (!WorkList.empty()) {
    Instruction *I = WorkList.pop_back_val();
    MadeChange |= SpecDCEInstruction(I, WorkList, TLI);
  }
  return MadeChange;
}

PreservedAnalyses SpecDCEPass::run(Function &F, FunctionAnalysisManager &AM) {
  if (F.getName() != "main")
    return PreservedAnalyses::all();

  HPSSAPass hpssaUtil;
  hpssaUtil.run(F, AM);
  
  std::vector<Instruction *> TauInsts = hpssaUtil.getAllTauInstrunctions(F);
  std::cout << "\t\tTotal Tau Instructions : " << TauInsts.size() << "\n";
  
  if (!eliminateDeadCode(F, &AM.getResult<TargetLibraryAnalysis>(F)))
    return PreservedAnalyses::all();

  PreservedAnalyses PA;
  PA.preserveSet<CFGAnalyses>();
  return PA;
}

// namespace {
// struct SpecDCELegacyPass : public FunctionPass {
//   static char ID; // Pass identification, replacement for typeid
//   SpecDCELegacyPass() : FunctionPass(ID) {
//     initializeSpecDCELegacyPassPass(*PassRegistry::getPassRegistry());
//   }

//   bool runOnFunction(Function &F) override {
//     if (skipFunction(F))
//       return false;

//     TargetLibraryInfo *TLI =
//         &getAnalysis<TargetLibraryInfoWrapperPass>().getTLI(F);

//     return eliminateDeadCode(F, TLI);
//   }

//   void getAnalysisUsage(AnalysisUsage &AU) const override {
//     AU.addRequired<TargetLibraryInfoWrapperPass>();
//     AU.setPreservesCFG();
//   }
// };
// }

// char SpecDCELegacyPass::ID = 0;
// INITIALIZE_PASS(SpecDCELegacyPass, "dce", "Dead Code Elimination", false, false)

// FunctionPass *llvm::createDeadCodeEliminationPass() {
//   return new SpecDCELegacyPass();
// }

namespace llvm {

class ExamplePass : public PassInfoMixin<ExamplePass> {
public:
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& AM);
};

PreservedAnalyses ExamplePass::run(Function& F, FunctionAnalysisManager& AM) {
  HPSSAPass hpssaUtil;
  if (F.getName() != "main") 
    return PreservedAnalyses::all();
  
  hpssaUtil.run(F, AM);
  std::vector<Instruction *> TauInsts = hpssaUtil.getAllTauInstrunctions(F);
  std::cout << "\t\tTotal Tau Instructions : " << TauInsts.size() << "\n";
  
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getExampleUseHPSSAInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HPSSA Usage", "v1.0", [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager& FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "specdce") {
                    FPM.addPass(SpecDCEPass());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getExampleUseHPSSAInfo();
}

} // namespace llvm