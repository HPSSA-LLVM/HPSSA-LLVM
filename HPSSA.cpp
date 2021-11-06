#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

// Hot Path Information
map<BasicBlock *, BitVector> HPSSAPass::getProfileInfo(Function &F) {
  map<StringRef, BasicBlock *> getPointer;
  for (auto &BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  ifstream reader;
  reader.open("BBProfiler/profileInfo.txt");
  map<BasicBlock *, BitVector> HotPaths;
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
      if (HotPaths[getPointer[node]].size() == 0) {
        HotPaths[getPointer[node]].resize(n);
      }
      HotPaths[getPointer[node]].set(i);
    }
  }
  reader.close();
  return HotPaths;
}
// After Buddy set creation check if it is a loop header
// if yes :
//            Union the incubating hot paths with every buddy set
//                      |-> taking xor with hot paths of entry block
map<Value*,vector<Value*>> renaming_stack; 
map<pair<BasicBlock*,Value*>, bool> hasPhi, hasTau; // if BB has corresponding phi or tau instruction
void HPSSAPass::Search(BasicBlock &BB, DomTreeNode &DTN) { // ? Meaning of Ordinary Assignment in LLVM Context
  // ? Should we prune unused tau?
  for(auto &I: BB) {
    // this is a change
    for(auto phi: renaming_stack) {
      // errs()<<"Trying to Replace...\n";
      I.replaceUsesOfWith(phi.first, phi.second.back());
    }
    if(PHINode* phi = dyn_cast<PHINode>(&I)) { // if is a phi
      hasPhi[{&BB,phi}] = true;
      renaming_stack[phi].push_back(phi); // renaming stack for phi created
    }
    if(CallInst* CI = dyn_cast<CallInst>(&I)) {
      Function *CF = CI->getCalledFunction();
      CI->getOperand(0)->dump();
      if(CF != NULL && (CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau"))) { // tau call
        // errs()<<"Entered Call Instruction Logic...\n";
        hasTau[{&BB,CI->getOperand(0)}] = true;
        renaming_stack[CI->getOperand(0)].push_back(&I); // tauNode pushed to the renaming stack of corresponding phi
      }
    }
  }

  for(auto Succ: successors(&BB)) {
    for(auto &phi: Succ->phis()) {
      Value* V = phi.getIncomingValueForBlock(&BB); // ! Assuming this gives the operand coming from this block
      if(PHINode* operand = dyn_cast<PHINode>(V)) { // if is a phi
        phi.replaceUsesOfWith(operand, renaming_stack[operand].back());
      }
      if(CallInst* CI = dyn_cast<CallInst>(V)) {
        Function *CF = CI->getCalledFunction();
        CI->getOperand(0)->dump();
        if(CF != NULL && (CF->getIntrinsicID() == Function::lookupIntrinsicID("llvm.tau"))) { // tau call
          // errs()<<"Entered Call Instruction Logic...\n";
          phi.replaceUsesOfWith(CI, renaming_stack[CI->getOperand(0)].back()); // tau replaced with the current top
        }
      }
    }
  }

  for(auto Child = DTN.begin(); Child != DTN.end(); ++Child) {
    // errs()<<"DomPar: "<<DTN.getBlock()->getName()<<" DomChild: "<<(**Child).getBlock()->getName()<<"\n";
      BasicBlock* ChildBB = (**Child).getBlock();
      Search(*ChildBB, **Child);
  }

  for(auto &varstack: renaming_stack) {
    if(hasTau[{&BB,varstack.first}]) {
      varstack.second.pop_back();
    }
  }
  // errs()<<"Stack at BB "<<BB.getName()<<": \n";
  // for(auto &BBphi: BB.phis()) {
  //   errs()<<"Size of Stack for phi "<<BBphi.getName()<<": "<<renaming_stack[&BBphi].size()<<"\n";
  //     // renaming_stack[&BBphi].pop_back();
  //   if(hasTau[{&BB, &BBphi}]) {
  //     renaming_stack[&BBphi].pop_back();
  //   }
  //   // errs()<<"PHI Variable "<<BBphi.getName()<<" :\n";
  //   // for(auto phi: renaming_stack[&BBphi]) {
  //   //   phi->dump();
  //   // }
  // }
  
}

map<BasicBlock *, bool> HPSSAPass::getCaloricConnector(Function &F) {
  auto HotPathSet = getProfileInfo(F);

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
      errs() << "--------------===\n Caloric Connector and BuddySet "
                "Information\n===--------------\n";
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

//================= Argument Allocation ====================//

map<pair<PHINode *, BasicBlock *>, frame> defAccumulator;

PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {

  if (F.getName() != "main") {
    return PreservedAnalyses::all();
  }
  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);
  // Hot path information
  // ? Avoid doing this thing twice
  auto HotPathSet = getProfileInfo(F);
  auto isCaloric = getCaloricConnector(F);
  map<std::pair<PHINode *, BasicBlock *>, bool> isInserted;

  errs()
      << "----------===\nInitiating Tau Insertion Algroithm\n===----------\n";

  /// RPOT provides access to the reverse iterators of vector containining
  /// basic blocks in Post order ( Assume DAG )
  ReversePostOrderTraversal<Function *> RPOT(&F);

  /// Store all paths that have been visited till now
  // BitVector allPaths;

  for (auto I = RPOT.begin(); I != RPOT.end(); ++I) {
    auto BB = *I; // Pointer to the current basic block being visited
    // errs() << BB->getName() << " " << isCaloric[BB] << "\n";

    // Paths incubating from this basic block
    // auto IncubationPath = allPaths;
    // IncubationPath &= HotPathSet[BB];
    // IncubationPath ^= HotPathSet[BB];

    // update allPaths
    // allPaths |= IncubationPath;

    // current phi whose definitions will be filtered by taus
    for (auto &phi : BB->phis()) {

      // Hot Paths such that if we follow them from parent block we will reach
      // this block in a particular order
      map<BasicBlock *, BitVector> currPaths;
      currPaths[BB] = HotPathSet[BB];

      // no hot path originates from here
      if (currPaths[BB].none())
        continue;

      //======================================================================//
      for (auto block : predecessors(BB)) {
        auto temp = HotPathSet[BB];
        temp &= HotPathSet[block];

        // Update temp to store new paths originating from BB itself;
        // temp |= IncubationPathSet ^ ( IncubationPathSet& HotPathSet );
        // IncubationPathSet |= HotPathSet

        // the definition does not reach through a hot path
        if (temp.none())
          continue;

        // this definition reach through a hot path
        auto arg = phi.getIncomingValueForBlock(block);
        // errs()<<*arg<<" ";

        // store a pair in pathset
        // * Add incubation nodes too
        // ? Remove hot backedge or not ?
        defAccumulator[{&phi, BB}].add(arg, temp);

        // add paths originating from here
        // this argument is available on these paths too
        // but for that should come from parent.
        // defAccumulator[{&phi,BB}].add(arg,IncubationPath);
      }

      // errs()<<"\n";

      //=====================================================================//
      // traverse along hot paths.
      // Use RPOT
      for (auto J = I; J != RPOT.end(); ++J) {
        auto curr = *J;
        // errs() << "Visiting " << curr->getName() << "\n";

        // for (auto defInfo : defAccumulator[{&phi, curr}].frameVector) {
        //   errs() << defInfo.first->getName() << " ";
        //   errs() << "{";
        //   for (int i = 0; i < defInfo.second.size(); i++) {
        //     errs() << defInfo.second[i] << " ";
        //   }
        //   errs() << "}\n";
        // }

        // http://pages.cs.wisc.edu/~fischer/cs701.f05/lectures/Lecture22.pdf

        // ! Not sure why we need to explicitily check whether the given
        // ! block is current block
        if (curr != BB && !DT.dominates(&phi, curr)) {
          errs() << "Reached the Dominance frontier while visiting from: "
                 << curr->getName() << "\n";
          break;
        }
        // Required condition for tau insertion
        if (isCaloric[curr] && !isInserted[{&phi, curr}] &&
            defAccumulator[{&phi, curr}].size() != 0) {

          auto TopInstruction = curr->getFirstNonPHI();

          std::vector<Type *> Tys;
          std::vector<Value *> Args;

          // Safe part of HPSSA
          Tys.push_back(phi.getType());
          Args.push_back(dyn_cast<Value>(&phi));

          // Speculative arguments
          auto Frame = defAccumulator[{&phi, curr}].frameVector;

          for (auto Info : Frame) {
            Args.push_back(Info.first);
          }

          Function *tau = Intrinsic::getDeclaration(
              F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

          CallInst *TAUNode;
          TAUNode = CallInst::Create(tau, Args, "tau", curr->getFirstNonPHI());
          
          // for(auto user: phi.users()) {
          //   CallInst *User = dyn_cast<CallInst>(user);
          //   if(User == NULL || User != TAUNode) {
          //     user->replaceUsesOfWith(&phi, TAUNode);
          //   } 
          // }
          // Done
          isInserted[{&phi, curr}] = true;

          errs() << "Inserted Tau at : " << curr->getName() << "\n";
        }

        for (auto succ : successors(curr)) {
          if (!DT.dominates(&phi, succ))
            continue;
          // errs() << curr->getName() << " : " << succ->getName() << "\n";

          auto temp = HotPathSet[succ];
          temp &= currPaths[curr];

          if (temp.any()) {
            auto currFrame = defAccumulator[{&phi, curr}].frameVector;

            for (auto it = currFrame.begin(); it != currFrame.end(); it++) {

              auto comman = it->second;
              comman &= temp;

              // the definition flows along one of the paths
              if (comman.any()) {
                defAccumulator[{&phi, succ}].add(it->first, comman);
              }
            }

            currPaths[succ] |= temp;
          }
        }
      }
    }
  }
  // DomTreeNode *DTN = getNode(F.getEntryBlock());
  Search(F.getEntryBlock(), *DT.getRootNode());
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
