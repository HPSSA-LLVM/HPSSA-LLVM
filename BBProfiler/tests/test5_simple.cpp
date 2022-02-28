#include <bits/stdc++.h>

// 1
// 6
// entry sw.bb1 label_4 end if.else if.end

int main() {
  int x = 2, m, n, y = 0, z = 9, c = 1;
  std::cin >> m;
  switch(m) {   
    case 2 : x = 2 * c + 5; n = 10; break;
    case 4 : x = 2 * c + 5; n = x - 2; break;
    case 6 : x = 2 * c + 1; n = x + 2; break;
    default : break;
  }
  
  y = 2 * x + 10;

  if (y <= z + x) {
  } else {
    z = n + 3 * x;
    switch (z) {
      default : break;
      case 200 : { 
        goto end;
      }
      case 300 : exit(0);
    }
  }

  m = y + x;  
  end:
    z = x;

  return 0;
}