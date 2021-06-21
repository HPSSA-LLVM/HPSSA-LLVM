#include "headers/HPSSA.h"
using namespace llvm;
using namespace std;

// ? How to Get hot path information from Profiler
pair<vector<vector<string>>, map<string, vector<pair<int,int>>>> HPSSAPass::getProfileInfo(){
  freopen("path.txt", "r", stdin);
  map<string, vector<pair<int,int>>> BBHotPaths;
  vector<vector<string>> PathList;
  int n;
  cin>>n;
  for(int i = 0; i < n; i++) {
    vector<string> path;
    int numNodes;
    cin>>numNodes;
    string node;
    for(int j = 0; j < numNodes; j++){
      cin>>node;
      path.push_back(node);
      BBHotPaths[node].push_back({i,j});
    }
    PathList.push_back(path);
  }
  return {PathList, BBHotPaths};
}
PreservedAnalyses HPSSAPass::run(Function &F, FunctionAnalysisManager &AM) {

  auto out = getProfileInfo();
  auto PathList = out.first; 
  auto BBHotPaths = out.second;
  map <BasicBlock*, vector<vector<int>>> BuddySet;
  map<BasicBlock*, bool> isCaloricConnector;

  for(BasicBlock &BB : F) { // ? Is it Pre-order?
    if(BB.isEntryBlock()) { // * BB is a caloric connector, but it cannot have a phi node
      vector<int> B; // buddies
      for(int i = 0; i < PathList.size(); i++)
        B.push_back(i);
      BuddySet[&BB].push_back(B);
      continue;
    }
    for(BasicBlock *Pred : predecessors(&BB)) {
      
    }
    bool hasHotPath = !(BBHotPaths[(string)BB.getName()]).empty();
    bool hasColdPath = false;
    if(BB.getNum)
    if(hasHotPath && hasColdPath) {
      isCaloricConnector[&BB] = true;
    }
    
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