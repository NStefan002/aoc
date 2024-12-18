isSorted :: [Int] -> Bool
isSorted [] = True
isSorted l = all (uncurry (<=)) p || all (uncurry (>)) p
  where
    p = zip l (tail l)

isSafe :: [Int] -> Bool
isSafe l = all (\(a, b) -> abs (a - b) >= 1 && abs (a - b) <= 3) p && isSorted l
  where
    p = zip l (tail l)

isSafeWithRemoval' :: Int -> [Int] -> Bool
isSafeWithRemoval' (-1) l = isSafe l
isSafeWithRemoval' i l = isSafe withoutCurrent || isSafeWithRemoval' (i - 1) l
  where
    withoutCurrent = take i l ++ drop (i + 1) l

isSafeWithRemoval :: [Int] -> Bool
isSafeWithRemoval l = isSafeWithRemoval' (length l - 1) l

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let reports = map (\l -> map read (words l) :: [Int]) (lines contents)
    print $ length $ filter isSafeWithRemoval reports
