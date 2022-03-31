#ifndef LLVM_TRANSFORMS_TDSTR_TDSTR_H
#define LLVM_TRANSFORMS_TDSTR_TDSTR_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Pass.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include <bits/stdc++.h>
using namespace std;
using namespace llvm;

namespace llvm {

inline void insertSpeculativeValues(Function &F, llvm::Value* tau, uint64_t specVal) {
  // assuming spec function signature takes a pointer to tau (Value*)
  // and an integer (speculative argument)
  Module *M = F.getParent();
  vector<Type*> Params{Type::getInt32PtrTy(M->getContext()),
                       Type::getInt32Ty(M->getContext())};
  FunctionType* fccType =
      FunctionType::get(Type::getVoidTy(M->getContext()), Params, false);

  Function* specFun =
      Function::Create(fccType, GlobalValue::ExternalLinkage, "_Z7speci", M);

  Instruction* I = dyn_cast<Instruction>(tau);
  CallInst* CI = dyn_cast<CallInst>(I);
  Function* CF = CI->getCalledFunction();
  errs() << "Speculative Tau: " << CF->getName() << "\t\n";
  std::vector<Value*> Args;
  Args.push_back(I);
  Args.push_back(
      ConstantInt::get(Type::getInt32Ty(M->getContext()), specVal));
  CallInst* SpecTau;
  SpecTau = CallInst::Create(specFun, Args, "", I->getNextNode());
  I->replaceAllUsesWith(SpecTau);
}

}
#endif // LLVM_TRANSFORMS_TDSTR_TDSTR_H
