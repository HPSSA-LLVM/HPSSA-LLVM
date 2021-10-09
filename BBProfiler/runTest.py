import random
import os

for j in range(1, 1001):
    test = open("test.txt", "w")
    for i in range(2):
        test.write(str(random.randint(-20, 20)) + " ")
    test.write("\n")
    test.close()
    # execute a.out take input from test.txt
    os.system("./a.out < test.txt")
    os.remove("test.txt")
