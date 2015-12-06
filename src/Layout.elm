module Layout where

import System exposing (..)
import Debug

generate : Model -> Layout
generate model =
  let
    numberOfSquares = model.width * model.height
    squares = List.repeat numberOfSquares model.colors
  in
    Layout model.width model.height squares
