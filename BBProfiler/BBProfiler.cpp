#include "headers/BBProfiler.h"
using namespace llvm;
using namespace std;
static LLVMContext myContext;

void writeSomething() {
    std::cout << "Awesome" << std::endl;
} 

PreservedAnalyses  BBProfilerPass::run(Module &M, ModuleAnalysisManager &AM) {
    // Void type
    llvm::FunctionType* fccType = llvm::FunctionType::get(llvm::Type::getVoidTy(myContext), false);

    // External - c++
    auto fcc = M.getOrInsertFunction("writeSomething", fccType);

  for(auto &F: M) {
    for(auto &BB: F) {
        std::vector<Value *> Args;
        // llvm::dyn_cast
        // StringRef BBName = BB.getName();
        // char* str = (char*)malloc((BBName.size()+1)*sizeof(char));
        // const char* data = BBName.data();
        // for(int i = 0; i < BBName.size(); i++) {
        //   str[i] = data[i];
        // }
        // str[BBName.size()] = '\0';
        
        // Args.push_back(dyn_cast<Value>(str));
        // Call
        std::vector<Value*> emptyArgs;
        CallInst::Create(fcc, makeArrayRef(emptyArgs));
    }
  }
    return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getBBProfilerPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "BBProfiler", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "bbprofiler") {
                    MPM.addPass( BBProfilerPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize  BBProfiler Pass when added to the pass pipeline on the
// command line, i.e. via '-passes= BBProfiler'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getBBProfilerPluginInfo();
}
