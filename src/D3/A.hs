module D3.A (main) where

import Text.Regex.TDFA

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let pattern = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)"
    let matches = contents =~ pattern :: [[String]]
    print $ sum $ map (\m -> (read (m !! 1) :: Int) * (read (m !! 2) :: Int)) matches
