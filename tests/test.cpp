#include <bits/stdc++.h>

int main() {
  start:
    int a, b, c, d, e = 0;
    std::cin >> a >> c;
    switch(c) {
      case 1 : goto label_1; break;
      case 2 : goto label_2; break;
      case 3 : goto label_3; break;
      case 4 : goto label_4; break;
      case 5 : goto label_5; break;
      case 6 : goto label_8; break;
      default : goto label_6;
    }
  
  label_1:
    a = 30;
    b = 70;
    e = 90;
    goto end;
  
  label_2:
    b = 60;
    a = 40;
    e = 90;
    goto end;
  
  label_3:
    a = 50;
    b = 50;
    e = 90;
    goto end;
  
  label_4:
    a = 10;
    b = 90;
    e = a + 80;
    goto label_7;

  label_5:
    a = 86;
    a += 1;
    b = 13;
    e = a + 3;
    goto label_7;

  label_8:
    a = 110;
    a += 1;
    b = -11;
    e = 90;
    goto label_7;

  label_7:
    d = a + e;
    e = 90;
    goto end;

  label_6:
    a = 23;
    b = 77;
    e = a + b - 10;
    goto end;

  end:
    int z = a + b;
    if (e >= 150) {
      a = a + 190;
    } else {
      a = a - 100;
    }
    
  z += a;
  return 0;
}