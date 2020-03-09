import qualified Data.Text    as T (pack)
import qualified Data.Text.IO as T (putStrLn)

main :: IO ()
main = T.putStrLn (T.pack "こんにちは")
