module Contivinteum where

import Data.List
import Data.Char


--3
partes :: String -> Char -> [String]
partes "" a = []
partes s delim = 
    case span (/= delim) s of
        ("",rest) -> partes (tail rest) delim
        (part,"") -> [part]
        (part,rest) -> part : partes (tail rest) delim 