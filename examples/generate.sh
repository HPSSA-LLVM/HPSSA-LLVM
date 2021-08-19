#!/usr/bin/bash

# clang -c -Xclang -emit-llvm -O0 $1.c -o $1.bc
# opt -instnamer -mem2reg -enable-new-pm=0 $1.bc -S -o $1.mem2reg.ll 
opt -dot-cfg $1.mem2reg.ll -disable-output -enable-new-pm=0
rm -rf $1.bc