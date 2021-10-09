#include <iostream>
#include <stdio.h>
#include <time.h>

int main() {

  int a, b, c, d;
  srand(time(NULL));

  if (rand() % 10 == 5) {
    a = b;
  } else {
    a = d;
  }

  c = a;
  std::cout << c << std::endl;

  return 0;
}