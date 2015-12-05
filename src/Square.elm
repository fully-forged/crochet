module Square where

import Random exposing (..)
import Color

rgbGenerator =
  map3 Color.rgb (int 0 255) (int 0 255) (int 0 255)

generateColor seed =
  generate rgbGenerator seed
