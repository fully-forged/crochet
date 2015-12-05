module System where

import Random exposing (Seed)
import Color exposing (Color)

type Action =
  NoOp
  | GenerateColor

type Square = List Color

type alias Layout =
  { width : Int
  , height : Int
  , squares : List Square
  }

type alias Model =
  { width : Int
  , height : Int
  , colors : List Color
  , seed : Seed
  }
