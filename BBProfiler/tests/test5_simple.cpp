#include <bits/stdc++.h>

// profileInfo
// 1
// 7
// entry if.then if.else if.end if.end29 if.then37 if.end41 

int main() {
  int a, b, c, d, x, y, e, f, z = 0;
  std::cin >> a >> b >> c >> d;
  if (rand() % 181 >= 991) {
    x = a + b; // dead
    y = 63;
    e = 90 + x; // dead
    if (rand() % 50 >= 2 * a) {
      x = a - b;
      b = 137;
    } else {
      x = 111 - c;
      y = b - c;
    }
    f += 8;
    a = x + 9354;
  } else {
    f = e + 762; // dead
    x = c + d; // dead
    y = a + 887;
    if (rand() % 70 >= 2 * a) {
      x = a + b;
      b = 8568;
    } else {
      e = (int)(99 / 8);
      x = 932 + c;
      y = b + c;
    }
    a = x + 1145;
  }
  y += x + a;
  f = y + 1;
  if (d + a > rand() % 60) {
    y = y + a;
  } else {
    y = x + a;
  }
  y += x + a;
  
  std::cout << y;
  return 0;
}