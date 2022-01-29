#include <bits/stdc++.h>

using namespace std;

int main() {
  int a, b, c, d, e;
  cin >> a >> b >> c >> d >> e;
  if (!(a == b and a == c and a == d and a == e)) {
    a = a * 5 + b;
  }
  c = c * 5 + a;
  return 0;
}