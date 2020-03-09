{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty     (ScottyM, scotty, get, delete, html, param, rescue)
import Prelude hiding (length)
import Data.Text.Lazy (length)
import Data.Monoid    ((<>))

app :: ScottyM ()
app = do
  get "/" $ html "<p>Hello, Scotty!</p>"

  get "/hello/:firstname" $ do
    firstname <- param "firstname"
    lastname <- param "lastname" `rescue` const (return "")
    html $ "<p>Hello, " <> firstname
           <> ( if 0 < length lastname
                then " " <> lastname
                else ""
              )
           <> "!</p>"

  delete "/" $ html "<p>Bye!</p>"

main :: IO ()
main = scotty 8080 app
