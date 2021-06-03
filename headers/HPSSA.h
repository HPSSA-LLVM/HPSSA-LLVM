#ifndef LLVM_TRANSFORMS_HPSSA_HPSSA_H
#define LLVM_TRANSFORMS_HPSSA_HPSSA_H

#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Analysis/CFG.h"

namespace llvm {

class HPSSAPass : public PassInfoMixin<HPSSAPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_HPSSA_HPSSA_H