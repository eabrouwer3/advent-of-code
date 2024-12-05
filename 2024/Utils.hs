module Utils
(
  parseInput,
  getInput,
  diff,
  remove
) where

toInt :: String -> Int
toInt x = read x :: Int

diff :: Int -> Int -> Int
diff = (abs .) . (-)

parseInput :: String -> [[Int]]
parseInput contents = do
  let rows = lines contents
  let splitRows = map words rows
  [map toInt x | x <- splitRows]

getInput :: String -> IO [[Int]]
getInput fileName = do
  contents <- readFile fileName
  return (parseInput contents)

remove :: Int -> [a] -> [a]
remove _ [] = []
remove 0 (x:xs) = xs
remove n (x:xs) = x : remove (n - 1) xs
