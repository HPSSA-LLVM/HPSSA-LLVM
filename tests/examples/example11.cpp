#include <iostream>

int main() {
  int N = 90;
  int sum = N;
  /* S1 */
  for (int j = 1; j <= N; j += 1) {
    /* S2 */
    if ((j % 2) == 0) {
      /* S3 */
      sum += j;
      std::cout << sum << std::endl;
    }
  }

  std::cout << sum << std::endl;
  /* S4 */
  return 0;
}