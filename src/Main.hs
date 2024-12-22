module Main (main) where

import qualified D1.A
import qualified D1.B

import qualified D2.A
import qualified D2.B

import qualified D3.A
import qualified D3.B

import qualified D4.A
import qualified D4.B

main :: IO ()
main = do
    putStrLn "Choose a solution to run:"
    putStrLn "[1-25].[a-b]"
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
        _ -> putStrLn "Invalid choice"
