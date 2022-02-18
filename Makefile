# FIX: Results not properly updating
# ! UPDATE ACCORDING TO YOUR LLVM PATH

BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -O1
# CXX=$(BUILD_PATH)/clang++ -std=c++17 -O0
# removed -g flag, add if needed
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
# CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti -Xclang -disable-O0-optnone
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifdef SILENT
.SILENT:
endif

.PHONY: test 

all: build test cfg_before cfg_after

build: HPSSA.cpp headers/HPSSA.h TDestruction.cpp headers/TDestruction.h
	@mkdir -p build
	$(CXX) -c HPSSA.cpp -o build/HPSSA.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/HPSSA.cpp.o -o build/HPSSA.cpp.so $(LDFLAGS)
	$(CXX) -c TDestruction.cpp -o build/TDestruction.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/TDestruction.cpp.o -o build/TDestruction.cpp.so $(LDFLAGS)

test: build BBProfiler/profileInfo.txt 
	# use the same test case which was profiled 
	cp BBProfiler/tests/test.cpp tests/test.cpp

	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA.cpp.so -passes=hpssa -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_hpssa.ll -f 2> output/custom_hpssa.log
	# $(BUILD_PATH)/opt -load-pass-plugin=build/TConditional.cpp.so -passes=tcond -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_tcond.ll -f 2> output/custom_tcond.log
	$(BUILD_PATH)/opt -load-pass-plugin=build/TDestruction.cpp.so -passes=tdstr -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_tdstr.ll -f 2> output/custom_tdstr.log
	# Handle exit code of diff(1 if changes found).
	diff IR/LL/test_mem2reg.ll IR/LL/test_hpssa.ll > output/changes_hpssa.log; [ $$? -eq 1 ]
	# diff IR/LL/test_hpssa.ll IR/LL/test_tdstr.ll > output/changes_tdstr.log; [ $$? -eq 1 ]
	$(BUILD_PATH)/opt -dot-cfg-only -cfg-func-name=main IR/LL/test_mem2reg.ll -enable-new-pm=0 -disable-output
	mv .main.dot stripped.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_hpssa.ll -disable-output -enable-new-pm=0 
	mv .main.dot main1.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_mem2reg.ll -enable-new-pm=0 -disable-output
	mv .main.dot main2.dot
	rm -rf .dot
	
cfg_before: test
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_mem2reg.ll -o IR/BC/test_mem2reg.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_before.png

dom_before: test
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_mem2reg.ll -o IR/BC/test_mem2reg.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/dom_before.png

cfg_after: test 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_hpssa.ll -o IR/BC/test_hpssa.bc
	# $(BUILD_PATH)/opt --dot-cfg IR/LL/test_tcond.ll -o IR/BC/test_tcond.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_after.png

dom_after: test
	$(BUILD_PATH)/opt --dot-dom-only IR/LL/test_hpssa.ll -o IR/BC/test_hpssa.bc 
	make dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/dom_after.png

dot2png: 
	mv *.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf build output && mkdir output 
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.s *.out *.log *.txt