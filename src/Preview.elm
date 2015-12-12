module Preview where

import Html exposing (..)
import Html.Attributes exposing (..)
import Color exposing (Color)

import Color.Extra exposing (toCss)
import System exposing (..)
import Layout

layer : Layer -> Html
layer l =
  let
    index' = l.index + 1
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


previewWidth : Model -> Int
previewWidth model =
  model.width * model.count

previewLayout : Model -> Html
previewLayout model =
  case List.head model.layouts of
    Just layout ->
      div [ class "preview" ]
          [ div [ class "layout"
                , style [ ("width", (model |> previewWidth |> toString) ++ "em") ]
                ]
            (List.map (\s -> square s.colors) layout.squares)
          ]
    Nothing ->
      div [ class "preview" ]
        [ h2 [] [ text "No layouts available" ] ]

invalidNotice : Html
invalidNotice =
  div [ class "preview" ]
    [ h2 [] [ text "The current combination cannot generate a layout" ] ]

previewOrNotice : Model -> Html
previewOrNotice model =
  if (Layout.isValidCombination model) then
    previewLayout model
  else
    invalidNotice
