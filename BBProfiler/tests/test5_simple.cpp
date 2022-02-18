#include <bits/stdc++.h>

int main() {
  int a, b, c, d, x, y, z = 0;
  std::cin >> a >> b >> c >> d; 
  if (rand() % 100 >= 90) {
    x = a + b;
    y = 90;
    if (rand() % a >= b) {
      x = a - b + 9;
      z = 90;
    } else {
      x = 90 - c;
      y = b + c;
    }
    a = x + 90;
  } else {
    x = c + d;
    y = 80;
    if (rand() % 70 >= 2 * a) {
      x = a + b;
      b = 90;
    } else {
      x = 90 + c;
      y = b + c;
    }
    a = x + 80;
  }
  y = y + x + a;
  std::cout << y;
  return 0;
}