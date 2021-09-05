# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBROSE
.SILENT:
endif

all: allpasses

pass.so: pass.o 
	$(CXX) $(CXXFLAGS) -shared build/BBProfiler.cpp.o -o build/BBProfiler.cpp.so $(LDFLAGS)

pass.o: BBProfiler.cpp headers/BBProfiler.h
	$(CXX) -c BBProfiler.cpp -o build/BBProfiler.cpp.o $(CXXFLAGS)

ir: tests/test.cpp
	# echo ${LLVM_BIN_PATH}
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll

mem2reg: ir
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll

allpasses: mem2reg pass.so
	$(BUILD_PATH)/opt -load-pass-plugin=build/BBProfiler.cpp.so -passes=bbprofiler -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	 diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

clean: 
	rm -rf .*.dot output build  IR && mkdir output && mkdir build  && mkdir IR && cd IR && mkdir BC && mkdir LL