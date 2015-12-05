module Main where

import Html exposing (..)
import StartApp
import Set
import Effects exposing (Effects, Never)
import Signal
import Task

import System exposing (..)

initialData : Model
initialData =
  Model 2 2 Set.empty

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp -> (model, Effects.none)

view : Signal.Address Action -> Model -> Html
view address model =
  h1 [] [ text "Crochet!" ]

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
