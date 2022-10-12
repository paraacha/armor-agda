{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509
import      Aeres.Data.X509.Properties.Extension       as ExtensionProps
import      Aeres.Data.X509.Properties.PublicKeyFields as PKProps
import      Aeres.Data.X509.Properties.RDNSeq          as RDNSeqProps
import      Aeres.Data.X509.Properties.SignAlgFields   as SignAlgProps
import      Aeres.Data.X509.Properties.ValidityFields  as ValidityFieldsProps
open import Aeres.Data.X690-DER
import       Aeres.Grammar.Definitions
import       Aeres.Grammar.Option
import       Aeres.Grammar.Properties
open import Aeres.Prelude
open import Tactic.MonoidSolver using (solve ; solve-macro)

module Aeres.Data.X509.Properties.TBSCertFields where

open Base256
open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Option      UInt8
open Aeres.Grammar.Properties  UInt8
open ≡-Reasoning

equivalent : Equivalent
               (&ₚ (&ₚ (Option X509.Version) Int)
               (&ₚ X509.SignAlg
               (&ₚ X509.RDNSeq
               (&ₚ X509.Validity
               (&ₚ X509.RDNSeq
               (&ₚ X509.PublicKey
               (&ₚ (Option X509.IssUID)
               (&ₚ (Option X509.SubUID) (Option X509.Extensions)))))))))
               X509.TBSCertFields
proj₁ equivalent (mk&ₚ (mk&ₚ fstₚ₁ sndₚ₁ refl) (mk&ₚ fstₚ₂ (mk&ₚ fstₚ₃ (mk&ₚ fstₚ₄ (mk&ₚ fstₚ₅ (mk&ₚ fstₚ₆ (mk&ₚ fstₚ₇ (mk&ₚ fstₚ₈ sndₚ₂ refl) refl) refl) refl) refl) refl) refl) bs≡) =
  X509.mkTBSCertFields fstₚ₁ sndₚ₁ fstₚ₂ fstₚ₃ fstₚ₄ fstₚ₅ fstₚ₆ fstₚ₇ fstₚ₈ sndₚ₂
    (trans₀ bs≡ (solve (++-monoid UInt8)))
proj₂ equivalent (X509.mkTBSCertFields version serial signAlg issuer validity subject pk issuerUID subjectUID extensions bs≡) =
  mk&ₚ (mk&ₚ version serial refl) (mk&ₚ signAlg (mk&ₚ issuer (mk&ₚ validity (mk&ₚ subject (mk&ₚ pk (mk&ₚ issuerUID (mk&ₚ subjectUID extensions refl) refl) refl) refl) refl) refl) refl)
    (trans₀ bs≡ (solve (++-monoid UInt8)))

iso : Iso
        (&ₚ (&ₚ (Option X509.Version) Int)
        (&ₚ X509.SignAlg
        (&ₚ X509.RDNSeq
        (&ₚ X509.Validity
        (&ₚ X509.RDNSeq
        (&ₚ X509.PublicKey
        (&ₚ (Option X509.IssUID)
        (&ₚ (Option X509.SubUID) (Option X509.Extensions)))))))))
        X509.TBSCertFields
proj₁ iso = equivalent
proj₁ (proj₂ iso) (mk&ₚ (mk&ₚ{bs₁ = bs₁}{bs₂} fstₚ₁ sndₚ₁ refl) (mk&ₚ{bs₁ = bs₃} fstₚ₂ (mk&ₚ{bs₁ = bs₄} fstₚ₃ (mk&ₚ{bs₁ = bs₅} fstₚ₄ (mk&ₚ{bs₁ = bs₆} fstₚ₅ (mk&ₚ{bs₁ = bs₇} fstₚ₆ (mk&ₚ{bs₁ = bs₈} fstₚ₇ (mk&ₚ{bs₁ = bs₉}{bs₁₀} fstₚ₈ sndₚ₂ refl) refl) refl) refl) refl) refl) refl) bs≡) =
  subst₀ (λ eq → mk&ₚ _ _ eq ≡ mk&ₚ _ _ bs≡) (≡-unique bs≡ (trans₀ (trans₀ bs≡ _) _)) refl
proj₂ (proj₂ iso) (X509.mkTBSCertFields version serial signAlg issuer validity subject pk issuerUID subjectUID extensions bs≡) =
  subst₀ (λ eq → X509.mkTBSCertFields version serial signAlg issuer validity subject pk issuerUID subjectUID extensions eq ≡ X509.mkTBSCertFields _ _ _ _ _ _ _ _ _ _ bs≡) (≡-unique bs≡ _) refl

postulate
  instance
    TBSEq : Eq (Exists─ (List UInt8) X509.TBSCert)

@0 unambiguous : Unambiguous X509.TBSCertFields
unambiguous =
  isoUnambiguous iso
    (unambiguous&ₚ
      (Unambiguous.unambiguous-option₁&₁
        (TLV.unambiguous (TLV.unambiguous λ {xs} → Int.unambiguous{xs}))
        TLV.nonnesting (TLV.unambiguous λ {xs} → Int.unambiguous{xs})
        (TLV.noconfusion λ ()))
      (NonNesting.noconfusion-option&₁
        TLV.nonnesting TLV.nonnesting (TLV.noconfusion λ ()))
      (unambiguous&ₚ
        (TLV.unambiguous SignAlgProps.unambiguous)
        TLV.nonnesting
        (unambiguous&ₚ RDNSeqProps.unambiguous TLV.nonnesting
          (unambiguous&ₚ
            (TLV.unambiguous ValidityFieldsProps.unambiguous)
            TLV.nonnesting
            (unambiguous&ₚ RDNSeqProps.unambiguous TLV.nonnesting
              (unambiguous&ₚ (TLV.unambiguous PKProps.unambiguous)
                TLV.nonnesting
                (Unambiguous.option₃&₂
                  (TLV.unambiguous BitString.unambiguous)
                  TLV.nonnesting TLV.nonempty
                  (TLV.unambiguous BitString.unambiguous)
                  TLV.nonnesting TLV.nonempty
                  (TLV.unambiguous ExtensionProps.ExtensionsSeq.unambiguous)
                  TLV.nonempty
                  (TLV.noconfusion λ ()) (TLV.noconfusion λ ()) (TLV.noconfusion λ ()))))))))
