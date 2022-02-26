#include <bits/stdc++.h>

// 1
// 6
// entry sw.bb1 label_4 end if.else if.end

int main() {
  int a = 1000, z, c = 10, m, e = 0, n = 100; 
  switch(m) {   
    case 2 : goto label_3; break;
    case 4 : goto label_4; break;
    default : goto label_5;
  }
  
  label_3:
    e = c * 10;
    // a = 111;
    goto end;
  
  label_4:
    e = c * (2 * 5);
    // a = 111;
    goto end;

  label_5:
    e = (c - 1) * 10 + 10;
    // a = e - 87;
    goto end;

  end:
    int b = a + e + n; 
    if (b >= 100) {
      a = e + 779;
    } else {
      a = e + 543;
    }
    
  a += 1;
  return 0;
}