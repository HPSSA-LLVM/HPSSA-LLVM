#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

// ? How to Get hot path information from Profiler

// * Hot Path Information
map<BasicBlock *, BitVector> HPSSAPass::getProfileInfo(Function &F) {
  map<StringRef, BasicBlock *> getPointer;
  for (auto &BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  ifstream reader;
  reader.open("path.txt");
  map<BasicBlock *, BitVector> HotPaths;
  int n;
  reader >> n;
  for (int i = 0; i < n; i++) {
    vector<string> path;
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

map<BasicBlock *, bool> HPSSAPass::getCaloricConnector(Function &F) {
  auto HotPathSet = getProfileInfo(F);

  map<BasicBlock *, vector<BitVector>> BuddySet;
  map<BasicBlock *, bool> isCaloric;
  int n; // no of hot paths.
  for (auto &BB : F) {
    // if entry block
    if (BB.isEntryBlock()) {

      /* Printing stuff */
      errs() << "===-----------------------------------------------------------"
                "--------------===\nCaloric Connector and BuddySet "
                "Information:\n===---------------------------------------------"
                "----------------------------===\n";
      errs() << BB.getName() << ": ";
      BuddySet[&BB].push_back(
          HotPathSet[&BB]); // All hot paths in a signle buddy set;
      for (auto buddy : BuddySet[&BB]) {
        errs() << "{";
        for (int i = 0; i < buddy.size(); i++) {
          errs() << buddy[i] << " ";
        }
        errs() << "} ";
      }
      errs() << "\n";
      /* Printing stuff */
      n = HotPathSet[&BB].size();
      continue;
    }

    BitVector alreadyInSets(n);

    auto currHotPaths = HotPathSet[&BB];

    // This is for edges and not child/current block so
    // maybe we should check this for the
    // parent blocks. If the parent block does not
    // have any hot path flowing through it then
    // the edge from that block to current one has a
    // cold path flowing through it.
    bool hasHotPath = currHotPaths.any();
    // Can an edge have both cold and hot path flowing
    // through it? In particualar consider an edge from
    // a parent which falls on a hot path. Later we found
    // that because all hot definitions reaching to parent
    // are not reaching to this block so this should have
    // a cold path flowing through it. So which type of
    // path is flowing through it.

    // according to current understanding the hotness and
    // coldness should be defined for "definitions".
    // So if all definitions are cold then child gets a cold
    // definition. For unique hot definitions ( Each buddy
    // in buddy set has a unique hot definition and they
    // all are same because the paths are exactly same.) if you miss
    // even one, what you get is not perfectly hot.
    // In other words the (set of) hot definitions from this parent
    // block are somewhat colder.(Not exactly cold).
    bool hasColdPath = false;

    for (auto pred : predecessors(&BB)) {

      // All definition reaching to parent are cold.
      if (HotPathSet[pred].none())
        hasColdPath = true;

      for (auto predBitVector : BuddySet[pred]) {
        // hot paths from this parent to current block.
        predBitVector &= currHotPaths;

        // parent does have a hot definition but
        // does not pass it to the child.
        if (predBitVector.none()) {
          hasColdPath = true;
          continue;
        }
        // As a sidenote, BuddySet only contain sets of
        // hot paths, So it might be empty. Hasn't been
        // so the above condition will cover the 1b case.
        // maybe push all zero if no hot paths, but might
        // complicate things.

        // Given predBitVector and alreadyInset we have to separate the paths
        // which has been inserted in the buddy set and the path which are
        // new.

        auto oldPaths = alreadyInSets;
        oldPaths &= predBitVector;

        auto newPaths = predBitVector;
        newPaths ^= oldPaths;

        // New paths form a different set
        if (newPaths.any())
          BuddySet[&BB].push_back(newPaths);

        // New paths added
        alreadyInSets |= newPaths;

        // New Sets formed
        vector<BitVector> toPush;

        // Old paths should be in same buddy set according to parent
        // but this might not always be the case. we check that by
        // iterating through the sets formed till now. For each parent we
        // go through the sets in child one by one and see if the
        // ones than contain some comman paths need to broken down.

        // *Invariant : All buddy sets in the child block are disjoint.

        for (auto &Buddy : BuddySet[&BB]) {

          auto temp = oldPaths;
          temp &= Buddy;
          // nothing to process
          if (oldPaths.none())
            break;

          // nothing to process
          if (temp.none())
            continue;

          // temp will occur no where again due to invariant.

          // Breakup needed
          // ! llvm bitvector operations are weird
          if (temp != Buddy) {
            // 1st part
            Buddy ^= temp; // check if it works.
            // 2nd part
            toPush.push_back(temp);
          }
          // update Old path
          oldPaths ^= temp;
        }

        for (auto rem : toPush) {
          BuddySet[&BB].push_back(rem);
        }
      }
    }

    if (hasHotPath && hasColdPath) {
      isCaloric[&BB] = true;
      errs() << BB.getName() << " is a Caloric Connector\n";
    }

    /* Printing stuff */
    errs() << BB.getName() << ": ";
    for (auto buddy : BuddySet[&BB]) {
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
/// map<value, phistack>
class phiStack {
  map<BasicBlock *, vector<frame>> phiFrame;

public:
  void push(frame f, BasicBlock *BB) { phiFrame[BB].push_back(f); }
  void pop(BasicBlock *BB) { phiFrame[BB].clear(); }
};

//================= Argument Allocation ====================//

map<pair<PHINode *, BasicBlock *>, frame> defAccumulator;
map<PHINode *, phiStack> val_to_phi;
//* Pass
PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {

  // Only Hotpath information of "main" function is available.
  if (F.getName() != "main") {
    return PreservedAnalyses::all();
  }
  DominatorTree &DT = AM.getResult<DominatorTreeAnalysis>(F);

  // Hot path information
  // ? Avoid doing this thing twice
  auto HotPathSet = getProfileInfo(F);
  auto isCaloric = getCaloricConnector(F);
  map<std::pair<PHINode *, BasicBlock *>, bool> isInserted;

  errs() << "===---------------------------------------------------------------"
            "----------===\nInitiating Tau Insertion "
            "Algroithm\n===----------------------------------------------------"
            "---------------------===\n";

  /// RPOT provides access to the reverse iterators of vector containining
  /// basic blocks in Post order ( Assume DAG )
  ReversePostOrderTraversal<Function *> RPOT(&F);

  for (auto I = RPOT.begin(); I != RPOT.end(); ++I) {
    auto BB = *I; // Pointer to the current basic block being visited
    errs() << BB->getName() << " " << isCaloric[BB] << "\n";

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
      // we need to create a defAccumulator for
      // basic block containing phi function
      // errs()<<"Creating frame for "<<BB->getName()<<"\n";
      for (auto block : predecessors(BB)) {
        auto temp = HotPathSet[BB];
        temp &= HotPathSet[block];
        // the definition does not reach through a hot path
        if (temp.none())
          continue;

        // this definition reach through a hot path
        auto arg = phi.getIncomingValueForBlock(block);
        // errs()<<*arg<<" ";

        // store a pair in pathset
        defAccumulator[{&phi, BB}].add(arg, temp);
      }
      // errs()<<"\n";

      //=====================================================================//
      map<BasicBlock *, bool> isVisited;
      // traverse along hot paths.

      // stack<BasicBlock *> toVisit;
      // toVisit.push(BB);

      // * Need to Do this whole thing in topological
      // * Order. Probably should move this to the top
      // * Because the top loop ensures that we are
      // * doing the DFS + topological traversal.

      // Use RPOT
      for (auto J = I; J != RPOT.end(); ++J) {
        auto curr = *J;
        errs() << "Visiting " << curr->getName() << "\n";

        for (auto defInfo : defAccumulator[{&phi, curr}].frameVector) {
          errs() << defInfo.first->getName() << " ";
          errs() << "{";
          for (int i = 0; i < defInfo.second.size(); i++) {
            errs() << defInfo.second[i] << " ";
          }
          errs() << "}\n";
        }

        // This won't happend
        // if (isVisited[curr]) {
        // errs() << curr->getName() << " Already Visited "
        //  << "\n";
        // continue;
        // }
        // Dominator frontier of a basic block N is the
        // basic block which is not "strictly" dominated
        // by N and is the "First Reached" on paths from N.
        // If the block itself lies in its dominance frontier
        // then it is possibly a loop header.
        // http://pages.cs.wisc.edu/~fischer/cs701.f05/lectures/Lecture22.pdf

        // ! Possibly use df iterators.
        // ! We do not completely understand this dominates function.
        if (curr != BB && !DT.dominates(&phi, curr)) {
          // ! Some problem with this dominator use.
          // ! Not sure if it is correct or not.
          errs() << curr->getName() << " Dominator is Problematic"
                 << "\n";
          break;
        }
        // Required condition for tau insertion
        //=========================================================//

        //============Initiate Tau insertion ======================//
        // We should have stored all reaching definitions in defAccumulator
        // because we are traversing in Reverse Post order
        // So if it is a caloric connector we should insert a tau function
        // with arguments stored in defAccumulator

        // if defAccumulator is empty that means tau insertion is not
        // needed (Spurious Tau functions)

        // Why we do need is Inserted.
        if (isCaloric[curr] && !isInserted[{&phi, curr}] &&
            defAccumulator[{&phi, curr}].size() != 0) {

          errs() << "Inserted Tau at : " << curr->getName() << "\n";
          auto TopInstruction = curr->getFirstNonPHI();

          //==========================================================//
          // We can allocate arguments while inserting a tau
          // no need to first insert and then allocate

          // Type of Arguments in Intrinsic : Remember overloaded.
          // Actual Argument
          std::vector<Type *> Tys;
          std::vector<Value *> Args;

          // Safe part of HPSSA
          Tys.push_back(phi.getType());
          Args.push_back(dyn_cast<Value>(&phi));

          // Speculative arguments.
          auto Frame = defAccumulator[{&phi, curr}].frameVector;

          for (auto it = Frame.begin(); it != Frame.end(); it++) {
            // Tys.push_back(it->first->getType());
            Args.push_back(dyn_cast<Value>(it->first));
          }

          // declare and define tau.
          Function *tau = Intrinsic::getDeclaration(
              F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

          CallInst *TAUNode;
          TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

          // Done
          isInserted[{&phi, curr}] = true;
        }

        // Update stack
        isVisited[curr] = true;

        // Succesors to be visited.
        // ! Weird visiting order observed

        // No fixed order of traversal guaranteed, Probably
        // A better method possible
        for (auto succ : successors(curr)) {
          // Why unnecessarily store things.
          if (!DT.dominates(&phi, succ))
            continue;
          errs() << curr->getName() << " : " << succ->getName() << "\n";

          // check whether we are following some hot path
          // or not.
          auto temp = HotPathSet[succ];
          temp &= currPaths[curr];

          if (temp.any()) {
            // errs() << "New insertion to the stack: " << succ->getName() <<
            // "\n";

            //=================================================================//
            // for each value update the definition that are being passed
            // to this Succesor

            auto currFrame = defAccumulator[{&phi, curr}].frameVector;

            for (auto it = currFrame.begin(); it != currFrame.end(); it++) {
              // for each value update the succesor values
              // that flow through a comman path

              auto comman = it->second;
              comman &= temp;

              // the definition flows along one of the paths
              if (comman.any()) {
                defAccumulator[{&phi, succ}].add(it->first, comman);
              }
            }
            //================================================================//

            // Even if visited might get some definitions through
            // hot paths of parents.
            // if (isVisited[succ]) {
            //   // errs() << succ->getName() << " is already visited \n";

            //   // Needed to assign arguments that's
            //   // why waited till now
            //   continue;
            // }

            // Paths that this succesor will pass
            // now. Note that when succesor time comes
            // we will have most updated current paths
            // i.e. All the paths from all the predecessors
            // of this block.
            currPaths[succ] |= temp;

            // Not visited so push in the waiting list
            // toVisit.push(succ);
            // } else {

            // errs() << "insertion to the stack failed " << succ->getName()
            //  << "\n";
            /* Printing stuff */
            // errs() << "Parent " << curr->getName() << " : { ";
            // for (int i = 0; i < currPaths[curr].size(); i++) {
            //   errs() << currPaths[curr][i] << " ";
            // }
            // errs() << "} \n Succesor: " << succ->getName() << " { ";
            // for (int i = 0; i < HotPathSet[succ].size(); i++) {
            //   errs() << HotPathSet[succ][i] << " ";
            // }
            // errs() << "} \n";
            /* Printing stuff */
          }
        }
      }
    }
  }
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
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hpssa'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHPSSAPluginInfo();
}
