{-# LANGUAGE OverloadedStrings #-}

import Network.Wai              (Application, responseLBS,
                                 requestMethod)
import Network.HTTP.Types       (ok200, methodNotAllowed405,
                                 methodGet, methodDelete)
import Network.Wai.Handler.Warp (run)

app :: Application
app request respond =
  let
    method = requestMethod request
  in
    respond $
      if method == methodGet
      then
        responseLBS
          ok200
          [("Content-Type", "text/plain")]
          "Hello!"
      else if method == methodDelete
      then
        responseLBS
          ok200
          [("Content-Type", "text/plain")]
          "Bye!"
      else
        responseLBS
          methodNotAllowed405
          [("Content-Type", "text/plain")]
          "Method Not Allowed"

main :: IO ()
main = run 8080 app
