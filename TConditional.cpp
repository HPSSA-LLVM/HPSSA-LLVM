#include "headers/TConditional.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses TConditionalPass::run(Function &F,
                                        FunctionAnalysisManager &AM) {
  for (auto &B : F) {
    for (auto &I : B) {
      CallInst *CI = dyn_cast<CallInst>(&I);
      if (CI == NULL)
        continue;
      Function *CF = CI->getCalledFunction();
      if ((CF == NULL) ||
          (CF->getIntrinsicID() != Function::lookupIntrinsicID("llvm.tau")))
        continue;
      CI->dump();
      for (auto &U : CI->operands()) {
        U->dump();
      }
      // CF is a call instance of tau function
      // CF->dump();
    }
  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getTConditionalPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "TConditional", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "tcond") {
                    FPM.addPass(TConditionalPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize TConditional Pass when added to the pass pipeline on the
// command line, i.e. via '-passes=tcond'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getTConditionalPluginInfo();
}