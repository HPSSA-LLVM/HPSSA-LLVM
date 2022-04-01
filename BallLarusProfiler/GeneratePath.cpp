#include "headers/GeneratePath.h"
using namespace llvm;
Graph getAbstractGraph() {
  Graph AG;
  ifstream pathInfo;
  pathInfo.open("pathInfo.txt");
  pathInfo >> AG.Entry;
  pathInfo >> AG.Exit;
  int bbCount;
  pathInfo >> bbCount;
  for (int i = 0; i < bbCount; i++) {
    string parentBB;
    pathInfo >> parentBB;
    int edgeCount;
    pathInfo >> edgeCount;
    for (int j = 0; j < edgeCount; j++) {
      Edge childEdge;
      pathInfo >> childEdge.val;
      pathInfo >> childEdge.to;
      AG.G[parentBB].push_back(childEdge);
    }
  }
  return AG;
}

vector<string> numToPath(Graph& AG, int hotPathNum) {
  string parentBB = AG.Entry;
  vector<string> path;
  path.push_back(parentBB);
  while (hotPathNum != 0) {
    Edge MaxEdge;
    MaxEdge.val = -1;
    for (auto BBEdge : AG.G[parentBB]) {
      if (BBEdge.val > hotPathNum)
        continue;
      if (BBEdge.val > MaxEdge.val) {
        MaxEdge = BBEdge;
      }
    }
    hotPathNum -= MaxEdge.val;
    parentBB = MaxEdge.to;
    path.push_back(parentBB);
  }
  return path;
}

map<int, vector<string>> generatePath(Graph& AG, vector<int> hotPath) {
  map<int, vector<string>> result;
  for (auto hotPathNum : hotPath) {
    result[hotPathNum] = numToPath(AG, hotPathNum);
  }
  return result;
}
