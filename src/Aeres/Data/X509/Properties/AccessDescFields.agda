{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509
open import Aeres.Prelude

module Aeres.Data.X509.Properties.AccessDescFields where

open Base256
open import Aeres.Grammar.Definitions Dig

equivalent : Equivalent (&ₚ (AccessMethod) (GeneralName)) X509.AccessDescFields
proj₁ equivalent (mk&ₚ fstₚ₁ sndₚ₁ bs≡) = X509.mkAccessDescFields fstₚ₁ sndₚ₁ bs≡
proj₂ equivalent (X509.mkAccessDescFields acmethod aclocation bs≡) = mk&ₚ acmethod aclocation bs≡

iso : Iso (&ₚ (AccessMethod) (GeneralName)) X509.AccessDescFields
proj₁ iso = equivalent
proj₁ (proj₂ iso) (mk&ₚ fstₚ₁ sndₚ₁ bs≡) = refl
proj₂ (proj₂ iso) (X509.mkAccessDescFields acmethod aclocation bs≡) = refl

@0 nonnesting : NonNesting X509.AccessDescFields
nonnesting x x₁ x₂ = NonNesting&ₚ TLV.nonnesting GeneralName.nonnesting x (proj₂ equivalent x₁) (proj₂ equivalent x₂)

@0 unambiguous : Unambiguous X509.AccessDescFields
unambiguous =
  isoUnambiguous iso
    (unambiguous&ₚ (TLV.unambiguous AccessMethod.unambiguous)
      TLV.nonnesting GeneralName.unambiguous)
