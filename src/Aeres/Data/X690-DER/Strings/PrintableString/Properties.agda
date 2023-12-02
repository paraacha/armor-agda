open import Aeres.Binary
open import Aeres.Data.X690-DER.Strings.PrintableString.Char
open import Aeres.Data.X690-DER.Strings.PrintableString.TCB
open import Aeres.Data.X690-DER.TLV
import      Aeres.Data.X690-DER.Tag as Tag
import      Aeres.Grammar.Definitions
import      Aeres.Grammar.IList
open import Aeres.Prelude

module Aeres.Data.X690-DER.Strings.PrintableString.Properties where

open Aeres.Grammar.Definitions UInt8
open Aeres.Grammar.IList       UInt8

sizeUnique : ∀ {@0 bs} → (a₁ a₂ : IList PrintableStringChar bs) → size a₁ ≡ size a₂
sizeUnique nil nil = refl
sizeUnique nil (consIList (mkPrintableStringChar c₂ _ refl) t₂ ())
sizeUnique (consIList (mkPrintableStringChar c₁ _ refl) t₁ ()) nil
sizeUnique (consIList (mkPrintableStringChar c₁ _ refl) t₁ refl) (consIList (mkPrintableStringChar c₂ _ refl) t₂ refl) =
  cong suc (sizeUnique t₁ t₂)

@0 unambiguous : Unambiguous PrintableString
unambiguous = TLV.unambiguous (IList.unambiguous Char.unambiguous Char.nonempty Char.nosubstrings)

@0 nonmalleableValue : NonMalleable RawPrintableStringValue
nonmalleableValue snd snd₁ x =
  IList.nonmalleable Char.nonempty Char.nosubstrings Char.nonmalleable snd snd₁ x

instance
  PrintableStringEq≋ : Eq≋ (IList PrintableStringChar)
  PrintableStringEq≋ = IList.IListEq≋

@0 nonmalleable : NonMalleable RawPrintableString
nonmalleable = TLV.nonmalleable nonmalleableValue
