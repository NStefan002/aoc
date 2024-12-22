module D3.B (main) where

import Text.Regex.TDFA

result' :: Bool -> [[String]] -> Int
result' _ [] = 0
result' on (h : t)
    | what == "do()" = result' True t
    | what == "don't()" = result' False t
    | otherwise = if on then ((read (h !! 1) :: Int) * (read (h !! 2) :: Int)) + result' on t else result' on t
  where
    what = head h

result :: [[String]] -> Int
result = result' True

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let pattern = "mul\\(([0-9]{1,3}),([0-9]{1,3})\\)|do\\(\\)|don't\\(\\)"
        matches = contents =~ pattern :: [[String]]
    print $ result matches
