module Day3
(
  day3
) where
import Utils as U
import Text.Regex.TDFA

numRegex :: String
numRegex = "[0-9]{1,3}"

mulRegex :: String
mulRegex = "mul\\(" ++ numRegex ++ "," ++ numRegex ++ "\\)"

parseMul :: String -> Int
parseMul cmd = do
  let [a, b] = getAllTextMatches (cmd =~ numRegex) :: [String]
  U.toInt a * U.toInt b

part1 :: String -> IO Int
part1 input = do
  let matches = getAllTextMatches (input =~ mulRegex) :: [String]
  let results = map parseMul matches
  return (sum results)

doRegex :: String
doRegex = "do\\(\\)"

dontRegex :: String
dontRegex = "don't\\(\\)"

part2Regex :: String
part2Regex = mulRegex ++ "|" ++ doRegex ++ "|" ++ dontRegex

collectMuls :: [String] -> Bool -> [String]
collectMuls [] _ = []
collectMuls matches enabled = do
  let cur = head matches
  let rest = tail matches
  if cur == "do()"
    then collectMuls rest True
    else if cur == "don't()"
      then collectMuls rest False
      else if enabled
        then cur : collectMuls rest enabled
        else collectMuls rest enabled


part2 :: String -> IO Int
part2 input = do
  let matches = getAllTextMatches (input =~ part2Regex) :: [String]
  let filteredMuls = collectMuls matches True
  let results = map parseMul filteredMuls
  return (sum results)

testInput :: String
testInput = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

day3 :: IO ()
day3 = do
  testResult1 <- part1 testInput
  testResult2 <- part2 testInput
  print ("Day 3, Test 1: " ++ show testResult1)
  print ("Day 3, Test 2: " ++ show testResult2)

  input <- readFile "input-data/day3.txt"
  result1 <- part1 input
  result2 <- part2 input
  print ("Day 3, Part 1: " ++ show result1)
  print ("Day 3, Part 2: " ++ show result2)
