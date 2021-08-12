#include <iostream>
using namespace std;
int main() {

// LEVEL 0
entry:
  int a, b;
  cin >> a >> b;
  if (a>2) {
    goto entry_1;
  }
  if (a< -1) {
    goto entry_2;
  }
  goto entry_3;

entry_1:
  a *= 5;
  goto while_start_label;

entry_2:
  a /= 4;
  goto while_start_label;

entry_3:
  a -= 7;
  goto while_start_label;

// LEVEL 1
// merge_block:
//   a -= 2;
//   // if (a < 5) {
//   //   goto while_start_label;
//   // } else {
//   //   goto while_else_label;
//   // }
//   goto

// LEVEL 2
while_start_label:
  a -= 4;
  int c;
  cin >> c;
  int d;
  cin >> d;
  if (a < 5) {
    // LEVEL 3
  while_if_label:
    d *= 5;
    a *= 2;
    goto while_end_label;

  } else {
    // LEVEL 3
  while_else_label:
    d *= 3;
    a *= 6;
    goto while_end_label;
  }

// LEVEL 4
while_end_label:
  d -= 4;
  c--;
  if (c>0)
    goto while_start_label;

  // LEVEL 5
  return 0;
}