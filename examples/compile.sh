#!/usr/bin/bash

if [[ -z $1 ]];
then
    echo "Pass the testnumber ./compile.sh <test_number>"
    exit 1
fi

clang -c -Xclang -emit-llvm -O0 test$1/program$1.c -o test$1/program$1.bc
opt -instnamer -mem2reg -enable-new-pm=0 test$1/program$1.bc -S -o test$1/program$1.mem2reg.ll

cp test$1/program$1.mem2reg.ll test$1/program$1.annotate.txt
rm -rf test$1/program$1.bc

echo "[Note] Annotate .annotate.txt file with @tau funcs and run cfggen.sh"

opt -dot-cfg-only -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0
mv .main.dot test$1/iblocks$1.dot

opt -dot-cfg -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0 
mv .main.dot test$1/cfg$1.dot