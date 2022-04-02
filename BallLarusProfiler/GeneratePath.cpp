#include "headers/GeneratePath.h"
using namespace std;

GP::Graph GP::getAbstractGraph() {
  GP::Graph AG;
  ifstream pathInfo;
  pathInfo.open("AbstractGraph.txt");
  pathInfo >> AG.Entry;
  pathInfo >> AG.Exit;
  // cout << AG.Entry << endl;
  // cout << AG.Exit << endl;
  int bbCount;
  pathInfo >> bbCount;
  for (int i = 0; i < bbCount; i++) {
    string parentBB;
    pathInfo >> parentBB;
    // cout << parentBB << endl;
    int edgeCount;
    pathInfo >> edgeCount;
    // cout << edgeCount << endl;
    for (int j = 0; j < edgeCount; j++) {
      GP::Edge childEdge;
      pathInfo >> childEdge.to;
      pathInfo >> childEdge.val;
      AG.G[parentBB].push_back(childEdge);
      // cout << childEdge.to << endl;
      // cout << childEdge.val << endl;
    }
  }
  return AG;
}

vector<vector<string>> GP::hotPathInfo(int threshold) {
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
  // for (auto [bb, edgeList] : AG.G) {
  //   cout << bb << endl;
  //   for (auto edgeDet : edgeList) {
  //     cout << edgeDet.to << " " << edgeDet.val << endl;
  //   }
  // }

  map<int, vector<string>> idToPath;
  idToPath = GP::regeneratePath(AG, hotPathNum);
  vector<vector<string>> hotPaths;
  for (auto hotId : hotPathNum) {
    hotPaths.push_back(idToPath[hotId]);
  }

  // for (auto v : hotPaths) {
  //   for (auto bb : v)
  //     cout << bb << " ";
  //   cout << endl;
  // }

  return hotPaths;
}

vector<string> GP::numToPath(GP::Graph& AG, int hotPathNum) {
  string parentBB = AG.Entry;
  vector<string> path;
  path.push_back(parentBB);
  while (parentBB != AG.Exit) {
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

map<int, vector<string>> GP::regeneratePath(GP::Graph& AG,
                                            vector<int> hotPath) {
  map<int, vector<string>> result;
  for (auto hotPathNum : hotPath) {
    result[hotPathNum] = GP::numToPath(AG, hotPathNum);
  }
  return result;
}
