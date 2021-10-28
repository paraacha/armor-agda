{-# OPTIONS --subtyping #-}

import Aeres.Data.X509.Properties.TLV as TLVprops
open import Aeres.Prelude
open import Aeres.Binary
open import Aeres.Data.X509
open import Data.Nat.Properties
  hiding (_≟_)
open import Tactic.MonoidSolver using (solve ; solve-macro)

module Aeres.Data.X509.Properties.GeneralName where

open Base256
open import Aeres.Grammar.Definitions Dig

nonempty : NonEmpty X509.GeneralName
nonempty (X509.oname ()) refl
nonempty (X509.rfcname ()) refl
nonempty (X509.dnsname ()) refl
nonempty (X509.x400add ()) refl
nonempty (X509.dirname ()) refl
nonempty (X509.ediname ()) refl
nonempty (X509.uri ()) refl
nonempty (X509.ipadd ()) refl
nonempty (X509.rid ()) refl


nonnesting : NonNesting X509.GeneralName
nonnesting x (X509.oname x₁) (X509.oname x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.oname x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.oname x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.rfcname x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.rfcname x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rfcname x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.dnsname x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.dnsname x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dnsname x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.x400add x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.x400add x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.x400add x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.dirname x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.dirname x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.dirname x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.ediname x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.ediname x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ediname x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.uri x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.uri x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.uri x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.ipadd x₁) (X509.ipadd x₂) = ‼ TLVprops.nonnesting x x₁ x₂
nonnesting x (X509.ipadd x₁) (X509.rid x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.oname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.rfcname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.dnsname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.x400add x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.dirname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.ediname x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.uri x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.ipadd x₂) = ⊥-elim (TLVprops.noconfusion (λ where ()) x x₁ x₂)
nonnesting x (X509.rid x₁) (X509.rid x₂) = ‼ TLVprops.nonnesting x x₁ x₂
