#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

// ? How to Get hot path information from Profiler
pair<vector<vector<string>>, map<string, vector<pair<int, int>>>>
HPSSAPass::getProfileInfo() {
  freopen("path.txt", "r", stdin);
  map<string, vector<pair<int, int>>> BBHotPaths;
  vector<vector<string>> PathList;
  int n;
  cin >> n;
  for (int i = 0; i < n; i++) {
    vector<string> path;
    int numNodes;
    cin >> numNodes;
    string node;
    for (int j = 0; j < numNodes; j++) {
      cin >> node;
      path.push_back(node);
      BBHotPaths[node].push_back({i, j});
    }
    PathList.push_back(path);
  }
  return {PathList, BBHotPaths};
}
void HPSSAPass::traverseAllPaths(vector<vector<BasicBlock*>> &allPaths, vector<BasicBlock*> &currPath, BasicBlock* BB) {
  currPath.push_back(BB);
  if(BB->isSentinel()) {
    allPaths.push_back(currPath);
    currPath.pop_back();
    return;
  }
  for(auto SB : successors(BB)) {
    traverseAllPaths(allPaths, currPath, SB);
  }
  currPath.pop_back();
}
PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {

  if(F.getName() != "main") {
    return PreservedAnalyses::all();
  }
  
  auto out = getProfileInfo();
  auto PathList = out.first;
  auto BBHotPaths = out.second;

  vector<vector<BasicBlock*>> allPaths; //both hot and cold
  vector<BasicBlock*> currPath; //current path being visited
  map<string, int> numPaths; //total number of paths passing through a Basic Block
  traverseAllPaths(allPaths, currPath, &F.getEntryBlock());
  for(auto v : allPaths) {
    for(auto i : v) {
      numPaths[(string)i->getName()]++;
    }
  }

  // ! Always using name of Block to get information : See if it works
  map<string, vector<vector<int>>> BuddySet;
  // map<BasicBlock *, bool> isCaloricConnector;
  vector<BasicBlock *> CaloricConnectors;

  for (BasicBlock &BB : F) { // ? Is it Pre-order?

    // * No special Case for Entry Block while creating Buddy Set
    // * Skip Later.

    // if (BB.isEntryBlock()) { // * BB is a caloric connector, but it cannot
    // have
    //                          // a phi node
    //   vector<int> B;         // buddies
    //   // ? What if path list contains paths which start at loop header.
    //   Better
    //   // ? Use BBHotPaths[BB]'s first value.
    //   // for (int i = 0; i < PathList.size(); i++)
    //   //   B.push_back(i);
    //   // ? Should only contain hot paths.
    //   for(auto BlockPosition: BBHotPaths[(string)BB.getName()])
    //   BuddySet[(string)BB.getName()].push_back(B);
    //   continue;
    // }

    // Creating BuddySet
    map<int, bool> isTupled;
    for (auto P1 : BBHotPaths[(string)BB.getName()]) {
      // already added to any buddyset tuple
      if (isTupled[P1.first]) {
        continue;
      }
      // tuple containing paths
      vector<int> B;
      B.push_back(P1.first);
      isTupled[P1.first] = true;
      for (auto P2 : BBHotPaths[(string)BB.getName()]) {
        // if index of current block is not same then the paths cannot be same
        // for sure.
        if (isTupled[P2.first] || P1.second != P2.second) {
          continue;
        }
        bool isBuddy = true;
        for (int i = 0; i < P1.second; i++) {
          if (PathList[P1.first][i] != PathList[P2.first][i]) {
            isBuddy = false;
            break;
          }
        }
        if (isBuddy) {
          B.push_back(P2.first);
          isTupled[P2.first] = true;
        }
      }
      // For Entry Block All hot paths will be equal by default
      // As there is only one block to compare.
      BuddySet[(string)BB.getName()].push_back(B);
    }

    // Entry Block cannot be a Caloric connector
    // Even if it has both hot and cold paths
    // Because No PHI Node above/in it.
    if (BB.isEntryBlock())
      continue;

    bool hasHotPath = !(BBHotPaths[(string)BB.getName()]).empty();
    bool hasColdPath = false;

    // If all paths are not hot then some are cold.
    // // FIXME : 1 predecessor might give more than 1 path.
    // if (distance(predecessors(&BB).begin(), predecessors(&BB).end()) !=
    //     BBHotPaths[(string)BB.getName()].size()) {
    //   hasColdPath = true;
    // }
    predecessors(&BB).begin();
    predecessors(&BB).end();
    // Even if all paths are hot some definitions may reach cold.
    if (!hasColdPath) {
      // BuddySet Logix
      // store all hot paths separately
      vector<int> pathIndexBB; // TODO : Avoid Doing this : DRY
      for (auto p : BBHotPaths[(string)BB.getName()]) {
        pathIndexBB.push_back(p.first);
      }

      // Iterate over all hot paths
      for (auto BlockPosition : BBHotPaths[(string)BB.getName()]) {
        // Parent block from where the hot definition came
        string HotDefCarrier =
            PathList[BlockPosition.first]
                    [BlockPosition.second -
                     1]; // Safe because it is not entry block.

        // Iterating over set of paths having same hot definition
        for (auto SameDef : BuddySet[HotDefCarrier]) {

          // Index of first Common element between the two vectors.
          auto matchPosition =
              find_first_of(pathIndexBB.begin(), pathIndexBB.end(),
                            SameDef.begin(), SameDef.end());

          // If none hot definition missing
          if (matchPosition == pathIndexBB.end()) {
            hasColdPath = true;
            break;
          }
        }
        if (hasColdPath)
          break;
      }
    }
    // Cannot be caloric connector.
    if (BB.isEntryBlock())
      continue;

    // Temperature difference.
    if (hasColdPath && hasHotPath) {
      CaloricConnectors.push_back(&BB);
    }
  }

  for (auto &BB : CaloricConnectors) {
    errs() << BB->getName() << "\n";
  }
  // ReversePostOrderTraversal<Function *> RPOT(&F); // Expensive to create
  // DenseMap<std::pair<PHINode *, BasicBlock *>, bool> isInserted;
  // for (BasicBlock *BB : RPOT) {
  //   Instruction *TopInstruction = BB->getFirstNonPHI();
  //   for (auto &phi : BB->phis()) {
  //     // DenseMap<BasicBlock*,bool> vis;
  //     std::vector<Type *> Tys;
  //     Tys.push_back(phi.getType());

  //     // create tau function
  //     Function *tau = Intrinsic::getDeclaration(
  //         F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);
  //     std::vector<Value *> Args;
  //     Args.push_back(dyn_cast<Value>(&phi));
  //     Args.push_back(dyn_cast<Value>(&phi));

  //     // Create Tau Call instance
  //     CallInst *TAUNode;
  //     TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

  //     // Insert Tau
  //     for (auto phi_user : phi.users()) {
  //       // errs() << *phi_user << "\n";
  //       if (phi_user != TAUNode) {
  //         phi_user->replaceUsesOfWith(&phi, TAUNode);
  //       }
  //     }
  //   }
  // }

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
