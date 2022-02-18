#include <bits/stdc++.h>

int main() {
  int a, b, c, d, x, y, z = 0;
  std::cin >> a >> b >> c >> d;
  if (rand() % 100 >= 90) {
    x = a + b;
    y = 63;
    if (rand() % 50 >= 2 * a) {
      x = a - b;
      b = 137;
    } else {
      x = 111 - c;
      y = b - c;
    }
    a = x + 9354;
  } else {
    x = c + d;
    y = a + 887;
    if (rand() % 70 >= 2 * a) {
      x = a + b;
      b = 8568;
    } else {
      x = 932 + c;
      y = b + c;
    }
    a = x + 1145;
  }
  y += x + a;
  
  if (d + a > rand() % 60) {
    y = y + a;
  } else {
    y = x + a;
  }
  y += x + a;
  
  std::cout << y;
  return 0;
}