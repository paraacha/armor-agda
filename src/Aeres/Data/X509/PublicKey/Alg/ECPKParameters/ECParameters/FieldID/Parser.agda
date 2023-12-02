open import Aeres.Binary
open import Aeres.Data.X509.PublicKey.Alg.ECPKParameters.ECParameters.FieldID.CharTwo
open import Aeres.Data.X509.PublicKey.Alg.ECPKParameters.ECParameters.FieldID.TCB
open import Aeres.Data.X509.PublicKey.Alg.ECPKParameters.ECParameters.FieldID.Properties
import      Aeres.Data.X509.PublicKey.Alg.ECPKParameters.ECParameters.FieldID.TCB.OIDs as OIDs
open import Aeres.Data.X690-DER.Int
open import Aeres.Data.X690-DER.OID
open import Aeres.Data.X690-DER.TLV
open import Aeres.Data.X690-DER.Sequence.DefinedByOID
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parallel
import      Aeres.Grammar.Parser
open import Aeres.Prelude
open import Data.Sum.Properties

module Aeres.Data.X509.PublicKey.Alg.ECPKParameters.ECParameters.FieldID.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parallel    UInt8
open Aeres.Grammar.Parser      UInt8

private
  here' = "X509: PublicKey: Alg: ECPKParameters: ECParameters: FieldID"

parseParameters : ∀ n {@0 bs} (o : OID bs) → Parser (Logging ∘ Dec) (ExactLength (FieldIDParameters o) n)
parseParameters n o =
  case ((-, TLV.val o) ∈? OIDs.Supported)
  ret (λ o∈? → Parser (Logging ∘ Dec) (ExactLength (FieldIDParameters' o o∈?) n))
  of λ where
    (no ¬p) → mkParser λ xs → do
      tell $ here' String.++ ": unsupported OID: " String.++ show (map (map toℕ) (Raw.to RawOID o) )
      return ∘ no $ λ ()
    (yes (here px)) →
      parseExactLength TLV.nosubstrings (tell $ here' String.++ ": Prime: length mismatch") (Int.parse here') _
    (yes (there (here px))) →
      parseExactLength TLV.nosubstrings (tell $ here' String.++ ": CharTwo: length mismatch") CharTwo.parse _

parse : Parser (Logging ∘ Dec) FieldID
parse = DefinedByOID.parse here' parseParameters
