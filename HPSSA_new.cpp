#include "headers/HPSSA_new.h"
using namespace llvm;
using namespace std;

class frame {
public:
  map<Value *, BitVector> frameVector; // ? Will pair<> be better?
  void add(Value *v, BitVector e) {
    if (frameVector[v].empty()) {
      frameVector[v] = e;
    } else {
      frameVector[v] |= e;
    }
  }
  int size() { return frameVector.size(); }
  bool empty() { return frameVector.empty(); }
};

class pStack {
public:
  stack<pair<frame, BasicBlock *>> pstack;

  void push(frame f, BasicBlock *BB) { // ? Should we take frame pointer instead
    pstack.push({f, BB});
  }
  // Assumption: Whenever pop is called in the algorithm, the frames
  // corresponding to BB (if any) are in the top
  // Proof: Structural induction on cfg ( True for child -> true for parent)
  void pop(BasicBlock *BB) {
    while (!pstack.empty()) {
      if (pstack.top().second != BB) {
        break;
      }
      pstack.pop();
    }
  }
  pair<frame, BasicBlock *> top() { return pstack.top(); }
};

map<BasicBlock *, BitVector> HotPathSet;

// Hot Path Information
void HPSSAPass::getProfileInfo(Function &F) {
  map<StringRef, BasicBlock *> getPointer;
  for (auto &BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  ifstream reader;
  reader.open("BBProfiler/profileInfo.txt");
  int n, numNodes;
  string node;
  reader >> n;
  for (int i = 0; i < n; i++) {
    reader >> numNodes;
    for (int j = 0; j < numNodes; j++) {
      reader >> node;
      if (HotPathSet[getPointer[node]].size() == 0) {
        HotPathSet[getPointer[node]].resize(n);
      }
      HotPathSet[getPointer[node]].set(i);
    }
  }
  reader.close();
}
// After Buddy set creation check if it is a loop header
// if yes :
//            Union the incubating hot paths with every buddy set
//             /         |-> taking xor with hot paths of entry block

PHINode *isPhi(Value *v) { return dyn_cast<PHINode>(v); }
CallInst *isTau(Value *v) { // ! Check this logic
  CallInst *CI = dyn_cast<CallInst>(v);
  if (!CI) {
    return CI;
  }

  Function *CF = CI->getCalledFunction();
  if (CF != NULL &&
      (CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau"))) {
    return CI;
  }
  return NULL;
}

map<Value *, vector<Value *>> renaming_stack;
map<pair<BasicBlock *, Value *>, bool> hasPhi, hasTau;
map<Value *, Value *> stackmap;
void HPSSAPass::Search(BasicBlock &BB, DomTreeNode &DTN) {
  // ? Meaning of Ordinary Assignment in LLVM Context
  // ? Should we prune unused tau?

  for (auto &I : BB) {
    for (auto &phi : renaming_stack) {
      if (phi.second.back() != NULL) {
        I.replaceUsesOfWith(phi.first, phi.second.back());
      }
    }
    if (PHINode *phi = dyn_cast<PHINode>(&I)) {
      hasPhi[{&BB, phi}] = true;
      renaming_stack[phi].push_back(phi);
      stackmap[phi] = phi;
    }

    if (CallInst *CI = isTau(&I)) {
      if (Value *parPhi = dyn_cast<Value>(CI->getOperand(0))) {
        hasTau[{&BB, stackmap[parPhi]}] = true;
        renaming_stack[stackmap[parPhi]].push_back(&I);
        stackmap[&I] = stackmap[parPhi];
      }
    }
  }

  for (auto Succ : successors(&BB)) {
    for (auto &phi : Succ->phis()) {
      // ! Assuming this gives the operand coming from this block
      Value *V = phi.getIncomingValueForBlock(&BB);
      if (PHINode *operand = isPhi(V)) {
        phi.replaceUsesOfWith(operand,
                              renaming_stack[stackmap[operand]].back());
      }

      if (CallInst *CI = isTau(V)) {
        if (Value *parPhi = dyn_cast<Value>(CI->getOperand(0))) {
          phi.replaceUsesOfWith(CI, renaming_stack[stackmap[parPhi]].back());
        }
      }
    }
  }

  for (auto Child = DTN.begin(); Child != DTN.end(); ++Child) {
    BasicBlock *ChildBB = (**Child).getBlock();
    Search(*ChildBB, **Child);
  }

  for (auto &varstack : renaming_stack) {
    if (hasTau[{&BB, varstack.first}]) {
      varstack.second.pop_back();
    }
  }
}

BitVector getIncubationPaths(BasicBlock *BB) {
  auto BBVector = HotPathSet[BB];
  auto PredVector = BitVector(BBVector.size());
  for (auto pred : predecessors(BB)) {
    PredVector |= HotPathSet[pred];
  }
  BBVector |= PredVector; // All paths present
  BBVector ^= PredVector; // paths only in current basic blocks

  return BBVector;
}

map<pair<BasicBlock *, PHINode *>, frame> defAcc;
map<PHINode *, pStack> phiStack;
void AllocateArgs(BasicBlock *BB) {
  for (auto &phi : BB->phis()) {
    auto deFrame = defAcc[{BB, &phi}];
    if (!deFrame.empty()) {
      phiStack[&phi].push(deFrame, BB);
    }
    auto topFrame = phiStack[&phi].top().first;
    auto currHotPath = HotPathSet[BB];
    BitVector incubationPaths = getIncubationPaths(BB);
    if (incubationPaths.any()) {
      frame newFrame;
      // ? Use C++14 notation
      for (auto &[currDef, hotPath] : topFrame.frameVector) {
        newFrame.add(currDef, incubationPaths);
      }
      // ? should we separate incubation paths
      newFrame.add(&phi, currHotPath);
      // and then add
      for (auto &args : phi.operands()) {
        if (!(isPhi(args) || isTau(args))) {
        }
        continue;
        newFrame.add(args, incubationPaths);
      }
    }
  }
}

map<BasicBlock *, bool> HPSSAPass::getCaloricConnector(Function &F) {
  map<BasicBlock *, vector<BitVector>> BuddySet;
  map<BasicBlock *, bool> isCaloric;
  int n; // no of hot paths.

  BitVector allPaths;
  ReversePostOrderTraversal<Function *> RPOT(&F);
  for (auto I = RPOT.begin(); I != RPOT.end(); ++I) {
    auto BB = *I;
    auto IncubationPath = allPaths; // Paths incubating from this basic block
    IncubationPath &= HotPathSet[BB];
    IncubationPath ^= HotPathSet[BB];

    // update allPaths
    allPaths |= IncubationPath;

    if (BB->isEntryBlock()) {

      errs() << "Caloric Connector and BuddySet Information\n";
      errs() << BB->getName() << ": ";

      // All hot paths in a single buddy set;
      BuddySet[BB].push_back(HotPathSet[BB]);
      n = HotPathSet[BB].size();
      continue;
    }

    BitVector alreadyInSets(n);
    auto currHotPaths = HotPathSet[BB];
    bool hasHotPath = currHotPaths.any();
    bool hasColdPath = false;

    for (auto pred : predecessors(BB)) {

      // All definition reaching to parent are cold.
      if (HotPathSet[pred].none())
        hasColdPath = true;

      for (auto predBitVector : BuddySet[pred]) {
        // hot paths from this parent to current block.
        predBitVector &= currHotPaths;

        // parent has a hot definition but
        // does not pass it to the child.
        if (predBitVector.none()) {
          hasColdPath = true;
          continue;
        }

        auto oldPaths = alreadyInSets;
        oldPaths &= predBitVector;

        auto newPaths = predBitVector;
        newPaths ^= oldPaths;

        // New paths form a different set
        if (newPaths.any()) {
          BuddySet[BB].push_back(newPaths);
        }

        alreadyInSets |= newPaths; // New paths added
        vector<BitVector> toPush;  // New Sets formed

        // All buddy sets in the child block are disjoint ** at this stage **
        for (auto &Buddy : BuddySet[BB]) {
          auto temp = oldPaths;
          temp &= Buddy;

          if (oldPaths.none())
            break;

          if (temp.none())
            continue;

          if (temp != Buddy) {
            Buddy ^= temp;
            toPush.push_back(temp);
          }
          oldPaths ^= temp;
        }

        for (auto rem : toPush) {
          BuddySet[BB].push_back(rem);
        }
      }
    }

    // * All the definitions reaching to this block are also avilable along the
    // * incubation nodes. Buddy set contains the set of paths carrying same
    // * definition The buddy sets are no more disjoint.
    for (auto &buddyDefs : BuddySet[BB]) {
      buddyDefs |= IncubationPath;
    }
    if (hasHotPath && hasColdPath) {
      isCaloric[BB] = true;
      errs() << BB->getName() << " is a Caloric Connector\n";
    }
  }
  return isCaloric;
}

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {
  // ! Running on Main Function Only
  // ? Look for alternative as name could not be relied upon
  if (F.getName() != "main") {
    return PreservedAnalyses::all();
  }

  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
  getProfileInfo(F);
  auto isCaloric = getCaloricConnector(F);
  map<pair<Instruction *, BasicBlock *>, bool> isInserted;

  // ! Is RPOT same as Topological?
  ReversePostOrderTraversal<Function *> RPOT(&F);

  for (auto J = RPOT.begin(); J != RPOT.end(); ++J) {
    auto BB = *J;
    for (auto &phi : BB->phis()) {
      auto BBHotPaths = HotPathSet[BB];
      // ! Replacing Loops 5 and 6, by the following algo: Traverse the
      // ! subtree rooted at BB in the Dominator tree of CFG and insert taus

      // ! The BFS over Dominator tree is clean but inefficient than on CFG.
      queue<BasicBlock *> BFSQueue;
      BFSQueue.push(BB);
      while (BFSQueue.empty() == false) {
        auto currBB = BFSQueue.front();
        BFSQueue.pop();

        auto currHotPath = HotPathSet[currBB];
        // ! isInserted is not needed in this implementation

        // All the childrens are alerady dominated
        // Corresponding Dominator tree node for BB
        auto &DTNode = *DT.getNode(currBB);
        for (auto Child = DTNode.begin(); Child != DTNode.end(); ++Child)
          BFSQueue.push((**Child).getBlock());

        // traverse along hot paths only
        if (!currHotPath.anyCommon(BBHotPaths) || !isCaloric[currBB])
          continue;
        std::vector<Type *> Tys;
        std::vector<Value *> Args;

        Tys.push_back(phi.getType());
        Args.push_back(dyn_cast<Value>(&phi));

        Function *tau = Intrinsic::getDeclaration(
            F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

        CallInst *TAUNode;
        TAUNode = CallInst::Create(tau, Args, "tau", currBB->getFirstNonPHI());
      }
    }
  }
  Search(F.getEntryBlock(), *DT.getRootNode()); // Renaming Algo
  AllocateArgs(F.getEntryBlock());              // Argument allocation algo

  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getHPSSAPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HPSSA_new", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hpssa_new") {
                    FPM.addPass(HPSSAPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will be
// able to recognize HPSSA Pass when added to the pass pipeline on the command
// line, i.e. via '-passes=hpssa'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHPSSAPluginInfo();
}
