module System where

import Random exposing (Seed)
import Color exposing (Color)

type Action =
  NoOp
  | GenerateColor
  | GenerateLayout

type alias Layout =
  { width : Int
  , height : Int
  , squares : List (List Color)
  }

type alias Model =
  { width : Int
  , height : Int
  , colors : List Color
  , seed : Seed
  }
