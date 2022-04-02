BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -I include -Xclang -disable-O0-optnone
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifdef SILENT
.SILENT:
endif

.PHONY: test 

all: build test cfg_before cfg_after

build: src/HPSSA_new.cpp include/HPSSA_new.h  # src/TDestruction.cpp headers/TDestruction.h
	$(CXX) -v
	@mkdir -p build
	$(CXX) -c src/HPSSA_new.cpp -o build/HPSSA_new.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/HPSSA_new.cpp.o -o build/HPSSA_new.cpp.so $(LDFLAGS)
#	$(CXX) -c TDestruction.cpp -o build/TDestruction.cpp.o $(CXXFLAGS)
#	$(CXX) $(CXXFLAGS) -shared build/TDestruction.cpp.o -o build/TDestruction.cpp.so $(LDFLAGS)

test: build tests/test.cpp BBProfiler/profileInfo.txt 
	# use the same test case which was profiled 
	# rm tests/test.cpp
	# cp BBProfiler/tests/test.cpp tests/test.cpp
	# $(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	# $(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	# $(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA_new.cpp.so -passes=hpssa_new -S -f -time-passes IR/LL/test_mem2reg_sumit.ll -o IR/LL/test_HPSSA_new.ll 2> output/custom_HPSSA_new.log
	# $(BUILD_PATH)/opt -load-pass-plugin=build/TConditional.cpp.so -passes=tcond -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_tcond.ll -f 2> output/custom_tcond.log
	# $(BUILD_PATH)/opt -load-pass-plugin=build/TDestruction.cpp.so -passes=tdstr -time-passes IR/LL/test_HPSSA_new.ll -S -o IR/LL/test_tdstr.ll -f 2> output/custom_tdstr.log
	# Handle exit code of diff(1 if changes found).
	diff IR/LL/test_mem2reg_sumit.ll IR/LL/test_HPSSA_new.ll > output/changes_HPSSA_new.log; [ $$? -eq 1 ]
	# diff IR/LL/test_HPSSA_new.ll IR/LL/test_tdstr.ll > output/changes_tdstr.log; [ $$? -eq 1 ]


cfg_before: build tests/test.cpp BBProfiler/profileInfo.txt 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_mem2reg_sumit.ll -o IR/BC/test_mem2reg_sumit.bc 
	make -f new.mak dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_before.png

dom_before:build tests/test.cpp BBProfiler/profileInfo.txt 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_mem2reg_sumit.ll -o IR/BC/test_mem2reg_sumit.bc 
	make -f new.mak dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/dom_before.png

cfg_after: test 
	$(BUILD_PATH)/opt --dot-cfg IR/LL/test_HPSSA_new.ll -o IR/BC/test_HPSSA_new.bc
	# $(BUILD_PATH)/opt --dot-cfg IR/LL/test_tcond.ll -o IR/BC/test_tcond.bc 
	make -f new.mak dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/cfg_after.png

dom_after: test
	$(BUILD_PATH)/opt --dot-dom-only IR/LL/test_HPSSA_new.ll -o IR/BC/test_HPSSA_new.bc 
	make -f new.mak dot2png
	mv ./IR/cfg/.main.dot.png ./IR/cfg/dom_after.png

dot2png: 

	mv .*.dot IR/cfg/
	find IR/cfg/ -name .*.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf output/*
	rm -rf IR/cfg/*
	rm -rf IR/BC/*
	rm -f *.s *.out *.log 