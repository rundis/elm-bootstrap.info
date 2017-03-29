module Page.Popover exposing (view, initialState, State)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Popover as Popover
import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Util


type alias State =
    { basicState : Popover.State
    , leftState : Popover.State
    , rightState : Popover.State
    , topState : Popover.State
    , bottomState: Popover.State
    }


initialState : State
initialState =
    { basicState = Popover.initialState
    , leftState = Popover.initialState
    , rightState = Popover.initialState
    , topState = Popover.initialState
    , bottomState = Popover.initialState
    }


view : State -> (State -> msg) -> Util.PageContent msg
view state toMsg =
    { title = "Popover"
    , description = """Add small overlay content, like those found in iOS, to any element for housing secondary information."""
    , children =
        example state toMsg
        ++ tooltips state toMsg
    }


example : State -> (State -> msg) -> List (Html msg)
example state toMsg =
    [ h2 [] [ text "Example" ]
    , p [] [ text "You can trigger popovers from most any element. Here is a small example. (Click the small button to see the popover)" ]
    , Util.example
        [ Form.group []
            [ Form.label []
                [ text "Username "
                , Popover.config
                    ( Button.button
                        [ Button.small
                        , Button.primary
                        , Button.attrs <|
                            Popover.onClick state.basicState (\s -> toMsg { state | basicState = s })
                        ]
                        [ span [class "fa fa-question-circle"]
                            []
                        ]
                    )
                    |> Popover.right
                    |> Popover.titleH4 [] [ text "Username help" ]
                    |> Popover.content []
                        [ text "Your username must not contain numbers..." ]
                    |> Popover.view state.basicState
                ]
            , Input.text [ Input.placeholder "Enter username" ]
            ]
        ]
    , Util.code exampleCode
    , Util.calloutInfo
        [ p []
            [ text """The popovers in Elm bootstrap are somewhat limited in that they introduce a wrapping div around the triggering element.
                         Once Elm gets a little more support for tracking things like scrolling and perhaps smoother facilities for getting the size of other elements we can hopefully create a more flexible popover. """
            ]
        ]
    ]

exampleCode : Html msg
exampleCode =
    Util.toMarkdownElm """

type alias Model =
        { popoverState = Popover.State }

-- Define a message to handle popover state changes
type Msg
    = PopoverMsg Popover.State


-- Initialize the popover state
initialState : ( Model, Cmd Msg )
initialState =
    ( { popoverState = Popover.initialState}, Cmd.none )


-- Step the popover state forward in your update function
update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        PopoverMsg state ->
            ( { model | popoverState = state }, Cmd.none )


-- Compose a popover in your view (or a view helper function)
view : Model -> Html Msg
view model =
     Form.group []
        [ Form.label []
            [ text "Username "
            , Popover.config
                ( Button.button
                    [ Button.small
                    , Button.primary
                    , Button.attrs <|
                        Popover.onClick model.popoverState PopoverMsg
                    ]
                    [ span [class "fa fa-question-circle"]
                        []
                    ]
                )
                |> Popover.right
                |> Popover.titleH4 [] [ text "Username help" ]
                |> Popover.content []
                    [ text "Your username must not contain numbers..." ]
                |> Popover.view model.popoverState
            ]
        , Input.text [ Input.placeholder "Enter username" ]
        ]

"""


tooltips : State -> (State -> msg) -> List (Html msg)
tooltips state toMsg =
    [ h2 [] [ text "Tooltips" ]
    , p [] [ text "You can also use the popovers as tooltips by changing from using onClick to onHover for triggering elements." ]
    , Util.example
        [ tooltipButton "Top" state.topState (\s -> toMsg { state | topState = s })
            |> popover Popover.top state.topState
        , tooltipButton "Bottom" state.bottomState (\s -> toMsg { state | bottomState = s })
            |> popover Popover.bottom state.bottomState
        , tooltipButton "Left" state.leftState (\s -> toMsg { state | leftState = s })
            |> popover Popover.left state.leftState
        , tooltipButton "Right" state.rightState (\s -> toMsg { state | rightState = s })
            |> popover Popover.right state.rightState
        ]
    , Util.calloutWarning
        [ p [] [ text """Unfortunately there seems to be an issue when having multiples of popovers functioning as tooltips.
                        I.e mouseleave doesn't always trigger as expected when you have mouseenter on another element with a tooltip trigger.
                        ( You can observe this if moving the mouse pointer quickly accross several buttons above.)
                        So you might want to use this feature with some care."""]
        ]
    ]

popover
    : (Popover.Config msg -> Popover.Config msg1)
    -> Popover.State
    -> Html msg
    -> Html msg1
popover posFn popState btn =
    Popover.config btn
        |> posFn
        |> Popover.content [] [ text "Tooltip" ]
        |> Popover.view popState


tooltipButton : String -> Popover.State -> (Popover.State -> msg) -> Html msg
tooltipButton label popState popMsg =
    Button.button
        [ Button.outlineInfo
        , Button.attrs <|
            ( class "mr-2" :: Popover.onHover popState popMsg)
        ]
        [ text label ]

