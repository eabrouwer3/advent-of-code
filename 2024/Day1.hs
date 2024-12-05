import Data.List
import Utils as U

part1 input = do

  let leftNums = sort [head x | x <- input]
  let rightNums = sort [last x | x <- input]
  let diffs = zipWith U.diff rightNums leftNums
  let total = sum diffs
  print total

countInt x ls = length [y | y <- ls, y == x]

part2 input = do
  let leftNums = sort [head x | x <- input]
  let rightNums = sort [last x | x <- input]
  let counts = [countInt x rightNums | x <- leftNums]
  let scores = [x * y | (x, y) <- zip leftNums counts]
  let total = sum scores
  print total

main = do
  pairs <- getInput "input1.txt"
  part1 pairs
  part2 pairs
