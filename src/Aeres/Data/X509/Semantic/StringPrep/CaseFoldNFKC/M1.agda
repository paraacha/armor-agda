{-# OPTIONS --sized-types #-}

open import Aeres.Binary
open import Aeres.Prelude
open import Aeres.Data.Unicode.UTF8.TCB
open import Aeres.Data.Unicode.UTF8.Trie
import      Aeres.Grammar.IList

module Aeres.Data.X509.Semantic.StringPrep.CaseFoldNFKC.M1 where

open Base256
open Aeres.Grammar.IList UInt8

trie₁ : List (List UInt8 × Exists─ (List UInt8) UTF8)
trie₁ = (([ # 65 ]) , (─ ([ # 97 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 97 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 66 ]) , (─ ([ # 98 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 98 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 67 ]) , (─ ([ # 99 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 99 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 68 ]) , (─ ([ # 100 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 100 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 69 ]) , (─ ([ # 101 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 101 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 70 ]) , (─ ([ # 102 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 102 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 71 ]) , (─ ([ # 103 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 103 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 72 ]) , (─ ([ # 104 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 104 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 73 ]) , (─ ([ # 105 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 105 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 74 ]) , (─ ([ # 106 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 106 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 75 ]) , (─ ([ # 107 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 107 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 76 ]) , (─ ([ # 108 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 108 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 77 ]) , (─ ([ # 109 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 109 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 78 ]) , (─ ([ # 110 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 110 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 79 ]) , (─ ([ # 111 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 111 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 80 ]) , (─ ([ # 112 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 112 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 81 ]) , (─ ([ # 113 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 113 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 82 ]) , (─ ([ # 114 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 114 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 83 ]) , (─ ([ # 115 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 115 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 84 ]) , (─ ([ # 116 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 116 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 85 ]) , (─ ([ # 117 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 117 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 86 ]) , (─ ([ # 118 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 118 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 87 ]) , (─ ([ # 119 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 119 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 88 ]) , (─ ([ # 120 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 120 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 89 ]) , (─ ([ # 121 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 121 <? 128 } tt) refl)) nil refl)))
          ∷ (([ # 90 ]) , (─ ([ # 122 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 122 <? 128 } tt) refl)) nil refl)))
          ∷ ((# 194 ∷ [ # 181 ]) , (─ (# 206 ∷ [ # 188 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 188 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 128 ]) , (─ (# 195 ∷ [ # 160 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 160 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 129 ]) , (─ (# 195 ∷ [ # 161 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 161 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 130 ]) , (─ (# 195 ∷ [ # 162 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 162 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 131 ]) , (─ (# 195 ∷ [ # 163 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 163 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 132 ]) , (─ (# 195 ∷ [ # 164 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 164 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 133 ]) , (─ (# 195 ∷ [ # 165 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 165 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 134 ]) , (─ (# 195 ∷ [ # 166 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 166 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 135 ]) , (─ (# 195 ∷ [ # 167 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 167 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 136 ]) , (─ (# 195 ∷ [ # 168 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 168 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 137 ]) , (─ (# 195 ∷ [ # 169 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 169 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 138 ]) , (─ (# 195 ∷ [ # 170 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 170 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 139 ]) , (─ (# 195 ∷ [ # 171 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 171 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 140 ]) , (─ (# 195 ∷ [ # 172 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 172 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 141 ]) , (─ (# 195 ∷ [ # 173 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 173 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 142 ]) , (─ (# 195 ∷ [ # 174 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 174 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 143 ]) , (─ (# 195 ∷ [ # 175 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 175 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 144 ]) , (─ (# 195 ∷ [ # 176 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 176 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 145 ]) , (─ (# 195 ∷ [ # 177 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 177 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 146 ]) , (─ (# 195 ∷ [ # 178 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 178 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 147 ]) , (─ (# 195 ∷ [ # 179 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 179 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 148 ]) , (─ (# 195 ∷ [ # 180 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 180 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 149 ]) , (─ (# 195 ∷ [ # 181 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 181 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 150 ]) , (─ (# 195 ∷ [ # 182 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 182 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 152 ]) , (─ (# 195 ∷ [ # 184 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 184 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 153 ]) , (─ (# 195 ∷ [ # 185 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 185 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 154 ]) , (─ (# 195 ∷ [ # 186 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 186 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 155 ]) , (─ (# 195 ∷ [ # 187 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 187 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 156 ]) , (─ (# 195 ∷ [ # 188 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 188 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 157 ]) , (─ (# 195 ∷ [ # 189 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 189 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 158 ]) , (─ (# 195 ∷ [ # 190 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 195 } tt) (toWitness {Q = inRange? 128 191 190 } tt) refl)) nil refl)))
          ∷ ((# 195 ∷ [ # 159 ]) , (─ (# 115 ∷ [ # 115 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 115 <? 128 } tt) refl)) (cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 115 <? 128 } tt) refl)) nil refl)) refl)))
          ∷ ((# 196 ∷ [ # 128 ]) , (─ (# 196 ∷ [ # 129 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 129 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 130 ]) , (─ (# 196 ∷ [ # 131 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 131 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 132 ]) , (─ (# 196 ∷ [ # 133 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 133 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 134 ]) , (─ (# 196 ∷ [ # 135 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 135 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 136 ]) , (─ (# 196 ∷ [ # 137 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 137 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 138 ]) , (─ (# 196 ∷ [ # 139 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 139 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 140 ]) , (─ (# 196 ∷ [ # 141 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 141 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 142 ]) , (─ (# 196 ∷ [ # 143 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 143 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 144 ]) , (─ (# 196 ∷ [ # 145 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 145 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 146 ]) , (─ (# 196 ∷ [ # 147 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 147 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 148 ]) , (─ (# 196 ∷ [ # 149 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 149 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 150 ]) , (─ (# 196 ∷ [ # 151 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 151 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 152 ]) , (─ (# 196 ∷ [ # 153 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 153 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 154 ]) , (─ (# 196 ∷ [ # 155 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 155 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 156 ]) , (─ (# 196 ∷ [ # 157 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 157 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 158 ]) , (─ (# 196 ∷ [ # 159 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 159 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 160 ]) , (─ (# 196 ∷ [ # 161 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 161 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 162 ]) , (─ (# 196 ∷ [ # 163 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 163 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 164 ]) , (─ (# 196 ∷ [ # 165 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 165 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 166 ]) , (─ (# 196 ∷ [ # 167 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 167 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 168 ]) , (─ (# 196 ∷ [ # 169 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 169 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 170 ]) , (─ (# 196 ∷ [ # 171 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 171 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 172 ]) , (─ (# 196 ∷ [ # 173 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 173 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 174 ]) , (─ (# 196 ∷ [ # 175 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 175 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 176 ]) , (─ (# 105 ∷ # 204 ∷ [ # 135 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 105 <? 128 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 204 } tt) (toWitness {Q = inRange? 128 191 135 } tt) refl)) nil refl)) refl)))
          ∷ ((# 196 ∷ [ # 178 ]) , (─ (# 196 ∷ [ # 179 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 179 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 180 ]) , (─ (# 196 ∷ [ # 181 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 181 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 182 ]) , (─ (# 196 ∷ [ # 183 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 183 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 185 ]) , (─ (# 196 ∷ [ # 186 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 186 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 187 ]) , (─ (# 196 ∷ [ # 188 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 188 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 189 ]) , (─ (# 196 ∷ [ # 190 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 196 } tt) (toWitness {Q = inRange? 128 191 190 } tt) refl)) nil refl)))
          ∷ ((# 196 ∷ [ # 191 ]) , (─ (# 197 ∷ [ # 128 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 128 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 129 ]) , (─ (# 197 ∷ [ # 130 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 130 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 131 ]) , (─ (# 197 ∷ [ # 132 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 132 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 133 ]) , (─ (# 197 ∷ [ # 134 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 134 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 135 ]) , (─ (# 197 ∷ [ # 136 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 136 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 137 ]) , (─ (# 202 ∷ # 188 ∷ [ # 110 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 202 } tt) (toWitness {Q = inRange? 128 191 188 } tt) refl)) (cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 110 <? 128 } tt) refl)) nil refl)) refl)))
          ∷ ((# 197 ∷ [ # 138 ]) , (─ (# 197 ∷ [ # 139 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 139 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 140 ]) , (─ (# 197 ∷ [ # 141 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 141 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 142 ]) , (─ (# 197 ∷ [ # 143 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 143 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 144 ]) , (─ (# 197 ∷ [ # 145 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 145 } tt) refl)) nil refl)))
          ∷ ((# 197 ∷ [ # 146 ]) , (─ (# 197 ∷ [ # 147 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 197 } tt) (toWitness {Q = inRange? 128 191 147 } tt) refl)) nil refl)))
          ∷ []


