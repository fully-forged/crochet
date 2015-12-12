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
    (layoutPropertiesTests ++
     validatesModelTest ++
     [randomizesColorsTest])

model =
  let
    colors = [ Color.rgb 1 1 1
             , Color.rgb 255 255 255
             , Color.rgb 6 6 6
             ]
    seed = Random.initialSeed 1
  in
    Model 3 3 colors seed [] 2

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
                         ]
    (layout, seed) = (Layout.generate model)
  in
    test "it randomizes colors"
      (assertEqual (Just firstSquare) (List.head layout.squares))

validatesModelTest =
  let
    assertions = (assertionList [ True, False, False, False, False ]
                                [ model |> Layout.isValidCombination
                                , { model | width = 0 } |> Layout.isValidCombination
                                , { model | height = 0 } |> Layout.isValidCombination
                                , { model | colors = [] } |> Layout.isValidCombination
                                , { model | count = 4 } |> Layout.isValidCombination
                                ])
    props = [ "valid data"
            , "invalid width"
            , "invalid height"
            , "empty colors"
            , "less colours than needed"
            ]
    testFn a p = test p a
  in
    List.map2 testFn assertions props
