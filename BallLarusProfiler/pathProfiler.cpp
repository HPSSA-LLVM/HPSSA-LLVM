#include <bits/stdc++.h>
using namespace std;

map<int, int> pathCounter;
void counter(int n, int dump) {
  pathCounter[n]++;
  if (dump) {
    ofstream pathStream;
    pathStream.open("pathData.txt", ios::app);
    for (auto path : pathCounter) {
      pathStream << abs(path.first) << "\t" << path.second << endl;
    }
    pathStream.close();
  }
}