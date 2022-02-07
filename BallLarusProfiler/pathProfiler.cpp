#include <iostream>
using namespace std;

bool flag = 1;
void counter(int n) {
  FILE *pathData = fopen("pathData.txt", "a");
  fprintf(pathData, "%d\n", n);
  fclose(pathData);
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