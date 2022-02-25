#include <bits/stdc++.h>

// 2
// 8
// entry start sw.bb1 label_4 label_7 end if.else if.end
// 7
// entry start sw.default label_6 end if.then if.end

int main() {
  int a = 1000, z, c, e = 0;
  switch(c) {   
    case 2 : goto label_3; break;
    case 4 : goto label_4; break;
    default : goto label_5;
  }
  
  label_3:
    e = 45 * 2;
    a = e + 20;
    goto end;
  
  label_4:
    e = 10 * 9;
    a = z + 100;
    goto end;

  label_5:
    e = 100 - 10;
    a = z - 87;
    goto end;

  end:
    if (e >= 100) {
      a = a + 777;
    } else {
      a = a - 888;
    }
    
  return 0;
}