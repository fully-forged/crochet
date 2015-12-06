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
    (layoutPropertiesTests ++ [randomizesColorsTest])

model =
  let
    colors = [ Color.rgb 1 1 1
             , Color.rgb 255 255 255
             , Color.rgb 6 6 6
             ]
    seed = Random.initialSeed 1
  in
    Model 3 3 colors seed []

layoutPropertiesTests =
  let
    (layout, seed) = (Layout.generate model)
    assertions = (assertionList [ 3, 3, 9]
                                [ layout.height
                                , layout.width
                                , (layout.squares |> List.length)
                                ])
    props = ["height", "width", "squares"]
    testFn a p = test p a
  in
    List.map2 testFn assertions props

randomizesColorsTest =
  let
    firstSquare = Square [ Color.rgb 6 6 6
                         , Color.rgb 255 255 255
                         , Color.rgb 1 1 1
                         ]
    (layout, seed) = (Layout.generate model)
  in
    test "it randomizes colors"
      (assertEqual (Just firstSquare) (List.head layout.squares))
