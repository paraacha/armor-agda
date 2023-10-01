{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509.Extension.PM.TCB
open import Aeres.Data.X690-DER.OID
open import Aeres.Data.X690-DER.TLV
import      Aeres.Data.X690-DER.Tag as Tag
open import Aeres.Data.X690-DER.SequenceOf.TCB
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Seq
open import Aeres.Prelude

module Aeres.Data.X509.Extension.PM.Properties where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Seq         UInt8

Rep = &ₚ OID OID

equivalent : Equivalent Rep PolicyMapFields
proj₁ equivalent (mk&ₚ v₁ v₂ refl) = mkPolicyMapFields v₁ v₂ refl
proj₂ equivalent (mkPolicyMapFields v₁ v₂ refl) = mk&ₚ v₁ v₂ refl

iso : Iso Rep PolicyMapFields
proj₁ iso = equivalent
proj₁ (proj₂ iso) (mk&ₚ fstₚ₁ sndₚ₁ refl) = refl
proj₂ (proj₂ iso) (mkPolicyMapFields issuerDomainPolicy subjectDomainPolicy refl) = refl

@0 unambiguous : Unambiguous PolicyMapFields
unambiguous =
  Iso.unambiguous iso
    (Seq.unambiguous OID.unambiguous TLV.nosubstrings OID.unambiguous)

@0 nosubstrings : NoSubstrings PolicyMapFields
nosubstrings x x₁ x₂ = Seq.nosubstrings TLV.nosubstrings TLV.nosubstrings x (proj₂ equivalent x₁) (proj₂ equivalent x₂)
