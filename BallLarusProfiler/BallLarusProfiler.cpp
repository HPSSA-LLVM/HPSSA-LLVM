#include "headers/BallLarusProfiler.h"

using namespace llvm;
using namespace std;

// ! Assuming no of paths <= INT_MAX, Modify if needed

BasicBlock* Exit;
map<std::pair<const BasicBlock*, const BasicBlock*>, bool> isBackedge;
Graph BallLarusProfilerPass::getAbstractGraph(Function& F) {
  for (auto& BB : F) {
    if (!succ_empty(&BB))
      continue;
    for (auto& I : BB) {
      if (auto* RI = dyn_cast<ReturnInst>(&I)) {
        Exit = &BB;
        break;
      }
    }
  }
  // BasicBlock* Exit = *po_begin(&F); // ? Exit will be the last block in post
  // order iterator. Will it be inefficient?
  Graph AbstractGraph;

  AbstractGraph.Entry = &F.getEntryBlock();
  AbstractGraph.Exit = Exit;

  SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
  FindFunctionBackedges(F, result); // backedges in this function

  map<std::pair<const BasicBlock*, const BasicBlock*>, bool> isBackedge;
  for (auto [from, to] : result) {
    isBackedge[make_pair(from, to)] = true;
  }

  uint backedge_ctr = 1;
  for (auto& BB : F) {
    if (succ_empty(&BB) && &BB != Exit) { // Unreachable block
      Edge nedge;
      nedge.from = &BB;
      nedge.to = Exit;
      nedge.backedge_number = 0;
      AbstractGraph.G[&BB].push_back(nedge);
    }
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
        AbstractGraph.Backedge[nedge1.backedge_number] = {nedge1, nedge2};
      }
    }
  }
  return AbstractGraph;
}

void BallLarusProfilerPass::dumpAbstractGraph(Graph& AG) {
  ofstream abstream;
  abstream.open("AbstractGraph.ag");

  abstream << (string)AG.Entry->getName() << " " << (string)AG.Exit->getName()
           << endl;
  abstream << AG.G.size() << endl;

  for (auto& [BB, Edges] : AG.G) {
    abstream << (string)BB->getName() << " ";
    abstream << Edges.size() << endl;
    for (auto& E : Edges) {
      abstream << (string)E.to->getName() << " " << E.val << " ";
    }
    abstream << endl;
  }

  abstream.close();
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

void BallLarusProfilerPass::getEdgeValues(Function& F, Graph& AG) {

  map<BasicBlock*, int32_t> NumPaths;
  vector<BasicBlock*> bbInPOrder = TopoSort(AG, &F.getEntryBlock());

  errs() << "Basic Blocks in Topological order: ";
  for (auto& BB : bbInPOrder)
    errs() << BB->getName() << " ";
  errs() << "\n";

  //   Post Order Traversal--Reverse Topological
  for (auto it = bbInPOrder.rbegin(); it != bbInPOrder.rend(); ++it) {
    BasicBlock* BB = *it;

    if (AG.G[BB].empty()) { // Leaf Node
      NumPaths[BB] = 1;
    } else {
      NumPaths[BB] = 0;
      for (auto& SuccEdge : AG.G[BB]) {
        auto Succ = SuccEdge.to;
        SuccEdge.val = NumPaths[BB];
        NumPaths[BB] = NumPaths[BB] + NumPaths[Succ];
      }
    }
  }
}

map<pair<BasicBlock*, BasicBlock*>, int> getIncValues(Graph& AG, Function& F) {
  BasicBlock& Entry = F.getEntryBlock();

  Edge nedge;
  nedge.backedge_number = 0; // ! See to it
  nedge.from = Exit;
  nedge.to = &Entry;
  nedge.val = 0; // used in figure 7 of Paper
  AG.G[Exit].push_back(nedge);

  Graph TAG = transposeGraph(AG);

  set<pair<int, BasicBlock*>, greater<pair<int, BasicBlock*>>>
      notInMST; // set sorted in descending order
  set<BasicBlock*> inMST;
  map<BasicBlock*, int> distance;
  map<BasicBlock*, pair<BasicBlock*, bool>>
      parent; // true: positive sign, false: negative sign

  map<pair<BasicBlock*, BasicBlock*>, int> Inc; // for each vertex pair

  bool flag = true;
  for (auto& [BB, BBEdgeList] : AG.G) {
    if (flag) {
      notInMST.insert({0, BB});
      distance[BB] = 0;
      parent[BB] = {NULL, true}; // root vertex
      flag = false;
    } else {
      notInMST.insert({INT_MIN, BB});
      distance[BB] = INT_MIN;
    }
  }

  while (!notInMST.empty()) {
    int BBDistance = notInMST.begin()->first;
    BasicBlock* BB = notInMST.begin()->second;

    //==================Updating Inc================//
    for (auto BBMST : inMST) {
      if (parent[BB].first == BBMST) {
        // ? unique numbering but negative numbering
        Inc[{BBMST, BB}] = (parent[BB].second ? distance[BB] : -distance[BB]);
        Inc[{BB, BBMST}] = -Inc[{BBMST, BB}];
      } else {
        Inc[{BBMST, BB}] = Inc[{BBMST, parent[BB].first}] +
                           (parent[BB].second ? distance[BB] : -distance[BB]);
        Inc[{BB, BBMST}] = -Inc[{BBMST, BB}];
      }
    }

    // Creating MST

    inMST.insert(BB);
    notInMST.erase(notInMST.begin());
    for (auto& SuccEdge : AG.G[BB]) {
      auto Succ = SuccEdge.to;
      auto EdgeVal = SuccEdge.val;

      if (inMST.find(Succ) != inMST.end())
        continue;

      if (EdgeVal > distance[Succ]) {
        notInMST.erase({distance[Succ], Succ});
        distance[Succ] = EdgeVal;
        parent[Succ] = {BB, true};
        notInMST.insert({distance[Succ], Succ});
      }
    }

    for (auto& SuccEdge : TAG.G[BB]) {
      auto Succ = SuccEdge.from; // from and to is maintained in edge struct
      auto EdgeVal = SuccEdge.val;

      if (inMST.find(Succ) != inMST.end())
        continue;

      if (EdgeVal > distance[Succ]) {
        notInMST.erase({distance[Succ], Succ});
        distance[Succ] = EdgeVal;
        parent[Succ] = {BB, false};
        notInMST.insert({distance[Succ], Succ});
      }
    }
  }

  for (auto& [BB, BBEdgeList] : AG.G) {
    if (parent[BB].first == NULL)
      continue;
    // errs() << parent[BB].first->getName() << " -> " << BB->getName() << "\n";
  }

  for (auto& [BB, BBEdgeList] : AG.G) {
    for (auto& Edge : BBEdgeList) {
      Edge.inc = Inc[{Edge.from, Edge.to}];

      if (Edge.from != parent[Edge.to].first &&
          parent[Edge.from].first != Edge.to) {
        Edge.chordEdge = true;
      } else
        Edge.chordEdge = false;
    }
  }
  return Inc;
}

void BallLarusProfilerPass::insertInc(Module* M, Instruction* insertBefore,
                                      GlobalVariable* gVar, int inc) {

  IRBuilder<> Builder(M->getContext());
  Builder.SetInsertPoint(insertBefore);

  BasicBlock* BB = insertBefore->getParent();
  Value* load = Builder.CreateLoad(Type::getInt32Ty(BB->getContext()), gVar);
  Value* newInst = Builder.CreateAdd(load, Builder.getInt32(inc));
  Value* store = Builder.CreateStore(newInst, gVar);
}

void BallLarusProfilerPass::resetInc(Module* M, Instruction* insertBefore,
                                     GlobalVariable* gVar, int resetValue) {

  IRBuilder<> Builder(M->getContext());
  Builder.SetInsertPoint(insertBefore);

  BasicBlock* BB = insertBefore->getParent();
  Value* reset =
      ConstantInt::get(Type::getInt32Ty(BB->getContext()), resetValue);
  Value* store = Builder.CreateStore(reset, gVar);
}

void BallLarusProfilerPass::regInc(Function* regIncF, GlobalVariable* gVar,
                                   Instruction* insertBefore, Module* M,
                                   bool dump) {

  IRBuilder<> Builder(M->getContext());
  Builder.SetInsertPoint(insertBefore);

  auto BB = insertBefore->getParent();
  Value* load = Builder.CreateLoad(Type::getInt32Ty(BB->getContext()), gVar);

  std::vector<Value*> Args;
  Args.push_back(load);

  Value* todump = ConstantInt::get(Type::getInt32Ty(M->getContext()), dump);
  Args.push_back(todump);

  // inserting in the end of the basic block
  CallInst::Create(regIncF, Args, "", insertBefore);
}

// ? Should we add the edge exit -> entry for mst

PreservedAnalyses BallLarusProfilerPass::run(Function& F,
                                             FunctionAnalysisManager& AM) {

  if (F.isDeclaration())
    return PreservedAnalyses::none();

  // Assuming one function only
  if (F.getName() != "main")
    return PreservedAnalyses::none();

  auto M = F.getParent();

  vector<Type*> Params{Type::getInt32Ty(M->getContext()),
                       Type::getInt32Ty(M->getContext())};
  FunctionType* fccType =
      FunctionType::get(Type::getVoidTy(M->getContext()), Params, false);

  Function* counterFunc = Function::Create(
      fccType, GlobalValue::ExternalLinkage, "_Z7counterii", M);

  Graph AbstractGraph = getAbstractGraph(F);
  getEdgeValues(F, AbstractGraph);
  // for (auto& [BB, EdgeList] : AbstractGraph.G) {
  //   for (auto& Edge : EdgeList) {
  //     errs() << (Edge.from)->getName() << " " << (Edge.to)->getName() << " "
  //            << (Edge.val) << "\n";
  //   }
  // }
  vector<Edge> chords; // all the edges here are chord edges
  auto Inc = getIncValues(AbstractGraph, F); // got annotated edges also
  for (auto& [BBPair, BBVal] : Inc) {
    // errs() << BBPair.first->getName() << " -> " << BBPair.second->getName()
    //        << " = " << BBVal << "\n";
  }
  for (auto& [BB, EdgeList] : AbstractGraph.G) {
    for (auto& Edge : EdgeList) {
      if (Edge.chordEdge) {
        chords.push_back(Edge);
      }
      errs() << (Edge.from)->getName() << " " << (Edge.to)->getName() << " "
             << (Edge.inc) << " " << (Edge.chordEdge ? "true" : "false")
             << "\n";
    }
  }
  IRBuilder<> Builder(M->getContext());
  // Create a global counter
  string counterName = "counter";
  M->getOrInsertGlobal(counterName, Builder.getInt32Ty());
  GlobalVariable* gVar = M->getNamedGlobal(counterName);
  gVar->setInitializer(ConstantInt::get(Type::getInt32Ty(M->getContext()),
                                        0)); // initialize r to 0

  for (auto chord : chords) {
    if (chord.backedge_number == 0) {       //  not a backedge
      if (chord.to == &F.getEntryBlock()) { // Exit to Entry edge
        insertInc(M, Exit->getTerminator(), gVar, Inc[{chord.from, chord.to}]);
        continue;
        ;
      }
      BasicBlock* instrumentBlock = SplitEdge(chord.from, chord.to);
      insertInc(M, instrumentBlock->getTerminator(), gVar,
                Inc[{chord.from, chord.to}]);
    } else { // is a backedge
      auto [edge1, edge2] = AbstractGraph.Backedge[chord.backedge_number];
      // edge1 is entry to loop header and edge2 is loop tail to exit
      BasicBlock* instrumentBlock = SplitEdge(edge2.from, edge1.to);

      int inc_value = Inc[{edge1.from, edge1.to}];
      int reset_value = Inc[{edge2.from, edge2.to}];
      insertInc(M, instrumentBlock->getTerminator(), gVar, inc_value);
      regInc(counterFunc, gVar, instrumentBlock->getTerminator(), M);
      resetInc(M, instrumentBlock->getTerminator(), gVar, reset_value);
    }
  }

  regInc(counterFunc, gVar, Exit->getTerminator(), M, true);
  dumpAbstractGraph(AbstractGraph); // to regenerate the path

  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getBallLarusProfilerPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "BallLarusProfiler", "v0.1",
          [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager& FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "blprofiler") {
                    FPM.addPass(UnifyFunctionExitNodesPass());
                    FPM.addPass(BallLarusProfilerPass());
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