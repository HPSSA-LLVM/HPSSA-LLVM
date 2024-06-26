BUILD_PATH=$(HOME)/llvm-project/build/bin
LLVM_CONFIG=$(BUILD_PATH)/llvm-config
CXX=$(BUILD_PATH)/clang++ -std=c++17 -I include -Xclang -disable-O0-optnone
CXXFLAGS=`$(LLVM_CONFIG) --cppflags` -fPIC -fno-rtti
LDFLAGS=`$(LLVM_CONFIG) --ldflags` -Wl,-znodelete

ifdef SILENT
.SILENT:
endif

.PHONY: test 

all: build baseline runpass cfg
runtest : baseline runpass cfg 

build: src/SCCPSolverTau.cpp src/SCCPTau.cpp include/SpecValueLattice.h
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -shared src/SCCPSolverTau.cpp -o build/SCCPSolverTau.cpp.so $(LDFLAGS)
	$(CXX) $(CXXFLAGS) -shared src/SCCPTau.cpp -o build/SCCPTau.cpp.so $(LDFLAGS)

test: BBProfiler/profileInfo.txt BBProfiler/tests/test.cpp
	# use the same test case which was profiled 
	cp BBProfiler/tests/test.cpp tests/test.cpp
	$(CXX) -c -emit-llvm tests/test.cpp -o IR/BC/test.bc
	$(CXX) -S -emit-llvm tests/test.cpp -o IR/LL/test.ll
	$(BUILD_PATH)/opt -instnamer -mem2reg IR/BC/test.bc -S -o IR/LL/test_mem2reg.ll

baseline: BBProfiler/profileInfo.txt BBProfiler/tests/test.cpp
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_mem2reg.ll -enable-new-pm=0 -disable-output
	mv .main.dot baseline.dot
	mv *.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png
	
runpass:  
	$(BUILD_PATH)/opt -load-pass-plugin=build/HPSSA_new.cpp.so -passes=hpssa_new -time-passes \
		IR/LL/test_mem2reg.ll -S -o IR/LL/test_hpssa.ll \
		-f 2> output/custom_hpssa.log
	
	$(BUILD_PATH)/opt -load build/SCCPSolverTau.cpp.so -load build/HPSSA_new.cpp.so \
	-load-pass-plugin=build/HPSSA_new.cpp.so -load-pass-plugin=build/SCCPTau.cpp.so -passes=tausccp \
		-time-passes -debug-only=tausccp IR/LL/test_mem2reg.ll -S -o IR/LL/test_spec_sccp.ll \
		-f 2> output/custom_speculative_sccp.log

	$(BUILD_PATH)/opt -sccp -time-passes -debug-only=sccp IR/LL/test_hpssa.ll -S -o IR/LL/test_sccp_onhpssa.ll \
		-f 2> output/custom_sccp_onhpssa.log
	$(BUILD_PATH)/opt -sccp -time-passes -debug-only=sccp IR/LL/test_mem2reg.ll -S -o IR/LL/test_sccp_onbaseline.ll \
		-f 2> output/custom_sccp_onbaseline.log

cfg:
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_hpssa.ll -enable-new-pm=0 -disable-output
	mv .main.dot afterHPSSA.dot
	mv *.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_spec_sccp.ll -enable-new-pm=0 -disable-output
	mv .main.dot specSCCP_HPSSA.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_sccp_onhpssa.ll -enable-new-pm=0 -disable-output
	mv .main.dot SCCP_HPSSA.dot
	$(BUILD_PATH)/opt -dot-cfg -cfg-func-name=main IR/LL/test_sccp_onbaseline.ll -enable-new-pm=0 -disable-output
	mv .main.dot SCCP_BASELINE.dot
	mv *.dot IR/cfg/
	find IR/cfg/ -name *.dot | xargs -I name dot -Tpng name -o name.png

clean: 
	rm -rf build output && mkdir output 
	rm -rf IR && mkdir IR && mkdir IR/BC && mkdir IR/LL && mkdir IR/cfg 
	rm -f *.s *.out *.log *.txt
