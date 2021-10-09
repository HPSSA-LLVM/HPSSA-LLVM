#include <iostream>

int main() {
  int a;
  std::cin >> a;
  for (int i = 0; i < a; i++) {
    a = a + 1;
    std::cout << a;
  }
  return 0;
}