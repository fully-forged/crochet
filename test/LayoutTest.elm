module LayoutTest where

import ElmTest exposing (..)
import Random
import Debug
import Color

import Layout
import System exposing (..)

all : Test
all =
  suite "Layout Suite"
    [ heightTest
    , widthTest
    , numberOfSquaresTest
    ]

model =
  let
    colors = [ Color.rgb 1 1 1
             , Color.rgb 255 255 255
             ]
    seed = Random.initialSeed 1
  in
    Model 3 3 colors seed

widthTest =
  let
    layout = (Layout.generate model)
  in
    test "It has correct width and height"
      (assertEqual 3 (layout.width))

heightTest =
  let
    layout = (Layout.generate model)
  in
    test "It has correct height and height"
      (assertEqual 3 (layout.height))

numberOfSquaresTest =
  let
    layout = (Layout.generate model)
    numberOfSquares = layout.squares |> List.length
  in
    test "It has correct number of squares"
      (assertEqual 9 numberOfSquares)
