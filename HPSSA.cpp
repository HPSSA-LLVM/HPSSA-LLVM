#include "headers/HPSSA.h"
#include <stack>
using namespace llvm;


// ? How to Get hot path information from Profiler

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {
  ReversePostOrderTraversal<Function *> RPOT(&F); // Expensive to create
  // DenseMap<std::pair<PHINode *, BasicBlock *>, bool> isInserted;
  for (BasicBlock *BB : RPOT) {
    Instruction *TopInstruction = BB->getFirstNonPHI();
    for (auto &phi : BB->phis()) {
      // DenseMap<BasicBlock*,bool> vis;
      std::vector<Type *> Tys;
      Tys.push_back(phi.getType());

      // create tau function
      Function *tau = Intrinsic::getDeclaration(
          F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);
      std::vector<Value *> Args;
      Args.push_back(dyn_cast<Value>(&phi));
      Args.push_back(dyn_cast<Value>(&phi));

      // Create Tau Call instance
      CallInst *TAUNode;
      TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

      // Insert Tau
      for (auto phi_user : phi.users()) {
        // errs() << *phi_user << "\n";
        if (phi_user != TAUNode) {
          phi_user->replaceUsesOfWith(&phi, TAUNode);
        }
      }
    }
  }

  return PreservedAnalyses::none();
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