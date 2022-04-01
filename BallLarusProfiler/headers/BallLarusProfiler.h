#ifndef LLVM_TRANSFORMS_BBProfiler_BBProfiler_H
#define LLVM_TRANSFORMS_BBProfiler_BBProfiler_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Dominators.h"
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
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/UnifyFunctionExitNodes.h"
#include <bits/stdc++.h>
using namespace std;
namespace llvm {

struct Edge {
  int val; // value of the edge
  int inc;  // the value needed to be incremented with, if a chord edge
  uint backedge_number;
  bool chordEdge; // chord edge of the minimal spanning tree
  BasicBlock* from;
  BasicBlock* to;
};

class Graph {
public:
  BasicBlock* Entry;
  BasicBlock* Exit;
  map<BasicBlock*, vector<Edge>> G;
  // map<std::pair<BasicBlock*, BasicBlock*>, vector<Edge>> Edges;
  map<uint, std::pair<Edge, Edge>> Backedge;
  // map<std::pair<BasicBlock*, BasicBlock*>, uint> BackedgeNumber;

  BasicBlock* getEntryBlock() { return Entry; }
  BasicBlock* getExitBlock() { return Exit; }
};
class BallLarusProfilerPass : public PassInfoMixin<BallLarusProfilerPass> {
public:
  void dumpAbstractGraph(Graph& AG);
  void getAnalysisUsage(AnalysisUsage& Info);
  Graph getAbstractGraph(Function& F);
  void getEdgeValues(Function& F, Graph& AG);
  PreservedAnalyses run(Function& F, FunctionAnalysisManager& AM);
  void insertInc(Module* M, Instruction* insertBefore, GlobalVariable* gVar, int inc); 
  void regInc(Function* regIncF, GlobalVariable* gVar, Instruction* insertBefore, Module* M, bool dump = false);
  void resetInc(Module* M, Instruction* insertBefore, GlobalVariable* gVar, int resetValue);
};

} // namespace llvm

#endif // LLVM_TRANSFORMS_BBProfiler_BBProfiler_H