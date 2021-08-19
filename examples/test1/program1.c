#include <stdio.h>
#include <stdlib.h>

int tau(void) { return 0; }

int main(void) {
  int x = 0;
  int y = 0;
  int z = 0;

  scanf("%d", &y);

  x = 2;

  if (y > 0) {
    x = 5;
  } else {
    x = 1;
  }

  // tau insertion
  tau();
  y = x;

  if (y > 5000) {

    // tau insertion
    tau();
    y = x;

    if (y > 6500) {
      goto label_g;
    } else if (y > 5500) {
      goto label_h;
    } else {
      goto label_i;
    }
  } else {
    goto label_g;
  }

label_g:
  // tau insertion
  tau();
  z = x;
  goto label_j;

label_h:
  z = 50;
  goto label_j;

label_i:
  z = 70;

label_j:
  z = x;

  return 0;
}