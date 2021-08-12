

#ifndef LLVM_TRANSFORMS_Backedge_Backedge_H
#define LLVM_TRANSFORMS_Backedge_Backedge_H

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
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

class BackedgePass : public PassInfoMixin<BackedgePass> {

public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
  // virtual void getAnalysisUsage(AnalysisUsage &AU) const;
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_Backedge_Backedge_H