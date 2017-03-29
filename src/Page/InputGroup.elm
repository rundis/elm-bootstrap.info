module Page.InputGroup exposing (view)

import Html exposing (..)
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Button as Button
import Util


view : Util.PageContent msg
view =
    { title = "Input group"
    , description =
        """Easily extend form controls by adding text or buttons on either side of textual inputs."""
    , children =
        basic ++ sizing ++ buttons


    }




basic : List (Html msg)
basic =
    [ h2 [] [ text "Basic example" ]
    , p [] [ text "Place one add-on or button on either side of an input. You may also place one on both sides of an input." ]
    , Util.example
        [ InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "amount"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "$"] ]
            |> InputGroup.successors
                [ InputGroup.span [] [ text ".00"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "amount"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "$"]
                , InputGroup.span [] [ text ".00"]
                ]
            |> InputGroup.view
        ]
    , Util.code basicCode
    ]


basicCode : Html msg
basicCode =
    Util.toMarkdownElm """
    div []
        [ InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "amount"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "$"] ]
            |> InputGroup.successors
                [ InputGroup.span [] [ text ".00"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "amount"])
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "$"]
                , InputGroup.span [] [ text ".00"]
                ]
            |> InputGroup.view
        ]

"""

sizing : List (Html msg)
sizing =
    [ h2 [] [ text "Sizing" ]
    , p [] [ text "Add the relative size to the input group itself and contents within will automatically resize—no need for repeating the form control size  on each element." ]
    , Util.example
        [ InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.large
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.small
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        ]
    , Util.code sizingCode
    ]

sizingCode : Html msg
sizingCode =
    Util.toMarkdownElm """
    div []
        [ InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.large
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        , br [] []
        , InputGroup.config
            (InputGroup.text [ Input.placeholder "username"])
            |> InputGroup.small
            |> InputGroup.predecessors
                [ InputGroup.span [] [ text "@"] ]
            |> InputGroup.view
        ]

"""

buttons : List (Html msg)
buttons =
    [ h2 [] [ text "Button addons" ]
    , p [] [ text "You can also use buttons as addons. " ]
    , Util.example
        [ Grid.row []
            [ Grid.col [ Col.lg6 ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Search for" ] )
                    |> InputGroup.predecessors
                        [ InputGroup.button [ Button.secondary ] [ text "Go!"] ]
                    |> InputGroup.view
                ]
            , Grid.col [ Col.lg6 ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Search for" ] )
                    |> InputGroup.successors
                        [ InputGroup.button [ Button.secondary ] [ text "Go!"] ]
                    |> InputGroup.view
                ]
            ]
        , br [] []
        , Grid.row []
            [ Grid.col [ Col.offsetLg3, Col.lg6 ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Product name" ] )
                    |> InputGroup.predecessors
                        [ InputGroup.button [ Button.success ] [ text "Love it"] ]
                    |> InputGroup.successors
                        [ InputGroup.button [ Button.danger ] [ text "Hate it"] ]
                    |> InputGroup.view
                ]
            ]
        ]
        , Util.code buttonsCode
    ]


buttonsCode : Html msg
buttonsCode =
    Util.toMarkdownElm """
div []
    [ Grid.row []
        [ Grid.col [ Col.lg6 ]
            [ InputGroup.config
                ( InputGroup.text [ Input.placeholder "Search for" ] )
                |> InputGroup.predecessors
                    [ InputGroup.button [ Button.secondary ] [ text "Go!"] ]
                |> InputGroup.view
            ]
        , Grid.col [ Col.lg6 ]
            [ InputGroup.config
                ( InputGroup.text [ Input.placeholder "Search for" ] )
                |> InputGroup.successors
                    [ InputGroup.button [ Button.secondary ] [ text "Go!"] ]
                |> InputGroup.view
            ]
        ]
    , br [] []
    , Grid.row []
        [ Grid.col [ Col.offsetLg3, Col.lg6 ]
            [ InputGroup.config
                ( InputGroup.text [ Input.placeholder "Product name" ] )
                |> InputGroup.predecessors
                    [ InputGroup.button [ Button.success ] [ text "Love it"] ]
                |> InputGroup.successors
                    [ InputGroup.button [ Button.danger ] [ text "Hate it"] ]
                |> InputGroup.view
            ]
        ]

    ]

"""
