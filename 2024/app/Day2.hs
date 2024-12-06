module Day2
(
  day2
) where
import Data.List
import Utils as U

part1CheckRow :: [Int] -> Bool
part1CheckRow row = do
  let sortedRow = sort row
  let reversedRow = reverse sortedRow
  let pairs = zip (init row) (tail row)
  let diffs = [diff x y | (x, y) <- pairs]
  (row == sortedRow || row == reversedRow) && all (< 4) diffs && all (> 0) diffs

part1 :: [[Int]] -> IO Int
part1 input = do
  let validRows = [row | row <- input, part1CheckRow row]
  return (length validRows)

part2CheckRow :: [Int] -> Bool
part2CheckRow row = do
  let l = length row
  any part1CheckRow [U.remove i row | i <- [0..l]]

part2 :: [[Int]] -> IO Int
part2 input = do
  let validRows = [row | row <- input, part1CheckRow row || part2CheckRow row]
  return (length validRows)

testInput :: String
testInput = "7 6 4 2 1\n\
\1 2 7 8 9\n\
\9 7 6 2 1\n\
\1 3 2 4 5\n\
\8 6 4 4 1\n\
\1 3 6 7 9"

day2 :: IO ()
day2 = do
  let testParsed = U.parseColumnarInput testInput
  testResult1 <- part1 testParsed
  testResult2 <- part2 testParsed
  print ("Day 2, Test 1: " ++ show testResult1)
  print ("Day 2, Test 2: " ++ show testResult2)

  input <- U.getColumnarInput "input-data/day2.txt"
  result1 <- part1 input
  result2 <- part2 input
  print ("Day 2, Part 1: " ++ show result1)
  print ("Day 2, Part 2: " ++ show result2)
