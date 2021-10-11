#!/usr/bin/bash

if [[ -z $1 ]];
then
    echo "Pass the testnumber ./compile.sh <test_number>"
    exit 1
fi

mkdir -p test$1

if [[ $1 == "10" ]];
then
    echo "Reservoir Example"
    echo 
    clang -I include example10.c -O1 -emit-llvm -S -o example10.llvmir
    clang -I include -c -Xclang -emit-llvm -O1 example10.c -o test10/program10.bc
else
    clang++ -I include example$1.cpp -O1 -emit-llvm -S -o example$1.llvmir
    clang++ -I include -c -Xclang -emit-llvm -O1 example$1.cpp -o test$1/program$1.bc
fi 

opt -instnamer -mem2reg -enable-new-pm=0 test$1/program$1.bc -S -o test$1/program$1.mem2reg.ll

cp test$1/program$1.mem2reg.ll test$1/program$1.annotate.txt
rm -rf test$1/program$1.bc

echo "[Note] Annotate .annotate.txt file with @tau funcs and run cfggen.sh"

opt -dot-cfg-only --view-cfg-only -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0
mv .main.dot test$1/iblocks$1.dot

opt -dot-cfg --view-cfg-only -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0 
mv .main.dot test$1/cfg$1.dot

dot -T png test$1/iblocks$1.dot -o test$1/iblocks$1.png
dot -T png test$1/cfg$1.dot -o test$1/cfg$1.png
