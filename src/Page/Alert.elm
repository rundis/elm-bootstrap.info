module Page.Alert exposing (view, update, initialState, subscriptions, State, Msg)

import Html exposing (..)
import Html.Attributes exposing (..)
import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Util


type alias State =
    { dismissableVisibility : Alert.Visibility
    , animatedVisibility : Alert.Visibility
    }


initialState : State
initialState =
    State Alert.shown Alert.shown


type Msg
    = AlertMsg Alert.Visibility
    | AnimatedMsg Alert.Visibility


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Alert.subscriptions state.animatedVisibility AnimatedMsg ]

update : Msg -> State -> State
update msg state =
    case msg of
        AlertMsg visibility ->
            { state | dismissableVisibility = visibility }

        AnimatedMsg visibility ->
            { state | animatedVisibility = visibility }


view : State -> Util.PageContent Msg
view state =
    { title = "Alert"
    , description = "Provide contextual feedback messages for typical user actions with the handful of available and flexible alert messages."
    , children =
        (basic ++ extended ++ dismissable state)
    }


basic : List (Html msg)
basic =
    [ h2 [] [ text "Basic alert messages " ]
    , p [] [ text """Alerts are available for any length of text. Use one of the 4 available functions in the Alert module.""" ]
    , Util.example
        [ simpleAlert Alert.primary <| "This is a primary message."
        , simpleAlert Alert.secondary <| "This is a secondary message."
        , simpleAlert Alert.success <| "This is a success message."
        , simpleAlert Alert.info <| "Just a heads up info message."
        , simpleAlert Alert.warning <| "Warning, you shouldn't be doing this."
        , simpleAlert Alert.danger <| "Something bad happened."
        , simpleAlert Alert.light <| "Make it really light."
        , simpleAlert Alert.dark <| "I prefer the dark."
        ]
    , div [ class "highlight" ]
        [ basicCode ]
    ]


simpleAlert : (Alert.Config msg -> Alert.Config msg) -> String -> Html msg
simpleAlert roleFn txt =
    Alert.config
        |> roleFn
        |> Alert.children
            [ Alert.text txt ]
        |> Alert.view Alert.shown


basicCode : Html msg
basicCode =
    Util.toMarkdown """
```elm

simpleAlert : (Alert.Config msg -> Alert.Config msg) -> String ->  Html msg
simpleAlert roleFn txt =
    Alert.config
        |> roleFn
        |> Alert.children
            [ Alert.text txt ]
        |> Alert.view Alert.shown

view : Html msg
view =
    div []
        [ simpleAlert Alert.primary <|   "This is a primary message."
        , simpleAlert Alert.secondary <| "This is a secondary message."
        , simpleAlert Alert.success <| "This is a success message."
        , simpleAlert Alert.info <| "Just a heads up info message."
        , simpleAlert Alert.warning <| "Warning, you shouldn't be doing this."
        , simpleAlert Alert.danger <| "Something bad happened."
        , simpleAlert Alert.light <| "Make it really light."
        , simpleAlert Alert.dark <| "I prefer the dark."
        ]


```

"""


extended : List (Html msg)
extended =
    [ h2 [] [ text "Styled links and headings" ]
    , p [] [ text "The Alert module provides a couple of helper functions to make your links and headings nicely styled inside alerts." ]
    , Util.example
        [ Alert.config
            |> Alert.info
            |> Alert.children
                [ Alert.h4 [] [ text "Alert heading" ]
                , Alert.text "This info message has a "
                , Alert.link [ href "javascript:void()" ] [ text "link" ]
                , Alert.p [] [ text "Followed by a paragraph behaving as you'd expect." ]
                ]
            |> Alert.view Alert.shown
        ]
    , div [ class "highlight" ]
        [ extendedCode ]
    ]


extendedCode : Html msg
extendedCode =
    Util.toMarkdown """
```elm
Alert.config
    |> Alert.info
    |> Alert.children
        [ Alert.h4 [] [ text "Alert heading"]
        , Alert.text "This info message has a "
        , Alert.link [ href "javascript:void()" ] [text "link"]
        , Alert.p [] [ text "Followed by a paragraph behaving as you'd expect."]
        ]
    |> Alert.view Alert.shown

```
"""


dismissable : State -> List (Html Msg)
dismissable state =
    [ h2 [] [ text "A dismissable alert" ]
    , p [] [ text "With a little state handling in your model, you may also have dismissable alerts." ]
    , p [] [ text "Unlike Twitter Bootstrap with JavaScript, the element is not removed from the DOM, it's just set to display:none."]
    , Util.example
        [ Alert.config
            |> Alert.info
            |> Alert.dismissable AlertMsg
            |> Alert.children
                [ Alert.h4 [] [ text "I'm dimissable" ]
                , Alert.text "My visibility is your responsibility to keep track of though!"
                ]
            |> Alert.view state.dismissableVisibility
        , Button.button
            [ Button.block, Button.primary, Button.onClick (AlertMsg Alert.shown) ]
            [ text "Reset alert" ]

        ]
    , div [ class "highlight" ]
        [ dismissableCode ]
    , h2 [] [ text "Animation support"]
    , p [] [ text "With a little tweak and adding a subscription wiring, you can make the alert do a fade out animation when dismissed." ]
    , Util.example
        [ Alert.config
            |> Alert.primary
            -- This enables the dismiss event to run an animation
            |> Alert.dismissableWithAnimation AnimatedMsg
            |> Alert.children
                [ Alert.h4 [] [ text "I'm dimissable" ]
                , Alert.text "I should fade out when dismissed."
                ]
            |> Alert.view state.animatedVisibility
        , Button.button
            [ Button.block, Button.primary, Button.onClick (AnimatedMsg Alert.shown) ]
            [ text "Reset alert" ]

        ]
    , div [ class "highlight" ]
        [ animatedCode ]
    ]


dismissableCode : Html msg
dismissableCode =
    Util.toMarkdown """
```elm

type Msg
    = AlertMsg Alert.Visibility


type Model =
    { alertVisibility : Alert.Visibility }

init : ( Model, Cmd Msg)
init =
    ( { alertVisibility = Alert.shown }, Cmd.none )

update : Msg -> Model -> (Model, Cmd.none)
update msg model =
    case msg of
        AlertMsg visibility ->
            { model | alertVisibility = visibility }


view : Model -> Html Msg
view =
    Alert.config
        |> Alert.info
        |> Alert.dismissable AlertMsg
        |> Alert.children
            [ Alert.h4 [] [ text "I'm dimissable" ]
            , Alert.text "My visibility is your responsibility to keep track of though!"
            ]
        |> Alert.view model.alertVisibility

```
"""


animatedCode : Html msg
animatedCode =
    Util.toMarkdown """
```elm

-- Msg, update and init as in previous example


-- You also need to wire up the subscriptions function for animations to work.
subscriptions : Model -> Sub Msg
subscriptions model =
    Alert.subscriptions model.alertVisibility AlertMsg

view : Model -> Html Msg
view =
    Alert.config
        |> Alert.info
        -- This enables the alert to be dismissable with a fade out animation
        |> Alert.dismissableWithAnimation AlertMsg
        |> Alert.children
            [ Alert.h4 [] [ text "I'm dimissable" ]
            , Alert.text "My visibility is your responsibility to keep track of though!"
            ]
        |> Alert.view model.alertVisibility

```
"""



