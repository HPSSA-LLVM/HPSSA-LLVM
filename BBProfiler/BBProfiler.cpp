#include "headers/BBProfiler.h"
using namespace llvm;
using namespace std;

PreservedAnalyses BBProfilerPass::run(Module &M, ModuleAnalysisManager &AM) {

  // void function
  vector<Type *> Params{Type::getInt32Ty(M.getContext())};
  FunctionType *fccType =
      FunctionType::get(Type::getVoidTy(M.getContext()), Params, false);
  Function *sampleFun = Function::Create(fccType, GlobalValue::ExternalLinkage,
                                         "_Z7counteri", &M);

  // create a function type taking a string as an argument
  // Function pointer
  // auto sampleFun = M.getOrInsertFunction("writeSomething",
  // Function::ExternalLinkage, fccType);

  int count = 0;
  FILE *bbMap = fopen("bbMap.txt", "w");

  for (Function &F : M) {
    if (F.isDeclaration())
      continue;

    // Assuming one function only
    if (F.getName() != "main")
      continue;
    SmallVector<std::pair<const BasicBlock *, const BasicBlock *>> result;
    FindFunctionBackedges(F, result); // backedges in this function
    for (auto &BB : F) {
      count += 1;

      fprintf(bbMap, "%d %s %s\n", count, F.getName().str().c_str(),
              BB.getName().str().c_str());

      std::vector<Value *> Args;
      Args.push_back(ConstantInt::get(Type::getInt32Ty(M.getContext()), count));
      // Args.push_back(dyn_cast<Value*>(StringRef("Hello World")));
      // Args.push_back(IRBuilderBase::CreateGlobalString(BB.getName(),M));
      // inserting in the end of the basic block
      CallInst::Create(sampleFun, Args, "", BB.getTerminator());
    }
    for (auto Backedges : result) {
      BasicBlock *from = const_cast<BasicBlock *>(Backedges.first);
      BasicBlock *to = const_cast<BasicBlock *>(Backedges.second);
      BasicBlock *blocker = SplitEdge(from, to);
      std::vector<Value *> Args;
      Args.push_back(
          ConstantInt::get(Type::getInt32Ty(M.getContext()), -1)); // terminate
      CallInst::Create(sampleFun, Args, "", blocker->getTerminator());
    }
  }
  fclose(bbMap);
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
