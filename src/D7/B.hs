module D7.B (main) where

splitOn :: Char -> String -> [String]
splitOn c s = if untilC == s then [s] else untilC : splitOn c afterC
  where
    untilC = takeWhile (/= c) s
    afterC = drop 1 (dropWhile (/= c) s)

eqIsCorrect' :: Int -> [String] -> (Int, [String]) -> Bool
eqIsCorrect' _ _ (x, []) = x /= 0
eqIsCorrect' i expr eq
    | evaluateExp (expr ++ [snd eq !! i]) > fst eq = False
    | i == length (snd eq) - 1 = evaluateExp (expr ++ [snd eq !! i]) == fst eq
    | otherwise =
        eqIsCorrect' (i + 1) (expr ++ [snd eq !! i, "+"]) eq
            || eqIsCorrect' (i + 1) (expr ++ [snd eq !! i, "*"]) eq
            || eqIsCorrect' (i + 1) (expr ++ [snd eq !! i, "||"]) eq

eqIsCorrect :: (Int, [String]) -> Bool
eqIsCorrect = eqIsCorrect' 0 []

concatNumbers :: [Int] -> Int
concatNumbers l = read (concatMap show l) :: Int

-- operators can be + or *
evaluateExp' :: [String] -> Int
evaluateExp' [] = 0
evaluateExp' [x] = read x :: Int
evaluateExp' (xh : xt)
    | op == "+" = x + nextExp
    | op == "*" = x * nextExp
    | otherwise = concatNumbers [nextExp, x]
  where
    x = read xh :: Int
    op = head xt
    nextExp = evaluateExp' (drop 1 xt)

evaluateExp :: [String] -> Int
evaluateExp expr = evaluateExp' (reverse expr)

main :: IO ()
main = do
    contents <- readFile "input.txt"
    -- creates pairs that represent equations (testResult, [list, of, the, numbers])
    let tests = map ((\s -> (read (head s) :: Int, words (s !! 1))) . splitOn ':') (lines contents)
        correctTests = filter eqIsCorrect tests
    print $ sum (map fst correctTests)
