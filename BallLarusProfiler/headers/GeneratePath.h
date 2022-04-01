#ifndef LLVM_TRANSFORMS_GeneratePath_GeneratePath_H
#define LLVM_TRANSFORMS_GeneratePath_GeneratePath_H

#include "llvm/Analysis/CFG.h"
#include "llvm/IR/BasicBlock.h"
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
#include "llvm/Transforms/Utils/UnifyFunctionExitNodes.h"
#include <bits/stdc++.h>
using namespace std;

struct Edge {
  int val; // value of the edge
  string to;
};

class Graph {
public:
  string Entry;
  string Exit;
  map<string, vector<Edge>> G;
  string getEntryBlock() { return Entry; }
  string getExitBlock() { return Exit; }
};

