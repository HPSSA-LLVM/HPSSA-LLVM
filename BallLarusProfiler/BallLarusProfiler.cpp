#include "headers/BallLarusProfiler.h"

using namespace llvm;
using namespace std;

// ! Assuming no of paths <= INT_MAX, Modify if needed

map<std::pair<const BasicBlock*, const BasicBlock*>, bool> isBackedge;
Graph BallLarusProfilerPass::getAbstractGraph(Function& F) {
  BasicBlock* Exit = *po_begin(&F); // ? Exit will be the last block in post
                                    // order iterator. Will it be inefficient?
  Graph AbstractGraph;
  SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
  FindFunctionBackedges(F, result); // backedges in this function
  map<std::pair<const BasicBlock*, const BasicBlock*>, bool> isBackedge;
  for (auto [from, to] : result) {
    isBackedge[make_pair(from, to)] = true;
  }

  uint backedge_ctr = 1;
  for (auto& BB : F) {
    for (auto Succ : successors(&BB)) {
      if (!isBackedge[{&BB, Succ}]) {
        Edge nedge;
        nedge.from = &BB;
        nedge.to = Succ;
        nedge.backedge_number = 0; // ! not a backedge
        AbstractGraph.G[&BB].push_back(nedge);
      } else {
        Edge nedge1, nedge2;
        nedge1.from = &F.getEntryBlock();
        nedge1.to = Succ; // This will be the loop header
        nedge1.backedge_number = backedge_ctr++;
        nedge2.from = &BB;
        nedge2.to = Exit; // Exit Block
        nedge2.backedge_number =
            nedge1.backedge_number; // Correspond to the same backedge
        AbstractGraph.G[nedge1.from].push_back(nedge1);
        AbstractGraph.G[nedge2.from].push_back(nedge2);
      }
    }
  }
  return AbstractGraph;
}

Graph transposeGraph(Graph& AG) {
  Graph TAG;
  for (auto& [BB, BBEdgeList] : AG.G) {
    for (auto& Edge : BBEdgeList) {
      TAG.G[Edge.to].push_back(Edge);
    }
  }
  return TAG;
}

vector<BasicBlock*> TopoSort(Graph& AG, BasicBlock* BBEntry) {
  int cntr = 0;
  map<BasicBlock*, int> visited, start, finish;
  DFS(AG, BBEntry, visited, start, finish, cntr);
  vector<BasicBlock*> BBList;
  for (auto& [BB, outEdge] : AG.G)
    BBList.push_back(BB);
  // Sort in decreasing order of finishing time
  std::sort(BBList.begin(), BBList.end(),
            [&](BasicBlock* BB1, BasicBlock* BB2) {
              return finish[BB1] > finish[BB2];
            });
  return BBList;
}

void DFS(Graph& AG, BasicBlock* BB, map<BasicBlock*, int>& visited,
         map<BasicBlock*, int>& start, map<BasicBlock*, int>& finish,
         int& cntr) {
  visited[BB] = true;
  start[BB] = cntr++;
  for (auto outEdge : AG.G[BB]) {
    if (visited[outEdge.to])
      continue;
    DFS(AG, outEdge.to, visited, start, finish, cntr);
  }
  finish[BB] = cntr++;
}

// void BallLarusProfiler::getEdgeValues(Function& F, Graph& AG) {
//   map<BasicBlock*, int32_t> NumPaths;
//   vector<BasicBlock*> bbInPOrder = TopoSort(AG, F.getEntryBlock());

//   // Post Order Traversal--Reverse Topological
//   for (auto it = bbInPOrder.begin(); it != bbInPOrder.end(); ++it) {
//     BasicBlock* BB = *it;
//     if (AG.G[BB].empty()) { // Leaf Node
//       NumPaths[BB] = 1;
//     } else {
//       NumPaths[BB] = 0;
//       for (auto SuccEdge : AG.G[BB]) {
//         auto Succ = SuccEdge.to;
//         SuccEdge.val = NumPaths[BB];
//         NumPaths[BB] = NumPaths[BB] + NumPaths[Succ];
//       }
//     }
//   }
// }

void getIncValues(Graph& AG) {
  Graph TAG = transposeGraph(AG);
  set<pair<int, BasicBlock*>> inMST, notInMST;
  map<BasicBlock*, int> distance;
  map<BasicBlock*, BasicBlock*> parent;
  bool flag = true;
  for (auto& [BB, BBEdgeList] : AG.G) {
    if (flag) {
      notInMST.insert({0, BB});
      distance[BB] = 0;
      parent[BB] = NULL; // root vertex
      flag = false;
    } else {
      notInMST.insert({INT_MAX, BB});
      distance[BB] = INT_MAX;
    }
  }

  while (!notInMST.empty()) {
    int BBDistance = notInMST.begin()->first;
    BasicBlock* BB = notInMST.begin()->second;
    // Use parent information here to update distance
    inMST.insert({BBDistance, BB});
    notInMST.erase(notInMST.begin());
    for (auto& SuccEdge : AG.G[BB]) {
      auto Succ = SuccEdge.to;
      auto EdgeVal = SuccEdge.val;
      if ((BBDistance + EdgeVal) <= distance[Succ]) {
        notInMST.erase({distance[Succ], Succ});
        distance[Succ] = BBDistance + EdgeVal;
        parent[Succ] = BB;
        notInMST.insert({distance[Succ], Succ});
      }
    }
  }
}
// ? Should we add the edge exit -> entry for mst

// void BallLarusProfilerPass::convertToDAG(Function& F) {
// SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
// FindFunctionBackedges(F, result); // backedges in this function
// }

void BallLarusProfilerPass::getAnalysisUsage(AnalysisUsage& Info) {
  Info.addRequired<
      UnifyFunctionExitNodesLegacyPass>(); // This is required as the paper
                                           // requires exactly one exit block
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