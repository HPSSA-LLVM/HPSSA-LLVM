#include "headers/TDestruction.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses TDSTRPass::run(Function &F, FunctionAnalysisManager &AM) {
  vector<Instruction*> toBeRemoved;
  for (auto &BB : F) {
    for (auto &I : BB) {
      CallInst *CI = dyn_cast<CallInst>(&I);
      if (CI == NULL)
        continue;
      Function *CF = CI->getCalledFunction();
      if (CF == NULL ||
          CF->getIntrinsicID() != Function::lookupIntrinsicID("llvm.tau"))
        continue;
      toBeRemoved.push_back(&I);
    }
  }
  for(auto I: toBeRemoved) {
      CallInst *CI = dyn_cast<CallInst>(I);
      I->getType()->dump();
      IRBuilder<> Builder(CI);
      Value *origPhi = CI->getOperand(0);
      Value *newTau =
          Builder.CreateAlloca(origPhi->getType(), nullptr, CI->getName()+".alloca");
      newTau->getType()->dump();
      Value *storeTau = Builder.CreateStore(origPhi, newTau);
      Value *loadInst = Builder.CreateLoad(origPhi->getType(), newTau, newTau->getName()+".load");
      I->replaceAllUsesWith(loadInst);
      I->eraseFromParent();
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