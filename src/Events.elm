module Events where

import Html.Events exposing (on, targetValue)
import Html
import Signal
import Json.Decode as Json

targetValueInt =
  Json.at ["target", "valueAsNumber"] Json.int

onChangeInt : Signal.Address a -> (Int -> a) -> Html.Attribute
onChangeInt address action =
  on "change" targetValueInt
    (\str -> Signal.message address (action str))
