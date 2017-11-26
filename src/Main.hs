module Main where

import System.Exit (exitFailure)
import System.IO
import GHC.IO.Encoding (setLocaleEncoding)

import qualified CommandLine.Arguments as Arguments
import qualified Manager
import qualified Reporting.Error as Error

import Data.Monoid ((<>))

import Debug.Trace

main :: IO ()
main =
  do  setLocaleEncoding utf8

      manager <- Arguments.parse

      -- traceM ("manager: " <> (show manager) <> "\n")

      result <- Manager.run manager

      traceM ("result: " <> (show result) <> "\n")

      case result of
        Right () ->
          return ()

        Left err ->
          do  Error.toStderr err
              exitFailure
