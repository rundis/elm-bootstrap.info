module Page.Popover exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Popover as Popover
import Html exposing (..)
import Html.Attributes exposing (..)
import Msg
import Util


type alias State a =
    { a
        | popBasic : Popover.State
        , popBottom : Popover.State
        , popLeft : Popover.State
        , popRight : Popover.State
        , popTop : Popover.State
    }


view :
    State a
    -> { children : List (Html Msg.Msg), description : String, title : String }
view state =
    { title = "Popover"
    , description = """Add small overlay content, like those found in iOS, to any element for housing secondary information."""
    , children =
        example state
            ++ tooltips state
    }


example : State a -> List (Html Msg.Msg)
example state =
    [ h2 [] [ text "Example" ]
    , p [] [ text "You can trigger popovers from most any element. Here is a small example. (Click the small button to see the popover)" ]
    , Util.example
        [ Form.group []
            [ Form.label []
                [ text "Username "
                , Popover.config
                    (Button.button
                        [ Button.small
                        , Button.primary
                        , Button.attrs <|
                            Popover.onClick state.popBasic Msg.PopBasic
                        ]
                        [ span [ class "fa fa-question-circle" ]
                            []
                        ]
                    )
                    |> Popover.right
                    |> Popover.titleH4 [] [ text "Username help" ]
                    |> Popover.content []
                        [ text "Your username must not contain numbers..." ]
                    |> Popover.view state.popBasic
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


tooltips : State a -> List (Html Msg.Msg)
tooltips state =
    [ h2 [] [ text "Tooltips" ]
    , p [] [ text "You can also use the popovers as tooltips by changing from using onClick to onHover for triggering elements." ]
    , Util.example
        [ tooltipButton "Top" state.popTop Msg.PopTop
            |> popover Popover.top state.popTop
        , tooltipButton "Bottom" state.popBottom Msg.PopBottom
            |> popover Popover.bottom state.popBottom
        , tooltipButton "Left" state.popLeft Msg.PopLeft
            |> popover Popover.left state.popLeft
        , tooltipButton "Right" state.popRight Msg.PopRight
            |> popover Popover.right state.popRight
        ]
    ]


popover :
    (Popover.Config msg -> Popover.Config msg1)
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
            (class "mr-2" :: Popover.onHover popState popMsg)
        ]
        [ text label ]
