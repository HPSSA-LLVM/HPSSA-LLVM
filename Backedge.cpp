#include "headers/Backedge.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses BackedgePass::run(Function &F, FunctionAnalysisManager &AM) {
  SmallVector<std::pair<const BasicBlock *, const BasicBlock *>> result;
  FindFunctionBackedges(F, result);
  // result.dump();
  for(auto comb: result){
    errs()<<comb.first->getName()<<" -> "<<comb.second->getName()<<"\n";
  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getBackedgePluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "Backedge", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "backedgeChecker") {
                    FPM.addPass(BackedgePass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HPSSA Pass when added to the pass pipeline on the
// command line, i.e. via '-passes=hpssa'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getBackedgePluginInfo();
}