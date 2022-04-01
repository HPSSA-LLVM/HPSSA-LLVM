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
#include <llvm/IR/DerivedTypes.h>
#include <llvm/Support/Casting.h>
#include <llvm/IR/Verifier.h>
using namespace std;
using namespace llvm;

namespace llvm {

inline void createSpeculativeFunctionVal(Function &F) {

  Module *M = F.getParent();
  
  Type *returnType = Type::getInt32Ty(M->getContext());
  vector<Type*> Params{Type::getInt32Ty(M->getContext())};

  FunctionType * functionType = FunctionType::get(
      returnType, Params, false);
  Function *function = Function::Create(functionType, 
    Function::ExternalLinkage, "assignSpecValue", M);
  
  Function::arg_iterator args = function->arg_begin();
  Value *x = args++;
  x->setName("specConstVal");

  BasicBlock* BB = BasicBlock::Create(M->getContext(), 
    "entry", function);
  IRBuilder<> builder(BB);
  builder.SetInsertPoint(BB);
  builder.CreateRet(x);

}

inline void insertSpeculativeValues(Function &F, 
    llvm::Value* tau, uint64_t specVal) {
  
  Module *M = F.getParent();

  std::vector<Value*> Args;
  Instruction* I = dyn_cast<Instruction>(tau);

  Args.emplace_back(
    ConstantInt::get(
      Type::getInt32Ty(M->getContext()), 
      specVal
  ));

  IRBuilder<> builder(I);
  builder.SetInsertPoint(I->getNextNode());
  // llvm::errs() << M->getFunction("specCalls") << "\n\n";

  CallInst* SpecTau = CallInst::Create(
    M->getFunction("assignSpecValue"), 
    Args, "call", I->getNextNode()
  );

  SpecTau->setName(tau->getNameOrAsOperand() + "_spec");
  I->replaceAllUsesWith(SpecTau);
}

}
#endif // LLVM_TRANSFORMS_TDSTR_TDSTR_H
