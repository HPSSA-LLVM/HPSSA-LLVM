#include <bits/stdc++.h>

// 1
// 6
// entry sw.bb1 label_4 end if.else if.end

int main() {
  int x = 2, m, y;
  std::cin >> m;
  switch(m) {   
    case 2 : goto label_b; break;
    case 4 : goto label_c; break;
    case 6 : goto label_d; break;
    default : goto label_e; break;
  }
  
  label_b:
    x = 5;
    goto label_e;
  
  label_c:
    x = 5;
    goto label_e;

  label_d:
    x = 1;
    goto label_e;

  label_e:
    y = x;
    if (y >= 1000) {
      goto label_g;
    } else {
      label_f:
        int z;
        z = x;
        switch(z) {   
          case 2 : {
          label_g:
            y = x;
            goto label_j;
          }
          case 4 : {
          label_h:
            goto label_j;
          }
          default: {
          label_i:
            goto end;
          }
        }
    }
  
  label_j:
    y = x;
    goto end;
  
  end:
    std::cout << x << y;

  return 0;
}