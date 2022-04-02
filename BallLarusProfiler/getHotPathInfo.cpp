#include "headers/GeneratePath.h"
using namespace std;

int main(int argc, char** argv) {
  // read AbstractGraph.ag file
  int threshold = atoi(argv[1]);
  vector<vector<string>> hotPathInfo = GP::hotPathInfo(threshold);
  ofstream hpinfo;
  hpinfo.open("hotPathInfo.txt");
  hpinfo << hotPathInfo.size() << endl;
  for (auto bbList : hotPathInfo) {
    hpinfo << bbList.size() << endl;
    for (auto bb : bbList) {
      hpinfo << bb << " ";
    }
    hpinfo << endl;
  }
  hpinfo.close();
}