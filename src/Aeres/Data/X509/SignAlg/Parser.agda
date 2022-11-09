{-# OPTIONS --subtyping #-}

open import Aeres.Prelude

open import Aeres.Binary
open import Aeres.Data.X509.SignAlg.ECDSA
open import Aeres.Data.X509.SignAlg.DSA
open import Aeres.Data.X509.SignAlg.RSA
open import Aeres.Data.X509.SignAlg.TCB
open import Aeres.Data.X690-DER.OID
open import Aeres.Data.X690-DER.OctetString
open import Aeres.Data.X690-DER.TLV
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parser
import      Aeres.Grammar.Properties
import      Aeres.Grammar.Sum

module Aeres.Data.X509.SignAlg.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parser      UInt8
open Aeres.Grammar.Properties  UInt8
open Aeres.Grammar.Sum         UInt8

parseUnsupported : Parser (Logging ∘ Dec) UnsupportedSignAlg
parseUnsupported =
  parseTLV _ "X509: SignAlg: unsupported" _
    λ n →
      parseEquivalent (symEquivalent Distribute.exactLength-&)
        (parse&ᵈ
          (withinLength-nonnesting (nonnestingΣₚ₁ TLV.nonnesting))
          (unambiguousΣₚ
            (unambiguousΣₚ OID.unambiguous (λ _ → T-unique))
            λ _ _ _ → erased-unique ≤-unique _ _ )
          (parse≤ _
            (parseSigma TLV.nonnesting OID.unambiguous parseOID
              (λ x → T-dec))
            (nonnestingΣₚ₁ TLV.nonnesting)
            (tell $ "X509: SignAlg: unsupported: OID overflow"))
          λ where
            (singleton r r≡) (mk×ₚ o o∉ refl) →
              subst₀ (λ x → Parser (Logging ∘ Dec) (ExactLength OctetStringValue (n - x)))
                (‼ r≡)
                (parseOctetStringValue (n - r)))

parseSignAlg : Parser (Logging ∘ Dec) SignAlg
parseSignAlg =
   parseSum ECDSA.parseSHA1
  (parseSum ECDSA.parseSHA224
  (parseSum ECDSA.parseSHA256
  (parseSum ECDSA.parseSHA384
  (parseSum ECDSA.parseSHA512
  (parseSum DSA.parseSHA1
  (parseSum DSA.parseSHA224
  (parseSum DSA.parseSHA256
  (parseSum RSA.parseMD2
  (parseSum RSA.parseMD5
  (parseSum RSA.parseSHA1
  (parseSum RSA.parseSHA224
  (parseSum RSA.parseSHA256
  (parseSum RSA.parseSHA384
  (parseSum RSA.parseSHA512
  (parseSum RSA.parsePSS
            parseUnsupported)))))))))))))))

