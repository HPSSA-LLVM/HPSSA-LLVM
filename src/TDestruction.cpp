#include "../include/TDestruction.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses TDSTRPass::run(Function &F, FunctionAnalysisManager &AM) {
  vector<Instruction *> toBeRemoved;
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
  for (auto I : toBeRemoved) {
    CallInst *CI = dyn_cast<CallInst>(I);
    Function *CF = CI->getCalledFunction();
    llvm::errs() << "Tau to be removed : " << CF->getName() << "\t\n";
    // I->getType()->dump();
    // errs() << "Original"
    //        << "\n";
    // I->dump();
    IRBuilder<> Builder(CI);
    Value *origPhi = CI;
    Value *replaceTAU = CI->getOperand(0);
    llvm::errs() << "Replacing variable " << origPhi->getName() << " with "
                 << replaceTAU->getName() << ".\n";
    // Value *newTau = Builder.CreateAlloca(origPhi->getType(), nullptr,
    //                                      CI->getName() + ".alloca");
    // Value *storeTau = Builder.CreateStore(replaceTAU, origPhi, false);
    // Value *loadInst = Builder.CreateLoad(origPhi->getType(), newTau,
    //                                      newTau->getName() + ".load");
    I->replaceAllUsesWith(replaceTAU);
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