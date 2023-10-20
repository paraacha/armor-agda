{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X690-DER.SequenceOf
open import Aeres.Data.X690-DER.SetOf.Order.TCB
open import Aeres.Data.X690-DER.SetOf.TCB
open import Aeres.Data.X690-DER.TLV
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parallel
open import Aeres.Prelude

module Aeres.Data.X690-DER.SetOf.Properties where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parallel    UInt8

@0 unambiguousFields
  : {A : @0 List UInt8 → Set} → Unambiguous A → NonEmpty A → NoSubstrings A
    → Unambiguous (SetOfFields A)
unambiguousFields ua ne ns (mkSetOfFields elems order) (mkSetOfFields elems₁ order₁) =
  case SequenceOf.Bounded.unambiguous{n = 1} ua ne ns elems elems₁ of λ where
    refl → case ‼ T-unique order order₁ ret (λ _ → _ ≡ _) of λ where
      refl → refl

@0 unambiguous
  : {A : @0 List UInt8 → Set} → Unambiguous A → NonEmpty A → NoSubstrings A
    → Unambiguous (SetOf A)
unambiguous ua ne ns = TLV.unambiguous (unambiguousFields ua ne ns)

@0 nonmalleableFields
  : {A : @0 List UInt8 → Set} {R : Raw A}
    → NonEmpty A → NoSubstrings A
    → NonMalleable R → NonMalleable (RawSetOfFields R)
nonmalleableFields ne ns nm (mkSetOfFields elems order) (mkSetOfFields elems₁ order₁) eq =
  case SequenceOf.Bounded.nonmalleable ne ns nm elems elems₁ eq of λ where
    refl → case (‼ T-unique order order₁) ret (λ _ → _ ≡ _) of λ where
      refl → refl

@0 nonmalleable
  : {A : @0 List UInt8 → Set} {R : Raw A}
    → NonEmpty A → NoSubstrings A
    → NonMalleable R → NonMalleable (RawSetOf R)
nonmalleable ne ns nm = TLV.nonmalleable (nonmalleableFields ne ns nm)
