#include <iostream>
#include <stdio.h>
#include <time.h>

int main() {

  int a, b, c, d;
  srand(time(NULL));

  if (a + b > c + d) {
    a = b;
  } else {
    a = c;
  }

  std::cout << a << std::endl;

  if (1 >= 2) {
    if (c > d) {
      a = b;
      d = c;
    } else {
      d = a;
      a = c;
    }
    c = a + d;
    std::cout << c << std::endl;
  } else {
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
  }

  c = a;
  std::cout << c << std::endl;

  return 0;
}
