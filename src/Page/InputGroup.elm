module Page.InputGroup exposing (initialState, update, view, subscriptions, State, Msg)

import Html exposing (..)
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Button as Button
import Bootstrap.Dropdown as Dropdown
import Util




type alias State =
    { dropdownState : Dropdown.State
    , splitDropdownState : Dropdown.State
    }

type Msg
    = DropdownMsg Dropdown.State
    | SplitDropdownMsg Dropdown.State


initialState : State
initialState =
    { dropdownState = Dropdown.initialState
    , splitDropdownState = Dropdown.initialState
    }

subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Dropdown.subscriptions state.dropdownState DropdownMsg
        , Dropdown.subscriptions state.splitDropdownState SplitDropdownMsg
        ]


update : Msg -> State -> State
update msg state =
    case msg of
        DropdownMsg newState ->
            { state | dropdownState = newState }

        SplitDropdownMsg newState ->
            { state | splitDropdownState = newState }



view : State -> Util.PageContent Msg
view state =
    { title = "Input group"
    , description =
        """Easily extend form controls by adding text or buttons on either side of textual inputs."""
    , children =
        basic ++ sizing ++ buttons ++ dropdowns state
    }




basic : List (Html Msg)
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


basicCode : Html Msg
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

sizing : List (Html Msg)
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

sizingCode : Html Msg
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

buttons : List (Html Msg)
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


buttonsCode : Html Msg
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


dropdowns : State -> List (Html Msg)
dropdowns state =
    [ h2 [] [ text "Dropdown addons" ]
    , p [] [ text "Dropdowns can be used as addons too, but you'll need to wire up the dropdowns since they have state related behavior. " ]
    , Util.example
        [ Grid.row []
            [ Grid.col [ Col.lg6 ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Search for" ] )
                    |> InputGroup.predecessors
                        [ InputGroup.dropdown
                            state.dropdownState
                            { options = []
                            , toggleMsg = DropdownMsg
                            , toggleButton =
                                Dropdown.toggle [ Button.outlineSecondary ] [ text "Dropdown addon" ]
                            , items =
                                [ Dropdown.buttonItem [] [ text "Item 1"]
                                , Dropdown.buttonItem [] [ text "Item 1"]
                                ]
                            }
                        ]
                    |> InputGroup.view
                ]
            , Grid.col [ Col.lg6 ]
                [ InputGroup.config
                    ( InputGroup.text [ Input.placeholder "Search for" ] )
                    |> InputGroup.successors
                        [ InputGroup.splitDropdown
                            state.splitDropdownState
                            { options = []
                            , toggleMsg = SplitDropdownMsg
                            , toggleButton =
                                Dropdown.splitToggle
                                    { options = [ Button.outlineSecondary ]
                                    , togglerOptions = [ Button.outlineSecondary ]
                                    , children = [ text "SplitDropdown addon" ]
                                    }
                            , items =
                                [ Dropdown.buttonItem [] [ text "Item 1"]
                                , Dropdown.buttonItem [] [ text "Item 1"]
                                ]
                            }
                        ]
                    |> InputGroup.view
                ]
            ]
        ]
        , Util.code dropdownsCode
    ]


dropdownsCode : Html Msg
dropdownsCode =
    Util.toMarkdownElm """

-- Check out the dropdown module for how to wire up the state handling neeeded for the dropdowns!

Grid.row []
    [ Grid.col [ Col.lg6 ]
        [ InputGroup.config
            ( InputGroup.text [ Input.placeholder "Search for" ] )
            |> InputGroup.predecessors
                [ InputGroup.dropdown
                    model.dropdownState
                    { options = []
                    , toggleMsg = DropdownMsg
                    , toggleButton =
                        Dropdown.toggle [ Button.outlineSecondary ] [ text "Dropdown addon" ]
                    , items =
                        [ Dropdown.buttonItem [] [ text "Item 1"]
                        , Dropdown.buttonItem [] [ text "Item 1"]
                        ]
                    }
                ]
            |> InputGroup.view
        ]
    , Grid.col [ Col.lg6 ]
        [ InputGroup.config
            ( InputGroup.text [ Input.placeholder "Search for" ] )
            |> InputGroup.successors
                [ InputGroup.splitDropdown
                    model.splitDropdownState
                    { options = []
                    , toggleMsg = SplitDropdownMsg
                    , toggleButton =
                        Dropdown.splitToggle
                            { options = [ Button.outlineSecondary ]
                            , togglerOptions = [ Button.outlineSecondary ]
                            , children = [ text "SplitDropdown addon" ]
                            }
                    , items =
                        [ Dropdown.buttonItem [] [ text "Item 1"]
                        , Dropdown.buttonItem [] [ text "Item 1"]
                        ]
                    }
                ]
            |> InputGroup.view
        ]
    ]

"""

