{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509.HashAlg
import      Aeres.Data.X509.HashAlg.TCB.OIDs        as OIDs
open import Aeres.Data.X509.MaskGenAlg
open import Aeres.Data.X509.SignAlg.RSA.PSS.Properties
open import Aeres.Data.X509.SignAlg.RSA.PSS.TCB
import      Aeres.Data.X509.SignAlg.TCB.OIDs        as OIDs
open import Aeres.Data.X690-DER.Int
open import Aeres.Data.X690-DER.OID
open import Aeres.Data.X690-DER.Sequence.DefinedByOID
open import Aeres.Data.X690-DER.TLV
import      Aeres.Data.X690-DER.Tag                 as Tag
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parallel
import      Aeres.Grammar.Parser
import      Aeres.Grammar.Properties
import      Aeres.Grammar.Option
import      Aeres.Grammar.Seq
import      Aeres.Grammar.Sum
open import Aeres.Prelude

module Aeres.Data.X509.SignAlg.RSA.PSS.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parallel    UInt8
open Aeres.Grammar.Parser      UInt8
open Aeres.Grammar.Properties  UInt8
open Aeres.Grammar.Option      UInt8
open Aeres.Grammar.Seq         UInt8
open Aeres.Grammar.Sum         UInt8

private
  here' = "X509: SignAlg: RSA: PSS"
  Rep‴  = TLV Tag.AA3 (Option (Σₚ Int λ _ i → Int.getVal i ≡ ℤ.1ℤ))
  Rep“  = (&ₚ (TLV Tag.AA2 (Option Int))
              (TLV Tag.AA3 (Option (Σₚ Int λ _ i → Int.getVal i ≡ ℤ.1ℤ))))
  Rep'  =  &ₚ (TLV Tag.AA1 (Option MGF1.MaskGenAlg))
              Rep“

parseSupportedHashAlg : Parser (Logging ∘ Dec) SupportedHashAlg
parseSupportedHashAlg =
   parseSum parseSHA1
  (parseSum parseSHA224
  (parseSum parseSHA256
  (parseSum parseSHA384
            parseSHA512)))

parseFields“ : ∀ n → Parser (Logging ∘ Dec) (ExactLength Rep“ n)
parseFields“ n =
  parseEquivalent (Iso.symEquivalent Distribute.exactLength-&)
    (parse&ᵈ
      (Parallel.nosubstrings₁ TLV.nosubstrings)
      (Parallel.Length≤.unambiguous _
        (TLV.unambiguous
          (Option.unambiguous Int.unambiguous
            TLV.nonempty)))
      (parse≤ _
        (parseTLV _ (here' String.++ ": Params: SaltLength") _
          (Option.parseOption₁ExactLength
            TLV.nosubstrings
            (tell $ here' String.++ ": Params: SaltLength: underflow")
            Int.parse))
        TLV.nosubstrings
        (tell $ here' String.++ ": Params: SaltLength: overflow"))
      (λ where
        (singleton x x≡) _ →
          subst₀ (λ x → Parser (Logging ∘ Dec) (ExactLength Rep‴ (n - x)))
            x≡
            (parseExactLength TLV.nosubstrings
              (tell $ here' String.++ "Params: trailerField: length mismatch")
              (parseTLV _ (here' String.++ "Params: trailerField") _
                (Option.parseOption₁ExactLength (Parallel.nosubstrings₁ TLV.nosubstrings)
                  (tell $ here' String.++ ": Params: trailerField: underflow")
                  (parseSigma TLV.nosubstrings Int.unambiguous Int.parse (λ i → _ ≟ _))))
              (n - x))))

parseFields' : ∀ n → Parser (Logging ∘ Dec) (ExactLength Rep' n)
parseFields' n =
  parseEquivalent (Iso.symEquivalent Distribute.exactLength-&)
    (parse&ᵈ
      (Parallel.nosubstrings₁ TLV.nosubstrings)
      (Parallel.Length≤.unambiguous _
        (TLV.unambiguous (Option.unambiguous MGF1.unambiguous TLV.nonempty)))
      (parse≤ _
        (parseTLV _ (here' String.++ ": Params: MaskGenAlg") _
          (Option.parseOption₁ExactLength TLV.nosubstrings
            (tell $ here' String.++ ": Params: MaskGenAlg: underflow")
            parseMGF1))
        TLV.nosubstrings
        (tell $ here' String.++ ": Params: MaskGenAlg: overflow"))
      λ where
        (singleton x x≡) _ →
          subst₀ (λ x → Parser (Logging ∘ Dec) (ExactLength Rep“ (n - x)))
            x≡ (parseFields“ (n - x)))

parsePSSParam : ∀ n {@0 bs} → (o : OID bs)
                → Parser (Logging ∘ Dec) (ExactLength (PSSParam o) n)
parsePSSParam n o =
  parseEquivalent{A = ExactLength Fields.Rep n ×ₚ const (_≋_{A = OIDValue} (TLV.val o) OIDs.RSA.PSS)}{B = ExactLength (PSSParam o) n}
    (Iso.transEquivalent (Parallel.equivalent₁ (Parallel.equivalent₁ Fields.equiv)) (Iso.symEquivalent (proj₁ (Distribute.×ₚ-Σₚ-iso{C = λ _ _ → _}))))
    (parse×Dec
      (Parallel.ExactLength.nosubstrings _)
      (tell $ here' String.++ ": OID mismatch (PSS)")
      (parseEquivalent
        (Iso.symEquivalent Distribute.exactLength-&)
        (parse&ᵈ
          (Parallel.nosubstrings₁ TLV.nosubstrings)
          (Parallel.unambiguous×ₚ
            (TLV.unambiguous
              (Option.unambiguous
                Fields.SupportedHashAlg.unambiguous
                Fields.SupportedHashAlg.nonempty))
            (erased-unique ≤-unique))
          (parse≤ _ (parseTLV _ here' _
            (Option.parseOption₁ExactLength
              Fields.SupportedHashAlg.nosubstrings
              (tell $ here' String.++ ": underflow (supported hash alg)")
              parseSupportedHashAlg))
            TLV.nosubstrings
            (tell $ here' String.++ ": overflow (supported hash alg)"))
          λ where
            (singleton x x≡) _ →
              subst₀ (λ x → Parser (Logging ∘ Dec) (ExactLength Rep' (n - x))) x≡
                (parseFields' (n - x))))
      (λ _ → _ ≋? _))

parsePSS : Parser (Logging ∘ Dec) PSS
parsePSS = DefinedByOID.parse here' parsePSSParam
