#include <iostream>

int main(void) {
  int x = 0, y = 0, b = 0, a = 0, c = 0, z = 0, d = 0;
  x = 5;
  y = 10;
  std::cin >> z;
  if (z > 900) {
    b = 9;
  } else {
    x = 15;
  }

  a = b + 1;
  c = a + 1;

  if (z > a) {
    z = a * c;
  } else {
    d = x + 1;
  }

  a = y + 1;
  return 0;
}