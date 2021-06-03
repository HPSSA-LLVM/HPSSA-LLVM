#include "headers/HPSSA.h"
#include <stack>

using namespace llvm;

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {
  errs()<<"\nx-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x"<<"\n";
  errs() << "Function: " << F.getName() << "\n";
  for (auto &BB : F) {
    errs() << "---------------------------------------------"
           << "\n";
    errs() << "\nOriginal Basic Block: " << BB << "\n";

    // Every New Tau Instruction will be inserted before this Instruction.
    Instruction *TopInstruction = BB.getFirstNonPHI();

    // Store the phi Encountered.
    llvm::SetVector<PHINode *> PhiList;
    errs() << "Modfications : "<<"\n";
    for (auto &I : BB) {
      if (PHINode *phi = dyn_cast<PHINode>(&I)) {
        // print PHI
        errs() << "PHI :"
               << "\n";
        errs() << *phi << "\n";
        PhiList.insert(phi);
      }
    }
    // Insert Tau
    for (auto phi : PhiList) {
      PHINode *tau = PHINode::Create(phi->getType(), 1, phi->getName() + ".tau",
                                     TopInstruction);

      // Rename Uses
      phi->replaceAllUsesWith(tau);
      // Add arguments to Tau : Safe part of HPSSA.
      tau->addIncoming(phi, &BB);

      // print TAU;
      errs() << "TAU :"
             << "\n";
      errs() << *tau << "\n";
    }
    if (PhiList.empty()) {
      errs() << "None"
             << "\n";
    } else {
      errs() << "\nModified Basic Block :"
             << "\n";
      errs() << BB << "\n";
    }
  }
    return PreservedAnalyses::all();
}

  llvm::PassPluginLibraryInfo getHPSSAPluginInfo() {
    return {LLVM_PLUGIN_API_VERSION, "HPSSA", "v0.1", [](PassBuilder &PB) {
              PB.registerPipelineParsingCallback(
                  [](StringRef Name, FunctionPassManager &FPM,
                     ArrayRef<PassBuilder::PipelineElement>) {
                    if (Name == "hpssa") {
                      FPM.addPass(HPSSAPass());
                      return true;
                    }
                    return false;
                  });
            }};
  }

  // This is the core interface for pass plugins. It guarantees that 'opt' will
  // be able to recognize HelloWorld when added to the pass pipeline on the
  // command line, i.e. via '-passes=hpssa'
  extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
  llvmGetPassPluginInfo() {
    return getHPSSAPluginInfo();
  }