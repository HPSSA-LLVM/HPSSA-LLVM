#include "headers/HPSSA.h"
#include <stack>

using namespace llvm;

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {
  ReversePostOrderTraversal<Function *> RPOT(&F); // Expensive to create
  DenseMap<std::pair<PHINode *, BasicBlock *>, bool> isInserted;
  for (BasicBlock *BB : RPOT) {

    // Every New Tau Instruction will be inserted before this Instruction.
    Instruction *TopInstruction = BB->getFirstNonPHI();
    // // Store the phi Encountered.
    for (auto &phi : BB->phis()) {
      // TODO: Get hot path information from Profiler
      // DenseMap<BasicBlock*,bool> vis;
      // TODO: Do not use ID directly

      // Get type of phi
      std::vector<Type *> Tys;
      Tys.push_back(phi.getType());

      // create tau
      Function *tau = Intrinsic::getDeclaration(F.getParent(), 276, Tys);
      std::vector<Value *> Args;
      Args.push_back(dyn_cast<Value>(&phi));
      Args.push_back(dyn_cast<Value>(&phi));
      // Args.push_back(dyn_cast<Value>(&phi));
      // errs()<<tau->isVarArg()<<"\n";
      // CallInst *TAUNode;
      // Insert tau
      CallInst* TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);
      // phi.replaceAllUsesWith(TAUNode);
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