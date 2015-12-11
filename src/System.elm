module System where

import Random exposing (Seed)
import Color exposing (Color)

type Action =
  NoOp
  | GenerateColor
  | GenerateLayout
  | ChangeWidth Int
  | ChangeHeight Int
  | ChangeCount Int

type alias Layer =
  { color: Color
  , index: Int
  , offset: Float
  , zIndex: Int
  }

type alias Square =
  { colors: List Color
  }

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
  , layouts : List Layout
  , count : Int
  }
