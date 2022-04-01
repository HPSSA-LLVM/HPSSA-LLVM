#ifndef LLVM_TRANSFORMS_GeneratePath_GeneratePath_H
#define LLVM_TRANSFORMS_GeneratePath_GeneratePath_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <bits/stdc++.h>
using namespace std;

namespace GP {
struct Edge {
  int val; // value of the edge
  string to;
};

class Graph {
public:
  string Entry;
  string Exit;
  map<string, vector<Edge>> G;
};

Graph getAbstractGraph();
vector<string> numToPath(Graph& AG, int hotPathNum);
map<int, vector<string>> regeneratePath(Graph& AG, vector<int> hotPath);
vector<vector<string>> hotPathInfo(int threshold);

} // namespace GP

#endif