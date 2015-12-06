module Editor where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Color exposing (Color)

import Color.Extra exposing (toCss)
import Events exposing (onChangeInt)
import System exposing (..)

addColor : Signal.Address Action -> Html
addColor address =
  input [ type' "button"
        , value "Add new color"
        , onClick address GenerateColor
        ]
        []

widthControl : Signal.Address Action -> Model -> Html
widthControl address model =
  div
    [ class "control" ]
    [ label
      [ for "width" ]
      [ text "Width" ]
    , input
      [ type' "number"
      , id "width"
      , value (model.width |> toString)
      , onChangeInt address ChangeWidth ]
      []
    ]

heightControl : Signal.Address Action -> Model -> Html
heightControl address model =
  div
    [ class "control" ]
    [ label
      [ for "height" ]
      [ text "Height" ]
    , input
      [ type' "number"
      , id "height"
      , value (model.height |> toString)
      , onChangeInt address ChangeHeight ]
      []
    ]

generateLayout : Signal.Address Action -> Html
generateLayout address =
  input [ type' "button"
        , value "Generate Layout"
        , onClick address GenerateLayout
        ]
        []

controls : Signal.Address Action -> Model -> Html
controls address model =
  section
    [ class "controls" ]
    [ nav
      [ class "dimensions" ]
      [ widthControl address model
      , heightControl address model
      ]
    , nav
      [ class "actions" ]
      [ addColor address
      , generateLayout address
      ]
    ]

colorBarItem : Color -> Html
colorBarItem color =
  li [ style [ ("backgroundColor", (toCss color)) ] ] []

colorBar : List Color -> Html
colorBar colors =
  ul [ class "colors" ]
    (List.map colorBarItem colors)

previewLayout : List Layout -> Html
previewLayout layouts =
  case List.head layouts of
    Just layout ->
      div []
        (List.map (\s -> colorBar s.colors) layout.squares)
    Nothing -> h2 [] [ text "No layouts available" ]
