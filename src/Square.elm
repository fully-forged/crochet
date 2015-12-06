module Square where

import Random exposing (..)
import Color

rgbGenerator : Generator Color.Color
rgbGenerator =
  map3 Color.rgb (int 0 255) (int 0 255) (int 0 255)

generateColor : Seed -> ( Color.Color, Seed )
generateColor seed =
  generate rgbGenerator seed
