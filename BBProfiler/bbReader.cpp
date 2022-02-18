#include <bits/stdc++.h>

using namespace std;

int main(int argc, char* argv[]) {

  if (argc < 1) {
    cout << "Provide the threshold\n";
    exit(-1);
  }
  long long threshold = atol(argv[1]);
  ifstream pathData;
  pathData.open("pathData.txt");

  ifstream bbMap;
  bbMap.open("bbMap.txt");

  // map[hash -> pathCount]
  unordered_map<long long, long long> pathCount;
  // map[hash -> path sequence]
  unordered_map<long long, vector<long long>> pathSequence;
  // map[block number -> name]
  unordered_map<long long, string> id_to_blockName;

  // hash the whole vector
  hash<string> hash_string;

  // get the path data
  string line;
  while (getline(pathData, line)) {
    // all values stored in line
    if (line.size() == 0)
      continue;
    stringstream ss(line);
    vector<long long> v;
    long long bbId;
    while (ss >> bbId) {
      v.push_back(bbId);
    }
    long long pathId = hash_string(line);
    pathCount[pathId] += 1;
    pathSequence[pathId] = v; // alternatively check whether the key exists
  }

  // get block names
  while (getline(bbMap, line)) {
    if (line.size() == 0)
      continue;
    stringstream ss(line);
    long long bbId;
    string FName, bbName;
    ss >> bbId >> FName >> bbName;
    id_to_blockName[bbId] = bbName;
  }

  // print information
  ofstream pfinfo;
  pfinfo.open("profileInfo.txt");

  // get no of hot path
  long long hotPathCount = 0;
  for (auto [pathId, count] : pathCount) {
    if (count >= threshold) {
      hotPathCount += 1;
    }
  }
  // count of hot path
  pfinfo << hotPathCount << endl;
  for (auto [pathId, count] : pathCount) {
    if (count >= threshold) {
      // no of basic blocks
      pfinfo << pathSequence[pathId].size() << endl;
      for (auto bbId : pathSequence[pathId]) {
        pfinfo << id_to_blockName[bbId] << " ";
      }
      pfinfo << endl;
    }
  }

  // close streams
  pathData.close();
  bbMap.close();
  pfinfo.close();
}