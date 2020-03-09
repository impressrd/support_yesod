{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE NoMonomorphismRestriction #-}

-- {-# LANGUAGE  #-}

module Main where

det :: T -> Int
det' :: T -> Int
mkT :: Int -> Int -> Int -> Int -> T
mkT' :: Int -> Int -> Int -> Int -> T

-- #@@range_begin(RecordWildCards)
data T = T { a :: Int, b :: Int, c :: Int, d :: Int }

det  T { a = a, b = b, c = c, d = d } = a * d - b * c
det' T {..} = a * d - b * c

mkT  a b c d = T { a = a, b = b, c = c, d = d }
mkT' a b c d = T {..}
-- #@@range_end(RecordWildCards)

-- #@@range_begin(TupleSections)
ts  = \a -> (a, 1, 2)
ts' = (, 1, 2)
-- #@@range_end(TupleSections)

data Foo = Foo
data Bar = Bar
f _ = Nothing
-- #@@range_begin(ViewPatterns)
g  :: [(String, Foo)] -> Bar
g  a = case lookup "foo" a of
         Just b  -> undefined
         _       -> undefined
g' :: [(String, Foo)] -> Bar
g' (lookup "foo" -> Just b) = undefined
g' _                        = undefined
-- #@@range_end(ViewPatterns)

-- #@@range_begin(TypeFamilies)
-- 型族
type family TF a :: *
type instance TF Int = Double
type instance TF Bool = Int

-- データ族
data family DF a
data instance DF Int = DF1 Int | DF2 Int String
newtype instance DF Double = DF3 Char

-- 関連型族・関連データ族
class C a where
  type CT a :: *
  data CD a :: *
  cf :: a -> CT a
  cg :: String -> CD a

instance C Int where
  type CT Int = Maybe String
  data CD Int = CDI
  cf = Just . show
  cg _ = CDI

instance C Double where
  type CT Double = [String]
  data CD Double = CDD
  cf a = [show a]
  cg _ = CDD
-- #@@range_end(TypeFamilies)

-- #@@range_begin(GADTs)
data AST a = ABool Bool
           | ANum a
           | AEq (AST a) (AST a) -- !

data AST' a where
  ABool' :: Bool -> AST' Bool
  ANum' :: (Num a) => a -> AST' a
  AEq' :: AST' a -> AST' a -> AST' Bool
-- #@@range_end(GADTs)

-- #@@range_begin(MultiParamTypeClasses)
class C2 a b where
  c2f :: a -> b
-- #@@range_end(MultiParamTypeClasses)

-- #@@range_begin(FlexibleContexts)
fC2 :: (C2 a b) => a -> b -> String
fC2 = undefined
-- #@@range_end(FlexibleContexts)

-- #@@range_begin(FlexibleInstances)
class C3 a where
  c3f :: a -> String

instance C3 (Maybe String) where
  c3f = undefined
-- #@@range_end(FlexibleInstances)

-- #@@range_begin(EmptyDataDecls)
data D
-- #@@range_end(EmptyDataDecls)

-- #@@range_begin(GeneralizedNewtypeDeriving)
newtype M a = M (Maybe a)
  deriving (Functor)
-- #@@range_end(GeneralizedNewtypeDeriving)

-- #@@range_begin(MonomorphismRestriction)
mrFoo = do
 print $ plus (1::Int) 2
 print $ plus 1.2 3.4

plus = (+)
-- #@@range_end(MonomorphismRestriction)
