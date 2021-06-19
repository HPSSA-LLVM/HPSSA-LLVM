#include <fstream>
#include <iostream>

using namespace std;

int main() {
  freopen("path.txt", "r", stdin);
  freopen("output.txt", "w", stdout);

  int n;
  cin>>n;

  for(int i = 0;i<n;i++){
	  int b;
	  cin>>b;
	  string block;
	  for(int j = 0;j<b;j++){
		  cin>>block;
		  cout<<"path["<<block<<"].push_back({"<<i<<","<<j<<"});"<<endl;
	  }
  }
  return 0;
}


// map<BasicBlock*,vector<pairs<int,int>> path;
// path[entry].push_back({0,0})


