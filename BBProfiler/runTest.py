import random
import os

for j in range(1, 1001):
    test = open("test.txt", "x")
    for i in range(2):
        test.write(str(random.randint(-20, 20)) + " ")
    test.write("\n")
    test.close()
    # execute a.out take input from test.txt: use bash
    os.system("bash -c './a.out < test.txt 1>/dev/null 2&>1' ")
    os.remove("test.txt")
