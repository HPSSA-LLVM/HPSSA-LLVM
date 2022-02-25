#include <bits/stdc++.h>

// 2
// 8
// entry start sw.bb1 label_4 label_7 end if.else if.end
// 7
// entry start sw.default label_6 end if.then if.end

int main() {
  int a = 1000, z, c = 2, m, e = 0, n = 100; 
  switch(m) {   
    case 2 : goto label_3; break;
    case 4 : goto label_4; break;
    default : goto label_5;
  }
  
  label_3:
    e = 45 * 2;
    a = e + 21;
    goto end;
  
  label_4:
    e = 10 * 9;
    a = z + 37;
    goto end;

  label_5:
    e = 5 * 9 + 45;
    a = z - 87;
    goto end;

  end:
    z = e + 30;
    int b = a + z + n; 
    if (b >= 100) {
      a = e + 777;
    } else {
      a = 3223;
    }
    
  a += 1;
  return 0;
}