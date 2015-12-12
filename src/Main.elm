module Main where

import Html exposing (..)
import Html.Attributes exposing (..)
import StartApp
import Effects exposing (Effects, Never)
import Signal exposing (Signal, Address, map)
import Task
import Random

import System exposing (..)
import Editor
import Color.Extra
import Layout
import Preview

port seedSignal : Signal Int

initialData : Model
initialData =
  Model 10 10 [] (Random.initialSeed 23123) [] 4

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
    NoOp -> noFx model
    NewSeed s -> noFx { model | seed = (Random.initialSeed s) }
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

view : Address Action -> Model -> Html
view address model =
  Html.main' []
    [ siteHeader
    , section
      [ class "workspace" ]
      [ (Editor.editor address model)
      , (Preview.previewOrNotice model)
      ]
    ]

app : StartApp.App Model
app =
  StartApp.start
    { init = (initialData, Effects.none)
    , update = update
    , view = view
    , inputs = [ NewSeed `map` seedSignal ]
    }

main : Signal.Signal Html
main =
  app.html

port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
