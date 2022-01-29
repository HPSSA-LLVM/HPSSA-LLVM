#include <bits/stdc++.h>
using namespace std;

int main() {

entry:
  int a, b;
  cin >> a >> b;

  int count = 0;

A:
  // loop atmax 10 times
  count += 1;
  if (count == 10)
    goto exit;

  if (a < 10)
    goto F;
  else
    goto B;

B:
  if (b < 0)
    goto C;
  else
    goto D;

C:
  b += 15;
  goto E;

D:
  b -= 15;

E:
  b *= 10;

F:
  if (a < 0)
    goto G;
  else
    goto H;

G:
  a += 7;
  goto I;

H:
  a -= 3;

I:
  if (b > 3)
    goto A;

exit:
  return 0;
}