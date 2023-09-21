{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509.DirectoryString
open import Aeres.Data.X509.RDN.ATV.OIDs
open import Aeres.Data.X509.RDN.ATV.TCB
open import Aeres.Data.X690-DER.OID
open import Aeres.Data.X690-DER.Sequence.DefinedByOID
open import Aeres.Data.X690-DER.Strings.IA5String
open import Aeres.Data.X690-DER.Strings.PrintableString
open import Aeres.Data.X690-DER.TLV
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parser
open import Aeres.Prelude

module Aeres.Data.X509.RDN.ATV.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parser      UInt8

private
  here' = "X509: RDN: ATV"

parse : Parser (Logging ∘ Dec) ATV
parse = DefinedByOID.parse here' λ n o → p n o ((-, TLV.val o) ∈? Supported)
  where
  p : ∀ n {@0 bs} → (o : OID bs) → (d : Dec ((-, TLV.val o) ∈ Supported)) → Parser (Logging ∘ Dec) (ExactLength (ATVParam o d) n)
  runParser (p n o (no ¬p)) xs = do
    tell $ here' String.++ ": defaulting to directory string"
    runParser
      (parseExactLength DirectoryString.nonnesting (tell $ here' String.++ ": length mismatch")
        parseDirectoryString n)
      xs
  runParser (p n o (yes (here px)))  xs = do
    tell $ here' String.++ ": X520DNQUALIFIER"
    runParser
      (parseExactLength TLV.nonnesting (tell $ here' String.++ ": length mismatch")
        parsePrintableString n)
      xs
  runParser (p n o (yes (there (here px)))) xs = do
    tell $ here' String.++ ": X520COUNTRYNAME"
    runParser
      (parseExactLength (nonnestingΣₚ₁ TLV.nonnesting) (tell $ here' String.++ ": length mismatch")
        (parseTLVSizeBound _ PrintableString.sizeUnique 2 2 (here' String.++ ": X520COUNTRYNAME") parsePrintableString) n)
      xs
  runParser (p n o (yes (there (there (here px))))) xs = do
    tell $ here' String.++ ": X520SERIALNUMBER"
    runParser
      (parseExactLength TLV.nonnesting (tell $ here' String.++ ": length mismatch")
        parsePrintableString n)
      xs
  runParser (p n o (yes (there (there (there (here px)))))) xs = do
    tell $ here' String.++ ": PCKS9-ID-EMAILADDRESS"
    runParser
      (parseExactLength TLV.nonnesting (tell $ here' String.++ ": length mismatch")
        parseIA5String n)
      xs
