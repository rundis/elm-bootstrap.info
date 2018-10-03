module Page.Modal exposing
    ( Msg
    , State
    , initialState
    , subscriptions
    , update
    , view
    )

import Bootstrap.Button as Button
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Modal as Modal
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Util


type alias State =
    { modalVisibility : Modal.Visibility
    , gridModalVisibility : Modal.Visibility
    , animatedModalVisibility : Modal.Visibility
    }


type Msg
    = CloseModal
    | ShowModal
    | CloseGridModal
    | ShowGridModal
    | CloseAnimatedModal
    | ShowAnimatedModal
    | AnimateAnimatedModal Modal.Visibility


initialState : State
initialState =
    { modalVisibility = Modal.hidden
    , gridModalVisibility = Modal.hidden
    , animatedModalVisibility = Modal.hidden
    }


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Modal.subscriptions state.animatedModalVisibility AnimateAnimatedModal ]


update : Msg -> State -> State
update msg state =
    case msg of
        CloseModal ->
            { state | modalVisibility = Modal.hidden }

        ShowModal ->
            { state | modalVisibility = Modal.shown }

        CloseGridModal ->
            { state | gridModalVisibility = Modal.hidden }

        ShowGridModal ->
            { state | gridModalVisibility = Modal.shown }

        CloseAnimatedModal ->
            { state | animatedModalVisibility = Modal.hidden }

        ShowAnimatedModal ->
            { state | animatedModalVisibility = Modal.shown }

        AnimateAnimatedModal visibility ->
            { state | animatedModalVisibility = visibility }


view : State -> Util.PageContent Msg
view state =
    { title = "Modal"
    , description =
        """Modals are streamlined, but flexible dialog prompts powered by Elm !
        They support a number of use cases from user notification to completely custom content and feature a handful of helpful subcomponents, sizes, and more."""
    , children =
        example state
            ++ grid state
            ++ animated state
    }


example : State -> List (Html Msg)
example state =
    [ h2 [] [ text "Example" ]
    , p [] [ text "Click the button below to show a simple example modal" ]
    , Util.example
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick ShowModal ]
            ]
            [ text "Open modal" ]
        , Modal.config CloseModal
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ text "Modal header" ]
            |> Modal.body [] [ p [] [ text "This is a modal for you !" ] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick CloseModal ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view state.modalVisibility
        ]
    , Util.code exampleCode
    , Util.calloutInfo
        [ h3 [] [ text "Modal composition" ]
        , ul []
            [ textLi "You start out by using the config function providing a message for handling closing the modal"
            , textLi "Then compose your modal with optional options, header, body and footer. The order is not important."
            , textLi "Finally to turn the modal into Elm Html you call the view function, passing whether to display the modal or not based on the stored state in your model"
            ]
        ]
    ]


textLi : String -> Html msg
textLi str =
    li [] [ text str ]


exampleCode : Html msg
exampleCode =
    Util.toMarkdownElm """


-- You need to keep track of whether to display the modal or not

type alias Model =
    { modalVisibility : Modal.Visibility }


-- Initialize your model

init : ( Model, Cmd Msg )
init =
    ( { modalVisibility = Modal.hidden }, Cmd.none )


-- Define messages for your modal

type Msg
    = CloseModal
    | ShowModal


-- Handle modal messages in your update function to enable showing and closing

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        CloseModal ->
            ( { model | modalVisibility = Modal.hidden } , Cmd.none )

        ShowModal ->
            ( { model | modalVisibility = Modal.shown } , Cmd.none )


-- Configure your modal view using pipeline friendly functions.

view : Model -> Html msg
view model =
    div []
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal ] ]
            ]
            [ text "Open modal"]
        , Modal.config CloseModal
            |> Modal.small
            |> Modal.hideOnBackdropClick True
            |> Modal.h3 [] [ text "Modal header" ]
            |> Modal.body [] [ p [] [ text "This is a modal for you !"] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick CloseModal ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view model.modalVisibility
        ]

"""


grid : State -> List (Html Msg)
grid state =
    [ h2 [] [ text "Using the Grid" ]
    , p [] [ text """Utilize the Bootstrap grid system within a modal by nesting Grid.containerFluid inside the Modal.body.
                    Then, use the normal grid system classes as you would anywhere else.""" ]
    , Util.example
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick ShowGridModal ]
            ]
            [ text "Open modal" ]
        , Modal.config CloseGridModal
            |> Modal.large
            |> Modal.h3 [] [ text "Modal grid header" ]
            |> Modal.body []
                [ Grid.containerFluid [ class "bd-example-row" ]
                    [ Grid.row []
                        [ Grid.col
                            [ Col.sm4 ]
                            [ text "Col sm4" ]
                        , Grid.col
                            [ Col.sm8 ]
                            [ text "Col sm8" ]
                        ]
                    , Grid.row []
                        [ Grid.col
                            [ Col.md4 ]
                            [ text "Col md4" ]
                        , Grid.col
                            [ Col.md8 ]
                            [ text "Col md8" ]
                        ]
                    ]
                ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick CloseGridModal ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view state.gridModalVisibility
        , Util.calloutInfo
            [ p [] [ text "Try resizing the window with the modal open to observe the responsive behavior." ] ]
        , Util.code gridCode
        ]
    ]


gridCode : Html msg
gridCode =
    Util.toMarkdownElm """

--
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col

div []
    [ Button.button
        [ Button.outlineSuccess
        , Button.attrs [ onClick CloseModal ]
        ]
        [ text "Open modal" ]
        , Modal.config ModalMsg
            |> Modal.large
            |> Modal.h3 [] [ text "Modal grid header" ]
            |> Modal.body []
                [ Grid.containerFluid [ ]
                    [ Grid.row [ ]
                        [ Grid.col
                            [ Col.sm4 ] [ text "Col sm4" ]
                        , Grid.col
                            [ Col.sm8 ] [ text "Col sm8" ]
                        ]
                    , Grid.row [ ]
                        [ Grid.col
                            [ Col.md4 ] [ text "Col md4" ]
                        , Grid.col
                            [ Col.md8 ] [ text "Col md8" ]
                        ]
                    ]
                ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick CloseModal ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view model.modalVisibility
        ]
"""


animated : State -> List (Html Msg)
animated state =
    [ h2 [] [ text "Modals with Animations" ]
    , p [] [ text "Modals support fade/slide animations when showing/closing. To support animations a bit more wiring is needed, that's why this is not on by default." ]
    , Util.example
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick ShowAnimatedModal ]
            ]
            [ text "Open modal" ]
        , Modal.config CloseAnimatedModal
            |> Modal.withAnimation AnimateAnimatedModal
            |> Modal.small
            |> Modal.h3 [] [ text "Modal header" ]
            |> Modal.body [] [ p [] [ text "This is a modal for you !" ] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    , Button.attrs [ onClick <| AnimateAnimatedModal Modal.hiddenAnimated ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view state.animatedModalVisibility
        ]
    , Util.code animatedCode
    ]


animatedCode : Html msg
animatedCode =
    Util.toMarkdownElm """


-- Extend messages to have a message for animations


type Msg
    = CloseModal
    | ShowModal
    | AnimateModal Modal.Visibility



-- Add a subscription to support animations.
-- DON'T forget this, otherwise closing will not work as expected !
subscriptions : Model -> Sub msg
    subscriptions model =
        Sub.batch
            [ Modal.subscriptions model.modalVisibility AnimateModal ]


-- Handle modal messages in your update function to enable showing and closing

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        CloseModal ->
            ( { model | modalVisibility = Modal.hidden }, Cmd.none )

        ShowModal ->
            ( { model | modalVisibility = Modal.shown }, Cmd.none )


        -- Add handling of the animation related messages
        AnimateModal visibility ->
            ( { model | modalVisibility = visibility }, Cmd.none )


-- Configure your modal view using pipeline friendly functions.

view : Model -> Html msg
view model =
    div []
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ShowModal ] ]
            ]
            [ text "Open modal"]
        , Modal.config CloseModal
            -- Configure the modal to use animations providing the new AnimateModal msg
            |> Modal.withAnimation AnimateModal
            |> Modal.small
            |> Modal.h3 [] [ text "Modal header" ]
            |> Modal.body [] [ p [] [ text "This is a modal for you !"] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlinePrimary
                    -- If you want the custom close button to use animations;
                    -- you should use the AnimateModal msg and provide it with the Modal.hiddenAnimated visibility
                    , Button.attrs [ onClick <| AnimateModal Modal.hiddenAnimated ]
                    ]
                    [ text "Close" ]
                ]
            |> Modal.view model.modalVisibility
        ]

"""
