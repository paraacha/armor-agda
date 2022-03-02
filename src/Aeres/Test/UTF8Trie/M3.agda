
{-# OPTIONS --subtyping --sized-types #-}

open import Aeres.Binary
open import Aeres.Prelude
open import Aeres.Data.UTF8.TCB
open import Aeres.Data.UTF8.Trie
import      Aeres.Grammar.IList

module Aeres.Test.UTF8Trie.M3 where

open Base256
open Aeres.Grammar.IList UInt8

trie₃ : List (List UInt8 × Exists─ (List UInt8) UTF8)
trie₃ = ((# 200 ∷ [ # 144 ]) , (─ (# 200 ∷ [ # 145 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 145 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 146 ]) , (─ (# 200 ∷ [ # 147 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 147 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 148 ]) , (─ (# 200 ∷ [ # 149 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 149 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 150 ]) , (─ (# 200 ∷ [ # 151 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 151 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 152 ]) , (─ (# 200 ∷ [ # 153 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 153 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 154 ]) , (─ (# 200 ∷ [ # 155 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 155 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 156 ]) , (─ (# 200 ∷ [ # 157 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 157 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 158 ]) , (─ (# 200 ∷ [ # 159 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 159 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 160 ]) , (─ (# 198 ∷ [ # 158 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 198 } tt) (toWitness {Q = inRange? 128 191 158 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 162 ]) , (─ (# 200 ∷ [ # 163 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 163 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 164 ]) , (─ (# 200 ∷ [ # 165 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 165 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 166 ]) , (─ (# 200 ∷ [ # 167 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 167 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 168 ]) , (─ (# 200 ∷ [ # 169 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 169 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 170 ]) , (─ (# 200 ∷ [ # 171 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 171 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 172 ]) , (─ (# 200 ∷ [ # 173 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 173 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 174 ]) , (─ (# 200 ∷ [ # 175 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 175 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 176 ]) , (─ (# 200 ∷ [ # 177 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 177 } tt) refl)) nil refl)))
          ∷ ((# 200 ∷ [ # 178 ]) , (─ (# 200 ∷ [ # 179 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 200 } tt) (toWitness {Q = inRange? 128 191 179 } tt) refl)) nil refl)))
          ∷ ((# 205 ∷ [ # 133 ]) , (─ (# 206 ∷ [ # 185 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 185 } tt) refl)) nil refl)))
          ∷ ((# 205 ∷ [ # 186 ]) , (─ (# 32 ∷ # 206 ∷ [ # 185 ]) , cons (mkIListCons (utf81 (mkUTF8Char1 _ (toWitness {Q = 32 <? 128 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 185 } tt) refl)) nil refl)) refl)))
          ∷ ((# 206 ∷ [ # 134 ]) , (─ (# 206 ∷ [ # 172 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 172 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 136 ]) , (─ (# 206 ∷ [ # 173 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 173 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 137 ]) , (─ (# 206 ∷ [ # 174 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 174 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 138 ]) , (─ (# 206 ∷ [ # 175 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 175 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 140 ]) , (─ (# 207 ∷ [ # 140 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 140 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 142 ]) , (─ (# 207 ∷ [ # 141 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 141 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 143 ]) , (─ (# 207 ∷ [ # 142 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 142 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 144 ]) , (─ (# 206 ∷ # 185 ∷ # 204 ∷ # 136 ∷ # 204 ∷ [ # 129 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 185 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 204 } tt) (toWitness {Q = inRange? 128 191 136 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 204 } tt) (toWitness {Q = inRange? 128 191 129 } tt) refl)) nil refl)) refl)) refl)))
          ∷ ((# 206 ∷ [ # 145 ]) , (─ (# 206 ∷ [ # 177 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 177 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 146 ]) , (─ (# 206 ∷ [ # 178 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 178 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 147 ]) , (─ (# 206 ∷ [ # 179 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 179 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 148 ]) , (─ (# 206 ∷ [ # 180 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 180 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 149 ]) , (─ (# 206 ∷ [ # 181 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 181 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 150 ]) , (─ (# 206 ∷ [ # 182 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 182 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 151 ]) , (─ (# 206 ∷ [ # 183 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 183 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 152 ]) , (─ (# 206 ∷ [ # 184 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 184 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 153 ]) , (─ (# 206 ∷ [ # 185 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 185 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 154 ]) , (─ (# 206 ∷ [ # 186 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 186 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 155 ]) , (─ (# 206 ∷ [ # 187 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 187 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 156 ]) , (─ (# 206 ∷ [ # 188 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 188 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 157 ]) , (─ (# 206 ∷ [ # 189 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 189 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 158 ]) , (─ (# 206 ∷ [ # 190 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 190 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 159 ]) , (─ (# 206 ∷ [ # 191 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 191 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 160 ]) , (─ (# 207 ∷ [ # 128 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 128 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 161 ]) , (─ (# 207 ∷ [ # 129 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 129 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 163 ]) , (─ (# 207 ∷ [ # 131 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 131 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 164 ]) , (─ (# 207 ∷ [ # 132 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 132 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 165 ]) , (─ (# 207 ∷ [ # 133 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 133 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 166 ]) , (─ (# 207 ∷ [ # 134 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 134 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 167 ]) , (─ (# 207 ∷ [ # 135 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 135 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 168 ]) , (─ (# 207 ∷ [ # 136 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 136 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 169 ]) , (─ (# 207 ∷ [ # 137 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 137 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 170 ]) , (─ (# 207 ∷ [ # 138 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 138 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 171 ]) , (─ (# 207 ∷ [ # 139 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 139 } tt) refl)) nil refl)))
          ∷ ((# 206 ∷ [ # 176 ]) , (─ (# 207 ∷ # 133 ∷ # 204 ∷ # 136 ∷ # 204 ∷ [ # 129 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 133 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 204 } tt) (toWitness {Q = inRange? 128 191 136 } tt) refl)) (cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 204 } tt) (toWitness {Q = inRange? 128 191 129 } tt) refl)) nil refl)) refl)) refl)))
          ∷ ((# 207 ∷ [ # 130 ]) , (─ (# 207 ∷ [ # 131 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 131 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 144 ]) , (─ (# 206 ∷ [ # 178 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 178 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 145 ]) , (─ (# 206 ∷ [ # 184 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 184 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 146 ]) , (─ (# 207 ∷ [ # 133 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 133 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 147 ]) , (─ (# 207 ∷ [ # 141 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 141 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 148 ]) , (─ (# 207 ∷ [ # 139 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 139 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 149 ]) , (─ (# 207 ∷ [ # 134 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 134 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 150 ]) , (─ (# 207 ∷ [ # 128 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 128 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 152 ]) , (─ (# 207 ∷ [ # 153 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 153 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 154 ]) , (─ (# 207 ∷ [ # 155 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 155 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 156 ]) , (─ (# 207 ∷ [ # 157 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 157 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 158 ]) , (─ (# 207 ∷ [ # 159 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 159 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 160 ]) , (─ (# 207 ∷ [ # 161 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 161 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 162 ]) , (─ (# 207 ∷ [ # 163 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 163 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 164 ]) , (─ (# 207 ∷ [ # 165 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 165 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 166 ]) , (─ (# 207 ∷ [ # 167 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 167 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 168 ]) , (─ (# 207 ∷ [ # 169 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 169 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 170 ]) , (─ (# 207 ∷ [ # 171 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 171 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 172 ]) , (─ (# 207 ∷ [ # 173 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 173 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 174 ]) , (─ (# 207 ∷ [ # 175 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 175 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 176 ]) , (─ (# 206 ∷ [ # 186 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 186 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 177 ]) , (─ (# 207 ∷ [ # 129 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 129 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 178 ]) , (─ (# 207 ∷ [ # 131 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 207 } tt) (toWitness {Q = inRange? 128 191 131 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 180 ]) , (─ (# 206 ∷ [ # 184 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 184 } tt) refl)) nil refl)))
          ∷ ((# 207 ∷ [ # 181 ]) , (─ (# 206 ∷ [ # 181 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 206 } tt) (toWitness {Q = inRange? 128 191 181 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 128 ]) , (─ (# 209 ∷ [ # 144 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 144 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 129 ]) , (─ (# 209 ∷ [ # 145 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 145 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 130 ]) , (─ (# 209 ∷ [ # 146 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 146 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 131 ]) , (─ (# 209 ∷ [ # 147 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 147 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 132 ]) , (─ (# 209 ∷ [ # 148 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 148 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 133 ]) , (─ (# 209 ∷ [ # 149 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 149 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 134 ]) , (─ (# 209 ∷ [ # 150 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 150 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 135 ]) , (─ (# 209 ∷ [ # 151 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 151 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 136 ]) , (─ (# 209 ∷ [ # 152 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 152 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 137 ]) , (─ (# 209 ∷ [ # 153 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 153 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 138 ]) , (─ (# 209 ∷ [ # 154 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 154 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 139 ]) , (─ (# 209 ∷ [ # 155 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 155 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 140 ]) , (─ (# 209 ∷ [ # 156 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 156 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 141 ]) , (─ (# 209 ∷ [ # 157 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 157 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 142 ]) , (─ (# 209 ∷ [ # 158 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 158 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 143 ]) , (─ (# 209 ∷ [ # 159 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 209 } tt) (toWitness {Q = inRange? 128 191 159 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 144 ]) , (─ (# 208 ∷ [ # 176 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 208 } tt) (toWitness {Q = inRange? 128 191 176 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 145 ]) , (─ (# 208 ∷ [ # 177 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 208 } tt) (toWitness {Q = inRange? 128 191 177 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 146 ]) , (─ (# 208 ∷ [ # 178 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 208 } tt) (toWitness {Q = inRange? 128 191 178 } tt) refl)) nil refl)))
          ∷ ((# 208 ∷ [ # 147 ]) , (─ (# 208 ∷ [ # 179 ]) , cons (mkIListCons (utf82 (mkUTF8Char2 _ _ (toWitness {Q = inRange? 192 223 208 } tt) (toWitness {Q = inRange? 128 191 179 } tt) refl)) nil refl)))
          ∷ []


