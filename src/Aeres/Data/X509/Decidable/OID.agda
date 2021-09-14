open import Aeres.Prelude

open import Aeres.Binary
open import Aeres.Data.Parser
open import Aeres.Data.X509
open import Data.Nat.Properties

module Aeres.Data.X509.Decidable.OID where

open Base256

module parseOIDSub where
  here' = "parseOIDSub"

  parseOIDSub : Parser Dig (Logging ∘ Dec) Generic.OIDSub
  runParser parseOIDSub xs
    with runParser (parseWhileₜ Dig ((_≥? 128) ∘ toℕ)) xs
  ... | no  ¬parse = do
    tell $ here' String.++ ": underflow"
    return ∘ no $ ‼ go
    where
    @0 go : ¬ Success Dig Generic.OIDSub xs
    go (success ._ read@._ refl (Generic.mkOIDSub lₚ lₚ≥128 lₑ lₑ<128 leastDigs refl) suffix refl) =
      contradiction (success (lₚ ∷ʳ lₑ) read refl (mkParseWhile lₚ lₑ lₚ≥128 (<⇒≱ lₑ<128) refl) suffix refl) ¬parse
  ... | yes (success ._ _ read≡ (mkParseWhile lₚ lₑ lₚ≥128 ¬lₑ≥128 refl) suffix refl)
    with lₚ
  ... | [] = return (yes (success [ lₑ ] _ read≡ (Generic.mkOIDSub [] All.[] lₑ (≰⇒> ¬lₑ≥128) tt refl) suffix refl))
  ... | lₚ'@(l ∷ lₚ)
    with toℕ l >? 128
  ... | no  l≯128 = do
    tell $ here' String.++ ": leading byte has value 0 (non-minimal repr.)"
    return ∘ no $ ‼ go
    where
    @0 go : ¬ Success Dig Generic.OIDSub (lₚ' ∷ʳ lₑ ++ suffix)
    go (success .([] ∷ʳ lₑ1) _ read≡ (Generic.mkOIDSub [] lₚ1≥128 lₑ1 lₑ1<128 leastDigs1 refl) .((lₚ ++ [ lₑ ]) ++ suffix) refl) =
      contradiction lₑ1<128 (≤⇒≯ (proj₁ (All.uncons lₚ≥128)))
    go (success .((x ∷ lₚ1) ∷ʳ lₑ1) _ read≡ (Generic.mkOIDSub (x ∷ lₚ1) lₚ1≥128 lₑ1 lₑ1<128 leastDigs1 refl) suffix1 ps≡1) =
      contradiction (subst (λ y → 128 < toℕ y) (∷-injectiveˡ ps≡1) leastDigs1) l≯128
  ... | yes l>128 =
    return (yes (success (lₚ' ∷ʳ lₑ) _ read≡ (Generic.mkOIDSub lₚ' lₚ≥128 lₑ (≰⇒> ¬lₑ≥128) l>128 refl) suffix refl))

open parseOIDSub public using (parseOIDSub)

module parseOIDField where
  here' = "parseOIDField"

  open ≡-Reasoning
  open import Tactic.MonoidSolver using (solve ; solve-macro)

  parseOIDField-wf  : Parserᵢ Dig (λ xs A → (@0 _ : Acc _<_ (length xs)) → Logging (Dec A)) Generic.OIDField
  parseOIDFieldₐ-wf : Parserᵢ Dig (λ xs A → (@0 _ : Acc _<_ (length xs)) → Logging (Dec A)) Generic.OIDFieldₐ

  parseOIDField-wf = {!!}

  runParser parseOIDFieldₐ-wf xs (WellFounded.acc rs) = do
    yes (success pre₀ r₀ r₀≡ oidₛ suf₀ ps≡₀) ← runParser parseOIDSub xs
      where no ¬parse → {!!}
    yes (success pre₁ r₁ r₁≡ oidₑ suf₁ ps≡₁) ← runParser parseOIDField-wf suf₀ (rs _ {!!})
      where no ¬parse → {!!}
    return $ yes
      (success (pre₀ ++ pre₁) (r₀ + r₁) {!!}
        (Generic.cons oidₛ oidₑ refl)
        suf₁
        (begin
          (pre₀ ++ pre₁) ++ suf₁ ≡⟨ solve (++-monoid Dig) ⟩
          pre₀ ++ pre₁ ++ suf₁ ≡⟨ cong (pre₀ ++_) ps≡₁ ⟩
          pre₀ ++ suf₀ ≡⟨ ps≡₀ ⟩
          xs ∎))

  -- runParser parseOIDFieldₐ xs = do
  --   yes (success pre₀ r₀ r₀≡ oidₛ suf₀ ps≡₀) ← runParser parseOIDSub xs
  --     where no ¬parse → do
  --       tell here'
  --       return ∘ no $ ‼ λ where
  --         (success prefix read read≡ (Generic.cons {bs₁}{bs₂} sub rest bs≡) suffix ps≡₀) →
  --           contradiction
  --             (success _ (length bs₁) refl sub (bs₂ ++ suffix) (begin
  --               bs₁ ++ bs₂ ++ suffix   ≡⟨ solve (++-monoid Dig) ⟩
  --               (bs₁ ++ bs₂) ++ suffix ≡⟨ cong (_++ suffix) (sym bs≡) ⟩
  --               prefix ++ suffix       ≡⟨ ps≡₀ ⟩
  --               xs                     ∎))
  --             ¬parse
  --   -- yes (success pre₁ r₁ r₁≡ oidₑ suf₁ ps≡₁) ← runParser parseOIDField suf₀
  --   --   where no ¬parse → {!!}
  --   {!!}

