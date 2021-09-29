
#include "llvm/IR/DerivedTypes.h"
// #include "llvm/ProfilingUtils.h" //removed
#include "ProfilingUtils.h"
// #include "llvm/Analysis/PathNumbering.h" //removed
#include "PathNumbering.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/InstrTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Pass.h"
#include "llvm/Support/Compiler.h"
// #include "llvm/Support/CFG.h"
#include "llvm/IR/CFG.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/Debug.h"
//#include "llvm/Support/TypeBuilder.h" //removed
#include "TypeBuilder.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Instrumentation.h"
#include <vector>

namespace llvm {
    class HPSSAPass : public PassInfoMixin<HPSSAPass> {
        
    };
}