{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X690-DER.Time.TimeType.TCB
import      Aeres.Grammar.Definitions.NonMalleable
open import Aeres.Prelude

module Aeres.Data.X690-DER.Time.Year.TCB where

open Aeres.Grammar.Definitions.NonMalleable UInt8

Year₂ : @0 List UInt8 → Set
Year₂ = TimeType 2 0 99

Year₄ : @0 List UInt8 → Set
Year₄ = TimeType 4 0 9999

{- T-REC X.680
-- 47.3 The type is defined, using ASN.1, as follows:
--      UTCTime ::= [UNIVERSAL 23] IMPLICIT VisibleString
-- with the values of the VisibleString restricted to strings of characters which are the juxtaposition of:
--       a) the six digits YYMMDD where YY is the two low-order digits of the Christian year[...]
--
-}
Window₂ : Set
Window₂ = ∀ {@0 bs} → Year₂ bs → Exists─ (List UInt8) λ bs' → Year₄ (bs' ++ bs)

RawYear₂ : Raw Year₂
RawYear₂ = RawTimeType _ _ _

RawYear₄ : Raw Year₄
RawYear₄ = RawTimeType _ _ _
