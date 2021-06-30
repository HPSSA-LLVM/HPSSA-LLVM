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
  for (auto &BB : F) {
    // errs() << BB.getName() << " " << isCaloric[&BB] << "\n";
    for (auto &phi : BB.phis()) {

      // Hot Paths such that if we follow
      // them from parent block we will reach
      // this block in a particular order.
      map<BasicBlock *, BitVector> currPaths;
      currPaths[&BB] = HotPathSet[&BB];
      map<BasicBlock *, bool> isVisited;
      // traverse along hot paths.

      stack<BasicBlock *> toVisit;
      toVisit.push(&BB);

      // DFS
      while (!toVisit.empty()) {
        auto curr = toVisit.top();
        // errs() << "Visiting " << curr->getName() << "\n";

        if (isVisited[curr]) {
          // errs() << curr->getName() << " Already Visited "
          //  << "\n";
          toVisit.pop();
          continue;
        }
        // Dominator frontier of a basic block N is the
        // basic block which is not "strictly" dominated
        // by N and is the "First Reached" on paths from N.
        // If the block itself lies in its dominance frontier
        // then it is possibly a loop header.
        // http://pages.cs.wisc.edu/~fischer/cs701.f05/lectures/Lecture22.pdf

        //! Possibly use df iterators.
        if ((curr != &BB) && !DT.dominates(&phi, curr)) {
          // ! Some problem with this dominator use.
          // ! Not sure if it is correct or not.
          errs() << curr->getName() << " Dominator is Problematic"
                 << "\n";
          toVisit.pop();
          continue;
        }
        // Required condition for tau insertion
        if (isCaloric[curr] && !isInserted[{&phi, curr}]) {
          // Insert tau.
          errs() << "Inserted Tau at : " << curr->getName() << "\n";
          auto TopInstruction = curr->getFirstNonPHI();

          // Type of Arguments in Intrinsic : Remember overloaded.
          std::vector<Type *> Tys;
          Tys.push_back(phi.getType());

          // Actual Argument
          std::vector<Value *> Args;
          Args.push_back(dyn_cast<Value>(&phi));

          // declare and define tau.
          Function *tau = Intrinsic::getDeclaration(
              F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

          CallInst *TAUNode;
          TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

          // Done
          isInserted[{&phi, curr}] = true;
        }

        // Update stack
        toVisit.pop();
        isVisited[curr] = true;

        // Succesors to be visited.
        // ! Weird visiting order observed
        for (auto succ : successors(curr)) {
          // errs() << curr->getName() << " : " << succ->getName() << "\n";
          if (isVisited[succ]) {
            // errs() << succ->getName() << " is already visited \n";
            continue;
          }

          // check whether we are following some hot path
          // or not.
          auto temp = HotPathSet[succ];
          temp &= currPaths[curr];

          if (temp.any()) {
            // errs() << "New insertion to the stack: " << succ->getName() <<
            // "\n";
            currPaths[succ] = temp;
            toVisit.push(succ);
          } else {

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
