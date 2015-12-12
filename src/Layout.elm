module Layout where

import Random
import Random.Array exposing (shuffle)
import Color exposing (Color)
import Array

import System exposing (..)

generateCombinations : List Color -> Random.Seed -> List (List Color) -> Int -> Int -> (List (List Color), Random.Seed)
generateCombinations colors seed acc amount countPerSquare =
  case amount of
    0 -> (acc, seed)
    otherwise ->
      let
        (combination, seed') = colors |> Array.fromList |> (shuffle seed)
        combination' = combination
                       |> Array.toList
                       |> (List.take countPerSquare)
        newAcc = combination' :: acc
      in
        generateCombinations colors seed' newAcc (amount - 1) countPerSquare

generate : Model -> (Layout, Random.Seed)
generate model =
  let
    numberOfSquares = model.width * model.height
    (combinations, seed) = generateCombinations model.colors model.seed [] numberOfSquares model.count
    squares = List.map Square combinations
  in
    (Layout model.width model.height squares, seed)

isValidCombination : Model -> Bool
isValidCombination m =
  let
    colorsCount = List.length m.colors
  in
    m.width > 0 &&
    m.height > 0 &&
    colorsCount > 0 &&
    colorsCount >= m.count
