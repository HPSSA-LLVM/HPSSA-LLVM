//===- ValueLattice.h - Value constraint analysis ---------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_ANALYSIS_VALUELATTICE_H
#define LLVM_ANALYSIS_VALUELATTICE_H

#define DEBUG_TYPE "tausccp"

#include "llvm/IR/ConstantRange.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/raw_ostream.h"

//
//===----------------------------------------------------------------------===//
//                               SpecValueLatticeElement
//===----------------------------------------------------------------------===//

namespace llvm {

/// This class represents lattice values for constants.
///
/// FIXME: This is basically just for bringup, this can be made a lot more rich
/// in the future.
///
class SpecValueLatticeElement {
  enum SpecValueLatticeElementTy {
    /// This Value has no known value yet.  As a result, this implies the
    /// producing instruction is dead.  Caution: We use this as the starting
    /// state in our local meet rules.  In this usage, it's taken to mean
    /// "nothing known yet".
    /// Transition to any other state allowed.
    unknown,

    /// This Value is an UndefValue constant or produces undef. Undefined values
    /// can be merged with constants (or single element constant ranges),
    /// assuming all uses of the result will be replaced.
    /// Transition allowed to the following states:
    ///  constant
    ///  constantrange_including_undef
    ///  overdefined
    undef,

    /// This Value has a specific constant value.  The constant cannot be undef.
    /// (For constant integers, constantrange is used instead. Integer typed
    /// constantexprs can appear as constant.) Note that the constant state
    /// can be reached by merging undef & constant states.
    /// Transition allowed to the following states:
    ///  overdefined
    constant,

    /// This Value has a speculative constant value.  The constant cannot be undef.
    /// (For constant integers, constantrange is used instead. Integer typed
    /// constantexprs can appear as constant.) Note that the constant state
    /// can be reached by merging undef & constant states.
    /// Transition allowed to the following states:
    ///  overdefined
    spec_constant,

    /// This Value is known to not have the specified value. (For constant
    /// integers, constantrange is used instead.  As above, integer typed
    /// constantexprs can appear here.)
    /// Transition allowed to the following states:
    ///  overdefined
    notconstant,

    /// The Value falls within this range. (Used only for integer typed values.)
    /// Transition allowed to the following states:
    ///  constantrange (new range must be a superset of the existing range)
    ///  constantrange_including_undef
    ///  overdefined
    constantrange,

    /// This Value falls within this range, but also may be undef.
    /// Merging it with other constant ranges results in
    /// constantrange_including_undef.
    /// Transition allowed to the following states:
    ///  overdefined
    constantrange_including_undef,

    /// We can not precisely model the dynamic values this value might take.
    /// No transitions are allowed after reaching overdefined.
    overdefined,
  };

  SpecValueLatticeElementTy Tag : 8;
  
  /// Number of times a constant range has been extended with widening enabled.
  unsigned NumRangeExtensions : 8;

  /// The union either stores a pointer to a constant or a constant range,
  /// associated to the lattice element. We have to ensure that Range is
  /// initialized or destroyed when changing state to or from constantrange.
  union {
    Constant *ConstVal;
    ConstantRange Range;
  };

  /// Destroy contents of lattice value, without destructing the object.
  void destroy() {
    switch (Tag) {
    case overdefined:
    case unknown:
    case undef:
    case constant:
    case spec_constant:
    case notconstant:
      break;
    case constantrange_including_undef:
    case constantrange:
      Range.~ConstantRange();
      break;
    };
  }

public:
  SpecValueLatticeElementTy Shadow_Tag : 8;
  /// Struct to control some aspects related to merging constant ranges.
  struct MergeOptions {
    /// The merge value may include undef.
    bool MayIncludeUndef;

    /// Handle repeatedly extending a range by going to overdefined after a
    /// number of steps.
    bool CheckWiden;

    /// The number of allowed widening steps (including setting the range
    /// initially).
    unsigned MaxWidenSteps;

    MergeOptions() : MergeOptions(false, false) {}

    MergeOptions(bool MayIncludeUndef, bool CheckWiden,
                 unsigned MaxWidenSteps = 1)
        : MayIncludeUndef(MayIncludeUndef), CheckWiden(CheckWiden),
          MaxWidenSteps(MaxWidenSteps) {}

    MergeOptions &setMayIncludeUndef(bool V = true) {
      MayIncludeUndef = V;
      return *this;
    }

    MergeOptions &setCheckWiden(bool V = true) {
      CheckWiden = V;
      return *this;
    }

    MergeOptions &setMaxWidenSteps(unsigned Steps = 1) {
      CheckWiden = true;
      MaxWidenSteps = Steps;
      return *this;
    }
  };

  // ConstVal and Range are initialized on-demand.
  SpecValueLatticeElement() : Tag(unknown), Shadow_Tag(unknown), 
    NumRangeExtensions(0) {}

  ~SpecValueLatticeElement() { destroy(); }

  SpecValueLatticeElement(const SpecValueLatticeElement &Other)
      : Tag(Other.Tag), Shadow_Tag(Other.Tag), NumRangeExtensions(0) {
    switch (Other.Tag) {
    case constantrange:
    case constantrange_including_undef:
      new (&Range) ConstantRange(Other.Range);
      NumRangeExtensions = Other.NumRangeExtensions;
      break;
    case constant:
    case spec_constant:
    case notconstant:
      ConstVal = Other.ConstVal;
      break;
    case overdefined:
    case unknown:
    case undef:
      break;
    }
  }

  SpecValueLatticeElement(SpecValueLatticeElement &&Other)
      : Tag(Other.Tag), Shadow_Tag(Other.Tag), NumRangeExtensions(0) {
    switch (Other.Tag) {
    case constantrange:
    case constantrange_including_undef:
      new (&Range) ConstantRange(std::move(Other.Range));
      NumRangeExtensions = Other.NumRangeExtensions;
      break;
    case constant:
    case spec_constant:
    case notconstant:
      ConstVal = Other.ConstVal;
      break;
    case overdefined:
    case unknown:
    case undef:
      break;
    }
    Other.Tag = unknown;
  }

  SpecValueLatticeElement &operator=(const SpecValueLatticeElement &Other) {
    destroy();
    new (this) SpecValueLatticeElement(Other);
    return *this;
  }

  SpecValueLatticeElement &operator=(SpecValueLatticeElement &&Other) {
    destroy();
    new (this) SpecValueLatticeElement(std::move(Other));
    return *this;
  }

  static SpecValueLatticeElement get(Constant *C) {
    SpecValueLatticeElement Res;
    if (isa<UndefValue>(C))
      Res.markUndef();
    else
      Res.markConstant(C);
    return Res;
  }
  static SpecValueLatticeElement getNot(Constant *C) {
    SpecValueLatticeElement Res;
    assert(!isa<UndefValue>(C) && "!= undef is not supported");
    Res.markNotConstant(C);
    return Res;
  }
  static SpecValueLatticeElement getRange(ConstantRange CR,
                                      bool MayIncludeUndef = false) {
    if (CR.isFullSet())
      return getOverdefined();

    if (CR.isEmptySet()) {
      SpecValueLatticeElement Res;
      if (MayIncludeUndef)
        Res.markUndef();
      return Res;
    }

    SpecValueLatticeElement Res;
    Res.markConstantRange(std::move(CR),
                          MergeOptions().setMayIncludeUndef(MayIncludeUndef));
    return Res;
  }
  static SpecValueLatticeElement getOverdefined() {
    SpecValueLatticeElement Res;
    Res.markOverdefined();
    return Res;
  }

  bool isUndef() const { return Tag == undef; }
  bool isSpecRange() const { return Shadow_Tag == spec_constant && Tag == constantrange; }
  bool isSpecConstant() const { return Shadow_Tag == spec_constant && Tag == constant; }
  bool isUnknown() const { return Tag == unknown; }
  bool isUnknownOrUndef() const { return Tag == unknown || Tag == undef; }
  bool isConstant() const { return Tag == constant; }
  bool isNotConstant() const { return Tag == notconstant; }
  bool isConstantRangeIncludingUndef() const {
    return Tag == constantrange_including_undef;
  }
  /// Returns true if this value is a constant range. Use \p UndefAllowed to
  /// exclude non-singleton constant ranges that may also be undef. Note that
  /// this function also returns true if the range may include undef, but only
  /// contains a single element. In that case, it can be replaced by a constant.
  bool isConstantRange(bool UndefAllowed = true) const {
    return Tag == constantrange || (Tag == constantrange_including_undef &&
                                    (UndefAllowed || Range.isSingleElement()));
  }
  
  bool isOverdefined() const { return Tag == overdefined; }

  Constant *getConstant() const {
    assert(isConstant() && "Cannot get the constant of a non-constant!");
    return ConstVal;
  }

  Constant *getNotConstant() const {
    assert(isNotConstant() && "Cannot get the constant of a non-notconstant!");
    return ConstVal;
  }

  /// Returns the constant range for this value. Use \p UndefAllowed to exclude
  /// non-singleton constant ranges that may also be undef. Note that this
  /// function also returns a range if the range may include undef, but only
  /// contains a single element. In that case, it can be replaced by a constant.
  const ConstantRange &getConstantRange(bool UndefAllowed = true) const {
    assert(isConstantRange(UndefAllowed) &&
           "Cannot get the constant-range of a non-constant-range!");
    return Range;
  }

  Optional<APInt> asConstantInteger() const {
    if (isConstant() && isa<ConstantInt>(getConstant())) {
      return cast<ConstantInt>(getConstant())->getValue();
    } else if (isConstantRange() && getConstantRange().isSingleElement()) {
      return *getConstantRange().getSingleElement();
    }
    return None;
  }

  bool markOverdefined() {
    if (isOverdefined())
      return false;
    destroy();
    Tag = overdefined;
    return true;
  }

  bool markUndef() {
    if (isUndef())
      return false;

    assert(isUnknown());
    Tag = undef;
    return true;
  }

  bool markUnknown() {
    if (isUnknown())
      return false;

    Tag = unknown;
    return true;
  }

  // COMMENT : Added marking of Spec Const.
  bool markSpeculativeConstant(Constant *V) {
    if (isSpecConstant())
      return false;

    // assert(isUnknown());
    Tag = constant;
    Shadow_Tag = spec_constant;
    ConstVal = V;
    return true;
  }

  bool markConstant(Constant *V, bool MayIncludeUndef = false) {
    if (isa<UndefValue>(V))
      return markUndef();

    if (isConstant()) {
      assert(getConstant() == V && "Marking constant with different value");
      return false;
    }

    if (ConstantInt *CI = dyn_cast<ConstantInt>(V))
      return markConstantRange(
          ConstantRange(CI->getValue()),
          MergeOptions().setMayIncludeUndef(MayIncludeUndef));

    assert(isUnknown() || isUndef());
    Tag = constant;
    ConstVal = V;
    return true;
  }

  bool markNotConstant(Constant *V) {
    assert(V && "Marking constant with NULL");
    if (ConstantInt *CI = dyn_cast<ConstantInt>(V))
      return markConstantRange(
          ConstantRange(CI->getValue() + 1, CI->getValue()));

    if (isa<UndefValue>(V))
      return false;

    if (isNotConstant()) {
      assert(getNotConstant() == V && "Marking !constant with different value");
      return false;
    }

    assert(isUnknown());
    Tag = notconstant;
    ConstVal = V;
    return true;
  }

  /// Mark the object as constant range with \p NewR. If the object is already a
  /// constant range, nothing changes if the existing range is equal to \p
  /// NewR and the tag. Otherwise \p NewR must be a superset of the existing
  /// range or the object must be undef. The tag is set to
  /// constant_range_including_undef if either the existing value or the new
  /// range may include undef.
  bool markConstantRange(ConstantRange NewR,
                         MergeOptions Opts = MergeOptions()) {
    assert(!NewR.isEmptySet() && "should only be called for non-empty sets");

    if (NewR.isFullSet())
      return markOverdefined();

    SpecValueLatticeElementTy OldTag = Tag;
    SpecValueLatticeElementTy NewTag =
        (isUndef() || isConstantRangeIncludingUndef() || Opts.MayIncludeUndef)
            ? constantrange_including_undef
            : constantrange;
    if (isConstantRange()) {
      Tag = NewTag;
      if (getConstantRange() == NewR)
        return Tag != OldTag;

      // Simple form of widening. If a range is extended multiple times, go to
      // overdefined.
      if (Opts.CheckWiden && ++NumRangeExtensions > Opts.MaxWidenSteps)
        return markOverdefined();

      assert(NewR.contains(getConstantRange()) &&
             "Existing range must be a subset of NewR");
      Range = std::move(NewR);
      return true;
    }

    assert(isUnknown() || isUndef());

    NumRangeExtensions = 0;
    Tag = NewTag;
    new (&Range) ConstantRange(std::move(NewR));
    return true;
  }

  // COMMENT : Add a shadow Tag.
  bool markSpeculativeConstantRange(ConstantRange NewR,
                         MergeOptions Opts = MergeOptions()) {
    assert(!NewR.isEmptySet() && "should only be called for non-empty sets");

    if (NewR.isFullSet())
      return markOverdefined();

    SpecValueLatticeElementTy OldTag = Tag;
    SpecValueLatticeElementTy NewTag =
        (isUndef() || isConstantRangeIncludingUndef() || Opts.MayIncludeUndef)
            ? constantrange_including_undef
            : constantrange;
    if (isConstantRange()) {
      Tag = NewTag;
      if (getConstantRange().isSingleElement())
        Shadow_Tag = spec_constant;
      if (getConstantRange() == NewR)
        return Tag != OldTag;

      // Simple form of widening. If a range is extended multiple times, go to
      // overdefined.
      if (Opts.CheckWiden && ++NumRangeExtensions > Opts.MaxWidenSteps)
        return markOverdefined();

      assert(NewR.contains(getConstantRange()) &&
             "Existing range must be a subset of NewR");
      Range = std::move(NewR);
      return true;
    }

    assert(isUnknown() || isUndef());

    NumRangeExtensions = 0;
    Tag = NewTag;
    if (getConstantRange().isSingleElement())
      Shadow_Tag = spec_constant;
    new (&Range) ConstantRange(std::move(NewR));
    return true;
  }

  /// Updates this object to approximate both this object and RHS. Returns
  /// true if this object has been changed.
  bool mergeIn(const SpecValueLatticeElement &RHS,
               MergeOptions Opts = MergeOptions()) {
    
    if (RHS.isUnknown() || isOverdefined())
      return false;
    
    if (RHS.isOverdefined()) {
      markOverdefined();
      return true;
    }

    // COMMENT : LHS meet RHS 
    if (RHS.isSpecConstant()) {
      if (isConstant() && getConstant() == RHS.getConstant())
        return markSpeculativeConstant(getConstant());
      if (getConstantRange().isSingleElement() && RHS.getConstantRange().isSingleElement() 
        && getConstantRange() == RHS.getConstantRange())
        return markSpeculativeConstantRange(RHS.getConstantRange(true),
                                 Opts.setMayIncludeUndef());
      return false;
    }

    if (isUndef()) {
      assert(!RHS.isUnknown());
      if (RHS.isUndef())
        return false;
      if (RHS.isConstant())
        return markConstant(RHS.getConstant(), true);
      if (RHS.isConstantRange())
        return markConstantRange(RHS.getConstantRange(true),
                                 Opts.setMayIncludeUndef());
      return markOverdefined();
    }

    if (isUnknown()) {
      LLVM_DEBUG(dbgs() << "\t\tUnknown LHS\n");
      assert(!RHS.isUnknown() && "Unknow RHS should be handled earlier");
      *this = RHS;
      return true;
    }

    if (isConstant()) {
      if (RHS.isConstant() && getConstant() == RHS.getConstant())
        return false;
      if (RHS.isUndef())
        return false;
      markOverdefined();
      return true;
    }

    if (isNotConstant()) {
      if (RHS.isNotConstant() && getNotConstant() == RHS.getNotConstant())
        return false;
      markOverdefined();
      return true;
    }

    auto OldTag = Tag;
    assert(isConstantRange() && "New ValueLattice type?");
    if (RHS.isUndef()) {
      Tag = constantrange_including_undef;
      return OldTag != Tag;
    }

    if (!RHS.isConstantRange()) {
      // We can get here if we've encountered a constantexpr of integer type
      // and merge it with a constantrange.
      markOverdefined();
      return true;
    }

    ConstantRange NewR = getConstantRange().unionWith(RHS.getConstantRange());
    return markConstantRange(
        std::move(NewR),
        Opts.setMayIncludeUndef(RHS.isConstantRangeIncludingUndef()));
  }

  // Compares this symbolic value with Other using Pred and returns either
  /// true, false or undef constants, or nullptr if the comparison cannot be
  /// evaluated.
  Constant *getCompare(CmpInst::Predicate Pred, Type *Ty,
                       const SpecValueLatticeElement &Other) const {
    if (isUnknownOrUndef() || Other.isUnknownOrUndef())
      return UndefValue::get(Ty);

    if (isConstant() && Other.isConstant())
      return ConstantExpr::getCompare(Pred, getConstant(), Other.getConstant());

    if (ICmpInst::isEquality(Pred)) {
      // not(C) != C => true, not(C) == C => false.
      if ((isNotConstant() && Other.isConstant() &&
           getNotConstant() == Other.getConstant()) ||
          (isConstant() && Other.isNotConstant() &&
           getConstant() == Other.getNotConstant()))
        return Pred == ICmpInst::ICMP_NE
            ? ConstantInt::getTrue(Ty) : ConstantInt::getFalse(Ty);
    }

    // Integer constants are represented as ConstantRanges with single
    // elements.
    if (!isConstantRange() || !Other.isConstantRange())
      return nullptr;

    const auto &CR = getConstantRange();
    const auto &OtherCR = Other.getConstantRange();
    if (CR.icmp(Pred, OtherCR))
      return ConstantInt::getTrue(Ty);
    if (CR.icmp(CmpInst::getInversePredicate(Pred), OtherCR))
      return ConstantInt::getFalse(Ty);

    return nullptr;
  }

  unsigned getNumRangeExtensions() const { return NumRangeExtensions; }
  void setNumRangeExtensions(unsigned N) { NumRangeExtensions = N; }
};

static_assert(sizeof(SpecValueLatticeElement) <= 48,
              "size of SpecValueLatticeElement changed unexpectedly");

raw_ostream &operator<<(raw_ostream &OS, const SpecValueLatticeElement &Val) {
  // COMMENT : Print Speculative Consts  
  if (Val.isSpecConstant())
    return OS << "speculative constant<" << *Val.getConstant() << ">";
  if (Val.isSpecRange())
    return OS << "speculative constantrange<" << Val.getConstantRange().getLower() << ", "
      << Val.getConstantRange().getUpper() << ">";

  if (Val.isUnknown())
    return OS << "unknown";
  if (Val.isUndef())
    return OS << "undef";
  if (Val.isOverdefined())
    return OS << "overdefined";

  if (Val.isNotConstant())
    return OS << "notconstant<" << *Val.getNotConstant() << ">";

  if (Val.isConstantRangeIncludingUndef())
    return OS << "constantrange incl. undef <"
              << Val.getConstantRange(true).getLower() << ", "
              << Val.getConstantRange(true).getUpper() << ">";

  if (Val.isConstantRange())
    return OS << "constantrange<" << Val.getConstantRange().getLower() << ", "
              << Val.getConstantRange().getUpper() << ">";
  return OS << "constant<" << *Val.getConstant() << ">";
}
} // end namespace llvm
#endif
