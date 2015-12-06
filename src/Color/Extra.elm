module Color.Extra where

import Color exposing (..)
import String

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
