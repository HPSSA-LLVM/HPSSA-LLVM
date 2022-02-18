#include <iostream>
#include <stdio.h>
#include <time.h>

int retval() { return rand() % 5; }

int main() {

  int a, b, c, d, z, arr[5] = {0, 0, 0, 0, 0};
  srand(time(NULL));

  for (int i = 0; i < 1000; i++) {
    if (i % 5 == 0) {
      a = z;
      for (int j = 0; j < 1000; j++) {
        if (rand() % 100 == 10) {
          a = b + 1;
          d = 50 - arr[(a + d) % 5];
          std::cout << c << d << std::endl;
        } else {
          d = c - a - retval();
          if (c < d) {
            c = c - 1;
            a = retval();
            std::cout << a << c << d << std::endl;
          }
        }
        a = retval();
        z = retval() + arr[(a + b + c + d) % 4];
        std::cout << j << a << b << c << d << std::endl;
      }
    }
  }

  c = a + retval();
  d = b;
  std::cout << d << c << std::endl;

  return 0;
}