#include "headers/GeneratePath.h"
using namespace llvm;

GP::Graph getAbstractGraph() {
  GP::Graph AG;
  ifstream pathInfo;
  pathInfo.open("AbstractGraph.txt");
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
      GP::Edge childEdge;
      pathInfo >> childEdge.val;
      pathInfo >> childEdge.to;
      AG.G[parentBB].push_back(childEdge);
    }
  }
  return AG;
}

vector<vector<string>> hotPathInfo(int threshold) {
  ifstream hpinfo;
  hpinfo.open("pathData.txt");
  int pathId, pathFreq;
  map<int, int> idToCount;
  int total = 0;
  while (hpinfo >> pathId >> pathFreq) {
    idToCount[pathId] += pathFreq;
    total += pathFreq;
  }

  vector<int> hotPathNum;
  for (auto& [id, count] : idToCount) {
    if (count < (total * threshold) / 100)
      continue;
    hotPathNum.push_back(id);
  }

  GP::Graph AG = GP::getAbstractGraph();
  map<int, vector<string>> idToPath;
  idToPath = GP::regeneratePath(AG, hotPathNum);
  vector<vector<string>> hotPaths;
  for (auto hotId : hotPathNum) {
    hotPaths.push_back(idToPath[hotId]);
  }
  return hotPaths;
}

vector<string> numToPath(GP::Graph& AG, int hotPathNum) {
  string parentBB = AG.Entry;
  vector<string> path;
  path.push_back(parentBB);
  while (hotPathNum != 0) {
    GP::Edge MaxEdge;
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

map<int, vector<string>> regeneratePath(GP::Graph& AG, vector<int> hotPath) {
  map<int, vector<string>> result;
  for (auto hotPathNum : hotPath) {
    result[hotPathNum] = GP::numToPath(AG, hotPathNum);
  }
  return result;
}
