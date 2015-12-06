module Color.Extra where

import Random exposing (..)
import Color exposing (..)
import String

rgbGenerator : Generator Color.Color
rgbGenerator =
  map3 Color.rgb (int 0 255) (int 0 255) (int 0 255)

generateColor : Seed -> ( Color.Color, Seed )
generateColor seed =
  generate rgbGenerator seed

toCss : Color -> String
toCss color =
  let rgb = toRgb color
      rgbString = [ rgb.red |> toString
                  , rgb.green |> toString
                  , rgb.blue |> toString
                  ]
                  |> String.join ","
  in
    "rgb(" ++ rgbString ++ ")"
