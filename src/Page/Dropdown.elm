module Page.Dropdown
    exposing
        ( view
        , State
        , initialState
        , subscriptions
        , update
        , Msg
        )

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Dropdown as Dropdown
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Radio as Radio
import Util


type alias State =
    { basicState : Dropdown.State
    , customizedState : Dropdown.State
    , splitState : Dropdown.State
    , menuState : Dropdown.State
    , options : Options
    }


type Msg
    = BasicMsg Dropdown.State
    | CustomizedMsg Dropdown.State
    | SplitMsg Dropdown.State
    | MenuMsg Dropdown.State
    | OptionsMsg Options



initialState : State
initialState =
    { basicState = Dropdown.initialState
    , customizedState = Dropdown.initialState
    , splitState = Dropdown.initialState
    , menuState = Dropdown.initialState
    , options = defaultOptions
    }


type alias Options =
    { coloring : Coloring
    , size : Size
    , dropDir : Maybe DropDir
    , menuRight : Bool
    }


type Coloring
    = Primary
    | Secondary
    | Success
    | Info
    | Warning
    | Danger
    | Light
    | Dark
    | OutlinePrimary
    | OutlineSecondary
    | OutlineSuccess
    | OutlineInfo
    | OutlineWarning
    | OutlineDanger
    | OutlineLight
    | OutlineDark


type DropDir
    = Up
    | Left
    | Right

type Size
    = Small
    | Medium
    | Large


defaultOptions : Options
defaultOptions =
    { coloring = Primary
    , size = Medium
    , dropDir = Nothing
    , menuRight = False
    }


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Dropdown.subscriptions state.basicState BasicMsg
        , Dropdown.subscriptions state.customizedState CustomizedMsg
        , Dropdown.subscriptions state.splitState SplitMsg
        , Dropdown.subscriptions state.menuState MenuMsg
        ]


update : Msg -> State -> State
update msg state =
    case msg of
        BasicMsg newState ->
            { state | basicState = newState }

        CustomizedMsg newState ->
            { state | customizedState = newState }

        SplitMsg newState ->
            { state | splitState = newState }

        MenuMsg newState ->
            { state | menuState = newState }

        OptionsMsg opts ->
            { state | options = opts }




view : State -> Util.PageContent Msg
view state =
    { title = "Dropdown"
    , description =
        """Dropdowns are toggleable, contextual overlays for displaying lists of links and more.
           They’re made interactive with a little bit of Elm. They’re toggled by clicking."""
    , children =
        (basic state
            ++ customized state
            ++ split state
            ++ menu state
        )
    }


basic : State -> List (Html Msg)
basic state =
    [ h2 [] [ text "Basic example" ]
    , p [] [ text "Since dropdowns are interactive, we need to do a little bit of wiring to use them." ]
    , Util.example
        [ Dropdown.dropdown
            state.basicState
            { options = []
            , toggleMsg = BasicMsg
            , toggleButton =
                Dropdown.toggle [ Button.outlinePrimary ] [ text "My dropdown" ]
            , items =
                [ Dropdown.buttonItem [] [ text "Item 1" ]
                , Dropdown.buttonItem [] [ text "Item 2" ]
                ]
            }
        ]
    , Util.code basicCode
    ]


basicCode : Html msg
basicCode =
    Util.toMarkdownElm """

-- Dropdowns depends on view state to keep track of whether it is (/should be) open or not
type alias Model =
    { myDrop1State : Dropdown.State }


-- init

init : (Model, Cmd Msg )
init =
    ( { myDrop1State = Dropdown.initialState} -- initially closed
    , Cmd.none
    )


-- Msg

type Msg
    = MyDrop1Msg Dropdown.State


-- In your update function you will to handle messages coming from the dropdown

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        MyDrop1Msg state ->
            ( { model | myDrop1State = state }
            , Cmd.none
            )


-- Dropdowns relies on subscriptions to automatically close any open when clicking outside them

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Dropdown.subscriptions model.myDrop1State MyDrop1Msg ]


-- Specify config and how the dropdown should look in your view (or view helper) function

view : Model -> Html Msg
view model =
    div []
        [ Dropdown.dropdown
            model.myDrop1State
            { options = [ ]
            , toggleMsg = MyDrop1Msg
            , toggleButton =
                Dropdown.toggle [ Button.primary ] [ text "My dropdown" ]
            , items =
                [ Dropdown.buttonItem [ onClick Item1Msg ] [ text "Item 1" ]
                , Dropdown.buttonItem [ onClick Item2Msg ] [ text "Item 2" ]
                ]
            }

        -- etc
        ]

"""


customized : State -> List (Html Msg)
customized state =
    [ h2 [] [ text "Customization" ]
    , p [] [ text "You can do quite a lot of customization on the dropdown and the dropdown button." ]
    , Util.example <|
        [ Dropdown.dropdown
            state.customizedState
            { options = customizedDropOptions state
            , toggleMsg = CustomizedMsg
            , toggleButton =
                Dropdown.toggle (customizedButtonOptions state) [ text "My dropdown" ]
            , items =
                [ Dropdown.buttonItem [] [ text "Item 1" ]
                , Dropdown.buttonItem [] [ text "Item 2" ]
                ]
            }
        ]
            ++ [customizeForm state]
    ]


customizeForm : State -> Html Msg
customizeForm ({ options } as state) =
    let
        coloringAttrs id opt rName =
            [ Radio.id id
            , Radio.checked <| opt == options.coloring
            , Radio.name rName
            , Radio.onClick <| OptionsMsg { options | coloring = opt }
            ]

        sizeAttrs id opt =
            [ Radio.id id
            , Radio.inline
            , Radio.name "sizes"
            , Radio.checked <| opt == options.size
            , Radio.onClick <| OptionsMsg { options | size = opt }
            ]

        dirAttrs id opt =
            [ Radio.id id
            , Radio.inline
            , Radio.name "directions"
            , Radio.checked <| opt == options.dropDir
            , Radio.onClick <| OptionsMsg { options | dropDir = opt }
            ]
    in
        Form.form [ class "container mt-3" ]
            [ h4 [] [ text "Dropdown customization" ]
            , Form.row []
                [ Form.col []
                    [ Radio.custom (dirAttrs "defaultDir" Nothing) "Default"
                    , Radio.custom (dirAttrs "dropUp" <| Just Up) "Dropdown.dropUp"
                    , Radio.custom (dirAttrs "dropLeft" <| Just Left) "Dropdown.dropLeft"
                    , Radio.custom (dirAttrs "dropRight" <| Just Right) "Dropdown.dropRight"
                    ]
                ]
            , Form.row []
                [ Form.col []
                    [ Form.group []
                        [ Form.label
                            [ style [ ( "font-weight", "bold" ) ] ]
                            [ text "Coloring" ]
                        , div []
                            [ Radio.custom (coloringAttrs "primary" Primary "coloring") "Button.primary"
                            , Radio.custom (coloringAttrs "secondary" Secondary "coloring") "Button.secondary"
                            , Radio.custom (coloringAttrs "success" Success "coloring") "Button.success"
                            , Radio.custom (coloringAttrs "info" Info "coloring") "Button.info"
                            , Radio.custom (coloringAttrs "warning" Warning "coloring") "Button.warning"
                            , Radio.custom (coloringAttrs "danger" Danger "coloring") "Button.danger"
                            , Radio.custom (coloringAttrs "light" Light "coloring") "Button.light"
                            , Radio.custom (coloringAttrs "dark" Dark "coloring") "Button.dark"
                            ]
                        ]
                    ]
                , Form.col []
                    [ Form.group []
                        [ Form.label
                            [ style [ ( "font-weight", "bold" ) ] ]
                            [ text "Outlines" ]
                        , div []
                            [ Radio.custom (coloringAttrs "outlinePrimary" OutlinePrimary "outlcoloring") "Button.outlinePrimary"
                            , Radio.custom (coloringAttrs "outlineSecondary" OutlineSecondary "outlcoloring") "Button.outlineSecondary"
                            , Radio.custom (coloringAttrs "outlineSuccess" OutlineSuccess "outlcoloring") "Button.outlineSuccess"
                            , Radio.custom (coloringAttrs "outlineInfo" OutlineInfo "outlcoloring") "Button.outlineInfo"
                            , Radio.custom (coloringAttrs "outlineWarning" OutlineWarning "outlcoloring") "Button.outlineWarning"
                            , Radio.custom (coloringAttrs "outlineDanger" OutlineDanger "outlcoloring") "Button.outlineDanger"
                            , Radio.custom (coloringAttrs "outlineLight" OutlineLight "outlcoloring") "Button.outlineLight"
                            , Radio.custom (coloringAttrs "outlineDark" OutlineDark "outlcoloring") "Button.outlineDark"
                            ]
                        ]
                    ]
                ]
            , Form.row []
                [ Form.col []
                    [ Form.label
                        [ style [ ( "font-weight", "bold" ) ]]
                        [ text "Button sizes" ]
                    , div []
                        [ Radio.custom (sizeAttrs "small" Small) "Button.small"
                        , Radio.custom (sizeAttrs "medium" Medium) "Default"
                        , Radio.custom (sizeAttrs "larger" Large) "Button.large"
                        ]
                    ]
                ]
        ]


customizedDropOptions : State -> List (Dropdown.DropdownOption msg)
customizedDropOptions { options } =
    (case options.dropDir of
        Just Up ->
            [ Dropdown.dropUp ]

        Just Left ->
            [ Dropdown.dropLeft ]

        Just Right ->
            [ Dropdown.dropRight ]

        _ ->
            []
    )
        ++ (if options.menuRight then
                [ Dropdown.alignMenuRight ]
            else
                []
           )


customizedButtonOptions : State -> List (Button.Option msg)
customizedButtonOptions { options } =
    (case options.coloring of
        Primary ->
            [ Button.primary ]

        Secondary ->
            [ Button.secondary ]

        Success ->
            [ Button.success]

        Info ->
            [ Button.info ]

        Warning ->
            [ Button.warning ]

        Danger ->
            [ Button.danger ]

        Light ->
            [ Button.light ]

        Dark ->
            [ Button.dark ]

        OutlinePrimary ->
            [ Button.outlinePrimary ]

        OutlineSecondary ->
            [ Button.outlineSecondary ]

        OutlineSuccess ->
            [ Button.outlineSuccess ]

        OutlineInfo ->
            [ Button.outlineInfo ]

        OutlineWarning ->
            [ Button.outlineWarning ]

        OutlineDanger ->
            [ Button.outlineDanger ]

        OutlineLight ->
            [ Button.outlineLight ]

        OutlineDark ->
            [ Button.outlineDark ]
    )
        ++ (case options.size of
                Small ->
                    [ Button.small ]

                Medium ->
                    []

                Large ->
                    [ Button.large ]
           )


split : State -> List (Html Msg)
split state =
    [ h2 [] [ text "Split button dropdowns" ]
    , p [] [ text "You can also create split button dropdowns. The left button has a normal button action, whilst the right (caret) button toggles the dropdown menu." ]
    , Util.example
        [ Dropdown.splitDropdown
            state.splitState
            { options = []
            , toggleMsg = SplitMsg
            , toggleButton =
                Dropdown.splitToggle
                    { options = [ Button.secondary ]
                    , togglerOptions = [ Button.secondary ]
                    , children = [ text "My split dropdown" ]
                    }
            , items =
                [ Dropdown.buttonItem [] [ text "Item 1" ]
                , Dropdown.buttonItem [] [ text "Item 2" ]
                ]
            }
        ]
    , Util.code splitCode
    ]


splitCode : Html msg
splitCode =
    Util.toMarkdownElm """
Dropdown.splitDropdown
    model.mySplitDropdownState
    { options = []
    , toggleMsg = MySplitDropdownMsg
    , toggleButton =
        Dropdown.splitToggle
            { options = [ Button.secondary]
            , togglerOptions = [ Button.secondary ]
            , children = [ text "My split dropdown" ]
            }
    , items =
        [ Dropdown.buttonItem [] [ text "Item 1" ]
        , Dropdown.buttonItem [] [ text "Item 2" ]
        ]
    }
"""


menu : State -> List (Html Msg)
menu state =
    [ h2 [] [ text "Menu headers and dividers" ]
    , p [] [ text "You may use menu header and divder elements to organize your dropdown items." ]
    , Util.example
        [ Dropdown.dropdown
            state.menuState
            { options = []
            , toggleMsg = MenuMsg
            , toggleButton =
                Dropdown.toggle [ Button.warning ] [ text "My dropdown" ]
            , items =
                [ Dropdown.header [ text "Header" ]
                , Dropdown.buttonItem [] [ text "Item 1" ]
                , Dropdown.buttonItem [] [ text "Item 2" ]
                , Dropdown.divider
                , Dropdown.header [ text "Another heading" ]
                , Dropdown.buttonItem [] [ text "Item 3" ]
                , Dropdown.buttonItem [] [ text "Item 4" ]
                ]
            }
        ]
    , Util.code menuCode
    ]


menuCode : Html msg
menuCode =
    Util.toMarkdownElm """

Dropdown.dropdown
    model.myDropdownState
    { options = []
    , toggleMsg = MyDropdownMsg
    , toggleButton =
        Dropdown.toggle [ Button.warning ] [ text "My dropdown" ]
    , items =
        [ Dropdown.header [ text "Header"]
        , Dropdown.buttonItem [] [ text "Item 1" ]
        , Dropdown.buttonItem [] [ text "Item 2" ]
        , Dropdown.divider
        , Dropdown.header [ text "Another heading" ]
        , Dropdown.buttonItem [] [ text "Item 3" ]
        , Dropdown.buttonItem [] [ text "Item 4" ]
        ]
    }
"""
