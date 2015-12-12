module Editor where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Color exposing (Color)

import Color.Extra exposing (toCss)
import Events exposing (onChangeInt)
import System exposing (..)
import Layout

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
      , Html.Attributes.min "0"
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
      , Html.Attributes.min "0"
      , value (model.height |> toString)
      , onChangeInt address ChangeHeight ]
      []
    ]

countControl : Signal.Address Action -> Model -> Html
countControl address model =
  div
    [ class "control" ]
    [ label
      [ for "count" ]
      [ text "Colors per square" ]
    , input
      [ type' "number"
      , id "count"
      , Html.Attributes.min "0"
      , value (model.count |> toString)
      , onChangeInt address ChangeCount ]
      []
    ]

generateLayout : Signal.Address Action -> Model -> Html
generateLayout address model =
  input [ type' "button"
        , value "Generate Layout"
        , disabled (not (Layout.valid model))
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
      , countControl address model
      ]
    , nav
      [ class "actions" ]
      [ addColor address
      , generateLayout address model
      ]
    ]

colorBarItem : Color -> Html
colorBarItem color =
  li [ style [ ("backgroundColor", (toCss color)) ] ] []

colorBar : List Color -> Html
colorBar colors =
  ul [ class "colors" ]
    (List.map colorBarItem colors)

editor : Signal.Address Action -> Model -> Html
editor address model =
  section
    [ class "editor" ]
    [ controls address model
    , colorBar model.colors
    ]
