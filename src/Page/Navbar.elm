module Page.Navbar exposing
    ( Msg
    , State
    , initialState
    , subscriptions
    , update
    , view
    )

import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Navbar as Navbar
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Json.Decode as Decode
import Util


type alias State =
    { basicState : Navbar.State
    , customState : Navbar.State
    }


type Msg
    = NoOp
    | BasicMsg Navbar.State
    | CustomMsg Navbar.State


initialState : ( State, Cmd Msg )
initialState =
    let
        ( basicState, cmdBasic ) =
            Navbar.initialState BasicMsg

        ( customState, cmdCustom ) =
            Navbar.initialState CustomMsg
    in
    ( { basicState = basicState
      , customState = customState
      }
    , Cmd.batch [ cmdBasic, cmdCustom ]
    )


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Navbar.subscriptions state.basicState BasicMsg
        , Navbar.subscriptions state.customState CustomMsg
        ]


update : Msg -> State -> State
update msg state =
    case msg of
        NoOp ->
            state

        BasicMsg newState ->
            { state | basicState = newState }

        CustomMsg newState ->
            { state | customState = newState }


view : State -> Util.PageContent Msg
view state =
    { title = "Navbar"
    , description =
        """The navbar is a wrapper that positions branding, navigation, and other elements in a concise header.
        It’s easily extensible and supports responsive behavior."""
    , children =
        basic state
            ++ custom state
    }


basic : State -> List (Html Msg)
basic state =
    [ h2 [] [ text "Basic example" ]
    , p [] [ text """Navbars supports a variety of content. We'll start off with a relatively simple example.
                  Since navbars require state and special care to handle responsibe behavior, there is a bit of wiring
                  needed to set one up.""" ]
    , Util.example
        [ Navbar.config BasicMsg
            |> Navbar.withAnimation
            |> Navbar.collapseMedium
            |> Navbar.brand [ href "#", noOpClick ] [ text "Brand" ]
            |> Navbar.items
                [ Navbar.itemLink [ href "#", noOpClick ] [ text "Item 1" ]
                , Navbar.itemLink [ href "#", noOpClick ] [ text "Item 2" ]
                ]
            |> Navbar.view state.basicState
        , Util.calloutInfo
            [ p [] [ text " Try resizing the window width to see the menu collapse behavior" ] ]
        ]
    , Util.code basicCode
    , Util.calloutInfo
        [ h3 [] [ text "Navbar composition" ]
        , ul []
            [ textLi "You start out by using the config function providing the navbar *Msg as it's argument."
            , textLi "Then you compose your modal with optional options, brand, menu items (links or dropdowns) and/or customItems (see next example)."
            , textLi "Finally to turn he navbar into Elm Html you call the view function passing it the current state of the navbar."
            ]
        ]
    ]


noOpClick =
    Events.custom "click" <| Decode.fail "JALLA"



--{ message = NoOp, stopPropagation = True, preventDefault = True }


textLi : String -> Html msg
textLi str =
    li [] [ text str ]


basicCode : Html msg
basicCode =
    Util.toMarkdownElm """

import Bootstrap.Navbar as Navbar

-- You need to keep track of the view state for the navbar in your model


type alias Model =
    { navbarState : Navbar.State }



-- The navbar needs to know the initial window size, so the inital state for a navbar requires a command to be run by the Elm runtime


initialState : ( Model, Cmd Msg )
initialState =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState NavbarMsg
    in
    ( { navbarState = navbarState }, navbarCmd )



-- Define a message for the navbar


type Msg
    = NavbarMsg Navbar.State



-- You need to handle navbar messages in your update function to step the navbar state forward


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )


view : Model -> Html Msg
view model =
    Navbar.config NavbarMsg
        |> Navbar.withAnimation
        |> Navbar.brand [ href "#" ] [ text "Brand" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#" ] [ text "Item 1" ]
            , Navbar.itemLink [ href "#" ] [ text "Item 2" ]
            ]
        |> Navbar.view model.navbarState



-- If you use animations as above or you use dropdowns in your navbar you need to configure subscriptions too


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navbarState NavbarMsg

"""


custom : State -> List (Html Msg)
custom state =
    [ h2 [] [ text "Options, dropdowns and custom content" ]
    , p [] [ text """You can twist and tweak the navbar quite a bit using a pipeline friendly syntax.
                  You may configure coloring with handy helper functions, add dropdowns as menu items and you can add a few flavors of custom content as well.
                  """ ]
    , Util.example
        [ Grid.container []
            [ Navbar.config CustomMsg
                |> Navbar.withAnimation
                |> Navbar.collapseMedium
                |> Navbar.info
                |> Navbar.brand
                    [ href "#", noOpClick ]
                    [ img
                        [ src "assets/images/elm-bootstrap.svg"
                        , class "d-inline-block align-top"
                        , style "width" "30px"
                        ]
                        []
                    , text " Elm"
                    ]
                |> Navbar.items
                    [ Navbar.itemLink [ href "#", noOpClick ] [ text "Item 1" ]
                    , Navbar.dropdown
                        { id = "mydropdown"
                        , toggle = Navbar.dropdownToggle [] [ text "Dropdown" ]
                        , items =
                            [ Navbar.dropdownHeader [ text "Heading" ]
                            , Navbar.dropdownItem
                                [ href "#", noOpClick ]
                                [ text "Drop item 1" ]
                            , Navbar.dropdownItem
                                [ href "#", noOpClick ]
                                [ text "Drop item 2" ]
                            , Navbar.dropdownDivider
                            , Navbar.dropdownItem
                                [ href "#", noOpClick ]
                                [ text "Drop item 3" ]
                            ]
                        }
                    ]
                |> Navbar.customItems
                    [ Navbar.formItem []
                        [ Input.text [ Input.attrs [ placeholder "enter" ] ]
                        , Button.button
                            [ Button.success
                            , Button.attrs [ Spacing.ml2Sm ]
                            ]
                            [ text "Search" ]
                        ]
                    , Navbar.textItem [ Spacing.ml2Sm, class "muted" ] [ text "Text" ]
                    ]
                |> Navbar.view state.customState
            ]
        ]
    , Util.code customCode
    ]


customCode : Html msg
customCode =
    Util.toMarkdownElm """
Grid.container []
    -- Wrap in a container to center the navbar
    [ Navbar.config NavbarMsg
        |> Navbar.withAnimation
        |> Navbar.collapseMedium
        -- Collapse menu at the medium breakpoint
        |> Navbar.info
        -- Customize coloring
        |> Navbar.brand
            -- Add logo to your brand with a little styling to align nicely
            [ href "#" ]
            [ img
                [ src "assets/images/elm-bootstrap.svg"
                , class "d-inline-block align-top"
                , style "width" "30px"
                ]
                []
            , text " Elm Bootstrap"
            ]
        |> Navbar.items
            [ Navbar.itemLink
                [ href "#" ]
                [ text "Item 1" ]
            , Navbar.dropdown
                -- Adding dropdowns is pretty simple
                { id = "mydropdown"
                , toggle = Navbar.dropdownToggle [] [ text "My dropdown" ]
                , items =
                    [ Navbar.dropdownHeader [ text "Heading" ]
                    , Navbar.dropdownItem
                        [ href "#" ]
                        [ text "Drop item 1" ]
                    , Navbar.dropdownItem
                        [ href "#" ]
                        [ text "Drop item 2" ]
                    , Navbar.dropdownDivider
                    , Navbar.dropdownItem
                        [ href "#" ]
                        [ text "Drop item 3" ]
                    ]
                }
            ]
        |> Navbar.customItems
            [ Navbar.formItem []
                [ Input.text [ Input.attrs [ placeholder "enter" ] ]
                , Button.button
                    [ Button.success
                    , Button.attrs [ Spacing.ml2Sm ]
                    ]
                    [ text "Search" ]
                ]
            , Navbar.textItem [ Spacing.ml2Sm, class "muted" ] [ text "Text" ]
            ]
        |> Navbar.view model.navbarState
    ]
"""
