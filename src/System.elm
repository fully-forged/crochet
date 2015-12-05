module System where

import Set exposing (Set)

type Action =
  NoOp

type Color = String

type Square = Set Color

type alias Layout =
  { width : Int
  , height : Int
  , squares : List Square
  }

type alias Model =
  { width : Int
  , height : Int
  , colors : Set Color
  }
