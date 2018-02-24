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
import Page.Carousel as Carousel
import Page.GettingStarted as GettingStarted
import Util
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Msg exposing (..)
import Bootstrap.Popover as Pop


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
    , popBasic : Pop.State
    , popTop : Pop.State
    , popBottom : Pop.State
    , popLeft : Pop.State
    , popRight : Pop.State
    , carouselState : Carousel.State
    , inputGroupState : InputGroup.State
    , alertState : Alert.State
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        tabInitialState =
            case (Route.decode location) of
                Just (Route.Tab (Just hash)) ->
                    Tab.initialStateWithHash hash

                _ ->
                    Tab.initialState

        ( navbarState, navbarCmd ) =
            Navbar.initialState NavbarMsg

        ( pageNavState, pageNavCmd ) =
            PageNav.initialState

        ( model, urlCmd ) =
            urlUpdate location
                { route = Route.NotFound
                , navbarState = navbarState
                , tableState = Table.initialState
                , progressState = Progress.initialState
                , gridState = Grid.initialState
                , tabState = tabInitialState
                , dropdownState = Dropdown.initialState
                , accordionState = Accordion.initialState
                , modalState = Modal.initialState
                , pageNavState = pageNavState
                , buttonGroupState = ButtonGroup.initialState
                , popBasic = Pop.initialState
                , popLeft = Pop.initialState
                , popRight = Pop.initialState
                , popTop = Pop.initialState
                , popBottom = Pop.initialState
                , carouselState = Carousel.initialState
                , inputGroupState = InputGroup.initialState
                , alertState = Alert.initialState
                }
    in
        ( model, Cmd.batch [ navbarCmd, urlCmd, Cmd.map PageNavMsg pageNavCmd ] )


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
        , Sub.map TabMsg <| Tab.subscriptions model.tabState
        , Sub.map DropdownMsg <| Dropdown.subscriptions model.dropdownState
        , Sub.map AccordionMsg <| Accordion.subscriptions model.accordionState
        , Sub.map PageNavMsg <| PageNav.subscriptions model.pageNavState
        , Sub.map CarouselMsg <| Carousel.subscriptions model.carouselState
        , Sub.map ModalMsg <| Modal.subscriptions model.modalState
        , Sub.map InputGroupMsg <| InputGroup.subscriptions model.inputGroupState
        , Sub.map AlertMsg <| Alert.subscriptions model.alertState
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

        TabMsg subMsg ->
            ( { model | tabState = Tab.update subMsg model.tabState }, Cmd.none )

        DropdownMsg subMsg ->
            ( { model | dropdownState = Dropdown.update subMsg model.dropdownState }, Cmd.none )

        AccordionMsg subMsg ->
            ( { model | accordionState = Accordion.update subMsg model.accordionState }, Cmd.none )

        ModalMsg subMsg ->
            ( { model | modalState = Modal.update subMsg model.modalState }, Cmd.none )

        ButtonGroupMsg state ->
            ( { model | buttonGroupState = state }, Cmd.none )

        PageNavMsg subMsg ->
            ( { model | pageNavState = PageNav.update subMsg model.pageNavState }, Cmd.none )

        PopBasic state ->
            ( { model | popBasic = state }, Cmd.none )

        PopLeft state ->
            ( { model | popLeft = state }, Cmd.none )

        PopRight state ->
            ( { model | popRight = state }, Cmd.none )

        PopTop state ->
            ( { model | popTop = state }, Cmd.none )

        PopBottom state ->
            ( { model | popBottom = state }, Cmd.none )

        CarouselMsg subMsg ->
            ( { model | carouselState = Carousel.update subMsg model.carouselState }, Cmd.none )

        InputGroupMsg subMsg ->
            ( { model | inputGroupState = InputGroup.update subMsg model.inputGroupState }, Cmd.none )

        AlertMsg subMsg ->
            ( { model | alertState = Alert.update subMsg model.alertState }, Cmd.none )


urlUpdate : Navigation.Location -> Model -> ( Model, Cmd Msg )
urlUpdate location model =
    case Route.decode location of
        Nothing ->
            ( { model | route = Route.NotFound }, Cmd.none )

        Just route ->
            ( { model | route = route }, updateAnalytics <| Route.encode route )


port updateAnalytics : String -> Cmd msg


view : Model -> Html Msg
view model =
    div
        []
        ([ viewMenu model ]
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
            (Route.clickTo Route.Home PageChange)
            [ text "Elm Bootstrap" ]
        |> Navbar.items
            [ menuLink "Getting started" Route.GettingStarted
            , menuLink "Modules" Route.Alert
            ]
        |> Navbar.view model.navbarState


menuLink : String -> Route.Route -> Navbar.Item Msg
menuLink name route =
    Navbar.itemLink
        (Route.clickTo route PageChange)
        [ text name ]


viewPage : Model -> List (Html Msg)
viewPage model =
    let
        wrap =
            wrapPageLayout model
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
                Alert.view model.alertState
                    |> mapPageContent AlertMsg
                    |> wrap

            Route.Badge ->
                Badge.view
                    |> wrap

            Route.ListGroup ->
                ListGroup.view
                    |> wrap

            Route.Tab hash ->
                Tab.view model.tabState
                    |> mapPageContent TabMsg
                    |> wrap

            Route.Button ->
                Button.view |> wrap

            Route.ButtonGroup ->
                ButtonGroup.view model.buttonGroupState ButtonGroupMsg
                    |> wrap

            Route.Dropdown ->
                Dropdown.view model.dropdownState
                    |> mapPageContent DropdownMsg
                    |> wrap

            Route.Accordion ->
                Accordion.view model.accordionState
                    |> mapPageContent AccordionMsg
                    |> wrap

            Route.Modal ->
                Modal.view model.modalState
                    |> mapPageContent ModalMsg
                    |> wrap

            Route.Navbar ->
                PageNav.view model.pageNavState
                    |> mapPageContent PageNavMsg
                    |> wrap

            Route.Form ->
                Form.view |> wrap

            Route.InputGroup ->
                InputGroup.view model.inputGroupState
                    |> mapPageContent InputGroupMsg
                    |> wrap

            Route.Popover ->
                Popover.view model
                    |> wrap

            Route.Carousel ->
                Carousel.view model.carouselState
                    |> mapPageContent CarouselMsg
                    |> wrap

            Route.NotFound ->
                NotFound.view


mapPageContent : (msg -> Msg) -> Util.PageContent msg -> Util.PageContent Msg
mapPageContent toMsg content =
    { content | children = List.map (\c -> Html.map toMsg c) content.children }


wrapPageLayout : Model -> Util.PageContent Msg -> List (Html Msg)
wrapPageLayout model pageContent =
    [ Util.simplePageHeader pageContent.title pageContent.description
    , Grid.container []
        [ Grid.row []
            [ Grid.col
                [ Col.xs12, Col.md2, Col.pushMd10, Col.attrs [ class "bd-sidebar" ] ]
                [ viewSidebar model ]
            , Grid.col
                [ Col.xs12, Col.md10, Col.pullMd2, Col.attrs [ class "bd-content" ] ]
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
                    , link Route.Carousel "Carousel"
                    , link Route.Dropdown "Dropdown"
                    , link Route.Form "Form"
                    , link Route.Grid "Grid"
                    , link Route.InputGroup "Input group"
                    , link Route.ListGroup "List group"
                    , link Route.Modal "Modal"
                    , link Route.Navbar "Navbar"
                    , link Route.Popover "Popover"
                    , link Route.Progress "Progress"
                    , link (Route.Tab Nothing) "Tab"
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
        [ a (Route.clickTo page PageChange)
            [ text label ]
        ]


viewFooter : Html Msg
viewFooter =
    footer [ class "bd-footer text-muted" ]
        [ div [ class "container" ]
            [ ul [ class "bd-footer-links" ]
                [ li []
                    [ i [ class "fa fa-github", attribute "aria-hidden" "true" ] []
                    , externalLink Globals.githubDocsUrl " Docs"
                    ]
                , li []
                    [ i [ class "fa fa-github", attribute "aria-hidden" "true" ] []
                    , externalLink Globals.githubSourceUrl " Source"
                    ]
                , li []
                    [ externalLink Globals.packageUrl "Package"
                    ]
                , li []
                    [ externalLink Globals.bootstrapUrl "Bootstrap 4" ]
                ]
            , p []
                [ text "Created by Magnus Rundberget "
                , i [ class "fa fa-twitter", attribute "aria-hidden" "true" ] []
                , externalLink "https://twitter.com/mrundberget" "mrundberget"
                , text " with help from contributor heroes !"
                ]
            , p [] [ text "The code is licensed BSD-3 and the documentation is licensed CC BY 3.0." ]
            ]
        ]


externalLink : String -> String -> Html msg
externalLink url label =
    a [ href url, target "_blank" ]
        [ text label ]
