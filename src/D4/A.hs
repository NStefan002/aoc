module D4.A (main) where

import Text.Regex.TDFA

numOfMatches :: [String] -> Int
numOfMatches l = sum $ map (\s -> (s =~ "XMAS" :: Int) + (s =~ "SAMX" :: Int)) l

extractCols :: [String] -> [String]
extractCols l = [[l !! i !! j | i <- [0 .. n - 1]] | j <- [0 .. n - 1]]
  where
    n = length l

extractDiags :: [String] -> [String]
extractDiags l = top ++ bottom
  where
    n = length l
    m = case l of
        [] -> 0
        (xh : _) -> length xh
    -- above the main diagonal (including it)
    top = [[l !! i !! (j + i) | i <- [0 .. min (n - 1) (m - 1 - j)]] | j <- [0 .. m - 1]]
    -- below the main diagonal (excluding it)
    bottom = drop 1 [[l !! (i + j) !! j | j <- [0 .. min (m - 1) (n - 1 - i)]] | i <- [0 .. n - 1]]

extractAntidiags :: [String] -> [String]
extractAntidiags l = top ++ bottom
  where
    n = length l
    m = case l of
        [] -> 0
        (xh : _) -> length xh
    -- above the main antidiagonal (including it)
    top = [[l !! i !! (j - i) | i <- [0 .. min (n - 1) j]] | j <- [m - 1, m - 2 .. 0]]
    -- below the main antdiagonal (excluding it)
    bottom = drop 1 [[l !! (i + j) !! (m - 1 - j) | j <- [0 .. min (n - 1 - i) (m - 1)]] | i <- [0 .. n - 1]]

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let rows = lines contents
        cols = extractCols rows
        diags = extractDiags rows
        antidiags = extractAntidiags rows
    print $ sum $ map numOfMatches [rows, cols, diags, antidiags]
