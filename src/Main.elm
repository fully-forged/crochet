module Main where

import Html exposing (..)
import StartApp
import Effects exposing (Effects, Never)
import Signal
import Task
import Random

import System exposing (..)
import Editor
import Color.Extra
import Layout

initialData : Model
initialData =
  Model 2 2 [] (Random.initialSeed 23123) [] 2

noFx : a -> ( a, Effects b )
noFx model =
  (model, Effects.none)

addRandomLayout : Model -> Model
addRandomLayout model =
  let
    (layout, seed) = Layout.generate model
  in
    { model | seed = seed
            , layouts = layout :: model.layouts }

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp -> (model, Effects.none)
    GenerateColor ->
      let
        (newColor, seed) = Color.Extra.generateColor model.seed
        model' = { model | seed = seed
                 , colors = newColor :: model.colors
                 }
      in
        model'
          |> addRandomLayout
          |> noFx
    GenerateLayout ->
      model
        |> addRandomLayout
        |> noFx
    ChangeWidth w ->
      { model | width = w }
        |> addRandomLayout
        |> noFx
    ChangeHeight h ->
      { model | height = h }
        |> addRandomLayout
        |> noFx
    ChangeCount c ->
      { model | count = c }
        |> addRandomLayout
        |> noFx

siteHeader : Html
siteHeader =
  header []
    [ h1 [] [ text "Crochet!" ] ]

previewOrNotice : Model -> Html
previewOrNotice model =
  if (Layout.valid model) then
    Editor.previewLayout model
  else
    Editor.invalidNotice

view : Signal.Address Action -> Model -> Html
view address model =
  Html.main' []
    [ siteHeader
    , Editor.controls address model
    , Editor.colorBar model.colors
    , (previewOrNotice model)
    ]

app : StartApp.App Model
app =
  StartApp.start
    { init = (initialData, Effects.none)
    , update = update
    , view = view
    , inputs = []
    }

main : Signal.Signal Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
