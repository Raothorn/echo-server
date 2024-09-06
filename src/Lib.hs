{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( someFunc
    ) where
-- Extremely minimal echo server for personal testing purposes

import qualified Data.Text.IO as T
import qualified Network.WebSockets as WS
import Control.Monad


application :: WS.ServerApp
application pending = do
    conn <- WS.acceptRequest pending
    WS.withPingThread conn 30 (return ()) $ forever $ do
        -- Wait for an incoming message
        msg <- WS.receiveData conn
        T.putStrLn msg

        -- Echo the message back to the client
        WS.sendTextData conn $ "Server recieved: " <> msg


someFunc :: IO ()
someFunc = do
    WS.runServer "127.0.0.1" 9160 application

