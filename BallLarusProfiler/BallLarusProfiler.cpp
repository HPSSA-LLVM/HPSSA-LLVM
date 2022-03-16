#include "headers/BallLarusProfiler.h"

using namespace llvm;
using namespace std;

map<std::pair<const BasicBlock*,const BasicBlock*>, bool> isBackedge;
Graph BallLarusProfilerPass::getAbstractGraph(Function& F) {
  BasicBlock* Exit = *po_begin(&F); // ? Exit will be the last block in post order iterator. Will it be inefficient?
  Graph AbstractGraph;
  SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
  FindFunctionBackedges(F, result); // backedges in this function
  map<std::pair<const BasicBlock*,const BasicBlock*>, bool> isBackedge;
  for(auto [from, to]: result) {
    isBackedge[make_pair(from, to)] = true;
  }

  uint backedge_ctr = 1;
  for(auto& BB: F) {
    for(auto Succ: successors(&BB)) {
      if(!isBackedge[{&BB, Succ}]) {
        Edge nedge;
        nedge.from = &BB;
        nedge.to = Succ;
        nedge.backedge_number = 0; // ! not a backedge
        AbstractGraph.G[&BB].push_back(nedge);
      }
      else {
        Edge nedge1, nedge2;
        nedge1.from = &F.getEntryBlock();
        nedge1.to = Succ; // This will be the loop header
        nedge1.backedge_number = backedge_ctr++;
        nedge2.from = &BB;
        nedge2.to = Exit; // Exit Block
        nedge2.backedge_number = nedge1.backedge_number; // Correspond to the same backedge
        AbstractGraph.G[nedge1.from].push_back(nedge1);
        AbstractGraph.G[nedge2.from].push_back(nedge2);
      }
    }
  }
  return AbstractGraph;
}
void DFS(BasicBlock* BB)
void DFSHelper() {

}
void BallLarusProfiler::getEdgeValues(Function &F, Graph &AG) {
  map<BasicBlock*, int32_t> NumPaths;

  for (auto it = po_begin(&F); it != po_end(&F);
        ++it) { // Post Order Traversal--Reverse Topologiacl
    BasicBlock* BB = *it;
    if (succ_empty(BB)) { // Leaf Node
      NumPaths[BB] = 1;
    } else {
      NumPaths[BB] = 0;
      for (auto Succ : successors(BB)) {
        if(!isBackedge[{BB, Succ}]) {
          AG.Edges[{BB, Succ}] // think what to do??
        }
        NumPaths[BB] = NumPaths[BB] + NumPaths[Succ];
      }
    }
  }
}

// void BallLarusProfilerPass::convertToDAG(Function& F) {
  // SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
  // FindFunctionBackedges(F, result); // backedges in this function
// }

void BallLarusProfilerPass::getAnalysisUsage(AnalysisUsage& Info) {
  Info.addRequired<UnifyFunctionExitNodesLegacyPass>(); // This is required as the paper requires exactly one exit block
  // Used legacy pass for now, will change to new pass
}

PreservedAnalyses BallLarusProfilerPass::run(Module& M,
                                             ModuleAnalysisManager& AM) {
  // ! Assuming the function to be a DAG for now
  // ! Not optmized as of now
  for (auto& F : M) {
    if (F.isDeclaration())
      continue;

    // Assuming one function only
    if (F.getName() != "main")
      continue;

    
    Graph AbstractGraph = getAbstractGraph(F);
    getEdgeValues(F, AbstractGraph);

    // Inside main function
    IRBuilder<> Builder(M.getContext());
    // Create a global counter
    string counterName = "counter";
    M.getOrInsertGlobal(counterName, Builder.getInt32Ty());
    GlobalVariable* gVar = M.getNamedGlobal(counterName);
    gVar->setInitializer(ConstantInt::get(Type::getInt32Ty(M.getContext()),
                                          0)); // initialize r to 0
    // Printf function
    vector<Type*> Params{Type::getInt32Ty(M.getContext())};
    FunctionType* fccType =
        FunctionType::get(Type::getVoidTy(M.getContext()), Params, false);
    Function* sampleFun = Function::Create(
        fccType, GlobalValue::ExternalLinkage, "_Z7counteri", &M);

  }
  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getBallLarusProfilerPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "BallLarusProfiler", "v0.1",
          [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, ModulePassManager& MPM,
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