module Main where

import Html exposing (..)
import StartApp
import Effects exposing (Effects, Never)
import Signal
import Task
import Random
import Debug

import System exposing (..)
import Editor
import Square
import Layout

initialData : Model
initialData =
  Model 2 2 [] (Random.initialSeed 23123)

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp -> (model, Effects.none)
    GenerateColor ->
      let
        (newColor, seed) = Square.generateColor model.seed
      in
        ( { model | seed = seed
                  , colors = newColor :: model.colors
          }
        , Effects.none )
    GenerateLayout ->
      let
        layout = (Layout.generate model)
                 |> Debug.log "layout"
      in
        (model, Effects.none)

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [ h1 [] [ text "Crochet!" ]
    , Editor.addColor address
    , Editor.generateLayout address
    , Editor.colorBar model.colors
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
