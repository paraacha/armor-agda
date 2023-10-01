{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509.DisplayText
open import Aeres.Data.X509.Extension.CertPolicy.PolicyInformation.Qualifier.UserNotice.NoticeReference.TCB
open import Aeres.Data.X690-DER.Int
open import Aeres.Data.X690-DER.TLV
open import Aeres.Data.X690-DER.SequenceOf
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Properties
import      Aeres.Grammar.Seq
open import Aeres.Prelude

module Aeres.Data.X509.Extension.CertPolicy.PolicyInformation.Qualifier.UserNotice.NoticeReference.Properties where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Properties  UInt8
open Aeres.Grammar.Seq         UInt8

iso : Iso (&ₚ DisplayText IntegerSeq) NoticeReferenceFields
proj₁ (proj₁ iso) (mk&ₚ fstₚ₁ sndₚ₁ bs≡) = mkNoticeReferenceFields fstₚ₁ sndₚ₁ bs≡
proj₂ (proj₁ iso) (mkNoticeReferenceFields organization noticenums bs≡) = mk&ₚ organization noticenums bs≡
proj₁ (proj₂ iso) (mk&ₚ fstₚ₁ sndₚ₁ bs≡) = refl
proj₂ (proj₂ iso) (mkNoticeReferenceFields organization noticenums bs≡) = refl

@0 unambiguous : Unambiguous NoticeReferenceFields
unambiguous =
  Iso.unambiguous iso
    (Seq.unambiguous
      DisplayText.unambiguous DisplayText.nosubstrings
      (TLV.unambiguous
        (SequenceOf.unambiguous (TLV.unambiguous λ {xs} → Int.unambiguous{xs})
          TLV.nonempty (NoSubstrings Int ∋ TLV.nosubstrings))))
