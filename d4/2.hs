-- returns the coordinates of all the 'A's, doesn't check for the 'A's on the edges (because those 'A's can't form an X)
findA :: [String] -> [(Int, Int)]
findA l = [(i, j) | i <- [1 .. n - 2], j <- [1 .. m - 2], l !! i !! j == 'A']
  where
    n = length l
    m = length (head l)

-- checks if the 'A' at (i, j) can form an X with 'M's and 'S's
isX :: (Int, Int) -> [String] -> Bool
isX (i, j) l
    | l !! (i - 1) !! (j - 1) /= 'M' && l !! (i - 1) !! (j - 1) /= 'S' = False
    | l !! (i - 1) !! (j + 1) /= 'M' && l !! (i - 1) !! (j + 1) /= 'S' = False
    | l !! (i + 1) !! (j - 1) /= 'M' && l !! (i + 1) !! (j - 1) /= 'S' = False
    | l !! (i + 1) !! (j + 1) /= 'M' && l !! (i + 1) !! (j + 1) /= 'S' = False
    -- can't create X with MAM or SAS
    | l !! (i - 1) !! (j - 1) == l !! (i + 1) !! (j + 1) = False
    | l !! (i - 1) !! (j + 1) == l !! (i + 1) !! (j - 1) = False
    | otherwise = True

countX :: [(Int, Int)] -> [String] -> Int
countX [] _ = 0
countX ((i, j) : xs) l = if isX (i, j) l then 1 + countX xs l else countX xs l

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let rows = lines contents
    print $ countX (findA rows) rows
