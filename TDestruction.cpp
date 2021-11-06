#include "headers/TDestruction.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses TDSTRPass::run(Function &F, FunctionAnalysisManager &AM) {
  for (auto &BB : F) {
    for (auto &I : BB) {
      CallInst *CI = dyn_cast<CallInst>(&I);
      if (CI == NULL)
        continue;
      Function *CF = CI->getCalledFunction();
      if (CF == NULL ||
          CF->getIntrinsicID() != Function::lookupIntrinsicID("llvm.tau"))
        continue;

      IRBuilder<> Builder(CI);
      Value *origPhi = CI->getOperand(0);
      Value *newTau =
          Builder.CreateAlloca(origPhi->getType(), nullptr, "tau.alloca");
      Value *storeTau = Builder.CreateStore(origPhi, newTau);
    }
  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getTDestructionPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "TDestruction", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "tdstr") {
                    FPM.addPass(TDSTRPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize TConditional Pass when added to the pass pipeline on
// the command line, i.e. via '-passes=tcond'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getTDestructionPluginInfo();
}