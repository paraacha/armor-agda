{-# OPTIONS --subtyping #-}

open import Aeres.Binary
open import Aeres.Data.X690-DER.Int.TCB
open import Aeres.Data.X690-DER.TLV.TCB
import      Aeres.Data.X690-DER.Tag as Tag
import      Aeres.Grammar.Option
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.Seq.TCB
open import Aeres.Prelude

module Aeres.Data.X509.Extension.PC.TCB where

open Aeres.Grammar.Definitions    UInt8
open Aeres.Grammar.Option UInt8
open Aeres.Grammar.Seq.TCB UInt8

-- https://datatracker.ietf.org/doc/html/rfc5280#section-4.2.1.11
--    id-ce-policyConstraints OBJECT IDENTIFIER ::=  { id-ce 36 }

--    PolicyConstraints ::= SEQUENCE {
--         requireExplicitPolicy           [0] SkipCerts OPTIONAL,
--         inhibitPolicyMapping            [1] SkipCerts OPTIONAL }

--    SkipCerts ::= INTEGER (0..MAX)
   
RequireExplicitPolicy : @0 List UInt8 → Set
RequireExplicitPolicy = [ Tag.A80 ]Int

InhibitPolicyMapping : @0 List UInt8 → Set
InhibitPolicyMapping = [ Tag.A81 ]Int

record PCFieldsSeqFields (@0 bs : List UInt8) : Set where
  constructor mkPCFieldsSeqFields
  field
    @0 {req ini} : List UInt8
    require : Option RequireExplicitPolicy req
    ihibit : Option InhibitPolicyMapping ini
    @0 bs≡  : bs ≡ req ++ ini

PCFieldsSeq : @0 List UInt8 → Set
PCFieldsSeq xs = TLV Tag.Sequence PCFieldsSeqFields xs

PCFields : @0 List UInt8 → Set
PCFields xs = TLV Tag.OctetString  PCFieldsSeq xs

PCFieldsSeqFieldsRep = &ₚ (Option RequireExplicitPolicy) (Option InhibitPolicyMapping)

equivalentPCFieldsSeqFields : Equivalent PCFieldsSeqFieldsRep PCFieldsSeqFields
proj₁ equivalentPCFieldsSeqFields (mk&ₚ v₁ v₂ refl) = mkPCFieldsSeqFields v₁ v₂ refl
proj₂ equivalentPCFieldsSeqFields (mkPCFieldsSeqFields v₁ v₂ refl) = mk&ₚ v₁ v₂ refl

RawPCFieldsSeqFieldsRep : Raw PCFieldsSeqFieldsRep
RawPCFieldsSeqFieldsRep = Raw&ₚ (RawOption (RawTLV _ RawIntegerValue))
                                 (RawOption (RawTLV _ RawIntegerValue))

RawPCFieldsSeqFields : Raw PCFieldsSeqFields
RawPCFieldsSeqFields = Iso.raw equivalentPCFieldsSeqFields RawPCFieldsSeqFieldsRep

RawPCFields : Raw PCFields
RawPCFields = RawTLV _ (RawTLV _ RawPCFieldsSeqFields)
