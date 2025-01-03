module Main (main) where

import qualified D1.A
import qualified D1.B

import qualified D2.A
import qualified D2.B

import qualified D3.A
import qualified D3.B

import qualified D4.A
import qualified D4.B

import qualified D5.A
import qualified D5.B

import qualified D7.A
import qualified D7.B

import qualified D8.A
import qualified D8.B

main :: IO ()
main = do
    putStrLn "Choose a solution to run:"
    putStrLn "[1-25][a-b]"
    choice <- getLine
    case choice of
        "1a" -> D1.A.main
        "1b" -> D1.B.main
        "2a" -> D2.A.main
        "2b" -> D2.B.main
        "3a" -> D3.A.main
        "3b" -> D3.B.main
        "4a" -> D4.A.main
        "4b" -> D4.B.main
        "5a" -> D5.A.main
        "5b" -> D5.B.main
        "7a" -> D7.A.main
        "7b" -> D7.B.main
        "8a" -> D8.A.main
        "8b" -> D8.B.main
        _ -> putStrLn "Invalid choice"
