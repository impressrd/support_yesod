{-# LANGUAGE OverloadedStrings #-}

import Network.Wai              (Application, responseLBS, queryString)
import Network.HTTP.Types       (ok200)
import Network.Wai.Handler.Warp (run)
import Data.ByteString.Lazy     (fromStrict)
import Data.Monoid              ((<>))
import Control.Monad            (join)

app :: Application
app request respond =
  let
    mname = join $ lookup "name" $ queryString request
  in
    respond $ responseLBS
      ok200
      [("Content-Type", "text/plain")]
      $ case mname of
          Just name -> "Hello, " <> (fromStrict name) <> "!"
          Nothing   -> "Hello!"

main :: IO ()
main = run 8080 app
