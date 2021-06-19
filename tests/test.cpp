#include <iostream>

using namespace std;

int main() {
  int a, b;
  cin >> a >> b;

  if (a > 5) {
    a = a * 9 + 6;
    b = b * 3 + 1;
  } else {
    a = a + 8;
    b = b + 9;
  }

  a = a + 7;
  b = b * 6;

  if (b > 6) {
    goto end_label;
  } else {
    if (a > 9) {
      a = a + 7;
      b = b * 6;

      if (a < 18)
        goto new_label;
      // block 3
      if (b > 15) {
        a = a * 7;
        b = b * 4;
      } else {
        a = a * 5 + 4;
        b = b * 4 + 3;
      }

      a = a + b;
      b = a * b;
    } else {
      a = a + 5;
      b = b * 6;

      if (b > 16) {
        a = a + 5;
        b = b + 7;
      } else {
        a = a * 4;
        b = b * 6;
      }

    new_label:
      a = a + 7;
      b = b + 6;
    }
  }

end_label:
  return 0;
}