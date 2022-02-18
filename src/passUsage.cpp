#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "../include/HPSSA.h"
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

class ExamplePass : public PassInfoMixin<ExamplePass> {
public:
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& AM);
};

PreservedAnalyses ExamplePass::run(Function& F, FunctionAnalysisManager& AM) {
  HPSSAPass hpssaUtil;
  if (F.getName() == "main") {
    hpssaUtil.run(F, AM);
    std::vector<Instruction *> TauInsts = hpssaUtil.getAllTauInstrunctions(F);
    std::cout << "\t\tTotal Tau Instructions : " << TauInsts.size() << "\n";
  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getExampleUseHPSSAInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HPSSA Usage", "v1.0", [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager& FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "usehpssa") {
                    FPM.addPass(ExamplePass());
                    return true;
                  }
                  return false;
                });
          }};
}

extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getExampleUseHPSSAInfo();
}

} // namespace llvm