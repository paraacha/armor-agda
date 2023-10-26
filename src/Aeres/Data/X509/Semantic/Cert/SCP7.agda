{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X509
import      Aeres.Data.X509.Extension.TCB.OIDs as OIDs
open import Aeres.Data.X509.Semantic.Cert.Utils
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Option
open import Aeres.Grammar.IList as IList
open import Aeres.Prelude
import      Data.Sum as Sum
open import Relation.Nullary.Implication

module Aeres.Data.X509.Semantic.Cert.SCP7 where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Option      UInt8

-- https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.8
-- Unique Identifiers fields MUST only appear if the Version is 2 or 3.
HasUniqueIdentifiers : ∀ {bs} → Cert bs → Set
HasUniqueIdentifiers c =
    (∃ λ subUID → Cert.getSubUID c ≡ some subUID)
  ⊎ (∃ λ issUID → Cert.getIssUID c ≡ some issUID)

{- https://datatracker.ietf.org/doc/html/rfc5280#section-4.1.2.1
-- This field describes the version of the encoded certificate.  When
-- extensions are used, as expected in this profile, version MUST be 3
-- (value is 2).  If no extensions are present, but a UniqueIdentifier
-- is present, the version SHOULD be 2 (value is 1); however, the
-- version MAY be 3.  If only basic fields are present, the version
-- SHOULD be 1 (the value is omitted from the certificate as the default
-- value); however, the version MAY be 2 or 3.
--
-- Implementations SHOULD be prepared to accept any version certificate.
-- At a minimum, conforming implementations MUST recognize version 3
-- certificates.
--
-- Generation of version 2 certificates is not expected by
-- implementations based on this profile.
-}
IsVersion2Or3 : ∀ {bs} → Cert bs → Set
IsVersion2Or3 c = Cert.getVersion c ∈ TBSCert.v2 ∷ [ TBSCert.v3 ]

SCP7 : ∀ {bs} → Cert bs → Set
SCP7 c = HasUniqueIdentifiers c → IsVersion2Or3 c

hasUniqueIdentifiers? : ∀ {@0 bs} → (c : Cert bs) → Dec (HasUniqueIdentifiers c)
hasUniqueIdentifiers? c =
  case Cert.getSubUID c ,′ Cert.getIssUID c
  ret (λ where (s , i) → Dec ((∃ λ subUID → s ≡ some subUID) ⊎ ∃ λ issUID → i ≡ some issUID))
  of λ where
    (some x , i) → yes (inj₁ (x , refl))
    (none , some x) → yes (inj₂ (x , refl))
    (none , none) → no Sum.[ (λ ()) , (λ ()) ]

isVersion2Or3? : ∀ {@0 bs} → (c : Cert bs) → Dec (IsVersion2Or3 c)
isVersion2Or3? c = Cert.getVersion c ∈? _

scp7 : ∀ {@0 bs} → (c : Cert bs) → Dec (SCP7 c)
scp7 c = (hasUniqueIdentifiers? c) →-dec (isVersion2Or3? c)
