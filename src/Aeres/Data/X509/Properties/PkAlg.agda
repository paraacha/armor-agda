{-# OPTIONS --subtyping --allow-unsolved-metas #-}

open import Aeres.Data.X509
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Properties
import      Aeres.Grammar.Sum
import      Aeres.Data.X509.Properties.TLV            as TLVprops
import      Aeres.Data.X509.Properties.RSAPkAlgFields            as RSAPkAlgFieldsProps
import      Aeres.Data.X509.Properties.EcPkAlgFields            as EcPkAlgFieldsProps
import      Aeres.Data.X509.Properties.SignAlgFields            as SignAlgFieldsProps
open import Aeres.Prelude
open import Aeres.Binary
open import Data.Nat.Properties
  hiding (_≟_)
open import Tactic.MonoidSolver using (solve ; solve-macro)

module Aeres.Data.X509.Properties.PkAlg where

open Base256
open Aeres.Grammar.Definitions Dig
open Aeres.Grammar.Properties  Dig
open import Aeres.Grammar.Sum Dig
open ≡-Reasoning


equivalent : Equivalent (Sum (Sum X509.RSAPkAlg X509.EcPkAlg) X509.SignAlg) X509.PkAlg
proj₁ equivalent (Aeres.Grammar.Sum.inj₁ (Aeres.Grammar.Sum.inj₁ x)) = X509.PkAlg.rsapkalg x
proj₁ equivalent (Aeres.Grammar.Sum.inj₁ (Aeres.Grammar.Sum.inj₂ x)) = X509.PkAlg.ecpkalg x
proj₁ equivalent (Aeres.Grammar.Sum.inj₂ x) = X509.PkAlg.otherpkalg x
proj₂ equivalent (X509.PkAlg.rsapkalg x) = Aeres.Grammar.Sum.inj₁ (Aeres.Grammar.Sum.inj₁ x)
proj₂ equivalent (X509.PkAlg.ecpkalg x) = Aeres.Grammar.Sum.inj₁ (Aeres.Grammar.Sum.inj₂ x)
proj₂ equivalent (X509.PkAlg.otherpkalg x) = Aeres.Grammar.Sum.inj₂ x


@0 nonnesting : NonNesting X509.PkAlg
nonnesting = equivalent-nonnesting equivalent
  (nonnestingSum (nonnestingSum TLVprops.nonnesting TLVprops.nonnesting (TLVprops.noconfusion {!!})) TLVprops.nonnesting {!!})


@0 iso : Iso (Sum (Sum X509.RSAPkAlg X509.EcPkAlg) X509.SignAlg) X509.PkAlg
proj₁ (proj₁ iso) (Sum.inj₁ (Sum.inj₁ x)) = X509.PkAlg.rsapkalg x
proj₁ (proj₁ iso) (Sum.inj₁ (Sum.inj₂ x)) = X509.PkAlg.ecpkalg x
proj₁ (proj₁ iso) (Sum.inj₂ x) = X509.PkAlg.otherpkalg x
proj₂ (proj₁ iso) (X509.PkAlg.rsapkalg x) = Sum.inj₁ (Sum.inj₁ x)
proj₂ (proj₁ iso) (X509.PkAlg.ecpkalg x) = Sum.inj₁ (Sum.inj₂ x)
proj₂ (proj₁ iso) (X509.PkAlg.otherpkalg x) = Sum.inj₂ x
proj₁ (proj₂ iso) (Sum.inj₁ (Sum.inj₁ x)) = refl
proj₁ (proj₂ iso) (Sum.inj₁ (Sum.inj₂ x)) = refl
proj₁ (proj₂ iso) (Sum.inj₂ x) = refl
proj₂ (proj₂ iso) {xs} (X509.PkAlg.rsapkalg x) = refl 
proj₂ (proj₂ iso) {xs} (X509.PkAlg.ecpkalg x) = refl
proj₂ (proj₂ iso) {xs} (X509.PkAlg.otherpkalg x) = refl

@0 unambiguous : Unambiguous X509.PkAlg
unambiguous = isoUnambiguous iso
  (unambiguousSum
    (unambiguousSum (TLVprops.unambiguous RSAPkAlgFieldsProps.unambiguous) (TLVprops.unambiguous EcPkAlgFieldsProps.unambiguous) (TLVprops.noconfusion {!!}))
      (TLVprops.unambiguous SignAlgFieldsProps.unambiguous)
    {!!})


