#include <iostream>
#include <stdio.h>
#include <time.h>

int main() {

  int a, b, c, d, z, arr[5] = {0, 0, 0, 0, 0};
  srand(time(NULL));

  for (int j = 0; j < 1000; j++) {
    if (rand() % 100 == 10) {
      a = b + 1;
      d = 50 - arr[(a + d) % 5];
      std::cout << c << d << std::endl;
    } else {
      d = c - a;
      if (c < d) {
        c = c - 1;
        std::cout << c << d << std::endl;
      }
    }
    z = 10 + arr[(a + b + c + d) % 4];
    std::cout << j << a << b << c << d << std::endl;
  }

  c = a;
  d = b;
  std::cout << d << c << std::endl;

  return 0;
}