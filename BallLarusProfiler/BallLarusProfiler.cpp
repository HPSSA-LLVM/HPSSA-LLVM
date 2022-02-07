#include "headers/BallLarusProfiler.h"

using namespace llvm;
using namespace std;

PreservedAnalyses BallLarusProfilerPass::run(Module &M,
                                             ModuleAnalysisManager &AM) {
  // ! Assuming the function to be a DAG for now
  // ! Not optmized as of now
  for (auto &F : M) {
    if (F.isDeclaration())
      continue;

    // Assuming one function only
    if (F.getName() != "main")
      continue;

    // Inside main function
    IRBuilder<> Builder(M.getContext());
    // Create a global counter
    string counterName = "counter";
    M.getOrInsertGlobal(counterName, Builder.getInt32Ty());
    GlobalVariable *gVar = M.getNamedGlobal(counterName);
    gVar->setInitializer(ConstantInt::get(Type::getInt32Ty(M.getContext()),
                                          0)); // initialize r to 0
    // Printf function
    vector<Type *> Params{Type::getInt32Ty(M.getContext())};
    FunctionType *fccType =
        FunctionType::get(Type::getVoidTy(M.getContext()), Params, false);
    Function *sampleFun = Function::Create(
        fccType, GlobalValue::ExternalLinkage, "_Z7counteri", &M);

    map<BasicBlock *, int32_t> NumPaths;

    for (auto it = po_begin(&F); it != po_end(&F);
         ++it) { // Post Order Traversal--Reverse Topologiacl
      BasicBlock *BB = *it;
      if (succ_empty(BB)) { // Leaf Node
        NumPaths[BB] = 1;
        std::vector<Value *> Args;
        Builder.SetInsertPoint(BB->getTerminator());
        Value *load =
            Builder.CreateLoad(Type::getInt32Ty(BB->getContext()), gVar);
        Args.push_back(load);
        // inserting in the end of the basic block
        CallInst::Create(sampleFun, Args, "", BB->getTerminator());
      } else {
        NumPaths[BB] = 0;
        for (auto Succ : successors(BB)) {
          BasicBlock *from = const_cast<BasicBlock *>(BB);
          BasicBlock *to = const_cast<BasicBlock *>(
              Succ); // ! Will this cast cause error in future?
          BasicBlock *instrument = SplitEdge(from, to);
          Builder.SetInsertPoint(instrument->getTerminator());
          Value *load = Builder.CreateLoad(
              Type::getInt32Ty(instrument->getContext()), gVar);
          Value *newInst =
              Builder.CreateAdd(load, Builder.getInt32(NumPaths[BB]));
          Value *store = Builder.CreateStore(newInst, gVar);
          NumPaths[BB] = NumPaths[BB] + NumPaths[Succ];
        }
      }
    }
  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getBallLarusProfilerPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "BallLarusProfiler", "v0.1",
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager &MPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "blprofiler") {
                    MPM.addPass(BallLarusProfilerPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize  BallLarusProfiler Pass when added to the pass
// pipeline on the command line, i.e. via '-passes= blprofiler'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getBallLarusProfilerPluginInfo();
}