#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

map<BasicBlock *, BitVector> HotPathSet;

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

// Hot Path Information
void HPSSAPass::getProfileInfo(Function &F) {
  map<StringRef, BasicBlock *> getPointer;
  for (auto &BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  ifstream reader;
  reader.open("BBProfiler/profileInfo.txt");
  //   map<BasicBlock *, BitVector> HotPaths;
  int n;
  reader >> n;
  for (int i = 0; i < n; i++) {
    // vector<string> path;
    // getline()
    int numNodes;
    reader >> numNodes;
    string node;
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
map<Value *, vector<Value *>> renaming_stack;
map<pair<BasicBlock *, Value *>, bool> hasPhi, hasTau;
map<Value *, Value *> stackmap;
void HPSSAPass::Search(BasicBlock &BB, DomTreeNode &DTN) {
  // ? Meaning of Ordinary Assignment in LLVM Context
  // ? Should we prune unused tau?

  errs() << "-- BB: " << BB.getName() << "\n";

  for (auto &I : BB) {
    errs() << "---- I: ";
    I.dump();

    errs() << "---- ";
    errs() << "attempt to renaming uses in I\n";
    for (auto &phi : renaming_stack) {
      errs() << "------ ";
      errs() << "phi: " << phi.first->getName() << "\n";
      if (phi.second.back() != NULL) {
        errs() << "------ ";
        errs() << phi.second.back()->getName() << "\n";
        errs() << "------ ";
        errs() << "mrd: " << phi.second.back()->getName() << "\n";
        I.replaceUsesOfWith(phi.first, phi.second.back());
      }
    }

    // tau = (phi1, phi2, ...)
    // x.2 = add phi1, x.3

    if (PHINode *phi = dyn_cast<PHINode>(&I)) {
      errs() << "------ ";
      errs() << "a phi instruction\n";
      hasPhi[{&BB, phi}] = true;
      renaming_stack[phi].push_back(phi);
      stackmap[phi] = phi;
    } else {
      errs() << "------ ";
      errs() << "Not a phi instruction\n";
    }

    if (CallInst *CI = dyn_cast<CallInst>(&I)) {
      Function *CF = CI->getCalledFunction();
      if (CF != NULL && (CF->getIntrinsicID() ==
                         Function::lookupIntrinsicID("llvm.tau"))) { // tau call
        // errs()<<"Entered Call Instruction Logic...\n";
        errs() << "------ ";
        errs() << "a tau instruction\n";

        // ! We assumed first operand of a tau is a PHINode, except its not due
        // ! to nature of our updates. The first operand (which was originally a
        // ! phi ) is being renamed to its most recent tau definition

        // ! TEMPORARY FIX
        if (Value *parPhi = dyn_cast<Value>(CI->getOperand(0))) {
          hasTau[{&BB, stackmap[parPhi]}] = true;
          renaming_stack[stackmap[parPhi]].push_back(&I);
          stackmap[&I] = stackmap[parPhi];
        }
        // ? delay replacing the uses of current instruction?
      } else {
        errs() << "------ ";
        errs() << "Not a tau instruction\n";
      }
    } else {
      errs() << "------ ";
      errs() << "Not a tau instruction\n";
    }
  }

  errs() << "------ ";
  errs() << "Succesor Logic\n";

  for (auto Succ : successors(&BB)) {
    errs() << "-------- ";
    errs() << "Succ: " << Succ->getName() << "\n";
    for (auto &phi : Succ->phis()) {
      errs() << "---------- ";
      errs() << "phi: " << phi.getName() << "\n";
      // ! Assuming this gives the operand coming from this block
      Value *V = phi.getIncomingValueForBlock(&BB);
      errs() << "---------- ";
      errs() << "V: " << V->getName() << "\n";
      if (PHINode *operand = dyn_cast<PHINode>(V)) {
        errs() << "---------- ";
        errs() << "a phi operand\n";
        phi.replaceUsesOfWith(operand,
                              renaming_stack[stackmap[operand]].back());
      } else {
        errs() << "---------- ";
        errs() << "Not a phi operand\n";
      }

      if (CallInst *CI = dyn_cast<CallInst>(V)) {
        Function *CF = CI->getCalledFunction();
        if (CF != NULL &&
            (CF->getIntrinsicID() ==
             Function::lookupIntrinsicID("llvm.tau"))) { // tau call
          // errs()<<"Entered Call Instruction Logic...\n";
          errs() << "---------- ";
          errs() << "a tau operand\n";

          // ! FIX THIS TOO
          if (Value *parPhi = dyn_cast<Value>(CI->getOperand(0))) {
            phi.replaceUsesOfWith(CI, renaming_stack[stackmap[parPhi]].back());
          }
        }
      } else {
        errs() << "---------- ";
        errs() << "Not a tau operand\n";
      }
    }
  }

  errs() << "------ ";
  errs() << "Recurse over Child \n";

  for (auto Child = DTN.begin(); Child != DTN.end(); ++Child) {
    errs() << "-------- ";
    errs() << "Parent: " << DTN.getBlock()->getName();
    errs() << " | Child: " << (**Child).getBlock()->getName() << "\n";
    BasicBlock *ChildBB = (**Child).getBlock();
    Search(*ChildBB, **Child);
  }

  errs() << "------ ";
  errs() << "Remove definitions if needed\n";

  for (auto &varstack : renaming_stack) {
    errs() << "-------- ";
    errs() << "phi: " << varstack.first->getName()
           << " mrd: " << varstack.second.back()->getName() << "\n";
    if (hasTau[{&BB, varstack.first}]) {
      errs() << "---------- ";
      errs() << "mrd changed\n";
      varstack.second.pop_back();
    } else {
      errs() << "---------- ";
      errs() << "mrd not changed\n";
    }
  }
}

bool isPhi(Value *v) { return dyn_cast<PHINode>(v) != nullptr; }
bool isTau(Value *v) { // ! Check this logic
  CallInst *CI = dyn_cast<CallInst>(v);
  if (!CI) {
    return false;
  }

  Function *CF = CI->getCalledFunction();
  if (CF != NULL &&
      (CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau"))) {
    return true;
  }
  return false;
}

BitVector IncubationPaths(BasicBlock *BB) {
  auto BBVector = HotPathSet[BB];
  auto PredVector = BitVector(BBVector.size());
  for (auto pred : predecessors(BB)) {
    PredVector |= HotPathSet[pred];
  }
  BBVector |= PredVector; // BBVector Union PredVector
  BBVector ^= PredVector; // Unset Common Bits

  return BBVector;
}

// x.1 = phi [x.0, z.4, y.3]
map<pair<BasicBlock *, PHINode *>, frame> defAcc;
map<PHINode *, pStack> phiStack;
void AllocateArgs(BasicBlock *BB) {
  for (auto &phi : BB->phis()) {
    auto deFrame = defAcc[{BB, &phi}];
    if (!deFrame.empty()) {
      phiStack[&phi].push(deFrame, BB); // ! IS this  INTELLISENSE problem
    }
    auto topFrame = phiStack[&phi].top().first;
    auto currHotPath = HotPathSet[BB];
    BitVector IncPaths = IncubationPaths(BB);
    if (IncPaths.any()) {
      frame newFrame;
      for (auto &[currDef, hotPath] :
           topFrame.frameVector) { // ? Change to g++14
        newFrame.add(currDef, IncPaths);
      }
      newFrame.add(
          &phi,
          currHotPath); // ? should we separate incubation paths and then add
      for (auto &args : phi.operands()) {
        if (!(isPhi(args) || isTau(args))) {
          
        }
          continue;
        newFrame.add(args, IncPaths);
      }
    }
  }
}

map<BasicBlock *, bool> HPSSAPass::getCaloricConnector(Function &F) {
  //   auto HotPathSet = getProfileInfo(F);

  map<BasicBlock *, vector<BitVector>> BuddySet;
  map<BasicBlock *, bool> isCaloric;
  int n; // no of hot paths.

  BitVector allPaths;
  ReversePostOrderTraversal<Function *> RPOT(&F);
  for (auto I = RPOT.begin(); I != RPOT.end(); ++I) {
    auto BB = *I;
    // Paths incubating from this basic block
    auto IncubationPath = allPaths;
    IncubationPath &= HotPathSet[BB];
    IncubationPath ^= HotPathSet[BB];

    // update allPaths
    allPaths |= IncubationPath;

    if (BB->isEntryBlock()) {

      /* Printing stuff */
      errs() << "----------===";
      errs() << "Caloric Connector and BuddySet Information";
      errs() << "===----------\n";
      errs() << BB->getName() << ": ";

      // All hot paths in a single buddy set;
      BuddySet[BB].push_back(HotPathSet[BB]);
      for (auto buddy : BuddySet[BB]) {
        errs() << "{";
        for (int i = 0; i < buddy.size(); i++) {
          errs() << buddy[i] << " ";
        }
        errs() << "} ";
      }
      errs() << "\n";
      /* Printing stuff */

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
        if (newPaths.any())
          BuddySet[BB].push_back(newPaths);

        // New paths added
        alreadyInSets |= newPaths;

        // New Sets formed
        vector<BitVector> toPush;

        // *Invariant : All buddy sets in the child block are disjoint.

        for (auto &Buddy : BuddySet[BB]) {

          auto temp = oldPaths;
          temp &= Buddy;
          // nothing to process
          if (oldPaths.none())
            break;

          // nothing to process
          if (temp.none())
            continue;

          // Breakup needed
          if (temp != Buddy) {
            // 1st part
            Buddy ^= temp;
            // 2nd part
            toPush.push_back(temp);
          }
          // update Old path
          oldPaths ^= temp;
        }

        for (auto rem : toPush) {
          BuddySet[BB].push_back(rem);
        }
      }
    }

    // * All the definitions reaching to this block are also
    // * avilable along the incubation nodes. Buddy set contains
    // * the set of paths carrying same definition
    // * The buddy sets are no more disjoint.
    for (auto &buddyDefs : BuddySet[BB]) {
      buddyDefs |= IncubationPath;
    }
    if (hasHotPath && hasColdPath) {
      isCaloric[BB] = true;
      errs() << BB->getName() << " is a Caloric Connector\n";
    }

    /* Printing stuff */
    errs() << BB->getName() << ": ";
    for (auto buddy : BuddySet[BB]) {
      errs() << "{ ";
      for (int i = 0; i < buddy.size(); i++) {
        errs() << buddy[i] << " ";
      }
      errs() << "} ";
    }
    errs() << "\n";
    /* Printing stuff */
  }

  return isCaloric;
}
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
};

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {
  // ! Running on Main Function Only
  if (F.getName() !=
      "main") { // ? Look for alternative as name could not be relied upon
    return PreservedAnalyses::all();
  }
  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
  getProfileInfo(F); // Fill the HotPathSet
  auto isCaloric = getCaloricConnector(F);
  map<pair<Instruction *, BasicBlock *>, bool> isInserted;

  ReversePostOrderTraversal<Function *> RPOT(
      &F); // ! Is RPOT same as Topological?

  for (auto J = RPOT.begin(); J != RPOT.end(); ++J) {
    auto BB = *J;
    for (auto &phi : BB->phis()) {
      auto BBHotPaths = HotPathSet[BB];
      // ! Replacing Loops 5 and 6, by the following algo:
      // ! Traverse the subtree rooted at BB in the Dominator tree of CFG and
      // insert taus

      // ! The BFS over Dominator tree is clean but inefficient than
      // ! on CFG.
      queue<BasicBlock *> BFSQueue;
      BFSQueue.push(BB);
      while (BFSQueue.empty() == false) {
        auto currBB = BFSQueue.front();
        BFSQueue.pop();

        auto currHotPath = HotPathSet[currBB];
        // ! isInserted is not needed in this implementation

        // All the childrens are alerady dominated
        auto &DTNode =
            *DT.getNode(currBB); // Corresponding Dominator tree node for BB
        for (auto Child = DTNode.begin(); Child != DTNode.end(); ++Child)
          BFSQueue.push((**Child).getBlock());

        if (!currHotPath.anyCommon(BBHotPaths) ||
            !isCaloric[currBB]) // traverse along hot paths only
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

  AllocateArgs(F.getEntryBlock()); // Argument allocation algo

  return PreservedAnalyses::none();
}

llvm::PassPluginLibraryInfo getHPSSAPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HPSSA", "v0.1", [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hpssa") {
                    FPM.addPass(HPSSAPass());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HPSSA Pass when added to the pass pipeline on the
// command line, i.e. via '-passes=hpssa'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHPSSAPluginInfo();
}
