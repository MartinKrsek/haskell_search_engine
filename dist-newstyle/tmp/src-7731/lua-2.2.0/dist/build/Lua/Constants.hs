{-# LINE 1 "src\\Lua\\Constants.hsc" #-}
{-# LANGUAGE PatternSynonyms #-}
{-|
Module      : Lua.Constants
Copyright   : © 2007–2012 Gracjan Polak;
              © 2012–2016 Ömer Sinan Ağacan;
              © 2017-2022 Albert Krewinkel
License     : MIT
Maintainer  : Albert Krewinkel <tarleb+hslua@zeitkraut.de>
Stability   : beta
Portability : ForeignFunctionInterface

Lua constants
-}
module Lua.Constants
  ( -- * Special values
    pattern LUA_MULTRET
    -- * Pseudo-indices
  , pattern LUA_REGISTRYINDEX
    -- * Basic types
  , pattern LUA_TNONE
  , pattern LUA_TNIL
  , pattern LUA_TBOOLEAN
  , pattern LUA_TLIGHTUSERDATA
  , pattern LUA_TNUMBER
  , pattern LUA_TSTRING
  , pattern LUA_TTABLE
  , pattern LUA_TFUNCTION
  , pattern LUA_TUSERDATA
  , pattern LUA_TTHREAD
    -- * Status codes
  , pattern LUA_OK
  , pattern LUA_YIELD
  , pattern LUA_ERRRUN
  , pattern LUA_ERRSYNTAX
  , pattern LUA_ERRMEM
  , pattern LUA_ERRERR
  , pattern LUA_ERRFILE
    -- * Relational operator codes
  , pattern LUA_OPEQ
  , pattern LUA_OPLT
  , pattern LUA_OPLE
    -- * Codes for arithmetic operations
  , pattern LUA_OPADD
  , pattern LUA_OPSUB
  , pattern LUA_OPMUL
  , pattern LUA_OPDIV
  , pattern LUA_OPIDIV
  , pattern LUA_OPMOD
  , pattern LUA_OPPOW
  , pattern LUA_OPUNM
  , pattern LUA_OPBNOT
  , pattern LUA_OPBAND
  , pattern LUA_OPBOR
  , pattern LUA_OPBXOR
  , pattern LUA_OPSHL
  , pattern LUA_OPSHR
    -- * Garbage-collection options
  , pattern LUA_GCSTOP
  , pattern LUA_GCRESTART
  , pattern LUA_GCCOLLECT
  , pattern LUA_GCCOUNT
  , pattern LUA_GCCOUNTB
  , pattern LUA_GCSTEP
  , pattern LUA_GCSETPAUSE
  , pattern LUA_GCSETSTEPMUL
  , pattern LUA_GCISRUNNING
  , pattern LUA_GCGEN
  , pattern LUA_GCINC
    -- * Predefined references
  , pattern LUA_REFNIL
  , pattern LUA_NOREF
    -- * Boolean
  , pattern TRUE
  , pattern FALSE
  ) where

import Foreign.C (CInt (..))
import Lua.Types




--
-- Special values
--

-- | Option for multiple returns in @'Lua.lua_pcall'@.
pattern LUA_MULTRET :: NumResults
pattern LUA_MULTRET = NumResults (-1)
{-# LINE 90 "src\\Lua\\Constants.hsc" #-}

-- | Stack index of the Lua registry.
pattern LUA_REGISTRYINDEX :: StackIndex
pattern LUA_REGISTRYINDEX = StackIndex (-1001000)
{-# LINE 94 "src\\Lua\\Constants.hsc" #-}

--
-- Type of Lua values
--
-- | Non-valid stack index
pattern LUA_TNONE :: TypeCode
pattern LUA_TNONE = TypeCode (-1)
{-# LINE 101 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua's @nil@ value
pattern LUA_TNIL :: TypeCode
pattern LUA_TNIL = TypeCode (0)
{-# LINE 105 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua booleans
pattern LUA_TBOOLEAN :: TypeCode
pattern LUA_TBOOLEAN = TypeCode (1)
{-# LINE 109 "src\\Lua\\Constants.hsc" #-}

-- | Type of light userdata
pattern LUA_TLIGHTUSERDATA :: TypeCode
pattern LUA_TLIGHTUSERDATA = TypeCode (2)
{-# LINE 113 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua numbers. See @'Lua.Number'@
pattern LUA_TNUMBER :: TypeCode
pattern LUA_TNUMBER = TypeCode (3)
{-# LINE 117 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua string values
pattern LUA_TSTRING :: TypeCode
pattern LUA_TSTRING = TypeCode (4)
{-# LINE 121 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua tables
pattern LUA_TTABLE :: TypeCode
pattern LUA_TTABLE = TypeCode (5)
{-# LINE 125 "src\\Lua\\Constants.hsc" #-}

-- | Type of functions, either normal or @'CFunction'@
pattern LUA_TFUNCTION :: TypeCode
pattern LUA_TFUNCTION = TypeCode (6)
{-# LINE 129 "src\\Lua\\Constants.hsc" #-}

-- | Type of full user data
pattern LUA_TUSERDATA :: TypeCode
pattern LUA_TUSERDATA = TypeCode (7)
{-# LINE 133 "src\\Lua\\Constants.hsc" #-}

-- | Type of Lua threads
pattern LUA_TTHREAD :: TypeCode
pattern LUA_TTHREAD = TypeCode (8)
{-# LINE 137 "src\\Lua\\Constants.hsc" #-}

--
-- Status codes
--

-- | Success.
pattern LUA_OK :: StatusCode
pattern LUA_OK = StatusCode 0
{-# LINE 145 "src\\Lua\\Constants.hsc" #-}

-- | Yielding / suspended coroutine.
pattern LUA_YIELD :: StatusCode
pattern LUA_YIELD = StatusCode 1
{-# LINE 149 "src\\Lua\\Constants.hsc" #-}

-- | A runtime error.
pattern LUA_ERRRUN :: StatusCode
pattern LUA_ERRRUN = StatusCode 2
{-# LINE 153 "src\\Lua\\Constants.hsc" #-}

-- | A syntax error.
pattern LUA_ERRSYNTAX :: StatusCode
pattern LUA_ERRSYNTAX = StatusCode 3
{-# LINE 157 "src\\Lua\\Constants.hsc" #-}

-- | Memory allocation error. For such errors, Lua does not call the
-- message handler.
pattern LUA_ERRMEM :: StatusCode
pattern LUA_ERRMEM = StatusCode 4
{-# LINE 162 "src\\Lua\\Constants.hsc" #-}

-- | Error while running the message handler.
pattern LUA_ERRERR :: StatusCode
pattern LUA_ERRERR = StatusCode 5
{-# LINE 166 "src\\Lua\\Constants.hsc" #-}

-- | File related error (e.g., the file cannot be opened or read).
pattern LUA_ERRFILE :: StatusCode
pattern LUA_ERRFILE = StatusCode 6
{-# LINE 170 "src\\Lua\\Constants.hsc" #-}

--
-- Comparison operators
--

-- | Compares for equality (==)
pattern LUA_OPEQ :: OPCode
pattern LUA_OPEQ = OPCode 0
{-# LINE 178 "src\\Lua\\Constants.hsc" #-}

-- | Compares for less than (<)
pattern LUA_OPLT :: OPCode
pattern LUA_OPLT = OPCode 1
{-# LINE 182 "src\\Lua\\Constants.hsc" #-}

-- | Compares for less or equal (<=)
pattern LUA_OPLE :: OPCode
pattern LUA_OPLE = OPCode 2
{-# LINE 186 "src\\Lua\\Constants.hsc" #-}

--
-- Arithmetic and bitwise operators
--

-- | Performs addition (@+@).
pattern LUA_OPADD :: ArithOPCode
pattern LUA_OPADD = ArithOPCode 0
{-# LINE 194 "src\\Lua\\Constants.hsc" #-}

-- | Performs subtraction (@-@)
pattern LUA_OPSUB :: ArithOPCode
pattern LUA_OPSUB = ArithOPCode 1
{-# LINE 198 "src\\Lua\\Constants.hsc" #-}

-- | Performs multiplication (@*@)
pattern LUA_OPMUL :: ArithOPCode
pattern LUA_OPMUL = ArithOPCode 2
{-# LINE 202 "src\\Lua\\Constants.hsc" #-}

-- | Performs float division (@\/@)
pattern LUA_OPDIV :: ArithOPCode
pattern LUA_OPDIV = ArithOPCode 5
{-# LINE 206 "src\\Lua\\Constants.hsc" #-}

-- | Performs floor division (@\/\/@)
pattern LUA_OPIDIV :: ArithOPCode
pattern LUA_OPIDIV = ArithOPCode 6
{-# LINE 210 "src\\Lua\\Constants.hsc" #-}

-- | Performs modulo (@%@)
pattern LUA_OPMOD :: ArithOPCode
pattern LUA_OPMOD = ArithOPCode 3
{-# LINE 214 "src\\Lua\\Constants.hsc" #-}

-- | Performs exponentiation (@^@)
pattern LUA_OPPOW :: ArithOPCode
pattern LUA_OPPOW = ArithOPCode 4
{-# LINE 218 "src\\Lua\\Constants.hsc" #-}

-- | Performs mathematical negation (unary @-@)
pattern LUA_OPUNM :: ArithOPCode
pattern LUA_OPUNM = ArithOPCode 12
{-# LINE 222 "src\\Lua\\Constants.hsc" #-}

-- | Performs bitwise NOT (@~@)
pattern LUA_OPBNOT :: ArithOPCode
pattern LUA_OPBNOT = ArithOPCode 13
{-# LINE 226 "src\\Lua\\Constants.hsc" #-}

-- | Performs bitwise AND (@&@)
pattern LUA_OPBAND :: ArithOPCode
pattern LUA_OPBAND = ArithOPCode 7
{-# LINE 230 "src\\Lua\\Constants.hsc" #-}

-- | Performs bitwise OR (@|@)
pattern LUA_OPBOR :: ArithOPCode
pattern LUA_OPBOR = ArithOPCode 8
{-# LINE 234 "src\\Lua\\Constants.hsc" #-}

-- | Performs bitwise exclusive OR (@~@)
pattern LUA_OPBXOR :: ArithOPCode
pattern LUA_OPBXOR = ArithOPCode 9
{-# LINE 238 "src\\Lua\\Constants.hsc" #-}

-- | Performs left shift (@\<\<@)
pattern LUA_OPSHL :: ArithOPCode
pattern LUA_OPSHL = ArithOPCode 10
{-# LINE 242 "src\\Lua\\Constants.hsc" #-}

-- | Performs right shift (@>>@)
pattern LUA_OPSHR :: ArithOPCode
pattern LUA_OPSHR = ArithOPCode 11
{-# LINE 246 "src\\Lua\\Constants.hsc" #-}

--
-- Garbage-collection options
--

-- | Stops the garbage collector.
pattern LUA_GCSTOP :: GCCode
pattern LUA_GCSTOP = GCCode 0
{-# LINE 254 "src\\Lua\\Constants.hsc" #-}

-- | Restarts the garbage collector.
pattern LUA_GCRESTART :: GCCode
pattern LUA_GCRESTART = GCCode 1
{-# LINE 258 "src\\Lua\\Constants.hsc" #-}

-- | Performs a full garbage-collection cycle.
pattern LUA_GCCOLLECT :: GCCode
pattern LUA_GCCOLLECT = GCCode 2
{-# LINE 262 "src\\Lua\\Constants.hsc" #-}

-- | Returns the current amount of memory (in Kbytes) in use by Lua.
pattern LUA_GCCOUNT :: GCCode
pattern LUA_GCCOUNT = GCCode 3
{-# LINE 266 "src\\Lua\\Constants.hsc" #-}

-- | Returns the remainder of dividing the current amount of bytes of
-- memory in use by Lua by 1024.
pattern LUA_GCCOUNTB :: GCCode
pattern LUA_GCCOUNTB = GCCode 4
{-# LINE 271 "src\\Lua\\Constants.hsc" #-}

-- | Performs an incremental step of garbage collection.
pattern LUA_GCSTEP :: GCCode
pattern LUA_GCSTEP = GCCode 5
{-# LINE 275 "src\\Lua\\Constants.hsc" #-}

-- | Sets data as the new value for the pause of the collector (see
-- §2.5) and returns the previous value of the pause.
pattern LUA_GCSETPAUSE :: GCCode
pattern LUA_GCSETPAUSE = GCCode 6
{-# LINE 280 "src\\Lua\\Constants.hsc" #-}

-- | Sets data as the new value for the step multiplier of the collector
-- (see §2.5) and returns the previous value of the step multiplier.
pattern LUA_GCSETSTEPMUL :: GCCode
pattern LUA_GCSETSTEPMUL = GCCode 7
{-# LINE 285 "src\\Lua\\Constants.hsc" #-}

-- | Returns a boolean that tells whether the collector is running
-- (i.e., not stopped).
pattern LUA_GCISRUNNING :: GCCode
pattern LUA_GCISRUNNING = GCCode 9
{-# LINE 290 "src\\Lua\\Constants.hsc" #-}

-- | Changes the collector to generational mode.
pattern LUA_GCGEN :: GCCode
pattern LUA_GCGEN = GCCode 10
{-# LINE 294 "src\\Lua\\Constants.hsc" #-}

-- | Changes the collector to incremental mode.
pattern LUA_GCINC :: GCCode
pattern LUA_GCINC = GCCode 11
{-# LINE 298 "src\\Lua\\Constants.hsc" #-}

--
-- Special registry values
--

-- | Value signaling that no reference was created.
pattern LUA_REFNIL :: CInt
pattern LUA_REFNIL = -2
{-# LINE 306 "src\\Lua\\Constants.hsc" #-}

-- | Value signaling that no reference was found.
pattern LUA_NOREF :: CInt
pattern LUA_NOREF = -2
{-# LINE 310 "src\\Lua\\Constants.hsc" #-}

--
-- Booleans
--

-- | Value which Lua usually uses as 'True'.
pattern TRUE :: LuaBool
pattern TRUE = LuaBool 1

-- | Value which Lua usually uses as 'False'.
pattern FALSE :: LuaBool
pattern FALSE = LuaBool 0
