#include <iostream>
using namespace std;
int main() {
  int a;
  cin >> a;
<<<<<<< HEAD
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
=======
  for (int i = 0; i < a; i++) {
    cout << a;
>>>>>>> 3ee17621d926caf3592921d45ebe6ac9ecf59533
  }
  return 0;
}