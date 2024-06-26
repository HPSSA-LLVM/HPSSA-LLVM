#ifndef LLVM_TRANSFORMS_HPSSA_HPSSA_H
#define LLVM_TRANSFORMS_HPSSA_HPSSA_H

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
using namespace std;
namespace llvm {

class HPSSAPass : public PassInfoMixin<HPSSAPass> {
  map<BasicBlock*, BitVector> getProfileInfo(Function& F);
  map<BasicBlock*, bool> getCaloricConnector(Function& F);
  void Search(BasicBlock& X, DomTreeNode& DTN);
  // Dominator tree.Probably virtual so that it gets overriden
public:
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& AM);
  std::vector<Instruction*> getAllTauInstrunctions(Function& F);
  // virtual void getAnalysisUsage(AnalysisUsage &AU) const;
};

bool isTauInstruction(llvm::Instruction *I);
std::vector<Value *> getTauOperands(llvm::Instruction *I);

} // namespace llvm

#endif // LLVM_TRANSFORMS_HPSSA_HPSSA_H