{-# LANGUAGE OverloadedStrings #-}

import Network.Wai              (Application, responseLBS)
import Network.HTTP.Types       (ok200)
import Network.Wai.Handler.Warp (run)

app :: Application
app _ respond =
  respond $ responseLBS
    ok200
    [("Content-Type", "text/plain")]
    "Hello, Web!"

main :: IO ()
main = run 8080 app
