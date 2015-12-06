module Layout where

import Random
import Random.Array exposing (shuffle)
import Color exposing (Color)
import Array

import System exposing (..)

generateCombinations : List Color -> Random.Seed -> List (List Color) -> Int -> (List (List Color), Random.Seed)
generateCombinations colors seed acc amount =
  case amount of
    0 -> (acc, seed)
    otherwise ->
      let
        (combination, seed') = colors |> Array.fromList |> (shuffle seed)
        newAcc = (Array.toList combination) :: acc
      in
        generateCombinations colors seed' newAcc (amount - 1)

generate : Model -> (Layout, Random.Seed)
generate model =
  let
    numberOfSquares = model.width * model.height
    (combinations, seed) = generateCombinations model.colors model.seed [] numberOfSquares
    squares = List.map Square combinations
  in
    (Layout model.width model.height squares, seed)

