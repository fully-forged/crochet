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
        (layout, seed') = Layout.generate model'
      in
        ( { model' | seed = seed'
                   , layouts = layout :: model.layouts }
        , Effects.none )
    GenerateLayout ->
      let
        (layout, seed) = Layout.generate model
      in
        ( { model | seed = seed
                  , layouts = layout :: model.layouts }
        , Effects.none)
    ChangeWidth w ->
      let
        model' = { model | width = w }
        (layout, seed) = Layout.generate model'
      in
        ( { model' | layouts = layout :: model.layouts }
        , Effects.none )
    ChangeHeight h ->
      let
        model' = { model | height = h }
        (layout, seed) = Layout.generate model'
      in
        ( { model' | layouts = layout :: model.layouts }
        , Effects.none )
    ChangeCount c ->
      let
        model' = { model | count = c }
        (layout, seed) = Layout.generate model'
      in
        ( { model' | layouts = layout :: model.layouts }
        , Effects.none )

siteHeader : Html
siteHeader =
  header []
    [ h1 [] [ text "Crochet!" ] ]

view : Signal.Address Action -> Model -> Html
view address model =
  Html.main' []
    [ siteHeader
    , Editor.controls address model
    , Editor.colorBar model.colors
    , Editor.previewLayout model
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
