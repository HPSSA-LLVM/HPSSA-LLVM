// #include "../include/SpecTauInsertion.h"
// using namespace llvm;
// // using namespace std;

// map<Value*, pair<bool, int>> tauSpecInfo;
// PreservedAnalyses SPTauPass::run(Module& M, ModuleAnalysisManager& AM) {

//   // assuming spec function signature takes a pointer to tau (Value*)
//   // and an integer (speculative argument)
//   vector<Type*> Params{Type::getInt32PtrTy(M.getContext()),
//                        Type::getInt32Ty(M.getContext())};
//   FunctionType* fccType =
//       FunctionType::get(Type::getVoidTy(M.getContext()), Params, false);

//   // NOTE - Should we depend on (mangled) name?
//   // TODO - Find alternative
//   Function* specFun =
//       Function::Create(fccType, GlobalValue::ExternalLinkage, "_Z7speci", &M);

//   for (Function& F : M) {

//     // Assuming one function only
//     if (F.isDeclaration())
//       continue;
//     if (F.getName() != "main")
//       continue;

//     // NOTE - Assuming all tau which are speculative were inserted in the map
//     for (auto [tau, specInfo] : tauSpecInfo) {
//       // Sanity check : not needed if only spec. tau are inserted.
//       if (specInfo.first == false)
//         continue;

//       Instruction* I = dyn_cast<Instruction>(tau);
//       CallInst* CI = dyn_cast<CallInst>(I);
//       Function* CF = CI->getCalledFunction();
//       errs() << "Speculative Tau: " << CF->getName() << "\t\n";
//       std::vector<Value*> Args;
//       Args.push_back(I);
//       Args.push_back(
//           ConstantInt::get(Type::getInt32Ty(M.getContext()), specInfo.second));
//       CallInst* SpecTau;
//       SpecTau = CallInst::Create(specFun, Args, "", I->getNextNode());
//       I->replaceAllUsesWith(SpecTau);
//     }
//   }
//   return PreservedAnalyses::none();
// }

// llvm::PassPluginLibraryInfo getSpecTauInsertionPluginInfo() {
//   return {LLVM_PLUGIN_API_VERSION, "SpecTauInsertion", "v0.1", [](PassBuilder& PB) {
//             PB.registerPipelineParsingCallback(
//                 [](StringRef Name, ModulePassManager& MPM,
//                    ArrayRef<PassBuilder::PipelineElement>) {
//                   if (Name == "sptau") {
//                     MPM.addPass(SPTauPass());
//                     return true;
//                   }
//                   return false;
//                 });
//           }};
// }

// // This is the core interface for pass plugins. It guarantees that 'opt' will
// // be able to recognize TConditional Pass when added to the pass pipeline on
// // the command line, i.e. via '-passes=tcond'
// extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
// llvmGetPassPluginInfo() {
//   return getSpecTauInsertionPluginInfo();
// }