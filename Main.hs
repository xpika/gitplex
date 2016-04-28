module Main where

import System.IO
import System.Environment
import System.Directory
import Control.Monad
import Data.List
import System.Process

main = do
  args <- getArgs
  let ((c:cs),local) = if head args == "-l" 
        then (tail args,True)
        else (args,False)  
  when local $ do 
    (_, Just hout, _, _) <-
      createProcess (proc c cs){ std_out = CreatePipe }
    hGetContents hout >>= putStrLn
    setCurrentDirectory ".."
  contents <- (getDirectoryContents ".") >>= return . filter (not . (flip elem [".",".."]))
  forM_ contents $ \cd -> do
    let srcDir = "./"++cd++"/.git"
    let destDir = "./"++cd++"/.plexgit"
    exists <- doesDirectoryExist srcDir
    when exists $ do 
      renameDirectory srcDir destDir
      print srcDir
  (_, Just hout, _, _) <-
    createProcess (proc c cs){ std_out = CreatePipe }
  hGetContents hout >>= putStrLn
  forM_ contents $ \cd -> do
    let srcDir = "./"++cd++"/.plexgit"
    let destDir = "./"++cd++"/.git"
    exists <- doesDirectoryExist srcDir
    when exists 
      (renameDirectory srcDir destDir)
 
