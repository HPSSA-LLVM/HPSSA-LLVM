#ifndef LLVM_TRANSFORMS_HPSSA_HPSSA_H
#define LLVM_TRANSFORMS_HPSSA_HPSSA_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Dominators.h"
#include "llvm/Pass.h"
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

class HPSSAPass : public PassInfoMixin<HPSSAPass> {
  map<BasicBlock *, BitVector> getProfileInfo(Function &F);
  map<BasicBlock *, bool> getCaloricConnector(Function &F);

  // Dominator tree.Probably virtual so that it gets overriden
  virtual void getAnalysisUsage(AnalysisUsage &AU) const;
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_HPSSA_HPSSA_H