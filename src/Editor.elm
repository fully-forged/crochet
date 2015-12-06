module Editor where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Color exposing (Color)

import Color.Extra exposing (toCss)
import System exposing (..)

addColor : Signal.Address Action -> Html
addColor address =
  input [ type' "button"
        , value "Add new color"
        , onClick address GenerateColor
        ]
        []

generateLayout : Signal.Address Action -> Html
generateLayout address =
  input [ type' "button"
        , value "Generate Layout"
        , onClick address GenerateLayout
        ]
        []

colorBarItem : Color -> Html
colorBarItem color =
  li [ style [ ("backgroundColor", (toCss color)) ] ] []

colorBar : List Color -> Html
colorBar colors =
  ul [ class "colors" ]
    (List.map colorBarItem colors)
