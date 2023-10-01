{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.Unicode.UTF8.TCB
open import Aeres.Data.Unicode.UTF16.TCB
  renaming (size to sizeBMP)
open import Aeres.Data.X690-DER.TLV.TCB
open import Aeres.Data.X690-DER.Strings.BMPString.TCB
open import Aeres.Data.X690-DER.Strings.IA5String.TCB
open import Aeres.Data.X690-DER.Strings.UTF8String.TCB
open import Aeres.Data.X690-DER.Strings.VisibleString.TCB
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parallel.TCB
import      Aeres.Grammar.Sum.TCB
open import Aeres.Prelude

module Aeres.Data.X509.DisplayText.TCB where

open Aeres.Grammar.Definitions   UInt8
open Aeres.Grammar.Parallel.TCB  UInt8
open Aeres.Grammar.Sum.TCB       UInt8

data DisplayText : @0 List UInt8 → Set where
  ia5String     : ∀ {@0 bs} → Σₚ IA5String     (TLVSizeBounded IA5StringValue.size     1 200) bs → DisplayText bs
  visibleString : ∀ {@0 bs} → Σₚ VisibleString (TLVSizeBounded VisibleStringValue.size 1 200) bs → DisplayText bs
  bmpString     : ∀ {@0 bs} → Σₚ BMPString     (TLVSizeBounded sizeBMP                 1 200) bs → DisplayText bs
  utf8String    : ∀ {@0 bs} → Σₚ UTF8String    (TLVSizeBounded UTF8.size               1 200) bs → DisplayText bs

DisplayTextRep : @0 List UInt8 → Set
DisplayTextRep =
  (Sum (Σₚ IA5String     (TLVSizeBounded IA5StringValue.size 1 200))
  (Sum (Σₚ VisibleString (TLVSizeBounded VisibleStringValue.size 1 200))
  (Sum (Σₚ BMPString     (TLVSizeBounded sizeBMP 1 200))
       (Σₚ UTF8String    (TLVSizeBounded UTF8.size 1 200)))))

equivalent : Equivalent DisplayTextRep DisplayText
proj₁ equivalent (Sum.inj₁ x) = ia5String x
proj₁ equivalent (Sum.inj₂ (Sum.inj₁ x)) = visibleString x
proj₁ equivalent (Sum.inj₂ (Sum.inj₂ (Sum.inj₁ x))) = bmpString x
proj₁ equivalent (Sum.inj₂ (Sum.inj₂ (Sum.inj₂ x))) = utf8String x
proj₂ equivalent (ia5String x) = inj₁ x
proj₂ equivalent (visibleString x) = inj₂ (inj₁ x)
proj₂ equivalent (bmpString x) = inj₂ (inj₂ (inj₁ x))
proj₂ equivalent (utf8String x) = inj₂ (inj₂ (inj₂ x))

RawDisplayTextRep : Raw DisplayTextRep
RawDisplayTextRep =
   RawSum (RawΣₚ₁ RawIA5String _)
  (RawSum (RawΣₚ₁ RawVisibleString _)
  (RawSum (RawΣₚ₁ RawBMPString _)
          (RawΣₚ₁ RawUTF8String _)))

RawDisplayText : Raw DisplayText
RawDisplayText = Iso.raw equivalent RawDisplayTextRep

