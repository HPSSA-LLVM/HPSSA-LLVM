#include "headers/BBProfiler.h"
using namespace llvm;
using namespace std;
// static LLVMContext myContext;

void writeSomething() {
  errs() << "Awesome"
         << "\n";
}

PreservedAnalyses BBProfilerPass::run(Module &M, ModuleAnalysisManager &AM) {

  // void function
  vector<Type *> Params { Type::getInt32Ty(M.getContext()) };
  FunctionType *fccType =
      FunctionType::get(Type::getVoidTy(M.getContext()),Params,false);
  Function *sampleFun = Function::Create(fccType, GlobalValue::ExternalLinkage, "_Z7counteri", &M);

// create a function type taking a string as an argument

  // Function pointer
  // auto sampleFun = M.getOrInsertFunction("writeSomething", Function::ExternalLinkage, fccType);

  int count = 0;
  for (auto &F : M) {
    count +=1;
    for (auto &BB : F) {
      std::vector<Value *> Args;
      Args.push_back(ConstantInt::get(Type::getInt32Ty(M.getContext()),count));
      // Args.push_back(dyn_cast<Value*>(StringRef("Hello World")));
      // Args.push_back(IRBuilderBase::CreateGlobalString(BB.getName(),M));
      // inserting in the end of the basic block
    
      CallInst::Create(sampleFun, Args, "", BB.getTerminator());
      count++;
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
                    MPM.addPass(BBProfilerPass());
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
