{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X690-DER.Length.TCB
import      Aeres.Grammar.Definitions.NonMalleable
open import Aeres.Prelude

module Aeres.Data.X690-DER.TLV.TCB where

open Aeres.Grammar.Definitions.NonMalleable UInt8
  using (Raw)

-- https://www.itu.int/rec/T-REC-X.690-202102-I/en
-- 8.1.1.1 The encoding of a data value shall consist of four components which shall appear in the following order:
-- a) identifier octets (see 8.1.2);
-- b) length octets (see 8.1.3);
-- c) contents octets (see 8.1.4);

record TLV (t : UInt8) (@0 A : List UInt8 → Set) (@0 bs : List UInt8) : Set where
  constructor mkTLV
  field
    @0 {l v} : List UInt8
    len : Length l
    val : A v
    @0 len≡ : getLength len ≡ length v
    @0 bs≡  : bs ≡ t ∷ l ++ v

TLVNonEmptyVal : ∀ {t}{@0 A} → (@0 bs : List UInt8) (tlv : TLV t A bs) → Set
TLVNonEmptyVal bs tlv = 1 ≤ getLength (TLV.len tlv)

TLVLenBounded : ∀ {t}{@0 A} → (l u : ℕ) → (@0 bs : List UInt8) (tlv : TLV t A bs) → Set
TLVLenBounded l u bs tlv = InRange l u (getLength (TLV.len tlv))

TLVSizeBounded : ∀ {t} {@0 A} (len : ∀ {@0 bs} → A bs → ℕ) (l u : ℕ) → ∀ (@0 bs) → TLV t A bs → Set
TLVSizeBounded len l u bs tlv = InRange l u (len (TLV.val tlv))

RawTLV : ∀ t {A} → Raw A → Raw (TLV t A)
Raw.D (RawTLV t R) = Raw.D R
Raw.to (RawTLV t R) tlv = Raw.to R (TLV.val tlv)
