{-# OPTIONS --subtyping #-}

import      Aeres.Grammar.Definitions.Iso.Base
import      Aeres.Grammar.Definitions.NonMalleable
import      Aeres.Grammar.Definitions.Unambiguous
open import Aeres.Prelude
import      Data.Product.Properties as Product

module Aeres.Grammar.Definitions.Iso.Properties (Σ : Set) where

open Aeres.Grammar.Definitions.Iso.Base     Σ
open Aeres.Grammar.Definitions.NonMalleable Σ
open Aeres.Grammar.Definitions.Unambiguous  Σ

symEquivalent : ∀ {A B} → Equivalent A B → Equivalent B A
symEquivalent (fst , snd) = snd , fst

transEquivalent : ∀ {A B C} → Equivalent A B → Equivalent B C → Equivalent A C
proj₁ (transEquivalent e₁ e₂) = proj₁ e₂ ∘ proj₁ e₁
proj₂ (transEquivalent e₁ e₂) = proj₂ e₁ ∘ proj₂ e₂

symIso : ∀ {A B} → Iso A B → Iso B A
proj₁ (symIso x) = symEquivalent (proj₁ x)
proj₁ (proj₂ (symIso ((eq₁ , eq₂) , iso))) = proj₂ iso
proj₂ (proj₂ (symIso ((eq₁ , eq₂) , iso))) = proj₁ iso

unambiguous : ∀ {A B} → Iso A B → Unambiguous A → Unambiguous B
unambiguous ((a→b , b→a) , _ , id₂) ua{xs} b₁ b₂ =
  subst₂ _≡_ (id₂ b₁) (id₂ b₂) (‼ b≡)
  where
  @0 a≡ : b→a b₁ ≡ b→a b₂
  a≡ = ua (b→a b₁) (b→a b₂)

  @0 b≡ : a→b (b→a b₁) ≡ a→b (b→a b₂)
  b≡ = cong a→b a≡

injective₁ : ∀ {A B} → (x : Iso A B) → let equiv = proj₁ x in
             ∀ {@0 bs} {a₁ a₂ : A bs} → proj₁ equiv a₁ ≡ proj₁ equiv a₂ → a₁ ≡ a₂
injective₁ (equiv , iso){a₁ = a₁}{a₂} eq =
  a₁ ≡⟨ sym (proj₁ iso a₁) ⟩
  proj₂ equiv (proj₁ equiv a₁) ≡⟨ cong (proj₂ equiv) eq ⟩
  proj₂ equiv (proj₁ equiv a₂) ≡⟨ proj₁ iso a₂ ⟩
  a₂ ∎
  where
  open ≡-Reasoning

raw : ∀ {A B} → Equivalent A B → Raw A → Raw B
Raw.D (raw equiv r) = Raw.D r
Raw.to (raw equiv r) (─ _ , b) = Raw.to r (─ _ , proj₂ equiv b)

@0 nonmalleable : ∀ {A B} → (iso : Iso A B) (r₁ : Raw A) → NonMalleable B (raw (proj₁ iso) r₁) → NonMalleable A r₁
NonMalleable.unambiguous (nonmalleable iso r₁ nm) = unambiguous (symIso iso) (NonMalleable.unambiguous nm)
NonMalleable.injective (nonmalleable (equiv , iso) r₁ nm) x₁@(─ _ , a₁) x₂@(─ _ , a₂) eq =
  case
    Inverse.f⁻¹ Product.Σ-≡,≡↔≡ (NonMalleable.injective nm (─ _ , proj₁ equiv a₁) (─ _ , proj₁ equiv a₂) eq')
  of λ where
    (refl , eq“) → case injective₁ (equiv , iso) eq“ of λ where
      refl → refl
  
  where
  open ≡-Reasoning

  eq' : Raw.to r₁ (─ _ , proj₂ equiv (proj₁ equiv a₁)) ≡ Raw.to r₁ (─ _ , proj₂ equiv (proj₁ equiv a₂))
  eq' = begin
    Raw.to r₁ (─ _ , proj₂ equiv (proj₁ equiv a₁))
      ≡⟨ cong (Raw.to r₁)
           (Inverse.f (Product.Σ-≡,≡↔≡{p₁ = (─ _ , proj₂ equiv (proj₁ equiv a₁))}{p₂ = (─ _ , a₁)})
             (refl , (proj₁ iso a₁))) ⟩
    Raw.to r₁ x₁ ≡⟨ eq ⟩
    Raw.to r₁ x₂
      ≡⟨ cong (Raw.to r₁)
           (sym (Inverse.f Product.Σ-≡,≡↔≡ (refl , (proj₁ iso a₂)))) ⟩
    Raw.to r₁ (─ _ , proj₂ equiv (proj₁ equiv a₂)) ∎

-- nonempty : ∀ {@0 A B} → Equivalent A B → NonEmpty A → NonEmpty B
-- nonempty eqv ne b ≡[] = contradiction ≡[] (ne (proj₂ eqv b))

-- nonnesting : ∀ {@0 A B} → Equivalent A B → NonNesting A → NonNesting B
-- nonnesting{A}{B} eqv nn ++≡ b₁ b₂ = ‼ nn ++≡ (proj₂ eqv b₁) (proj₂ eqv b₂)
