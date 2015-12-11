module Editor where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Color exposing (Color)

import Color.Extra exposing (toCss)
import Events exposing (onChangeInt)
import System exposing (..)
import Layout
import Debug

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

layer : Layer -> Html
layer l =
  let
    index' = l.index + 1
    dbg = Debug.log "layer" l
  in
    div [ class "layer"
        , style [ ("backgroundColor", (toCss l.color))
                , ("width", (index' |> toString) ++ "em")
                , ("height", (index' |> toString) ++ "em")
                , ("left", (l.offset |> toString) ++ "em")
                , ("top", (l.offset |> toString) ++ "em")
                , ("z-index", l.zIndex |> toString)
                ]
        ]
        []

square : List Color -> Html
square colors =
  let
    size = colors |> List.length
    dimensions = [ ("height", (size |> toString) ++ "em")
                 , ("width", (size |> toString) ++ "em")
                 ]
    offset i = toFloat(size - i - 1) / 2
    indexedColors = colors
                    |> List.indexedMap (,)
                    |> List.map (\(i, c) -> Layer c i (offset i) (size - i))
  in
    div [ class "square"
        , style dimensions
        ]
        (List.map layer indexedColors)

previewLayout : List Layout -> Html
previewLayout layouts =
  case List.head layouts of
    Just layout ->
      div [ class "preview" ]
        (List.map (\s -> square s.colors) layout.squares)
    Nothing ->
      div [ class "preview" ]
        [ h2 [] [ text "No layouts available" ] ]
