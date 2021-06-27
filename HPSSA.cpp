#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

// ? How to Get hot path information from Profiler

// * Hot Path Information
map<BasicBlock*, BitVector>
HPSSAPass::getProfileInfo(Function &F) {
  map<StringRef, BasicBlock*> getPointer;
  for(auto &BB : F) {
    getPointer[BB.getName()] = &BB;
  }
  // freopen("path.txt", "r", stdin);
  ifstream reader;
  reader.open("path.txt");
  map<BasicBlock*, BitVector> HotPaths;
  int n;
  reader >> n;
  for (int i = 0; i < n; i++) {
    vector<string> path;
    int numNodes;
    reader >> numNodes;
    string node;
    for (int j = 0; j < numNodes; j++) {
      reader >> node;
      if(HotPaths[getPointer[node]].size() == 0) {
        HotPaths[getPointer[node]].resize(n);
      }
      HotPaths[getPointer[node]].set(i);
      // path.push_back(node);
      // BBHotPaths[node].push_back({i, j});
    }
    // HotPathList.push_back(path);
  }
  reader.close();
  return HotPaths;
}

//* Pass
PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {

  // Only Hotpath information of "main" function is available.
  if (F.getName() != "main") {
    return PreservedAnalyses::all();
  }

  // Hot path information
  auto HotPathSet = getProfileInfo(F);

//   vector<vector<BasicBlock *>> allPaths; // both hot and cold
//   vector<BasicBlock *> currPath;         // current path being visited
//   map<string, int>
//       numPaths; // total number of paths passing through a Basic Block
//   traverseAllPaths(allPaths, currPath, &F.getEntryBlock());
//   for (auto Path : allPaths) {
//     for (auto BB : Path) {
//       numPaths[(string)BB->getName()]++;
//     }
//   }

//   // Always using name of Block to get information
//   map<string, vector<vector<int>>> BuddySet;
//   // map<BasicBlock *, bool> isCaloricConnector;
//   vector<BasicBlock *> CaloricConnectors;

//   // TODO : Use Pointers instead of name in all data structures.
//   // Irrevelant after some time because we will use profiler data.

//   // ! Really Ugly thing to do
//   map<string, BasicBlock *> nameToBlock;
//   for (BasicBlock &BB : F) { // CFG + Topologically sorted.
//     // temporary solution for getting Basic block from name.
//     nameToBlock[(string)BB.getName()] = &BB;
//     // errs()<< BB.getName()<<" "<< numPaths[(string)BB.getName()] <<"\n";

//     map<int, bool> isTupled;
//     // Populate BuddySet
//     for (auto P1 : BBHotPaths[(string)BB.getName()]) {
//       // already added to any buddyset tuple
//       if (isTupled[P1.first]) {
//         continue;
//       }
//       // tuple containing hot paths carrying same definition as P1.
//       vector<int> B;
//       B.push_back(P1.first);
//       isTupled[P1.first] = true;
//       for (auto P2 : BBHotPaths[(string)BB.getName()]) {
//         // if index of current block is not same then
//         // the paths cannot be same for sure.
//         if (isTupled[P2.first] || P1.second != P2.second) {
//           continue;
//         }
//         bool isBuddy = true;
//         for (int i = 0; i < P1.second; i++) {
//           // Every node must be same.
//           if (HotPathList[P1.first][i] != HotPathList[P2.first][i]) {
//             isBuddy = false;
//             break;
//           }
//         }
//         if (isBuddy) {
//           B.push_back(P2.first);
//           isTupled[P2.first] = true;
//         }
//       }
//       // For Entry Block All hot paths will be equal
//       // As there is only one block to compare.
//       BuddySet[(string)BB.getName()].push_back(B);
//     }

//     // Entry Block cannot be a Caloric connector
//     // Even if it has both hot and cold paths
//     // Because No PHI Node above/in it.
//     if (BB.isEntryBlock())
//       continue;

//     bool hasHotPath = !(BBHotPaths[(string)BB.getName()]).empty();
//     bool hasColdPath = false;

//     // Checking if every edge coming to BB lie on a Hot Path.
//     for (auto Pred : predecessors(&BB)) {
//       bool isPresent = false; // All cold paths
//       for (auto HotPaths :
//            BBHotPaths[(string)Pred->getName()]) { // iterate over all hot path
//         if (HotPaths.second + 1 < HotPathList[HotPaths.first].size()) {
//           if (HotPathList[HotPaths.first][HotPaths.second + 1] ==
//               BB.getName()) {
//             isPresent = true; // lie on a hot path.
//             break;
//           }
//         }
//       }
//       // No hot path contain this edge.
//       if (!isPresent) {
//         hasColdPath = true;
//         break;
//       }
//     }
//     // Even if all edges are hot some definitions may reach cold through them.
//     if (!hasColdPath) {
//       // BuddySet Logix
//       // store all hot paths separately
//       vector<int> pathIndexBB; // TODO : Avoid Doing this : DRY
//       for (auto p : BBHotPaths[(string)BB.getName()]) {
//         pathIndexBB.push_back(p.first);
//       }

//       // Iterate over all hot paths
//       for (auto BlockPosition : BBHotPaths[(string)BB.getName()]) {
//         // Parent block from where the hot definition came
//         string HotDefCarrier =
//             HotPathList[BlockPosition.first]
//                        [BlockPosition.second -
//                         1]; // Safe because it is not entry block.

//         // Iterating over set of paths having same hot definition
//         for (auto SameDef : BuddySet[HotDefCarrier]) {

//           // Index of first Common element between the Vector
//           // Containing Path passing through this block and
//           // The Vector Carrying a particular hot definition.
//           auto matchPosition =
//               find_first_of(pathIndexBB.begin(), pathIndexBB.end(),
//                             SameDef.begin(), SameDef.end());

//           // If none hot definition missing
//           if (matchPosition == pathIndexBB.end()) {
//             hasColdPath = true;
//             break;
//           }
//         }
//         if (hasColdPath)
//           break;
//       }
//     }
//     // Cannot be caloric connector.
//     if (BB.isEntryBlock())
//       continue;

//     // Temperature difference.
//     if (hasColdPath && hasHotPath) {
//       CaloricConnectors.push_back(&BB);
//     }
//   }

//   for (auto &BB : CaloricConnectors) {
//     errs() << BB->getName() << "\n";
//   }
//   map<std::pair<PHINode *, BasicBlock *>, bool> isInserted;
//   // Basic block traversal in Topological order.
//   for (auto &BB : F) {
//     // Iterate over Only phi instructions
//     for (auto &phi : BB.phis()) {
//       // Go along Each hot path.
//       for (auto HotPathInfo : BBHotPaths[(string)BB.getName()]) {
//         auto PathIndex = HotPathInfo.first;
//         auto BlockPosition = HotPathInfo.second;
//         // Traverse the blocks on these paths till dom-frontier.
//         for (int i = BlockPosition; i < HotPathList[PathIndex].size(); i++) {
//           // Get block name;
//           auto SuccessorName = HotPathList[PathIndex][i];
//           auto Successor = nameToBlock[SuccessorName];
//           // TODO : Check if dom-frontier : Break.

//           if (isInserted[{&phi, Successor}])
//             continue;


//           // ? Use Unordered Set in place of Vector.
//           // If not a caloric connector continue.
//           if (find(CaloricConnectors.begin(), CaloricConnectors.end(),
//                    Successor) == CaloricConnectors.end())
//             continue;

//           // Need to insert tau function.

//           // First Non-Phi instruction.
//           auto TopInstruction = Successor->getFirstNonPHI();

//           // create tau function


//           // Type of Arguments in Intrinsic : Remember overloaded.
//           std::vector<Type *> Tys;
//           Tys.push_back(phi.getType());

//           // declare and define tau.
//           Function *tau = Intrinsic::getDeclaration(
//               F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);

//           // Argument is phi.
//           std::vector<Value *> Args;
//           Args.push_back(dyn_cast<Value>(&phi));

          
//           // Create Tau Call instance and insert it.
//           CallInst *TAUNode;
//           TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

//           // Done
//           isInserted[{&phi, Successor}] = true;
//         }
//       }
//     }
//   }

//   // ReversePostOrderTraversal<Function *> RPOT(&F); // Expensive to create
//   // DenseMap<std::pair<PHINode *, BasicBlock *>, bool> isInserted;
//   // for (BasicBlock *BB : CaloricConnectors) {
//   //   Instruction *TopInstruction = BB->getFirstNonPHI();
//   //   for (auto &phi : BB->phis()) {
//   //     // DenseMap<BasicBlock*,bool> vis;
//   //     std::vector<Type *> Tys;
//   //     Tys.push_back(phi.getType());

//   //     // create tau function
//   //     Function *tau = Intrinsic::getDeclaration(
//   //         F.getParent(), Function::lookupIntrinsicID("llvm.tau"), Tys);
//   //     std::vector<Value *> Args;
//   //     Args.push_back(dyn_cast<Value>(&phi));
//   //     Args.push_back(dyn_cast<Value>(&phi));

//   //     // Create Tau Call instance
//   //     CallInst *TAUNode;
//   //     TAUNode = CallInst::Create(tau, Args, "tau", TopInstruction);

//   //     // Insert Tau
//   //     for (auto phi_user : phi.users()) {
//   //       // errs() << *phi_user << "\n";
//   //       if (phi_user != TAUNode) {
//   //         phi_user->replaceUsesOfWith(&phi, TAUNode);
//   //       }
//   //     }
//   //   }
//   // }

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
