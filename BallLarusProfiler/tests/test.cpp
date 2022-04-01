#include <iostream>
using namespace std;
int main() {
  int a;
  cin >> a;
  int b;
  cin >> b;
  int c = 0;
  for (int i = a; i < b; i++) {
    // if (a < 10) {
    //   break;
    // } else if (b < 5) {
    //   b += 4;
    // } else
    //   a -= 1;
    // b += 1;
    c += rand();
    int d;
    cin >> d;
    if(d > 0) break;
  }
  return 0;
}