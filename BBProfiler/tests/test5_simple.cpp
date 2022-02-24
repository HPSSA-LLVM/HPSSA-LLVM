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
    default : goto label_7;
  }
  
  label_3:
    e = 90;
    goto label_7;
  
  label_4:
    e = 100 - 10;
    goto label_7;

  label_7:
    e = e + 70;
    goto end;

  end:
    if (e >= 100) {
      a = a + 777;
    } else {
      a = a - 888;
    }
    
  return 0;
}