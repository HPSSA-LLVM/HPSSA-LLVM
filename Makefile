BUILD_PATH=${LLVM_BIN_PATH}
LLVM_CONFIG=llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -I include -Xclang -disable-O0-optnone
CXXFLAGS= `$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifdef SILENT
.SILENT:
endif

.PHONY: test build dot2png

all: buildhpssa build test dot2png 
runpass : test dot2png

buildhpssa: src/HPSSA_new.cpp include/HPSSA_new.h
	@mkdir -p build
	$(CXX) -c src/HPSSA_new.cpp -o build/HPSSA_new.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/HPSSA_new.cpp.o -o build/HPSSA_new.cpp.so $(LDFLAGS)

build: src/TDestruction.cpp include/TDestruction.h src/SpecTauInsertion.cpp include/SpecTauInsertion.h
	$(CXX) -c src/TDestruction.cpp -o build/TDestruction.cpp.o $(CXXFLAGS)
	$(CXX) $(CXXFLAGS) -shared build/TDestruction.cpp.o -o build/TDestruction.cpp.so $(LDFLAGS)
	# $(CXX) -c src/SpecTauInsertion.cpp -o build/SpecTauInsertion.cpp.o $(CXXFLAGS)
	# $(CXX) $(CXXFLAGS) -shared build/SpecTauInsertion.cpp.o -o build/SpecTauInsertion.cpp.so $(LDFLAGS)

test: build BBProfiler/profileInfo.txt 
	# use the same test case which was profiled 
	cp BBProfiler/tests/test.cpp tests/test.cpp

	$(CXX) -c -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm $(CXXFLAGS) tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA_new.cpp.so -passes=hpssa_new -time-passes IR/LL/test_mem2reg.ll -S -o IR/LL/test_hpssa.ll -f 2> output/custom_hpssa.log
	# $(BUILD_PATH)/opt -load-pass-plugin=build/TConditional.cpp.so -passes=tcond -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_tcond.ll -f 2> output/custom_tcond.log
	$(BUILD_PATH)/opt -load-pass-plugin=build/TDestruction.cpp.so -passes=tdstr -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_tdstr.ll -f 2> output/custom_tdstr.log
	# $(BUILD_PATH)/opt -load-pass-plugin=build/SpecTauInsertion.cpp.so -passes=sptau -time-passes IR/LL/test_hpssa.ll -S -o IR/LL/test_sptau.ll -f 2> output/custom_sptau.log
	# Handle exit code of diff(1 if changes found).
	diff IR/LL/test_mem2reg.ll IR/LL/test_hpssa.ll > output/changes_hpssa.log; [ $$? -eq 1 ]
	# diff IR/LL/test_hpssa.ll IR/LL/test_tdstr.ll > output/changes_tdstr.log; [ $$? -eq 1 ]
	# diff IR/LL/test_hpssa.ll IR/LL/test_sptau.ll > output/changes_sptau.log; [ $$? -eq 1 ]
	$(BUILD_PATH)/opt -dot-cfg-only -cfg-func-name=main IR/LL/test_mem2reg.ll -enable-new-pm=0 -disable-output
	mv .main.dot stripped.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_hpssa.ll -disable-output -enable-new-pm=0 
	mv .main.dot withHPSSA_new.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_tdstr.ll -disable-output -enable-new-pm=0 
	mv .main.dot removeHPSSA_new.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_mem2reg.ll -enable-new-pm=0 -disable-output
	mv .main.dot baseline.dot
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

topng: 
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf output/*
	rm -rf IR/cfg/*
	rm -rf IR/BC/*
	rm -f *.s *.out *.log 