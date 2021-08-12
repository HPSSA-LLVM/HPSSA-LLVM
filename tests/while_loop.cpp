#include <iostream>
using namespace std;
int main() {

// LEVEL 1
entry:
  int a, b;
  cin >> a >> b;
  if (a < 5) {
    goto while_start_label;
  } else {
    goto while_else_label;
  }

// LEVEL 2
while_start_label:
  int c;
  cin >> c;
  int d;
  cin >> d;
  if (d < 5) {
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