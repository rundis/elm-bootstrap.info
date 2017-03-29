port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Navigation exposing (Location)
import Route
import Globals
import Bootstrap.Navbar as Navbar
import Page.NotFound as NotFound
import Page.Home as PHome
import Page.Table as Table
import Page.Progress as Progress
import Page.Grid as Grid
import Page.Alert as Alert
import Page.Badge as Badge
import Page.ListGroup as ListGroup
import Page.Tab as Tab
import Page.Card as Card
import Page.Button as Button
import Page.ButtonGroup as ButtonGroup
import Page.Dropdown as Dropdown
import Page.Accordion as Accordion
import Page.Modal as Modal
import Page.Navbar as PageNav
import Page.Form as Form
import Page.InputGroup as InputGroup
import Page.Popover as Popover
import Page.GettingStarted as GettingStarted
import Util
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col


type alias Model =
    { route : Route.Route
    , navbarState : Navbar.State
    , tableState : Table.State
    , progressState : Progress.State
    , gridState : Grid.State
    , tabState : Tab.State
    , dropdownState : Dropdown.State
    , accordionState : Accordion.State
    , modalState : Modal.State
    , pageNavState : PageNav.State
    , buttonGroupState : ButtonGroup.State
    , popoverState : Popover.State
    }


type Msg
    = UrlChange Location
    | PageChange String
    | NavbarMsg Navbar.State
    | TableMsg Table.State
    | ProgressMsg Progress.State
    | GridMsg Grid.State
    | TabMsg Tab.State
    | DropdownMsg Dropdown.State
    | AccordionMsg Accordion.State
    | ModalMsg Modal.State
    | PageNavMsg PageNav.State
    | ButtonGroupMsg ButtonGroup.State
    | PopoverMsg Popover.State


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState NavbarMsg

        ( pageNavState, pageNavCmd ) =
            PageNav.initialState PageNavMsg

        ( model, urlCmd ) =
            urlUpdate location
                { route = Route.NotFound
                , navbarState = navbarState
                , tableState = Table.initialState
                , progressState = Progress.initialState
                , gridState = Grid.initialState
                , tabState = Tab.initialState
                , dropdownState = Dropdown.initialState
                , accordionState = Accordion.initialState
                , modalState = Modal.initialState
                , pageNavState = pageNavState
                , buttonGroupState = ButtonGroup.initialState
                , popoverState = Popover.initialState
                }
    in
        ( model, Cmd.batch [ navbarCmd, urlCmd, pageNavCmd ] )


main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Navbar.subscriptions model.navbarState NavbarMsg
        , Tab.subscriptions model.tabState TabMsg
        , Dropdown.subscriptions model.dropdownState DropdownMsg
        , Accordion.subscriptions model.accordionState AccordionMsg
        , PageNav.subscriptions model.pageNavState PageNavMsg
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            urlUpdate location model

        PageChange url ->
            ( model, Navigation.newUrl url )

        NavbarMsg state ->
            ( { model | navbarState = state }, Cmd.none )

        TableMsg state ->
            ( { model | tableState = state }, Cmd.none )

        ProgressMsg state ->
            ( { model | progressState = state }, Cmd.none )

        GridMsg state ->
            ( { model | gridState = state }, Cmd.none )

        TabMsg state ->
            ( { model | tabState = state }, Cmd.none )

        DropdownMsg state ->
            ( { model | dropdownState = state }, Cmd.none )

        AccordionMsg state ->
            ( { model | accordionState = state }, Cmd.none )

        ModalMsg state ->
            ( { model | modalState = state }, Cmd.none )

        ButtonGroupMsg state ->
            ( { model | buttonGroupState = state }, Cmd.none )

        PopoverMsg state ->
            ( { model | popoverState = state }, Cmd.none )

        PageNavMsg state ->
            ( { model | pageNavState = state }, Cmd.none )


urlUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
urlUpdate location model =
    case Route.decode location of
        Nothing ->
            ( { model | route = Route.NotFound }, Cmd.none )

        Just route ->
            ( { model | route = route }, updateAnalytics <| Route.encode route )


port updateAnalytics: String -> Cmd msg


view : Model -> Html Msg
view model =
    div
        []
        ( [ viewMenu model ]
         ++ viewPage model
         ++ [ viewFooter ]
        )


viewMenu : Model -> Html Msg
viewMenu model =
    Navbar.config NavbarMsg
        |> Navbar.container
        |> Navbar.collapseSmall
        |> Navbar.withAnimation
        |> Navbar.lightCustomClass "bd-navbar"
        |> Navbar.brand
            ( Route.clickTo Route.Home PageChange )
            [ text "Elm Bootstrap" ]
        |> Navbar.items
            [ menuLink "Getting started" Route.GettingStarted
            , menuLink "Modules" Route.Alert
            ]
        |> Navbar.view model.navbarState


menuLink : String -> Route.Route -> Navbar.Item Msg
menuLink name route =
    Navbar.itemLink
        (Route.clickTo route PageChange )
        [ text name ]


viewPage : Model -> List (Html Msg)
viewPage model =
    let
        wrap = wrapPageLayout model
    in
        case model.route of
            Route.Home ->
                PHome.view PageChange

            Route.GettingStarted ->
                GettingStarted.view PageChange

            Route.Grid ->
                Grid.view model.gridState GridMsg
                    |> wrap

            Route.Card ->
                Card.view |> wrap

            Route.Table ->
                Table.view model.tableState TableMsg
                    |> wrap

            Route.Progress ->
                Progress.view model.progressState ProgressMsg
                    |> wrap

            Route.Alert ->
                Alert.view
                    |> wrap

            Route.Badge ->
                Badge.view
                    |> wrap

            Route.ListGroup ->
                ListGroup.view
                    |> wrap

            Route.Tab ->
                Tab.view model.tabState TabMsg
                    |> wrap

            Route.Button ->
                Button.view |> wrap

            Route.ButtonGroup ->
                ButtonGroup.view model.buttonGroupState ButtonGroupMsg
                    |> wrap

            Route.Dropdown ->
                Dropdown.view model.dropdownState DropdownMsg
                    |> wrap

            Route.Accordion ->
                Accordion.view model.accordionState AccordionMsg
                    |> wrap

            Route.Modal ->
                Modal.view model.modalState ModalMsg
                    |> wrap

            Route.Navbar ->
                PageNav.view model.pageNavState PageNavMsg
                    |> wrap

            Route.Form ->
                Form.view |> wrap

            Route.InputGroup ->
                InputGroup.view |> wrap

            Route.Popover ->
                Popover.view model.popoverState PopoverMsg
                    |> wrap

            Route.NotFound ->
                NotFound.view


wrapPageLayout : Model -> Util.PageContent Msg -> List (Html Msg)
wrapPageLayout model pageContent =
    [ Util.simplePageHeader pageContent.title pageContent.description
    , Grid.container []
        [ Grid.row []
            [ Grid.col
                [ Col.xs12, Col.md2, Col.pushMd10, Col.attrs [ class "bd-sidebar" ] ]
                [ viewSidebar model ]
            , Grid.col
                [ Col.xs12, Col.md10, Col.pullMd2, Col.attrs [ class "bd-content"] ]
                pageContent.children
            ]
        ]
    ]



viewSidebar : Model -> Html Msg
viewSidebar model =
    let
        link page title =
            sidebarLink page title (page == model.route)
    in
        nav [ class "bd-links" ]
            [ div [ class "bd-toc-item active" ]
                [ text "Modules"
                , ul [ class "nav bd-sidenav" ]
                   [ link Route.Accordion "Accordion"
                   , link Route.Alert "Alert"
                   , link Route.Badge "Badge"
                   , link Route.Button "Button"
                   , link Route.ButtonGroup "Button group"
                   , link Route.Card "Card"
                   , link Route.Dropdown "Dropdown"
                   , link Route.Form "Form"
                   , link Route.Grid "Grid"
                   , link Route.InputGroup "Input group"
                   , link Route.ListGroup "List group"
                   , link Route.Modal "Modal"
                   , link Route.Navbar "Navbar"
                   , link Route.Popover "Popover"
                   , link Route.Progress "Progress"
                   , link Route.Tab "Tab"
                   , link Route.Table "Table"
                   ]
                ]
            ]

sidebarLink : Route.Route -> String -> Bool -> Html Msg
sidebarLink page label isActive =
    li
        (if isActive then
             [ class "active bd-sidenav-active" ]
           else
                []
        )
        [ a (Route.clickTo page PageChange )
            [ text label ]
        ]



viewFooter : Html Msg
viewFooter =
    footer [ class "bd-footer text-muted" ]
        [ div [ class "container" ]
            [ ul [ class "bd-footer-links" ]
                [ li []
                    [ i [class "fa fa-github", attribute "aria-hidden" "true" ] []
                    , externalLink Globals.githubDocsUrl " Docs"
                    ]
                , li []
                    [ i [class "fa fa-github", attribute "aria-hidden" "true" ] []
                    , externalLink Globals.githubSourceUrl " Source"
                    ]
                , li []
                    [ externalLink Globals.packageUrl "Package"
                    ]
                , li []
                    [ externalLink Globals.bootstrapUrl "Bootstrap 4" ]
                ]

            , p [] [ text "Created by Magnus Rundberget "
                   , i [class "fa fa-twitter", attribute "aria-hidden" "true" ] []
                   , externalLink "https://twitter.com/mrundberget" "mrundberget"
                   , text " with help from contributor heroes !"
                   ]
            , p [] [ text "The code is licensed BSD-3 and the documentation is licensed CC BY 3.0." ]

            ]
        ]


externalLink : String -> String -> Html msg
externalLink url label =
    a [ href url, target "_blank"]
        [ text label ]
