#include <iostream>
using namespace std;
int main() {
  int a;
  cin >> a;
  int b;
  cin >> b;
  for (int i = 0; i < 5; i++) {
    if (a < 10) {
      break;
    } else if (b < 5) {
      b += 4;
    } else
      a -= 1;
    b += 1;
  }
<<<<<<< HEAD
=======

  a = a + 7;
  b = b * 6;
  std::cout << a << b << std::endl;

  if (b > 6) {
    goto end_label;
  } else {
    if (a > 9) {
      a = a + 7;
      b = b * 6;
      std::cout << a << b << std::endl;

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
      std::cout << a << b << std::endl;

      a = a + b;
      b = a * b;
    } else {
      a = a + 5;
      b = b * 6;
      std::cout << a << b << std::endl;

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
      std::cout << a << b << std::endl;
    }
  }

end_label:
  std::cout << a << b << std::endl;
>>>>>>> 3ee17621d926caf3592921d45ebe6ac9ecf59533
  return 0;
}