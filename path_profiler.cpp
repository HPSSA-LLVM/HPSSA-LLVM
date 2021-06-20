#include <fstream>
#include <iostream>
#include<bits/stdc++.h>
using namespace std;

int main() {

  //////////////////
  freopen("path.txt", "r", stdin);
  map<string, vector<pair<int,int>>> Paths;
  vector<vector<string>> PathList;
  int n;
  cin>>n;
  for(int i = 0; i < n; i++) {
    vector<string> path;
    int numNodes;
    cin>>numNodes;
    string node;
    for(int j = 0; j < numNodes; j++){
      cin>>node;
      path.push_back(node);
      Paths[node].push_back({i,j});
    }
    PathList.push_back(path);
  }
  for(auto it = Paths.begin(); it != Paths.end(); ++it) {
	  cout<<it->first<<" ";
	  for(auto j: it->second) {
		  cout<<j.first<<" "<<j.second<<" ";
	  }
	  cout<<"\n";
  }
  for(auto it: PathList){
	  for(auto it2: it){
		  cout<<it2<<" ";
	  }
	  cout<<"\n";
  }
}


// map<BasicBlock*,vector<pairs<int,int>> path;
// path[entry].push_back({0,0})


