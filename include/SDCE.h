#ifndef LLVM_TRANSFORMS_SCALAR_DCE_H
#define LLVM_TRANSFORMS_SCALAR_DCE_H

#include "llvm/IR/Function.h"
#include "llvm/IR/PassManager.h"

namespace llvm {

/// Basic Dead Code Elimination pass.
class SpecDCEPass : public PassInfoMixin<SpecDCEPass> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

class SpecRedundantDbgInstElimination
    : public PassInfoMixin<SpecRedundantDbgInstElimination> {
public:
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};
}

#endif // LLVM_TRANSFORMS_SCALAR_DCE_H