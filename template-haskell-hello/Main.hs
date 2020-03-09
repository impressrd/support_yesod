{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH
import Language.Haskell.TH.Syntax

returnQ [(ValD (VarP (mkName "foo"))
               (NormalB (LitE (StringL "foo")))
               []
         )]

main = putStrLn foo
