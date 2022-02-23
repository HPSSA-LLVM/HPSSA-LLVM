#include <bits/stdc++.h>

// 2
// 8
// entry start sw.bb1 label_4 label_7 end if.else if.end
// 7
// entry start sw.default label_6 end if.then if.end

int main() {
  start:
    int a, b, c, d, e = 0;
    switch(c) {   
      case 2 : goto label_3; break;
      case 4 : goto label_4; break;
      default : goto label_6;
    }
  
  label_3:
    a = 50;
    b = 50;
    e = 90;
    d = a + b + e;
    goto label_7;
  
  label_4:
    a = 10;
    b = 90;
    e = a + 80;
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