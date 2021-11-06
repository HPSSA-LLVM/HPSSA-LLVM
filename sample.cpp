x, y, z;

if (x > y) {

bb1:
  x = x + y;
  x.br = 1;
} else {
bb2:
  x = x - y;
  x.br = 2;
  if (rand() % 100) {
    x = x + 1;
    x.br = 3;
  } else {
    x = x + 2;
    x.br = 4;
  }
  x = x + 30;

  x.br = 2;
}

bb : x .2 = phi[x0 % bb1, x1 % bb2];
            // x.2.br = phi [1 %bb1, ]
            // x.2.br = phi [ x0.br %bb1, x1.br %bb2 ]

            x2.tau = tau(x .2, x1);

         if (x.br != 2);
}
z = x + y;