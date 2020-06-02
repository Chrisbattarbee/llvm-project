#include "llvm/ADT/SetVector.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstVisitor.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/ValueMap.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Instrumentation.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Scalar.h"
#include <sys/types.h>

#include <iostream>
#include <llvm/ProfileData/InstrProf.h>
#include <llvm/Support/Debug.h>

#include "ValuePrefetching.h"

using namespace llvm;

#define DOMINANT_STRIDE_CUTOFF 0.9
#define LARGE_STRIDE 4096

struct ValuePrefetchingPass : FunctionPass, InstVisitor<ValuePrefetchingPass> {
  /// The module that we're currently working on
  Module *M = 0;
  /// The data layout of the current module.
  DataLayout *DL = 0;
  /// Unique value.  Its address is used to identify this class.
  static char ID;
  /// Call the superclass constructor with the unique identifier as the
  /// (by-reference) argument.

  ValuePrefetchingPass() : FunctionPass(ID) {}

  /// Return the name of the pass, for debugging.
  StringRef getPassName() const override {
    return "Indirect Software Prefetch";
  }

  /// doInitialization - called when the pass manager begins running this
  /// pass on a module.  A single instance of the pass may be run on multiple
  /// modules in sequence.
  bool doInitialization(Module &Mod) override {
    M = &Mod;
    if (DL)
      delete DL;
    DL = new DataLayout(M);
    // Return false on success.

    return false;
  }

  bool runOnFunction(Function &F) override {
    // Large dominant strides
    bool changed = false;
    for (auto BB = F.begin(); BB != F.end(); BB++) {
      for (auto I = BB->begin(); I != BB->end(); I++) {
        if (!dyn_cast<LoadInst>(I)) {
          continue;
        }
        LoadInst* L = dyn_cast<LoadInst>(I);
        uint32_t ActualNumValueData;
        uint64_t TotalC;
        InstrProfValueData ValueDataArray[INSTR_PROF_MAX_NUM_VAL_PER_SITE];
        bool Res = getValueProfDataFromInst(
            *L, IPVK_GepOffset, INSTR_PROF_MAX_NUM_VAL_PER_SITE, ValueDataArray,
            ActualNumValueData, TotalC);

        if (!Res) {
          // No profiling information so we just return true
          dbgs() << "Can not do analysis of dominant strides, no profiling information for " << *I << ".\n";
          continue;
        }

        // Calculate our own totalC because we dont record all data
        TotalC = 0;
        for (int x = 0; x < ActualNumValueData; x ++) {
          TotalC += ValueDataArray[x].Count;
        }

        // Check if there is a large dominant stride
        for (int x = 0; x < ActualNumValueData; x ++) {
          if (((float)ValueDataArray[x].Count) > (((float)TotalC) * 0.9)) {
            if (ValueDataArray[x].Value > LARGE_STRIDE) {
              LoadInst* Load = dyn_cast<LoadInst>(I);
              dbgs() << "Adding large dominant stride prefetching for " << *Load << "\n";
              IRBuilder<> Builder(dyn_cast<Instruction>(I));


              uint64_t Stride = ValueDataArray[x].Value;

              Value* LoadAddress = Load->getPointerOperand();
              Value* LoadAddressInt = Builder.CreatePtrToInt(LoadAddress, Type::getInt64Ty(F.getContext()));
              Value* PrefetchAddressInt = Builder.CreateAdd(LoadAddressInt, ConstantInt::get(Type::getInt64Ty(F.getContext()), Stride * 64));
              Value* PrefetchAddress = Builder.CreateIntToPtr(PrefetchAddressInt, LoadAddress->getType());

              Function *fun =
                  Intrinsic::getDeclaration(F.getParent(), Intrinsic::prefetch, PrefetchAddress->getType());

              Value *IntrinsicArgs[] = {
                  PrefetchAddress, ConstantInt::get(Type::getInt32Ty(M->getContext()), 0),
                  ConstantInt::get(Type::getInt32Ty(M->getContext()), 3),
                  ConstantInt::get(Type::getInt32Ty(M->getContext()), 1)};
              Builder.CreateCall(fun, IntrinsicArgs);
              changed = true;
            }
          }
        }
      }
    }

    // Bimodal Stides
    return changed;
  }
  /// doFinalization - called when the pass manager has finished running this
  /// pass on a module.  It is possible that the pass will be used again on
  /// another module, so reset it to its initial state.
  bool doFinalization(Module &Mod) override {
    assert(&Mod == M);

    delete DL;
    M = nullptr;
    DL = nullptr;
    // Return false on success.

    return false;
  }
};

char ValuePrefetchingPass::ID;

FunctionPass *
llvm::createValuePrefetchingPass() {
  return new ValuePrefetchingPass();
}
