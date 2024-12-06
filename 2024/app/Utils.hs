module Utils
(
  toInt,
  parseColumnarInput,
  getColumnarInput,
  diff,
  remove
) where

toInt :: String -> Int
toInt x = read x :: Int

diff :: Int -> Int -> Int
diff = (abs .) . (-)

parseColumnarInput :: String -> [[Int]]
parseColumnarInput contents = do
  let rows = lines contents
  let splitRows = map words rows
  [map toInt x | x <- splitRows]

getColumnarInput :: String -> IO [[Int]]
getColumnarInput fileName = do
  contents <- readFile fileName
  return (parseColumnarInput contents)

remove :: Int -> [a] -> [a]
remove _ [] = []
remove 0 (_:xs) = xs
remove n (x:xs) = x : remove (n - 1) xs
