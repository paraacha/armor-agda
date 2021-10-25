{-# OPTIONS --subtyping #-}

open import Aeres.Prelude

open import Aeres.Binary
open import Aeres.Data.X509
open import Aeres.Data.X509.Decidable.GeneralName
open import Aeres.Data.X509.Decidable.Int
open import Aeres.Data.X509.Decidable.Length
open import Aeres.Data.X509.Decidable.Octetstring
open import Aeres.Data.X509.Decidable.TLV
open import Aeres.Data.X509.Properties as Props
open import Aeres.Grammar.Definitions
open import Aeres.Grammar.Parser
open import Data.List.Properties
open import Data.Nat.Properties
  hiding (_≟_)
open import Tactic.MonoidSolver using (solve ; solve-macro)

module Aeres.Data.X509.Decidable.AKIFields where

open Base256

module parseAKIFields where
  module Here where
    AKIKeyId = "AKI key id"
    AKIAuthCertIssuer = "AKI auth. cert. issuer"
    AKIAuthCertSN = "AKI auth. cert. SN"
    AKI = "AKI"

  open ≡-Reasoning

  parseAKIKeyId : Parser Dig (Logging ∘ Dec) X509.AKIKeyId
  parseAKIKeyId = parseTLV _ Here.AKIKeyId _ parseOctetstringValue

  parseAKIAuthCertIssuer : Parser Dig (Logging ∘ Dec) X509.AKIAuthCertIssuer
  parseAKIAuthCertIssuer = parseTLV _ Here.AKIAuthCertIssuer _ parseGeneralNamesElems

  parseAKIAuthCertSN : Parser Dig (Logging ∘ Dec) X509.AKIAuthCertSN
  parseAKIAuthCertSN = parseTLV _ Here.AKIAuthCertSN _ parseIntValue

  -- NOTE: The proof effort caught a bug in my original implementation :)
  -- (Try to parse all, then check lengths)
  parseAKIFieldsSeqFields : ∀ n → Parser Dig (Logging ∘ Dec) (ExactLength _ X509.AKIFieldsSeqFields n)
  runParser (parseAKIFieldsSeqFields zero) xs =
    return (yes (success [] _ refl (mk×ₚ (X509.mkAKIFieldsSeqFields none none none refl) refl refl) xs refl))
  runParser (parseAKIFieldsSeqFields n'@(suc n)) xs = do
    x₁ ← runParser (parse≤ _ n' parseAKIKeyId Props.TLV.nonnesting (return (Level.lift tt))) xs
    case <-cmp n' (readDecSuccess _ x₁) of λ where
      (tri< n'<r₁ _ _) → contradiction n'<r₁ (check₁ x₁)
      (tri≈ _ n'≡r₁ _) → return (yes (ret₁ x₁ n'≡r₁))
      (tri> _ _ r₁<n') → do
        let n“ = n' - (readDecSuccess _ x₁)
        x₂ ← runParser (parse≤ _ n“ parseAKIAuthCertIssuer Props.TLV.nonnesting (return (Level.lift tt))) (suffixDecSuccess _ x₁)
        case <-cmp n“ (readDecSuccess _ x₂) of λ where
          (tri< n“<r₂ _ _) → contradiction n“<r₂ (check₂ x₁ r₁<n' self x₂)
          (tri≈ _ n“≡r₂ _) → return (yes (ret₂ x₁ r₁<n' self x₂ n“≡r₂))
          (tri> _ _ r₂<n“) → do
            let n‴ = n“ - (readDecSuccess _ x₂)
            x₃ ← runParser (parse≤ _ n‴ parseAKIAuthCertSN Props.TLV.nonnesting (return (Level.lift tt))) (suffixDecSuccess _ x₂)
            case <-cmp n‴ (readDecSuccess _ x₃) of λ where
              (tri< n‴<r₃ _ _) → contradiction n‴<r₃ (check₃ x₁ r₁<n' self x₂ r₂<n“ self x₃)
              (tri> _ _ r₃<n‴) → do
                return ∘ no $ ‼ underflow x₁ r₁<n' self x₂ r₂<n“ self x₃ r₃<n‴
              (tri≈ _ n‴≡r₃ _) → return (yes (ret₃ x₁ r₁<n' self x₂ r₂<n“ self x₃ n‴≡r₃))
    where
    Res₁ : (A : (@0 _ : List Dig) → Set) → Set
    Res₁ A = Dec (Success Dig (_×ₚ_ _ A ((_≤ n') ∘ length)) xs)

    Res₂ : ∀ {A₁} (A₂ : (@0 _ : List Dig) → Set) → (x₁ : Res₁ A₁) → ℕ → Set
    Res₂ A₂ x₁ n“ = Dec (Success Dig (_×ₚ_ _ A₂ ((_≤ n“) ∘ length)) (suffixDecSuccess _ x₁))

    Res₃ : ∀ {A₁ A₂} (A₃ : (@0 _ : List Dig) → Set) → (x₁ : Res₁ A₁) (n“ : ℕ) (x₂ : Res₂ A₂ x₁ n“) → ℕ → Set
    Res₃ A₃ x₁ n“ x₂ n‴ = Dec (Success _ (_×ₚ_ _ A₃ ((_≤ n‴) ∘ length)) (suffixDecSuccess _ x₂))

    check₁ : ∀ {@0 A} → (x₁ : Res₁ A) → ¬ n' < readDecSuccess _ x₁
    check₁ (no _) ()
    check₁ (yes (success prefix read read≡ (mk×ₚ akiId akiLen refl) suffix ps≡)) n'<r₁ =
      contradiction (≤-trans (Lemmas.≡⇒≤ read≡) akiLen) (<⇒≱ n'<r₁)

    ret₁ : (x₁ : Res₁ X509.AKIKeyId) → n' ≡ readDecSuccess _ x₁ → Success _ (ExactLength _ X509.AKIFieldsSeqFields n') xs
    ret₁ (no ¬parse) ()
    ret₁ (yes (success prefix ._ read≡ (mk×ₚ akiKeyId akiKeyIdLen refl) suffix ps≡)) refl =
      success prefix _ read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields (some akiKeyId) none none refl) (trans₀ (cong length (++-identityʳ prefix)) (sym read≡)) (++-identityʳ _ )) suffix ps≡

    -- `check₂` is given more information than it needs (e.g., the value of `n“` in terms of `n'` is never used)
    check₂ : ∀ {@0 A₁ A₂} (x₁ : Res₁ A₁) (r₁<n' : readDecSuccess _ x₁ < n') (n“ : Singleton (n' - readDecSuccess _ x₁)) (x₂ : Res₂ A₂ x₁ (Singleton.x n“))
             → ¬ Singleton.x n“ < readDecSuccess _ x₂
    check₂ (no _) _ (singleton ._ refl) x₂ n“<r₂ = check₁ x₂ n“<r₂
    check₂ (yes x₁) _ (singleton n“ n“≡) (no _) ()
    check₂ (yes (success _ r₁ read≡ (mk×ₚ fstₚ₁ r₁≤n' refl) suffix ps≡)) r₁<n' (singleton n“ n“≡) (yes (success _ r₂ read≡₁ (mk×ₚ fstₚ₂ r₂≤n“ refl) suffix₁ ps≡₁)) n“<r₂ =
      contradiction (≤-trans (Lemmas.≡⇒≤ read≡₁) r₂≤n“) (<⇒≱ n“<r₂)

    ret₂ : (x₁ : Res₁ X509.AKIKeyId) → n' > readDecSuccess _ x₁
           → (n“ : Singleton (n' - readDecSuccess _ x₁)) (x₂ : Res₂ X509.AKIAuthCertIssuer x₁ (Singleton.x n“))
           → Singleton.x n“ ≡ readDecSuccess _ x₂
           → Success _ (ExactLength _ X509.AKIFieldsSeqFields n') xs
    ret₂ (no _) _ (singleton n“@._ refl) (no _) ()
    ret₂ (no _) _ (singleton .n' refl) (yes (success prefix read read≡ (mk×ₚ akici akiciLen refl) suffix ps≡)) n“≡r₂ =
      success prefix _ read≡
        (mk×ₚ (X509.mkAKIFieldsSeqFields none (some akici) none (sym $ ++-identityʳ prefix))
          (trans₀ (sym read≡) (sym n“≡r₂)) refl)
        suffix ps≡
    ret₂ (yes (success prefix read read≡ (mk×ₚ akiID akiLen refl) suffix ps≡)) n'>r₁ (singleton .0 n“≡) (no _) refl =
      contradiction (m∸n≡0⇒m≤n (sym n“≡)) (<⇒≱ n'>r₁)
    ret₂ (yes (success pre₁ r₁ r₁≡ (mk×ₚ akiID akiIdLen refl) suf₁ ps≡₁)) n'>r₁ (singleton .r₂ n“≡) (yes (success pre₂ r₂ r₂≡ (mk×ₚ akiCI akiCILen refl) suf₂ ps≡₂)) refl =
      success (pre₁ ++ pre₂) (r₁ + r₂) r₁+r₂≡
        (mk×ₚ (X509.mkAKIFieldsSeqFields (some akiID) (some akiCI) none (pre₁ ++ pre₂ ≡ pre₁ ++ pre₂ ++ [] ∋ solve (++-monoid Dig)))
          (‼ (begin length (pre₁ ++ pre₂) ≡⟨ sym r₁+r₂≡ ⟩
                    r₁ + r₂               ≡⟨ cong (r₁ +_) n“≡ ⟩
                    r₁ + (n' - r₁)        ≡⟨ (sym $ +-∸-assoc r₁ (<⇒≤ n'>r₁)) ⟩
                    (r₁ + n') - r₁        ≡⟨ cong (_∸ r₁) (+-comm r₁ _) ⟩
                    (n' + r₁) - r₁        ≡⟨ +-∸-assoc n'{r₁} ≤-refl ⟩
                    n' + (r₁ - r₁)        ≡⟨ cong (n' +_) (n∸n≡0 r₁) ⟩
                    n' + 0                ≡⟨ +-identityʳ _ ⟩
                    n'                    ∎))
          refl)
        suf₂ (begin (pre₁ ++ pre₂) ++ suf₂ ≡⟨ solve (++-monoid Dig) ⟩
                    pre₁ ++ pre₂ ++ suf₂   ≡⟨ cong (pre₁ ++_) ps≡₂ ⟩
                    pre₁ ++ suf₁           ≡⟨ ps≡₁ ⟩
                    xs                     ∎)
      where
      open ≡-Reasoning
      @0 r₁+r₂≡ : r₁ + r₂ ≡ length (pre₁ ++ pre₂)
      r₁+r₂≡ = begin
        r₁ + r₂ ≡⟨ ‼ (cong₂ _+_ r₁≡ r₂≡) ⟩
        length pre₁ + length pre₂ ≡⟨ (sym $ length-++ pre₁) ⟩
        length (pre₁ ++ pre₂) ∎

    ret₃ : (x₁ : Res₁ X509.AKIKeyId) → n' > readDecSuccess _ x₁
           → (n“ : Singleton (n' - readDecSuccess _ x₁)) (x₂ : Res₂ X509.AKIAuthCertIssuer x₁ (Singleton.x n“))
           → Singleton.x n“ > readDecSuccess _ x₂
           → (n‴ : Singleton (Singleton.x n“ - readDecSuccess _ x₂)) (x₃ : Res₃ X509.AKIAuthCertSN x₁ (Singleton.x n“) x₂ (Singleton.x n‴))
           → Singleton.x n‴ ≡ readDecSuccess _ x₃
           → Success _ (ExactLength _ X509.AKIFieldsSeqFields n') xs
    ret₃ x₁ r₁<n' n“ x₂ r₂<n“ (singleton .0 n‴≡) (no ¬authcertsn) refl = contradiction (m∸n≡0⇒m≤n (sym n‴≡)) (<⇒≱ r₂<n“)
    ret₃ (yes (success pre₁ r₁ r₁≡ (mk×ₚ authkeyid _ refl) suf₁ ps≡₁)) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss _ refl) suf₂ ps≡₂)) r₂<n“ self (yes (success pre₃ r₃@._ r₃≡ (mk×ₚ authcertsn _ refl) suf₃ ps≡₃)) refl =
      success _ (r₁ + r₂ + r₃)
        (begin (r₁ + r₂ + r₃ ≡⟨ cong₂ (λ x y → (x + y) + r₃) r₁≡ r₂≡ ⟩
               length pre₁ + length pre₂ + r₃ ≡⟨ cong (_+ r₃) (sym (length-++ pre₁)) ⟩
               length (pre₁ ++ pre₂) + r₃ ≡⟨ cong (length (pre₁ ++ pre₂) +_) r₃≡ ⟩
               length (pre₁ ++ pre₂) + length pre₃ ≡⟨ sym (length-++ (pre₁ ++ pre₂)) ⟩
               length ((pre₁ ++ pre₂) ++ pre₃) ≡⟨ cong length ((pre₁ ++ pre₂) ++ pre₃ ≡ pre₁ ++ pre₂ ++ pre₃ ∋ solve (++-monoid Dig)) ⟩
               length (pre₁ ++ pre₂ ++ pre₃) ∎))
        (mk×ₚ
          (X509.mkAKIFieldsSeqFields (some authkeyid) (some authcertiss) (some authcertsn) refl)
          (‼ (sym (begin
            (n' ≡⟨ sym (m+n∸m≡n r₂ n') ⟩
            r₂ + n' - r₂ ≡⟨ +-∸-assoc r₂ (r₂ ≤ n' ∋ ≤-trans (<⇒≤ r₂<n“) (m∸n≤m n' r₁)) ⟩
            r₂ + (n' - r₂) ≡⟨ cong (λ x → r₂ + (x ∸ r₂)) (sym (m+n∸m≡n r₁ n')) ⟩
            r₂ + (r₁ + n' - r₁ - r₂) ≡⟨ cong (r₂ +_) (cong (_- r₂) (+-∸-assoc r₁ (r₁ ≤ n' ∋ <⇒≤ r₁<n' ))) ⟩
            r₂ + (r₁ + (n' - r₁) - r₂) ≡⟨ cong (r₂ +_) (+-∸-assoc r₁ (r₂ ≤ n' - r₁ ∋ <⇒≤ r₂<n“)) ⟩
            r₂ + (r₁ + (n' - r₁ - r₂)) ≡⟨ sym (+-assoc r₂ r₁ _) ⟩
            r₂ + r₁ + (n' - r₁ - r₂) ≡⟨ cong (r₂ + r₁ +_) r₃≡ ⟩
            r₂ + r₁ + length pre₃ ≡⟨ cong (_+ length pre₃) (+-comm r₂ r₁) ⟩
            r₁ + r₂ + length pre₃ ≡⟨ cong₂ (λ x y → x + y + length pre₃) r₁≡ r₂≡ ⟩
            length pre₁ + length pre₂ + length pre₃ ≡⟨ cong (_+ length pre₃) (sym (length-++ pre₁)) ⟩
            length (pre₁ ++ pre₂) + length pre₃ ≡⟨ sym (length-++ (pre₁ ++ pre₂)) ⟩
            length ((pre₁ ++ pre₂) ++ pre₃) ≡⟨ cong length ((pre₁ ++ pre₂) ++ pre₃ ≡ pre₁ ++ pre₂ ++ pre₃ ∋ solve (++-monoid Dig)) ⟩
            length (pre₁ ++ pre₂ ++ pre₃) ∎))))
          refl)
        suf₃
        (begin (pre₁ ++ pre₂ ++ pre₃) ++ suf₃ ≡⟨ solve (++-monoid Dig) ⟩
               pre₁ ++ pre₂ ++ (pre₃ ++ suf₃) ≡⟨ cong (λ x → pre₁ ++ pre₂ ++ x) ps≡₃ ⟩
               pre₁ ++ pre₂ ++ suf₂ ≡⟨ cong (pre₁ ++_) ps≡₂ ⟩
               pre₁ ++ suf₁ ≡⟨ ps≡₁ ⟩
               xs ∎)
    ret₃ (yes (success pre₁ r₁ r₁≡ (mk×ₚ authkeyid _ refl) suf₁ ps≡₁)) r₁<n' (singleton .(n' - r₁) refl) (no _) r₂<n“ self (yes (success pre₃ r₃@._ r₃≡ (mk×ₚ authcertsn _ refl) suf₃ ps≡₃)) refl =
      success _ (r₁ + r₃)
        (trans (cong₂ _+_ r₁≡ r₃≡) (sym (length-++ pre₁)))
        (mk×ₚ
          (X509.mkAKIFieldsSeqFields (some authkeyid) none (some authcertsn) refl)
          (‼ (sym (begin
            (n' ≡⟨ sym (m+n∸m≡n r₁ n') ⟩
            r₁ + n' - r₁ ≡⟨ +-∸-assoc r₁ (<⇒≤ r₁<n') ⟩
            r₁ + (n' - r₁) ≡⟨ cong (r₁ +_) r₃≡ ⟩
            r₁ + length pre₃ ≡⟨ cong (_+ length pre₃) r₁≡ ⟩
            length pre₁ + length pre₃ ≡⟨ sym (length-++ pre₁) ⟩
            length (pre₁ ++ pre₃) ∎))))
          refl)
        suf₃
        (sym (trans (sym ps≡₁) (trans (cong (pre₁ ++_) (sym ps≡₃)) (solve (++-monoid Dig)))))
    ret₃ (no _) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authiss _ refl) suf₂ ps≡₂)) r₂<n“ (singleton .(n' - r₂) refl) (yes (success pre₃ r₃@._ r₃≡ (mk×ₚ authcertsn _ refl) suf₃ ps≡₃)) refl =
      success _ (r₂ + r₃) (trans (cong₂ _+_ r₂≡ r₃≡) (sym (length-++ pre₂)))
        (mk×ₚ
          (X509.mkAKIFieldsSeqFields none (some authiss) (some authcertsn) refl)
          (‼ sym (begin (n' ≡⟨ sym (m+n∸m≡n r₂ n') ⟩
                      r₂ + n' - r₂ ≡⟨ +-∸-assoc r₂ (<⇒≤ r₂<n“) ⟩
                      r₂ + (n' - r₂) ≡⟨ cong (r₂ +_) r₃≡ ⟩
                      r₂ + length pre₃ ≡⟨ cong (_+ length pre₃) r₂≡ ⟩
                      length pre₂ + length pre₃ ≡⟨ sym (length-++ pre₂) ⟩
                      length (pre₂ ++ pre₃) ∎)))
          refl)
        suf₃
        (sym (trans (sym ps≡₂) (trans (cong (pre₂ ++_) (sym ps≡₃)) (solve (++-monoid Dig)))))
    ret₃ (no _) _ self (no _) _ self (yes (success pre₃ r₃ r₃≡ (mk×ₚ authcertsn _ refl) suf₃ ps≡₃)) r₃≡n‴ =
      success _ r₃ r₃≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none (some authcertsn) refl) (trans₀ (sym r₃≡) (sym r₃≡n‴)) refl) suf₃ ps≡₃

    -- `check₃` is given more information than it needs (e.g., the value of `n‴` in terms of `n'` is never used)
    check₃ : ∀ {@0 A₁ A₂ A₃} (x₁ : Res₁ A₁) (r₁<n' : readDecSuccess _ x₁ < n') (n“ : Singleton (n' - readDecSuccess _ x₁))
             → (x₂ : Res₂ A₂ x₁ (Singleton.x n“)) (r₂<n“ : readDecSuccess _ x₂ < Singleton.x n“) (n‴ : Singleton (Singleton.x n“ - readDecSuccess _ x₂))
             → (x₃ : Res₃ A₃ x₁ (Singleton.x n“) x₂ (Singleton.x n‴)) → ¬ Singleton.x n‴ < readDecSuccess _ x₃
    check₃ (no _) r₁<n' (singleton n“@._ refl) x₂ r₂<n“ n‴ x₃ n‴<r₃ = check₂ x₂ r₂<n“ n‴ x₃ n‴<r₃
    check₃ (yes x₁) r₁<n' n“ (no _) r₂<n“ (self {n‴@._}) x₃ n‴<r₃ = check₂ (yes x₁) r₁<n' n“ x₃ n‴<r₃
    check₃ (yes x₁) r₁<n' n“ (yes x₂) r₂<n“ n‴ (no _) ()
    check₃ (yes (success pre₁ r₁ r₁≡ v₁ suf₁ ps≡₁)) r₁<n' n“ (yes (success pre₂ r₂ r₂≡ v₂ suf₂ ps≡₂)) r₂<n“ (self {n‴@._}) (yes (success pre₃ r₃ r₃≡ (mk×ₚ v₃ r₃≤n‴ refl) suf₃ ps≡₃)) n‴<r₃ =
      contradiction (≤-trans (Lemmas.≡⇒≤ r₃≡) r₃≤n‴) (<⇒≱ n‴<r₃)

    module underflow₁-₁
      {@0 akid ci csn suffix pre₁ suf₁ : List Dig}
      (@0 ps≡ : (akid ++ ci ++ csn) ++ suffix ≡ xs) (@0 ps≡₁ : pre₁ ++ suf₁ ≡ xs)
      (n'≡ : length (akid ++ ci ++ csn) ≡ n')
      (r₁ : ℕ) (@0 r₁≡ : r₁ ≡ length pre₁)
      (akeyid : X509.AKIKeyId akid) (akeyid' : X509.AKIKeyId pre₁)
      where

      @0 ps≡₁' : akid ++ ci ++ csn ++ suffix ≡ pre₁ ++ suf₁
      ps≡₁' = begin akid ++ ci ++ csn ++ suffix   ≡⟨ solve (++-monoid Dig) ⟩
                    (akid ++ ci ++ csn) ++ suffix ≡⟨ ps≡ ⟩
                    xs                            ≡⟨ sym ps≡₁ ⟩
                    pre₁ ++ suf₁                  ∎
      @0 akid≡ : akid ≡ pre₁
      akid≡ = TLV.nonnesting ps≡₁' akeyid akeyid'

      @0 n'-r₁≡ : n' - r₁ ≡ length (ci ++ csn)
      n'-r₁≡ = begin
            n' - r₁ ≡⟨ cong (n' -_) r₁≡ ⟩
            n' - length pre₁ ≡⟨ cong (_- length pre₁) (sym n'≡) ⟩
            length (akid ++ ci ++ csn) - length pre₁ ≡⟨ cong (_∸ length pre₁) (length-++ akid) ⟩
            (length akid + length (ci ++ csn)) - length pre₁ ≡⟨ cong _ akid≡ ⟩
            (length pre₁ + length (ci ++ csn)) - length pre₁ ≡⟨ cong (_∸ length pre₁) (+-comm (length pre₁) _) ⟩
            (length (ci ++ csn) + length pre₁) - length pre₁ ≡⟨ +-∸-assoc (length (ci ++ csn)){length pre₁} ≤-refl ⟩
            length (ci ++ csn) + (length pre₁ - length pre₁) ≡⟨ cong (length (ci ++ csn) +_) (n∸n≡0 (length pre₁)) ⟩
            length (ci ++ csn) + 0 ≡⟨ +-identityʳ _ ⟩
            length (ci ++ csn) ∎

      module underflow₁₁-₁₁
        {@0 pre₂ suf₂ : List Dig} (@0 ps≡₂ : pre₂ ++ suf₂ ≡ suf₁)
        (r₂ : ℕ) (@0 r₂≡ : r₂ ≡ length pre₂)
        (authcertiss : X509.AKIAuthCertIssuer ci) (authcertiss' : X509.AKIAuthCertIssuer pre₂)
        where

        @0 ps≡₂' : ci ++ csn ++ suffix ≡ pre₂ ++ suf₂
        ps≡₂' = trans₀ (Lemmas.++-cancel≡ˡ _ _ akid≡ ps≡₁') (sym ps≡₂)

        @0 ci≡ : ci ≡ pre₂
        ci≡ = TLV.nonnesting ps≡₂' authcertiss authcertiss'

        @0 n'-r₁-r₂≡ : n' - r₁ - r₂ ≡ length csn
        n'-r₁-r₂≡ = begin
          (n' - r₁) - r₂                           ≡⟨ cong (_- r₂) n'-r₁≡ ⟩
          length (ci ++ csn) - r₂                  ≡⟨ cong (_- r₂) (length-++ ci) ⟩
          length ci + length csn - r₂              ≡⟨ cong (λ x → length x + length csn - r₂) ci≡ ⟩
          length pre₂ + length csn - r₂            ≡⟨ cong (length pre₂ + length csn -_) r₂≡ ⟩
          length pre₂ + length csn - length pre₂   ≡⟨ cong (_- length pre₂) (+-comm (length pre₂) _) ⟩
          length csn + length pre₂ - length pre₂   ≡⟨ +-∸-assoc (length csn){length pre₂} ≤-refl ⟩
          length csn + (length pre₂ - length pre₂) ≡⟨ cong (length csn +_) (n∸n≡0 (length pre₂)) ⟩
          length csn + 0                           ≡⟨ +-identityʳ (length csn) ⟩
          length csn ∎

        module underflow₁₁₁-₁₁₁
          {@0 pre₃ suf₃ : List Dig} (@0 ps≡₃ : pre₃ ++ suf₃ ≡ suf₂)
          (r₃ : ℕ) (@0 r₃≡ : r₃ ≡ length pre₃)
          (authcertsn : X509.AKIAuthCertSN csn) (authcertsn' : X509.AKIAuthCertSN pre₃)
          where

          @0 ps≡₃' : csn ++ suffix ≡ pre₃ ++ suf₃
          ps≡₃' = trans₀ (Lemmas.++-cancel≡ˡ _ _ ci≡ ps≡₂') (sym ps≡₃)

          @0 csn≡ : csn ≡ pre₃
          csn≡ = TLV.nonnesting ps≡₃' authcertsn authcertsn'

          @0 n'-r₁-r₂-r₃≡ : n' - r₁ - r₂ - r₃ ≡ 0
          n'-r₁-r₂-r₃≡ = begin
            n' - r₁ - r₂ - r₃         ≡⟨ cong (_- r₃) n'-r₁-r₂≡ ⟩
            length csn - r₃           ≡⟨ cong (λ x → length x - r₃) csn≡ ⟩
            length pre₃ - r₃          ≡⟨ cong (length pre₃ -_) r₃≡ ⟩
            length pre₃ - length pre₃ ≡⟨ n∸n≡0 (length pre₃) ⟩
            0 ∎

      module underflow₁₀-₁₀
        (@0 ci≡ : ci ≡ [])
        where

        @0 ps≡₂' : csn ++ suffix ≡ suf₁
        ps≡₂' = trans₀ (cong (λ x → x ++ csn ++ suffix) (sym ci≡)) (Lemmas.++-cancel≡ˡ _ _ akid≡ ps≡₁')

    module underflow₀₁-₀₁
      {@0 ci csn suffix pre₂ suf₂ : List Dig} (@0 ps≡ : (ci ++ csn) ++ suffix ≡ xs) (@0 ps≡₂ : pre₂ ++ suf₂ ≡ xs)
      (r₂ : ℕ) (@0 r₂≡ : r₂ ≡ length pre₂)
      (authcertiss : X509.AKIAuthCertIssuer ci) (authcertiss' : X509.AKIAuthCertIssuer pre₂)
      where

      @0 ps≡₂' : ci ++ csn ++ suffix ≡ pre₂ ++ suf₂
      ps≡₂' = trans (ci ++ csn ++ suffix ≡ (ci ++ csn) ++ suffix ∋ solve (++-monoid Dig)) (trans ps≡ (sym ps≡₂))
        -- trans₀ (Lemmas.++-cancel≡ˡ _ _ akid≡ ps≡₁') (sym ps≡₂)

      @0 ci≡ : ci ≡ pre₂
      ci≡ = TLV.nonnesting ps≡₂' authcertiss authcertiss' -- TLV.nonnesting ps≡₂' authcertiss authcertiss'

    @0 underflow : ∀ (x₁ : Res₁ X509.AKIKeyId) (r₁<n' : readDecSuccess _ x₁ < n') (n“ : Singleton (n' - readDecSuccess _ x₁))
                   → (x₂ : Res₂ X509.AKIAuthCertIssuer x₁ (Singleton.x n“)) (r₂<n“ : readDecSuccess _ x₂ < Singleton.x n“) (n‴ : Singleton (Singleton.x n“ - readDecSuccess _ x₂))
                   → (x₃ : Res₃ X509.AKIAuthCertSN x₁ (Singleton.x n“) x₂ (Singleton.x n‴)) → readDecSuccess _ x₃ < Singleton.x n‴  → ¬ Success _ (ExactLength _ X509.AKIFieldsSeqFields n') xs
    underflow (no ¬akeyid) r₁<n' n“ x₂ r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) authcertiss authcertsn refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl (mk×ₚ akeyid (≤-trans (Lemmas.length-++-≤₁ akid (ci ++ csn)) (Lemmas.≡⇒≤ n'≡)) refl) (ci ++ csn ++ suffix) (trans (akid ++ ci ++ csn ++ suffix ≡ (akid ++ ci ++ csn) ++ suffix ∋ solve (++-monoid Dig)) ps≡))
        ¬akeyid
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (no ¬authcertiss) r₂<n“ self x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) (some authcertiss) authcertsn refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl (mk×ₚ authcertiss (≤-trans (Lemmas.length-++-≤₁ ci _) (Lemmas.≡⇒≤ $ sym n'-r₁≡)) refl) (csn ++ suffix) (Lemmas.++-cancel≡ˡ _ _ akid≡ ps≡₁'))
        ¬authcertiss
      where open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ self (no ¬authcertsn) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) (some authcertiss) (some authcertsn) refl) n'≡ refl) suffix ps≡) = ‼
      contradiction
        (success _ _ n'-r₁-r₂≡ (mk×ₚ authcertsn (Lemmas.≡⇒≤ (sym n'-r₁-r₂≡)) refl) suffix (Lemmas.++-cancel≡ˡ _ _ ci≡ ps≡₂'))
        ¬authcertsn
      where
      open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
      open underflow₁₁-₁₁ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ self (yes (success pre₃ r₃ r₃≡ (mk×ₚ authcertsn' _ refl) suf₃ ps≡₃)) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) (some authcertiss) (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction (sym n'-r₁-r₂-r₃≡) (<⇒≢ (m<n⇒0<n∸m r₃<n‴))
      where
      open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
      open underflow₁₁-₁₁ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
      open underflow₁₁₁-₁₁₁ ps≡₃ r₃ r₃≡ authcertsn authcertsn'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) (some authcertiss) none refl) n'≡ refl) suffix ps≡) =
      contradiction (sym n'-r₁-r₂≡) (<⇒≢ (m<n⇒0<n∸m r₂<n“))
      where
      open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
      open underflow₁₁-₁₁ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' n“ x₂ r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) none none refl) n'≡ refl) suffix ps≡) =
      contradiction
        (trans₀ r₁≡ (trans₀ (cong length (sym akid≡)) (trans (cong length (sym $ ++-identityʳ akid)) n'≡)))
        (<⇒≢ r₁<n')
      where
      open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' n“ (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      TLV.noconfusion (λ where ()) (sym $ Lemmas.++-cancel≡ˡ _ _ akid≡ (trans₀ ps≡₁' (cong (pre₁ ++_) (sym ps≡₂)))) authcertiss' authcertsn
      where
      open underflow₁-₁{ci = ci} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (no _) r₂<n“ self (no ¬authcertsn) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl
          (mk×ₚ authcertsn
            (Lemmas.≡⇒≤ (begin length csn                               ≡⟨ sym $ m+n∸m≡n (length akid) (length csn) ⟩
                               (length akid + length csn) - length akid ≡⟨ cong (_∸ length akid) (sym (length-++ akid)) ⟩
                               length (akid ++ csn) - length akid       ≡⟨ cong (_- length akid) n'≡ ⟩
                               n' - length akid                         ≡⟨ cong (λ x → n' ∸ length x) akid≡ ⟩
                               n' - length pre₁                         ≡⟨ cong (n' -_) (sym r₁≡) ⟩
                               n' - r₁ ∎))
            refl)
          suffix ps≡₂')
        ¬authcertsn
      where
      open underflow₁-₁{ci = []} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
      open underflow₁₀-₁₀ refl
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' self (no _) r₂<n“ self (yes (success pre₃ r₃ r₃≡ (mk×ₚ authcertsn' _ refl) suf₃ ps≡₃)) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{akid = akid}{ci}{csn} (some akeyid) none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction
        (trans₀ (trans (cong (_+ r₃) r₁≡) (trans (cong (length pre₁ +_) r₃≡) (trans (sym (length-++ pre₁)) (cong₂ (λ x x₁ → length (x ++ x₁)) (sym akid≡) (sym csn≡))))) n'≡)
        (<⇒≢ (r₁ + r₃ < n' ∋ ≤-trans (+-monoʳ-< r₁ r₃<n‴) (Lemmas.≡⇒≤ (trans₀ (sym (+-∸-assoc r₁{n'}{r₁} (<⇒≤ r₁<n'))) (m+n∸m≡n r₁ n')))))
      where
      open underflow₁-₁{ci = []} ps≡ ps≡₁ n'≡ r₁ r₁≡ akeyid akeyid'
      open underflow₁₀-₁₀ refl

      @0 csn≡ : csn ≡ pre₃
      csn≡ = TLV.nonnesting (trans ps≡₂' (sym ps≡₃)) authcertsn authcertsn'

    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' n“ x₂ r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{ci = ci}{csn} none (some authcertiss) authcertsn refl) n'≡ refl) suffix ps≡) =
      TLV.noconfusion (λ where ()) (trans₀ ps≡₁ (trans (sym ps≡) ((ci ++ csn) ++ suffix ≡ ci ++ csn ++ suffix ∋ solve (++-monoid Dig)))) akeyid' authcertiss
    underflow (no _) r₁<n' self (no ¬authcertiss) r₂<n“ self x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{ci = ci}{csn} none (some authcertiss) authcertsn refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl (mk×ₚ authcertiss (≤-trans (Lemmas.length-++-≤₁ ci _) (Lemmas.≡⇒≤ n'≡)) refl) _ (trans₀ (ci ++ csn ++ suffix ≡ (ci ++ csn) ++ suffix ∋ solve (++-monoid Dig)) ps≡))
        ¬authcertiss
    underflow (no _) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ self x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{ci = ci}{csn} none (some authcertiss) none refl) n'≡ refl) suffix ps≡) =
      contradiction
        (trans₀ r₂≡ (trans₀ (trans (cong length (pre₂ ≡ ci ∋ sym ci≡ )) (cong length (ci ≡ ci ++ [] ∋ solve (++-monoid Dig)))) n'≡))
        (<⇒≢ r₂<n“)
      where
      open underflow₀₁-₀₁ ps≡ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
    underflow (no _) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ self (no ¬authcertsn) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{ci = ci}{csn} none (some authcertiss) (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl
          (mk×ₚ authcertsn
            (Lemmas.≡⇒≤ $ begin
              length csn ≡⟨ sym $ m+n∸m≡n (length ci) (length csn) ⟩
              length ci + length csn - length ci ≡⟨ cong (_∸ length ci) (sym (length-++ ci)) ⟩
              length (ci ++ csn) - length ci ≡⟨ cong (_∸ length ci) n'≡ ⟩
              n' - length ci ≡⟨ cong (λ x → n' ∸ length x) ci≡ ⟩
              n' - length pre₂ ≡⟨ cong (n' ∸_) (sym r₂≡) ⟩
              n' - r₂ ∎)
            refl)
          suffix (Lemmas.++-cancel≡ˡ _ _ ci≡ ps≡₂'))
        ¬authcertsn
      where
      open underflow₀₁-₀₁ ps≡ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
    underflow (no _) r₁<n' self (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ self (yes (success pre₃ r₃ r₃≡ (mk×ₚ authcertsn' _ refl) suf₃ ps≡₃)) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields{ci = ci}{csn} none (some authcertiss) (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction
        (begin (r₃ ≡⟨ sym (m+n∸m≡n r₂ r₃) ⟩
               r₂ + r₃ - r₂ ≡⟨ cong₂ (λ x y → x + y - r₂) r₂≡ r₃≡ ⟩
               length pre₂ + length pre₃ - r₂ ≡⟨ cong (_∸ r₂) (sym (length-++ pre₂)) ⟩
               length (pre₂ ++ pre₃) - r₂ ≡⟨ cong₂ (λ x y → length (x ++ y) - r₂) (sym ci≡) (TLV.nonnesting (trans ps≡₃ (sym (Lemmas.++-cancel≡ˡ _ _ ci≡ ps≡₂'))) authcertsn' authcertsn) ⟩
               length (ci ++ csn) - r₂ ≡⟨ cong (_- r₂) n'≡ ⟩
               n' - r₂ ∎))
        (<⇒≢ r₃<n‴)
      where
      open underflow₀₁-₀₁ ps≡ ps≡₂ r₂ r₂≡ authcertiss authcertiss'
    underflow (yes (success pre₁ r₁ r₁≡ (mk×ₚ akeyid' _ refl) suf₁ ps≡₁)) r₁<n' n“ x₂ r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      TLV.noconfusion (λ where ()) (trans ps≡ (sym ps≡₁)) authcertsn akeyid'
    underflow (no _) r₁<n' n“ (yes (success pre₂ r₂ r₂≡ (mk×ₚ authcertiss' _ refl) suf₂ ps≡₂)) r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      TLV.noconfusion (λ where ()) (trans ps≡₂ (sym ps≡)) authcertiss' authcertsn
    underflow (no _) r₁<n' self (no _) r₂<n“ self (no ¬authcertsn) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction
        (success _ _ refl (mk×ₚ authcertsn (Lemmas.≡⇒≤ n'≡) refl) suffix ps≡)
        ¬authcertsn
    underflow (no _) r₁<n' self (no _) r₂<n“ self (yes (success pre₃ r₃ r₃≡ (mk×ₚ authcertsn' _ refl) suf₃ ps≡₃)) r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none (some authcertsn) refl) n'≡ refl) suffix ps≡) =
      contradiction (trans (trans r₃≡ (cong length $ TLV.nonnesting (trans ps≡₃ (sym ps≡)) authcertsn' authcertsn)) n'≡) (<⇒≢ r₃<n‴)
    underflow x₁ r₁<n' n“ x₂ r₂<n“ n‴ x₃ r₃<n‴ (success prefix read read≡ (mk×ₚ (X509.mkAKIFieldsSeqFields none none none refl) () refl) suffix ps≡)

open parseAKIFields public using (parseAKIKeyId ; parseAKIAuthCertIssuer ; parseAKIAuthCertSN ; parseAKIFieldsSeqFields)


private
  module Test where

    AKIid₁ : List Dig
    AKIid₁ = # 128 ∷ # 20 ∷ # 20 ∷ # 46 ∷ # 179 ∷ # 23 ∷ # 183 ∷ # 88 ∷ # 86 ∷ # 203 ∷ # 174 ∷ # 80 ∷ # 9 ∷ # 64 ∷ # 230 ∷ # 31 ∷ # 175 ∷ # 157 ∷ # 139 ∷ # 20 ∷ # 194 ∷ [ # 198 ]

    AKIsn₁ : List Dig
    AKIsn₁ = # 130 ∷ # 2 ∷ # 2 ∷ [ # 3 ]

    AKIissuer₁ : List Dig
    AKIissuer₁ = # 161 ∷ # 8 ∷ # 130 ∷ # 2 ∷ # 90 ∷ # 90 ∷ # 130 ∷ # 2 ∷ # 90 ∷ [ # 90 ]

    AKIfields₁ : List Dig
    AKIfields₁ = # 130 ∷ # 2 ∷ # 2 ∷ [ # 3 ]
    
    test₁ : X509.AKIKeyId AKIid₁
    test₁ = Success.value (toWitness {Q = Logging.val (runParser parseAKIKeyId AKIid₁)} tt)

    test₂ : X509.AKIAuthCertIssuer AKIissuer₁
    test₂ = Success.value (toWitness {Q = Logging.val (runParser parseAKIAuthCertIssuer AKIissuer₁)} tt)

    test₃ : X509.AKIAuthCertSN AKIsn₁
    test₃ = Success.value (toWitness {Q = Logging.val (runParser parseAKIAuthCertSN AKIsn₁)} tt)

    -- AKIfieldstest₁ : X509.AKIFieldsSeqFields AKIfields₁
    -- AKIfieldstest₁ = Success.value (toWitness {Q = Logging.val (runParser {!parseAKIFieldsSeqFields!} AKIfields₁) } tt)

