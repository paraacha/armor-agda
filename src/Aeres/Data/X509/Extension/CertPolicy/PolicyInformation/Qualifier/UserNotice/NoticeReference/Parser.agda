open import Aeres.Binary
open import Aeres.Data.X509.Extension.CertPolicy.PolicyInformation.Qualifier.UserNotice.NoticeReference.Properties
open import Aeres.Data.X509.Extension.CertPolicy.PolicyInformation.Qualifier.UserNotice.NoticeReference.TCB
open import Aeres.Data.X509.DisplayText
open import Aeres.Data.X690-DER.TLV
open import Aeres.Data.X690-DER.SequenceOf
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Parallel
import      Aeres.Grammar.Parser
import      Aeres.Grammar.Seq
open import Aeres.Prelude

module Aeres.Data.X509.Extension.CertPolicy.PolicyInformation.Qualifier.UserNotice.NoticeReference.Parser where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.Parallel    UInt8
open Aeres.Grammar.Parser      UInt8
open Aeres.Grammar.Seq         UInt8

private
  here' = "X509: Extension: CertPolicy: PolicyInformation: Qualifier: UserNotice: NoticeReference"

parseNoticeReferenceFields : ∀ n → Parser (Logging ∘ Dec) (ExactLength NoticeReferenceFields n)
runParser (parseNoticeReferenceFields n) xs = do
  yes x ←
    runParser (parseExactLength (Seq.nosubstrings DisplayText.nosubstrings TLV.nosubstrings)
                (tell $ here' String.++ ": underflow")
                (parse& DisplayText.nosubstrings parseDisplayText parseIntegerSeq) n)
              xs
    where no ¬parse → do
      return ∘ no $ λ where
        (success prefix read read≡ (mk×ₚ (mkNoticeReferenceFields organiztion noticenums bs≡₁) sndₚ₁) suffix ps≡) →
          contradiction
            (success prefix _ read≡ (mk×ₚ (mk&ₚ organiztion noticenums bs≡₁) sndₚ₁) suffix ps≡)
            ¬parse
  return (yes
    (mapSuccess
      (λ where
        {xs} (mk×ₚ (mk&ₚ orgs notices bs≡₁) vLen) →
          mk×ₚ (mkNoticeReferenceFields orgs notices bs≡₁) vLen)
      x))

parseNoticeReference : Parser (Logging ∘ Dec) NoticeReference
parseNoticeReference = parseTLV _ here' _ parseNoticeReferenceFields


-- private                         
--   module Test where

--   val₁ : List Dig
--   val₁ = # 48 ∷ # 12 ∷ # 22 ∷ # 2 ∷ # 67 ∷ # 68 ∷ # 48 ∷ # 6 ∷ # 2 ∷ # 1 ∷ # 1 ∷ # 2 ∷ # 1 ∷ [ # 2 ]

--   test₁ : NoticeReference val₁
--   test₁ = Success.value (toWitness {Q = Logging.val (runParser parseNoticeReference val₁)} tt)
