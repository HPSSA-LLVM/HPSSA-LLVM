# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
CXXFLAGS=`$(LLVM_CONFIG) --cppflags` -g -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifndef VERBOSE
.SILENT:
endif

all: cfg

pass.so: pass.o
	$(CXX) $(CXXFLAGS) -shared build/Backedge.cpp.o -o build/Backedge.cpp.so $(LDFLAGS)

pass.o: Backedge.cpp headers/Backedge.h
	$(CXX) -c Backedge.cpp -o build/Backedge.cpp.o $(CXXFLAGS)

ir: tests/test.cpp
	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll

mem2reg: ir
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll

allpasses: mem2reg pass.so
	$(BUILD_PATH)/opt -load-pass-plugin=build/Backedge.cpp.so -passes=backedgeChecker -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_modified.ll -f 2> output/custom.log
	# Handle exit code of diff(1 if changes found).
	diff IR/LL/test_mem2reg.ll IR/LL/test_modified.ll > output/changes.log; [ $$? -eq 1 ]

cfg: allpasses
	${LLVM_BIN_PATH}/opt --dot-cfg-only --disable-output IR/LL/test_modified.ll
	# dot_to_png
	ls .*.dot | xargs -I name dot -Tpng name -o cfg/name.png
	rm -f .*.dot

clean:
	rm -rf output/* build/*  IR/* cfg
	mkdir cfg
	mkdir IR/BC
	mkdir IR/LL
