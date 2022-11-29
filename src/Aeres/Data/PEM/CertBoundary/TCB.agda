{-# OPTIONS --subtyping #-}


open import Aeres.Data.Base64.TCB
open import Aeres.Data.PEM.RFC5234.TCB
open import Aeres.Prelude

module Aeres.Data.PEM.CertBoundary.TCB where

record CertBoundary (ctrl : String) (@0 bs : List Char) : Set where
  constructor mkCertBoundary
  field
    @0 {e} : List Char
    @0 begin : Singleton ∘ String.toList $
                 "-----" String.++ ctrl String.++ " CERTIFICATE-----"
    @0 eol   : EOL e
    @0 bs≡   : bs ≡ ↑ begin ++ e

CertHeader = CertBoundary "BEGIN"
CertFooter = CertBoundary "END"

