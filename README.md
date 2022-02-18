# HPSSA-LLVM

From LLVM SSA to HPSSA Form  
Paper : [Constructing HPSSA over SSA](https://dl.acm.org/doi/10.1145/3078659.3078660)

Directory Structure:  
- [HPSSA.cpp](./HPSSA.cpp) is the file containing pass implementation.
- [build](./build) : Pass Object and Shared Object files
- [headers](./headers) : Include files
- [IR](./IR) : LLVM IR and Bitcode of test files at various stage
- [output](./output) :
  -  [changes.log](./output/changes.log) stores the changes the Pass made to the original IR.
  - [custom.log](./output/custom.log) shows custom output from pass printed through error stream.
- [tests](./tests) : Files on which passes will be tested.
- Other files are for standard use.

## Running 

```
$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make all
```

## For using HPSSA_new Pass

```
$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make -f Makefile_new
```

## Importing and using the pass.

Check `passUsage.cpp` file in [src](./src) folder. 

```
$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make all -f usage.mak
```