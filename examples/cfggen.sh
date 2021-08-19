#!/usr/bin/bash

opt -dot-cfg-only -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0
mv .main.dot test$1/iblocks$1.dot

opt -dot-cfg  -cfg-func-name=main test$1/program$1.annotate.txt -disable-output -enable-new-pm=0 
mv .main.dot test$1/cfg$1.dot