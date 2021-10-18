#ifndef LLVM_TRANSFORMS_TCONDITIONAL_TCONDITIONAL_H
#define LLVM_TRANSFORMS_TCONDITIONAL_TCONDITIONAL_H

#include "llvm/IR/Function.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Analysis/CFG.h"
#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

class TConditionalPass : public PassInfoMixin<TConditionalPass> {

public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_TCONDITIONAL_TCONDITIONAL_H
