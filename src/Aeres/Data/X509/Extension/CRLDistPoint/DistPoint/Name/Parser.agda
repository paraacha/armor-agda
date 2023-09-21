{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509.Extension.CRLDistPoint.DistPoint.Name.Properties
open import Aeres.Data.X509.Extension.CRLDistPoint.DistPoint.Name.TCB
open import Aeres.Data.X509.GeneralName
open import Aeres.Data.X509.RDN
open import Aeres.Data.X690-DER.SequenceOf
open import Aeres.Data.X690-DER.TLV
import      Aeres.Data.X690-DER.Tag as Tag
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parser
import      Aeres.Grammar.Sum
open import Aeres.Prelude

module Aeres.Data.X509.Extension.CRLDistPoint.DistPoint.Name.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parser      UInt8
open Aeres.Grammar.Sum         UInt8

private
  here' = "X509: Extension: CRLDistPoint: DistPoint: Name"

parseFullName = parseTLV Tag.AA0 (here' String.++ ": full name") _ parseGeneralNamesElems

parseNameRTCrlIssuer : Parser (Logging ∘ Dec) NameRTCrlIssuer
parseNameRTCrlIssuer =
  parseTLV Tag.AA1 (here' String.++ "RT CRL issuer") _
    (λ n → parseBoundedSequenceOf (here' String.++ "RT CRL issuer") _ TLV.nonempty TLV.nonnesting RDN.ATV.parse n 1)

parseDistPointNameChoice : Parser (Logging ∘ Dec) DistPointNameChoice
parseDistPointNameChoice =
  parseEquivalent equivalent
    (parseSum parseFullName parseNameRTCrlIssuer)
