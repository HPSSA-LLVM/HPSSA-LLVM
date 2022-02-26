#include <bits/stdc++.h>

// 2
// 8
// entry start sw.bb1 label_4 label_7 end if.else if.end
// 7
// entry start sw.default label_6 end if.then if.end

int main() {
  int a = 1000, z, c = 10, m, e = 0, n = 100; 
  switch(m) {   
    case 2 : goto label_3; break;
    case 4 : goto label_4; break;
    default : goto label_5;
  }
  
  label_3:
    e = 101;
    a = e + 50;
    goto end;
  
  label_4:
    e = 101;
    a = e + 40;
    goto end;

  label_5:
    e = 101;
    a = e + 40;
    goto end;

  end:
    int b = a + e; 
    if (b + n >= 100) {
      a = b + 999;
    } else {
      a = b + 666;
    }
    
  a += 1;
  return 0;
}