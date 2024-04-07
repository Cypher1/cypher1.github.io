divOrFail :: Either Int String -> Int -> Either Int String
divOrFail (Left d) n
  | n==0 = Right ("Cannot divide by 0")
  | (d`mod`n)/=0 = Right ("Cannot divide "++show d++" by "++show n)
  | otherwise = Left $ d`div`n
divOrFail (Right e) _ = (Right e)

applyAll :: Foldable f => (Either a err -> b -> Either a err) -> a -> f b -> Either a err
applyAll func start xs = foldl func (Left start) xs
