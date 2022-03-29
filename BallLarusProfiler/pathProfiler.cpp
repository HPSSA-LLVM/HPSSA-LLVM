#include <bits/stdc++.h>
using namespace std;

map<int, int> pathCounter;
void counter(int n, bool dump) {
  pathCounter[n]++;
  if(dump) {
    FILE* pathData = fopen("pathData.txt", "a");
    for(auto [pathNum, freq]: pathCounter) {
      fprintf(pathData, "%d\t%d\n", pathNum, freq);
    }
    fclose(pathData);
  }
}

/**
 * Read pathData.txt
 * Create a map with hash of path as key -> count of path
 * Hash is calculated one by one, passing .....
 * Create another map hash of path --> sequence of basic block
 * Use both maps
 * Optionally read bbMap.txt : output name directly
 *        HPSSA.cpp -> directly
 */