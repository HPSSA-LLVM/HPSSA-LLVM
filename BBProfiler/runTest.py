import random
import os

for j in range(1, 1001):
    test = open("test.txt", "w")
    # n = random.randint(1, 100)
    # give n as a input to the program
    # test.write(str(n) + "\n")
    for i in range(2):
        test.write(str(random.randint(-20, 20)) + " ")
    test.write("\n")
    test.close()
    os.system("cat test.txt | ./a.out")
    os.remove("test.txt")
