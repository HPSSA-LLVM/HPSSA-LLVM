#include <iostream>
using namespace std;

bool flag = 1;
vector<bool> visited;
void counter(int n) {
  FILE *pathData = fopen("pathData.txt", "a");
  if(flag){
	  fprintf(pathData,"\n");
	  flag = 0;
  }
  fprintf(pathData,"%d ",n);
  fclose(pathData);
}

bool flag2 = 1;
void BBname(s,){
  FILE* bbMap = fopen("bbMap.txt","a");
  if(flag2){
	  fprintf(bbMap,"\n");
	  flag2 = 0;
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
 * /