import Data.List
import Utils as U

part1CheckRow :: [Int] -> Bool
part1CheckRow row = do
  let sortedRow = sort row
  let reversedRow = reverse sortedRow
  let pairs = zip (init row) (tail row)
  let diffs = [diff x y | (x, y) <- pairs]
  (row == sortedRow || row == reversedRow) && all (< 4) diffs && all (> 0) diffs

part1 input = do
  let validRows = [row | row <- input, part1CheckRow row]
  print (length validRows)

countInt x ls = length [y | y <- ls, y == x]

part2CheckRow :: [Int] -> Bool
part2CheckRow row = do
  let l = length row
  any part1CheckRow [U.remove i row | i <- [0..l]]

part2 input = do
  let validRows = [row | row <- input, part1CheckRow row || part2CheckRow row]
  print (length validRows)

main = do
  let testInput = "7 6 4 2 1\n\
\1 2 7 8 9\n\
\9 7 6 2 1\n\
\1 3 2 4 5\n\
\8 6 4 4 1\n\
\1 3 6 7 9"
  let testParsed = U.parseInput testInput
  part1 testParsed
  part2 testParsed

  input <- getInput "input2.txt"
  part1 input
  part2 input
