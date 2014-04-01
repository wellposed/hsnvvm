-- Copyright (c) 2012-2014 NVIDIA Corporation
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
-- 
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
-- |
-- Module      : Foreign.LibNVVM.Info
-- Copyright   : 2012 Sean Lee
--               2014 Trevor L. McDonell
-- License     :
--
-- Maintainer  : Sean Lee <selee@nvidia.com>
-- Stability   : experimental
-- Portability : non-portable (GHC extensions)
--

module Foreign.LibNVVM.Info (

  nvvmVersion,

) where

import Foreign.LibNVVM.Internal
import Foreign.LibNVVM.Error

import Data.Version
import Foreign.C
import Foreign.Ptr
import Foreign.Marshal

#include "cbits/stubs.h"
{# context lib="nvvm" #}


-- | Return the libNVVM version number
--
nvvmVersion :: IO Version
nvvmVersion = do
  (r, major,minor) <- nvvmVersion'
  resultIfOk (r, Version [major,minor] [])


{-# INLINE nvvmVersion' #-}
{# fun unsafe nvvmVersion as nvvmVersion'
  { alloca- `Int' peekIntConv*
  , alloca- `Int' peekIntConv*
  }
  -> `Status' cToEnum #}

