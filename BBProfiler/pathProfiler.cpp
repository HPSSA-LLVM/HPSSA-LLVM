#include <iostream>
using namespace std;

bool flag = 1;
void counter(int n) {
  FILE *pathData = fopen("pathData.txt", "a");

  if (n == -1) {
    // new path starting from loop header
    fprintf(pathData, "\n");
    fclose(pathData);
    return;
  }
  if (flag) {
    fprintf(pathData, "\n");
    flag = 0;
  }
  fprintf(pathData, "%d ", n);
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