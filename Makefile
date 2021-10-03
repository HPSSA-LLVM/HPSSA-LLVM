# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
# removed -g flag, add if required
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBOSE
.SILENT:
endif

all: build test cfg 

build: HPSSA.cpp headers/HPSSA.h
	$(CXX) -c HPSSA.cpp -o build/HPSSA.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/HPSSA.cpp.o -o build/HPSSA.cpp.so $(LDFLAGS)

test: build tests/test.cpp BBProfiler/profileInfo.txt 
	# use the same test case which was profiled 
	cp BBProfiler/tests/test.cpp tests/test.cpp

	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA.cpp.so -passes=hpssa -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

cfg: test 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_modified.ll -o IR/BC/test_modified.bc 
	mv .*.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf output && mkdir output 
	rm -rf build && mkdir build  
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.o *.so *.s *.out *.log *.txt