#include <iostream>
#include <stdio.h>
#include <time.h>

int main() {

  int a, b, c, d;
  srand(time(NULL));

  for (int j = 0; j < 1000; j++) {
     if (rand() % 100 == 10) {
      a = b + 1;
      c = d - 1;
      std::cout << c << d << std::endl;
    } else {
      if (c < d) {
        c = c - 1;
        d = d - 1;
        std::cout << c << d << std::endl;
      }
    }
    std::cout << j << a << b << c << d << std::endl;
  }

  c = a;
  d = b;
  std::cout << d << c << std::endl;

  return 0;
}