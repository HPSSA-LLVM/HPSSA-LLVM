#include "../include/HPSSA_new.h"
using namespace llvm;
using namespace std;

class frame {
public:
  map<Value*, BitVector> frameVector; // ? Will pair<> be better?
  void add(Value* v, BitVector e) {
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
  stack<pair<frame, BasicBlock*>> pstack;

  void push(frame f, BasicBlock* BB) { // ? Should we take frame pointer instead
    pstack.push({f, BB});
  }
  // Assumption: Whenever pop is called in the algorithm, the frames
  // corresponding to BB (if any) are in the top
  // Proof: Structural induction on cfg ( True for child -> true for parent)
  void pop(BasicBlock* BB) {
    while (!pstack.empty()) {
      if (pstack.top().second != BB) {
        break;
      }
      pstack.pop();
    }
  }
  pair<frame, BasicBlock*> top() { return pstack.top(); }
  bool empty() { return pstack.empty(); }
};

map<BasicBlock*, BitVector> HotPathSet;

// Hot Path Information
void HPSSAPass::getProfileInfo(Function& F) {
  map<StringRef, BasicBlock*> getPointer;
  for (auto& BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  ifstream reader;
  reader.open("BallLarusProfiler/hotPathInfo.txt");
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

PHINode* isPhi(Value* v) { return dyn_cast<PHINode>(v); }
CallInst* isTau(Value* v) { // ! Check this logic
  CallInst* CI = dyn_cast<CallInst>(v);
  if (!CI) {
    return CI;
  }

  Function* CF = CI->getCalledFunction();
  if (CF != NULL &&
      (CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau"))) {
    return CI;
  }
  return NULL;
}

map<BasicBlock*, int> topoNum;
void HPSSAPass::fillTopologicalNumbering(
    ReversePostOrderTraversal<Function*> RPOT) {
  int ctr = 0;
  for (auto I = RPOT.begin(); I != RPOT.end(); ++I) {
    auto BB = *I;
    topoNum[BB] = ctr++;
  }
}

map<std::pair<const BasicBlock*, const BasicBlock*>, bool> isBackedge;
void HPSSAPass::FillFunctionBackedges(
    Function& F) { // fill the isBackedge map to be used in AllocateArgs()
  SmallVector<std::pair<const BasicBlock*, const BasicBlock*>> result;
  FindFunctionBackedges(F,
                        result); // backedges in this function
  for (auto& info : result) {
    isBackedge[info] = true;
  }
}

map<Value*, vector<Value*>> renaming_stack;
map<pair<BasicBlock*, Value*>, bool> hasPhi, hasTau;
map<Value*, Value*> stackmap;
void HPSSAPass::Search(BasicBlock& BB, DomTreeNode& DTN) {
  // ? Meaning of Ordinary Assignment in LLVM Context
  // ? Should we prune unused tau?

  for (auto& I : BB) {
    for (auto& phi : renaming_stack) {
      if (phi.second.back() != NULL) {
        I.replaceUsesOfWith(phi.first, phi.second.back());
      }
    }
    if (PHINode* phi = dyn_cast<PHINode>(&I)) {
      hasPhi[{&BB, phi}] = true;
      renaming_stack[phi].push_back(phi);
      stackmap[phi] = phi;
    }

    if (CallInst* CI = isTau(&I)) {
      if (Value* parPhi = dyn_cast<Value>(CI->getOperand(0))) {
        hasTau[{&BB, stackmap[parPhi]}] = true;
        renaming_stack[stackmap[parPhi]].push_back(&I);
        stackmap[&I] = stackmap[parPhi];
      }
    }
  }

  for (auto Succ : successors(&BB)) {
    for (auto& phi : Succ->phis()) {
      if (phi.getBasicBlockIndex(&BB) < 0)
        continue; // if no argument comes from this basic block
      Value* V = phi.getIncomingValueForBlock(&BB);
      if (PHINode* operand = isPhi(V)) {
        phi.replaceUsesOfWith(operand,
                              renaming_stack[stackmap[operand]].back());
      }

      if (CallInst* CI = isTau(V)) {
        if (Value* parPhi = dyn_cast<Value>(CI->getOperand(0))) {
          phi.replaceUsesOfWith(CI, renaming_stack[stackmap[parPhi]].back());
        }
      }
    }
  }

  for (auto Child = DTN.begin(); Child != DTN.end(); ++Child) {
    BasicBlock* ChildBB = (**Child).getBlock();
    Search(*ChildBB, **Child);
  }

  for (auto& varstack : renaming_stack) {
    if (hasTau[{&BB, varstack.first}]) {
      if (varstack.second.back()->getNumUses() ==
          0) { // The tau inserted is spurious
        auto I = dyn_cast<Instruction>(
            varstack.second.back()); // ? Can the casting result be Null?
        I->eraseFromParent();
      }
      varstack.second.pop_back();
    }
  }
}

BitVector getIncubationPaths(BasicBlock* BB) {
  auto BBVector = HotPathSet[BB];
  auto PredVector = BitVector(BBVector.size());
  for (auto pred : predecessors(BB)) {
    PredVector |= HotPathSet[pred];
  }
  BBVector |= PredVector; // All paths present
  BBVector ^= PredVector; // paths only in current basic blocks

  return BBVector;
}

map<pair<BasicBlock*, Value*>, frame>
    defAcc; // ! Convincing evidence that defAcc is for all variables, not only
            // phis
map<PHINode*, pStack> phiStack;
map<Value*, Value*> corrPhi; // phi corresponding to a tau
void HPSSAPass::AllocateArgs(BasicBlock* BB, DomTreeNode& DTN) {

  auto currHotPath = HotPathSet[BB];
  BitVector incubationPaths = getIncubationPaths(BB);

  for (auto& phi : BB->phis()) {

    for (auto& arg : phi.operands()) {
      auto from = phi.getIncomingBlock(arg);
      auto pathInt = HotPathSet[from];
      pathInt &= currHotPath;
      if (pathInt.any()) {
        defAcc[{BB, &phi}].add(arg, pathInt); // ! Our idea, not in paper
      }
    }

    auto deFrame = defAcc[{BB, &phi}];
    if (!deFrame.empty()) {
      phiStack[&phi].push(deFrame, BB);
    }

    frame topFrame;
    if (!phiStack[&phi].empty()) {
      topFrame = phiStack[&phi].top().first;
    }
    if (incubationPaths.any()) {
      frame newFrame(topFrame);
      // ? Use C++14 notation
      for (auto& [currDef, hotPath] : topFrame.frameVector) {
        newFrame.add(currDef, incubationPaths);
      }
      for (auto& args : phi.operands()) {
        auto BBParent = phi.getIncomingBlock(args);
        if (!(isPhi(args) || isTau(args))) { // ? Incoming edge meaning
          auto PathSet = HotPathSet[BBParent];
          PathSet &= currHotPath; // pathSet(bp->b)
          newFrame.add(args, incubationPaths);
          newFrame.add(args, PathSet);
        }
        if (isBackedge[{BBParent, BB}]) {
          newFrame.add(args, incubationPaths);
        }
      }

      phiStack[&phi].push(newFrame, BB);
    }
  }
  // According to our implementation, all taus are inserted before the first
  // non-phi instruction. So if there is a tau, it will be right after the list
  // of phis
  BasicBlock::iterator it(BB->getFirstNonPHI());
  while (isTau(&*it)) {
    auto phi = dyn_cast<PHINode>(corrPhi[&*it]);

    std::vector<Type*> Tys;
    std::vector<Value*> Args;

    Tys.push_back(phi->getType());
    Args.push_back(dyn_cast<Value>(
        it->getOperand(0))); // ! It should be noted that the phi may be
                             // replaced by some tau as first argument

    if (!phiStack[phi].empty()) {
      for (auto& [phiArgs, phiArgsPath] :
           phiStack[phi].top().first.frameVector) {
        auto commonPaths = phiArgsPath;
        commonPaths &= currHotPath;
        if (commonPaths.any()) {
          Args.push_back(dyn_cast<Value>(phiArgs));
        }
      }
      // ! Need to again create tau functions
      Function* tau = Intrinsic::getDeclaration(
          BB->getParent()->getParent(), Function::lookupIntrinsicID("llvm.tau"),
          Tys);

      CallInst* TAUNode;
      TAUNode = CallInst::Create(tau, Args, "tau");
      it->dump();
      ReplaceInstWithInst(BB->getInstList(), it,
                          TAUNode); // ! Replacing the original tau instruction,
                                    // 'it' will be reset to new inst
      it->dump();
    }
    ++it;
  }

  for (auto Succ : successors(BB)) {

    if (pred_size(Succ) <= 1) // not a join node
      continue;
    //  errs()<<Succ->getName()<<"->";
    auto PathSet = HotPathSet[Succ];
    PathSet &= currHotPath; // pathSet(bp->b)
    for (auto& [phi, frameStack] : phiStack) {
      if (frameStack.empty())
        continue;
      for (auto& [phiArgs, phiArgsPath] : frameStack.top().first.frameVector) {
        phiArgsPath &= PathSet;
        defAcc[{Succ, phi}].add(phiArgs, phiArgsPath);
      }
    }
  }
  // // !NOT DONE YET
  // // ! Store topological numbering, sort children of domtree according
  // // to that numbering, then call recursively.
  vector<tuple<int, BasicBlock*, DomTreeNode**>> Children;
  for (auto Child = DTN.begin(); Child != DTN.end(); ++Child) {
    BasicBlock* ChildBB = (**Child).getBlock();
    Children.push_back({topoNum[ChildBB], ChildBB, Child});
    //  errs()<<"Idhar hi fault dedo\n";
    //  errs()<<((*Child == nullptr)?"Yo\bro\n":"Nah\n");
  }
  std::sort(Children.begin(), Children.end()); // ? Is there any other function

  for (auto& [Num, ChildBB, ChildN] : Children) {
    AllocateArgs(ChildBB, **ChildN);
  }

  for (auto& [phi, corr_pStack] : phiStack) {
    corr_pStack.pop(BB);
  }
}

map<BasicBlock*, bool> HPSSAPass::getCaloricConnector(Function& F) {
  map<BasicBlock*, vector<BitVector>> BuddySet;
  map<BasicBlock*, bool> isCaloric;
  int n; // no of hot paths.

  BitVector allPaths;
  ReversePostOrderTraversal<Function*> RPOT(&F);
  fillTopologicalNumbering(RPOT);
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
        for (auto& Buddy : BuddySet[BB]) {
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
    for (auto& buddyDefs : BuddySet[BB]) {
      buddyDefs |= IncubationPath;
    }
    if (hasHotPath && hasColdPath) {
      isCaloric[BB] = true;
      errs() << BB->getName() << " is a Caloric Connector\n";
    }
  }
  return isCaloric;
}

PreservedAnalyses HPSSAPass::run(Function& F, FunctionAnalysisManager& AM) {
  // ! Running on Main Function Only
  // ? Look for alternative as name could not be relied upon
  if (F.getName() != "main") {
    return PreservedAnalyses::all();
  }

  DominatorTree& DT = AM.getResult<DominatorTreeAnalysis>(F);
  getProfileInfo(F);
  auto isCaloric = getCaloricConnector(F);
  map<pair<Instruction*, BasicBlock*>, bool> isInserted;

  // ! Is RPOT same as Topological?
  ReversePostOrderTraversal<Function*> RPOT(&F);

  for (auto J = RPOT.begin(); J != RPOT.end(); ++J) {
    auto BB = *J;
    for (auto& phi : BB->phis()) {
      auto BBHotPaths = HotPathSet[BB];
      // ! Replacing Loops 5 and 6, by the following algo: Traverse the
      // ! subtree rooted at BB in the Dominator tree of CFG and insert taus

      // ! The BFS over Dominator tree is clean but inefficient than on CFG.
      queue<BasicBlock*> BFSQueue;
      BFSQueue.push(BB);
      while (BFSQueue.empty() == false) {
        auto currBB = BFSQueue.front();
        BFSQueue.pop();

        auto currHotPath = HotPathSet[currBB];
        // ! isInserted is not needed in this implementation

        // All the childrens are alerady dominated
        // Corresponding Dominator tree node for BB
        auto& DTNode = *DT.getNode(currBB);
        for (auto Child = DTNode.begin(); Child != DTNode.end(); ++Child)
          BFSQueue.push((**Child).getBlock());

        // traverse along hot paths only
        if (!currHotPath.anyCommon(BBHotPaths) || !isCaloric[currBB])
          continue;
        std::vector<Type*> Tys;
        std::vector<Value*> Args;

        Tys.push_back(phi.getType());
        Args.push_back(dyn_cast<Value>(&phi));

        Function* tau = Intrinsic::getDeclaration(
            F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

        CallInst* TAUNode;
        TAUNode = CallInst::Create(tau, Args, "tau", currBB->getFirstNonPHI());
        corrPhi[TAUNode] = &phi; // Mapping taus to phis
      }
    }
  }
  Search(F.getEntryBlock(), *DT.getRootNode()); // Renaming Algo
  FillFunctionBackedges(F);
  AllocateArgs(&F.getEntryBlock(),
               *DT.getRootNode()); // Argument allocation algo

  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getHPSSAPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HPSSA_new", "v0.1", [](PassBuilder& PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager& FPM,
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
