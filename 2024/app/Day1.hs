module Day1
(
  day1
) where
import Data.List
import Utils as U

part1 :: [[Int]] -> IO Int
part1 input = do
  let leftNums = sort [head x | x <- input]
  let rightNums = sort [last x | x <- input]
  let diffs = zipWith U.diff rightNums leftNums
  return (sum diffs)

countInt :: Eq a => a -> [a] -> Int
countInt x ls = length [y | y <- ls, y == x]

part2 :: [[Int]] -> IO Int
part2 input = do
  let leftNums = sort [head x | x <- input]
  let rightNums = sort [last x | x <- input]
  let counts = [countInt x rightNums | x <- leftNums]
  let scores = [x * y | (x, y) <- zip leftNums counts]
  return (sum scores)

day1 :: IO ()
day1 = do
  pairs <- U.getColumnarInput "input-data/day1.txt"
  result1 <- part1 pairs
  result2 <- part2 pairs
  print ("Day 1, Part 1: " ++ show result1)
  print ("Day 1, Part 2: " ++ show result2)
