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

all: pass.so

pass.so: pass.o
	$(CXX) $(CXXFLAGS) -shared build/PathProfiling.cpp.o -o build/PathProfiling.cpp.so $(LDFLAGS)

pass.o: PathProfiling.cpp #PathProfiling.h
	$(CXX) -c PathProfiling.cpp -o build/PathProfiling.cpp.o $(CXXFLAGS)