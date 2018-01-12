module Page.ButtonGroup exposing (view, initialState, State)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Button as Button
import Bootstrap.ButtonGroup as ButtonGroup
import Util


type alias State =
    { radio : RadioState
    , chk1 : Bool
    , chk2 : Bool
    , chk3 : Bool
    }


type RadioState
    = One
    | Two
    | Three

initialState : State
initialState =
    { radio = Two
    , chk1 = False
    , chk2 = False
    , chk3 = True
    }


view : State -> (State -> msg) -> Util.PageContent msg
view  state toMsg =
    { title = "Button group"
    , description ="""Group a series of buttons together on a single line with the button group, or nest even further to create a button toolbar."""
    , children =
        basic
        ++ checkbox state toMsg
        ++ radios state toMsg
        ++ sizing
        ++ vertical
        ++ toolbar
    }



basic : List (Html msg)
basic =
    [ h2 [] [ text "Basic example" ]
    , p [] [ text "Group a series of buttons together using the buttonGroup function." ]
    , Util.example
        [ ButtonGroup.buttonGroup [] bunchOfButtons ]
    , Util.code groupBasicCode

    ]

groupBasicCode : Html msg
groupBasicCode =
    Util.toMarkdownElm """
ButtonGroup.group []
    [ ButtonGroup.button [ Button.secondary ] [  text "Left" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Middle" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Right" ]
    ]
"""



checkbox : State -> (State -> msg) -> List (Html msg)
checkbox state toMsg =
    [ h2 [] [ text "Checkbox buttons"]
    , p  [] [ text "You can have checkboxes as buttons if you like." ]
    , Util.example
        [ ButtonGroup.checkboxButtonGroup []
            [ ButtonGroup.checkboxButton
                state.chk1
                [ Button.primary
                , Button.onClick <| toMsg { state | chk1 = not state.chk1 }
                ]
                [ text "Check me" ]
            , ButtonGroup.checkboxButton
                state.chk2
                [ Button.primary
                , Button.onClick <| toMsg { state | chk2 = not state.chk2 }
                ]
                [ text "No me" ]
            , ButtonGroup.checkboxButton
                state.chk3
                [ Button.primary
                , Button.onClick <| toMsg { state | chk3 = not state.chk3 }
                ]
                [ text "Correct" ]
            ]
        ]
    , Util.code checkboxCode
    ]


checkboxCode : Html msg
checkboxCode =
    Util.toMarkdownElm """

type alias Model =
    { chk1 : Bool
    , chk2 : Bool
    , chk3 : Bool
    }

type Msg
    = Chk1Msg
    | Chk2Msg
    | Chk3Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Chk1Msg ->
            ( { model | chk1 = not model.chk1 }, Cmd.none )

        Chk2Msg ->
            ( { model | chk2 = not model.chk2 }, Cmd.none )

        Chk3Msg ->
            ( { model | chk3 = not model.chk3 }, Cmd.none )


view : Model -> Html Msg
view model =
    ButtonGroup.checkboxButtonGroup []
        [ ButtonGroup.checkboxButton
            model.chk1
            [ Button.primary, Button.onClick Chk1Msg ]
            [ text "Check me" ]
        , ButtonGroup.checkboxButton
            model.chk2
            [ Button.primary, Button.onClick Chk2Msg ]
            [ text "No me" ]
        , ButtonGroup.checkboxButton
            model.chk3
            [ Button.primary, Button.onClick Chk3Msg ]
            [ text "Correct" ]

"""

radios : State -> (State -> msg) -> List (Html msg)
radios state toMsg =
    [ h2 [] [ text "Radio buttons"]
    , p  [] [ text "You can also have radio inputs as buttons if that makes sense too you." ]
    , Util.example
        [ ButtonGroup.radioButtonGroup []
            [ ButtonGroup.radioButton
                (state.radio == One)
                [ Button.primary
                , Button.onClick <| toMsg { state | radio = One }
                ]
                [ text "One" ]
            , ButtonGroup.radioButton
                (state.radio == Two)
                [ Button.primary
                , Button.onClick <| toMsg { state | radio = Two }
                ]
                [ text "Two" ]
            , ButtonGroup.radioButton
                (state.radio == Three)
                [ Button.primary
                , Button.onClick <| toMsg { state | radio = Three }
                ]
                [ text "Three" ]
            ]
        ]
    , Util.code radiosCode
    ]


radiosCode : Html msg
radiosCode =
    Util.toMarkdownElm """

type alias Model =
    { radioState : RadioState }


type RadioState
    = One
    | Two
    | Three


type Msg
    = RadioMsg RadioState

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RadioMsg state ->
            ( { model | radioState = state }, Cmd.none )


view : Model -> Html Msg
view model =
    ButtonGroup.radioButtonGroup []
        [ ButtonGroup.radioButton
            (model.radioState == One)
            [ Button.primary, Button.onClick <| RadioMsg One ]
            [ text "One" ]
        , ButtonGroup.radioButton
            (model.radioState == Two)
            [ Button.primary, Button.onClick <| RadioMsg Two ]
            [ text "Two" ]
        , ButtonGroup.radioButton
            (model.radioState == Three)
            [ Button.primary, Button.onClick <| RadioMsg Three ]
            [ text "Three" ]
        ]
"""


sizing : List (Html msg)
sizing =
    [ h2 [] [ text "Sizing"]
    , p [] [ text "Instead of applying sizing options to individual buttons, you can apply one size option for all buttons in a group" ]
    , Util.example
        [ ButtonGroup.buttonGroup [ ButtonGroup.large ] bunchOfButtons
        , ButtonGroup.buttonGroup
            [ ButtonGroup.small, ButtonGroup.attrs [ style [("display", "block")]] ]
            bunchOfButtons
        ]
    , Util.code groupSizingCode
    ]

groupSizingCode : Html msg
groupSizingCode =
    Util.toMarkdownElm """
div []
    [ ButtonGroup.buttonGroup [ ButtonGroup.large ] bunchOfButtons
    , ButtonGroup.buttonGroup
        [ ButtonGroup.small, ButtonGroup.attrs [ style [("display", "block")]] ]
        bunchOfButtons
    ]

bunchOfButtons : List (ButtonGroup.ButtonItem msg)
bunchOfButtons =
    [ ButtonGroup.button [ Button.secondary ] [  text "Left" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Middle" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Right" ]
    ]
"""

vertical : List (Html msg)
vertical =
    [ h2 [] [ text "Vertical variation" ]
    , p [] [ text "Make a set of buttons appear vertically stacked rather than horizontally." ]
    , Util.example
        [ ButtonGroup.buttonGroup [ ButtonGroup.vertical ] bunchOfButtons ]
    , Util.code verticalGroupCode
    ]

verticalGroupCode : Html msg
verticalGroupCode =
    Util.toMarkdownElm """
ButtonGroup.buttonGroup [ ButtonGroup.vertical ] bunchOfButtons
"""


toolbar : List (Html msg)
toolbar =
    [ h2 [] [ text "Button toolbar" ]
    , p [] [ text "Combine sets of button groups into button toolbars for more complex components. Use utility classes as needed to space out groups, buttons, and more." ]
    , Util.example
        [ ButtonGroup.toolbar []
            [ ButtonGroup.buttonGroupItem [] bunchOfButtons
            , ButtonGroup.buttonGroupItem [ ButtonGroup.attrs [ class "ml-1"] ] bunchOfButtons
            , ButtonGroup.buttonGroupItem [ ButtonGroup.attrs [ class "ml-3"] ] bunchOfButtons
            ]
        ]
    , Util.code toolbarCode
    , Util.calloutWarning
        [ h4 [] [ text "ButtonGroup.*Item functions" ]
        , p [] [ text """Note the use of the function buttonGroupItem. It has the same signature as the buttonGroup function, except that it doesn't return Html
                      This separation is in place to ensure type safety and control over what is placed within a button toolbar.

                      Also worth noting that you can use radioButtonGroupItem and checkboxButtonGroupItem to include radio groups and checkbox groups in a toolbar."""
               ]
        ]
    ]

toolbarCode : Html msg
toolbarCode =
    Util.toMarkdownElm """
ButtonGroup.toolbar []
    [ ButtonGroup.buttonGroupItem [] bunchOfButtons
    , ButtonGroup.buttonGroupItem [ ButtonGroup.attrs [ class "ml-1"] ] bunchOfButtons
    , ButtonGroup.buttonGroupItem [ ButtonGroup.attrs [ class "ml-3"] ] bunchOfButtons
    ]
"""


bunchOfButtons : List (ButtonGroup.ButtonItem msg)
bunchOfButtons =
    [ ButtonGroup.button [ Button.secondary ] [  text "Left" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Middle" ]
    , ButtonGroup.button [ Button.secondary ] [  text "Right" ]
    ]








