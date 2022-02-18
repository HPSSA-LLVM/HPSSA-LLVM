#include <iostream>

// Profile Info
// 1
// 6
// entry for.body for.body7.lr.ph for.body7 for.cond.cleanup6 for.cond.cleanup: 


int main() {
  int a, b, c, d, x, y, z = 0;
  std::cin >> a >> b >> c >> d;
  for (auto i = 0; i <= a; i++) {
    x = x + i;
    if (i + x > 90) {
      x = x - 100;
    } else {
      x = x + 3 * i;
    }
    for(auto j = 0; j < b; j++) {
      x = x * j;
      c = b - i;
    }
  }
  b = x + c;
  std::cout << b << x << a;
  return 0;
}