# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBOSE
.SILENT:
endif


all: build test profile cfg

build: BBProfiler.cpp headers/BBProfiler.h
	$(CXX) -c BBProfiler.cpp -o build/BBProfiler.cpp.o $(CXXFLAGS) 
	$(CXX) $(CXXFLAGS) -shared build/BBProfiler.cpp.o -o build/BBProfiler.cpp.so $(LDFLAGS)

test: build tests/test.cpp 
	# echo ${LLVM_BIN_PATH}
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/BBProfiler.cpp.so -passes=bbprofiler -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	 diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

profile: test pathProfiler.cpp bbReader.cpp runTest.py
	rm -f pathData.txt
	$(CXX) $(CXXFLAGS) pathProfiler.cpp IR/LL/test_modified.ll
	python3 runTest.py
	$(CXX) $(CXXFLAGS) bbReader.cpp -o bbReader.o
	./bbReader.o $(LIMIT) 
      
cfg: test 
	$(BUILD_PATH)/opt --dot-cfg-only IR/LL/test_modified.ll
	mv .*.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf output && mkdir output 
	rm -rf build && mkdir build  
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.o *.so *.s *.out *.log *.txt
	