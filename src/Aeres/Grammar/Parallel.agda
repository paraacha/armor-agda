import      Aeres.Grammar.Parallel.Parser
import      Aeres.Grammar.Parallel.Properties
import      Aeres.Grammar.Parallel.TCB

module Aeres.Grammar.Parallel (Σ : Set) where

open Aeres.Grammar.Parallel.Parser Σ public
open Aeres.Grammar.Parallel.TCB    Σ public

module Parallel where
  open import Aeres.Grammar.Parallel.Properties Σ public
