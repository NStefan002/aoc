module D2.A (main) where

isSorted :: [Int] -> Bool
isSorted [] = True
isSorted l = all (uncurry (<=)) p || all (uncurry (>)) p
  where
    p = zip l (tail l)

isSafe :: [Int] -> Bool
isSafe l = all (\(a, b) -> abs (a - b) >= 1 && abs (a - b) <= 3) p && isSorted l
  where
    p = zip l (tail l)

main :: IO ()
main = do
    contents <- readFile "input.txt"
    let reports = map (\l -> map read (words l) :: [Int]) (lines contents)
    print $ length $ filter isSafe reports
