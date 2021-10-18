#include "headers/TConditional.h"
using namespace llvm;
// using namespace std;

PreservedAnalyses TConditionalPass::run(Function &F,
                                        FunctionAnalysisManager &AM) {
  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
  vector<vector<Value *>> allTauArgs;
  ReversePostOrderTraversal<Function *> RPOT(&F);
  Instruction *lastTau = nullptr;
  for (auto B = RPOT.begin(); B != RPOT.end(); ++B) {
    for (Instruction &I : **B) {
      CallInst *CI = dyn_cast<CallInst>(&I);
      if (CI == NULL)
        continue;
      Function *CF = CI->getCalledFunction();
      if ((CF == NULL) ||
          (CF->getIntrinsicID() != Function::lookupIntrinsicID("llvm.tau")))
        continue;
      // CI->dump();
      lastTau = &I;
      vector<Value *> tauArgs;
      // IRBuilder<> builder(CI);
      // Value *first = CI->getOperand(0);
      // Value *second = CI->getOperand(1);
      // Value *newInst = builder.CreateICmp(CmpInst::ICMP_NE, first, second);
      // newInst->dump();
      for (auto &U : CI->operands()) {
        tauArgs.push_back(U);
      }
      // CF is a call instance of tau function
      // CF->dump();
    }
  }
  // No Tau instruction present
  if (lastTau == nullptr)
    return PreservedAnalyses::none();

  // Insert all conditional statements after last tau Instruction
  // while doing RPOT So that all uses are dominated by the user;
  IRBuilder<> builder(lastTau->getNextNode());
  // lastTau->dump();
  Value *first = lastTau->getOperand(0);
  Value *second = lastTau->getOperand(1);
  Value *newInst = builder.CreateICmp(CmpInst::ICMP_NE, first, second);
  lastTau->getParent()->dump();
  // newInst->dump();

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