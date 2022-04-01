# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

#! RUN: make limit

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
# CXX=$(BUILD_PATH)/clang++ -std=c++17 -O0
# removed -g flag, add if needed
# CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti -Xclang -disable-O0-optnone
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBOSE
.SILENT:
endif

.PHONY: build

all: build test cfg # profile

build: BallLarusProfiler.cpp headers/BallLarusProfiler.h
	$(CXX) -c BallLarusProfiler.cpp -o build/BallLarusProfiler.cpp.o $(CXXFLAGS) 
	$(CXX) $(CXXFLAGS) -shared build/BallLarusProfiler.cpp.o -o build/BallLarusProfiler.cpp.so $(LDFLAGS)

test: build tests/test.cpp 
	# echo ${LLVM_BIN_PATH}
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/BallLarusProfiler.cpp.so -passes=blprofiler -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	 diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

profile: test pathProfiler.cpp bbReader.cpp runTest.py
	rm -f pathData.txt
	$(CXX) $(CXXFLAGS) pathProfiler.cpp IR/LL/test_modified.ll
	python3 runTest.py
	$(CXX) $(CXXFLAGS) bbReader.cpp -o bbReader.o
	./bbReader.o $(limit) 
      
cfg: cfg_before cfg_after

cfg_before: build tests/test.cpp
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_mem2reg.ll -o IR/BC/test_mem2reg.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_before.png

cfg_after: test 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_modified.ll -o IR/BC/test_modified.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_after.png

dot2png: 
	mv .*.dot IR/cfg/
	find IR/cfg/ -name .*.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf output && mkdir output 
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.s *.out *.log *.txt
	