module Editor where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Color exposing (Color)
import String

import System exposing (..)

addColor : Signal.Address Action -> Html
addColor address =
  input [ type' "button"
        , value "Add new color"
        , onClick address GenerateColor
        ]
        []

colorToCss : Color -> String
colorToCss color =
  let rgb = Color.toRgb color
      rgbString = [ rgb.red |> toString
                  , rgb.green |> toString
                  , rgb.blue |> toString
                  ]
                  |> String.join ","
  in
    "rgb(" ++ rgbString ++ ")"

colorBarItem : Color -> Html
colorBarItem color =
  li [ style [ ("backgroundColor", (colorToCss color)) ] ] []

colorBar : List Color -> Html
colorBar colors =
  ul [ class "colors" ]
    (List.map colorBarItem colors)
