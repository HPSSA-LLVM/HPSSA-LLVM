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

## LLVM CGO 

- [LLVM CGO Video](https://www.youtube.com/watch?v=ECwP3HRP0Z4)
- [https://llvm.org/devmtg/2022-04-03/slides/The.Hot.Path.SSA.Form.in.LLVM.pdf](https://llvm.org/devmtg/2022-04-03/slides/The.Hot.Path.SSA.Form.in.LLVM.pdf)

## LLVM Install 

This works with `clang-13` and below upto `clang-10`. 

```
clang version 13.0.1 (https://github.com/llvm/llvm-project 75e33f71c2dae584b13a7d1186ae0a038ba98838)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/local/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/10
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/8
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/9
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/11
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Candidate multilib: x32;@mx32
Selected multilib: .;@m64
Found CUDA installation: /usr/local/cuda-11.8, version 11.2
```

- Modify/Add this code to `llvm-project`. [tau patch code snippets](./assets/patch)

```
# Install ninja-build ninja and cmake first.
$ cmake -G "Ninja" build \
  -DLLVM_ENABLE_PROJECTS="llvm;compiler-rt;clang;clang-tools-extra" \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_CCACHE_BUILD=OFF -DLLVM_BUILD_TESTS=ON \
  -DLLVM_INSTALL_UTILS=ON \
  -B build -S llvm


$ cd build && ninja -j10 all
$ sudo ninja -j6 install

$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make all
```

## For using HPSSA Pass

```
$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make -f Makefile
```

## Importing and using the pass.

Check `HPSSA.cpp` file in [src](./src) folder. 

```
$ export LLVM_BIN_PATH=$HOME/llvm-project/build/bin && make all -f usage.mak
```
