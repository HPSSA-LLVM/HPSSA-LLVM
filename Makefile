# FIX: Results not properly updating

BUILD_PATH=~/HPSSA/llvm-project/build/bin
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBROSE
.SILENT:
endif

all: allpasses

pass.so: pass.o 
	$(CXX) $(CXXFLAGS) -shared build/HPSSA.cpp.o -o build/HPSSA.cpp.so $(LDFLAGS)

pass.o: HPSSA.cpp headers/HPSSA.h
	$(CXX) -c HPSSA.cpp -o build/HPSSA.cpp.o $(CXXFLAGS)

ir: tests/test.cpp
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll

mem2reg: ir
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll

allpasses: mem2reg pass.so
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA.cpp.so -passes=hpssa IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	 diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

clean: 
	rm -rf output/* build/*  IR/* && cd IR && mkdir BC && mkdir LL