#ifndef LLVM_TRANSFORMS_BBProfiler_BBProfiler_H
#define LLVM_TRANSFORMS_BBProfiler_BBProfiler_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Dominators.h"
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
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

class BBProfilerPass : public PassInfoMixin<BBProfilerPass> {
<<<<<<< HEAD
=======
  //   map<BasicBlock *, BitVector> getProfileInfo(Function &F);
  //   map<BasicBlock *, bool> getCaloricConnector(Function &F);

  // Dominator tree.Probably virtual so that it gets overriden
>>>>>>> 3ee17621d926caf3592921d45ebe6ac9ecf59533
public:
  PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_BBProfiler_BBProfiler_H