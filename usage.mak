BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1 -I include
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifdef SILENT
.SILENT:
endif

.PHONY: test 

all: build test

build: build/* src/passUsage.cpp
	@mkdir -p build
	$(CXX) -c src/passUsage.cpp -o build/passUsage.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/passUsage.cpp.o -o build/passUsage.cpp.so $(LDFLAGS)

test: build/* BBProfiler/profileInfo.txt 
	# use the same test case which was profiled 
	cp BBProfiler/tests/test.cpp tests/test.cpp
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/passUsage.cpp.so -load-pass-plugin=build/HPSSA.cpp.so -passes="usehpssa" \
		-time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_usage.ll 
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_usage.ll -enable-new-pm=0 -disable-output
	mv .main.dot afterHPSSA.dot
	mv *.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png
	
clean: 
	rm -rf build output && mkdir output 
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.s *.out *.log *.txt