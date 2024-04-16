module Aula5_Spec where
import Test.HUnit
import Aula5

tests1 = test [
       "Teste 1 (1,2)" ~: [1,2]       ~=? enumFromTo' 1 2,
       "Teste 2 (3,1)" ~: []          ~=? enumFromTo' 3 1, 
       "Teste 3 (4,8)" ~: [4,5,6,7,8] ~=? enumFromTo' 4 8
              ]

tests2 = test [
       "Teste 1 (1,3,10)"  ~: [1,3,5,7,9] ~=? enumFromThenTo' 1 3 10,
       "Teste 2 (10,11,1)" ~: []          ~=? enumFromThenTo' 10 11 1,
       "Teste 3 (10,7,1)"  ~: [10,7,4,1]  ~=? enumFromThenTo' 10 7 1
              ]

tests3 = test [
       "Teste 1 ([],[1])"          ~: [1]           ~=? cola [] [1],
       "Teste 2 ([1,2,3],[4,5,6])" ~: [1,2,3,4,5,6] ~=? cola [1,2,3] [4,5,6],
       "Teste 3 ([4,5],[8,9])"     ~: [4,5,8,9]     ~=? cola [4,5] [8,9]
              ]
