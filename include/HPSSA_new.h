#ifndef LLVM_TRANSFORMS_HPSSA_HPSSA_H
#define LLVM_TRANSFORMS_HPSSA_HPSSA_H

#include "llvm/ADT/BreadthFirstIterator.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <bits/stdc++.h>

#include "../BallLarusProfiler/headers/BallLarusProfiler.h"
#include "../BallLarusProfiler/headers/GeneratePath.h"
using namespace std;
namespace llvm {

class HPSSAPass : public PassInfoMixin<HPSSAPass> {
  void FillFunctionBackedges(Function& F);
  void fillTopologicalNumbering(ReversePostOrderTraversal<Function*> RPOT);
  void getProfileInfo(Function& F);
  map<BasicBlock*, bool> getCaloricConnector(Function& F);
  void Search(BasicBlock& X, DomTreeNode& DTN);
  void AllocateArgs(BasicBlock* BB, DomTreeNode& DTN);

  // Dominator tree.Probably virtual so that it gets overriden
public:
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& AM);
  // virtual void getAnalysisUsage(AnalysisUsage &AU) const;
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_HPSSA_HPSSA_H
