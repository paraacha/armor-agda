{-# OPTIONS --subtyping --sized-types --guardedness #-}

open import Aeres.Binary
  hiding (module Base64)
open import Aeres.Data.X509
open import Aeres.Data.X509.Semantic.Chain
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.IList
open import Aeres.Foreign.ByteString
  hiding (foldl)
open import Aeres.Prelude
import      Data.Nat.Properties as Nat
open import Data.Nat.Show renaming (show to showℕ) 

module Aeres.Data.X509.ChainBuilder.Exec where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.IList       UInt8
open Base256

------------ chain building ---------------
getCertsbySubject : Exists─ (List UInt8) RDNSeq → List (Exists─ (List UInt8) Cert) →  List (Exists─ (List UInt8) Cert)
getCertsbySubject x [] = []
getCertsbySubject (fst , snd) ((fst₁ , snd₁) ∷ x₂)
  with MatchRDNSeq-dec (proj₂ (Cert.getSubject snd₁)) snd
... | no ¬p = getCertsbySubject ((fst , snd)) x₂
... | yes p = [(fst₁ , snd₁)] ++ getCertsbySubject ((fst , snd)) x₂

{-# TERMINATING #-}
--- TODO: satisfy termination checker
findIssuerCert :  Exists─ (List UInt8) Cert → List (Exists─ (List UInt8) Cert) →  List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert)
findIssuerCert (fst , snd) aux root
  with getCertsbySubject (Cert.getIssuer snd) root
... | [] = case (getCertsbySubject (Cert.getIssuer snd) aux) of λ where
               [] → []
               (y ∷ t) → case findIssuerCert y aux root of λ where
                   [] → []
                   (x ∷ z) → [ y ] ++ x ∷ z
... | y ∷ t = [ y ]
  
buildChain : List (Exists─ (List UInt8) Cert) →  List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert)
buildChain [] x₁ = []
buildChain (x ∷ x₂) x₁
  with findIssuerCert x x₂ x₁
... | [] = []
... | x₃ ∷ v = [ x ] ++ x₃ ∷ v

listToChain : List (Exists─ (List UInt8) Cert) → Exists─ (List UInt8) Chain
listToChain [] = _ , nil
listToChain ((─ ps , snd) ∷ x₁) = let (─ bs , tl) = listToChain x₁ in (─ (ps ++ bs)) , cons (mkIListCons snd tl refl)

------------------------- not working correctly

certInList : Exists─ (List UInt8) Cert →  List (Exists─ (List UInt8) Cert) → Bool
certInList c [] = false
certInList (fst , snd) ((fst₁ , snd₁) ∷ l)
  with MatchRDNSeq-dec (proj₂ (Cert.getSubject snd)) (proj₂ (Cert.getSubject snd₁))
... | no ¬p = certInList (fst , snd) l
... | yes p
  with MatchRDNSeq-dec (proj₂ (Cert.getIssuer snd)) (proj₂ (Cert.getIssuer snd₁))
... | no ¬q = certInList (fst , snd) l
... | yes q = true  

helper₁ : List (Exists─ (List UInt8) Cert) →  List (Exists─ (List UInt8) Cert) → List (List (Exists─ (List UInt8) Cert)) → List (List (Exists─ (List UInt8) Cert))
helper₁ [] curChain chains = []
helper₁ (x ∷ cers) curChain chains = (curChain ++ [ x ]) ∷ helper₁ cers curChain chains

{-# TERMINATING #-}
dfs : List (Exists─ (List UInt8) Cert) → Exists─ (List UInt8) Cert →
  List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) →
  List (List (Exists─ (List UInt8) Cert)) → List (List (Exists─ (List UInt8) Cert))
dfs visited cert intermediates trustedRoots currentChain chains = if not (certInList cert visited)
  then
    (let
       visited' : List (Exists─ (List UInt8) Cert)
       visited' = cert ∷ visited

       currentChain' : List (Exists─ (List UInt8) Cert)
       currentChain' = cert ∷ currentChain
     in
     case getCertsbySubject (Cert.getIssuer (proj₂ cert)) trustedRoots of λ where
       [] → chains
       (x ∷ v) →
         let
           chains' : List (List (Exists─ (List UInt8) Cert))
           chains' = helper₁ (x ∷ v) currentChain' chains
         in
         case getCertsbySubject (Cert.getIssuer (proj₂ cert)) intermediates of λ where
           [] → chains
           (y ∷ z) → helper₂ visited' (y ∷ z)  intermediates trustedRoots currentChain' chains')
  else chains
  where
    helper₂ :  List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) →
                        List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) →
                        List (List (Exists─ (List UInt8) Cert)) → List (List (Exists─ (List UInt8) Cert))
    helper₂ v [] i t cc cs = []
    helper₂ v (x ∷ certs) i t cc cs = cs ++ (dfs v x i t cc cs) ++ helper₂ v certs i t cc cs

buildCertificateChains : Exists─ (List UInt8) Cert →  List (Exists─ (List UInt8) Cert) → List (Exists─ (List UInt8) Cert) → List (List (Exists─ (List UInt8) Cert))
buildCertificateChains c i t = let
  visited : List (Exists─ (List UInt8) Cert)
  visited = []

  currentChain : List (Exists─ (List UInt8) Cert)
  currentChain = []

  chains : List (List (Exists─ (List UInt8) Cert))
  chains = []
 
  in
  dfs visited c i t currentChain chains
------------------------------------------
