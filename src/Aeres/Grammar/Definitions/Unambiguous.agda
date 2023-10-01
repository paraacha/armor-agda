{-# OPTIONS --subtyping #-}

open import Aeres.Prelude

module Aeres.Grammar.Definitions.Unambiguous (Σ : Set) where

-- `A` is unambiguous iff there is only one way for a given string to be
-- accepted by the grammar

Unambiguous : (A : List Σ → Set) → Set
Unambiguous A = ∀ {xs} → (a₁ a₂ : A xs) → a₁ ≡ a₂

UnambiguousHet : (A : List Σ → Set) → Set
UnambiguousHet A = ∀ {xs ys} → (eq : xs ≡ ys) (a₁ : A xs) (a₂ : A ys)
                   → subst A eq a₁ ≡ a₂

unambiguousHet : ∀ {A} → Unambiguous A → UnambiguousHet A
unambiguousHet ua refl a₁ a₂ = ua a₁ a₂
