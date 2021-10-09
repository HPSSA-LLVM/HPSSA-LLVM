#include <iostream>
using namespace std;
int main() {
  int a;
  cin >> a;
  int b;
  cin >> b;
  for (int i = 0; i < 5; i++) {
    if (a < 10) {
      break;
    } else if (b < 5) {
      b += 4;
    } else
      a -= 1;
    b += 1;
  }
  return 0;
}