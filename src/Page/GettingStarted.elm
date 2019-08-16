module Page.GettingStarted exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Util


view : List (Html msg)
view =
    [ Util.simplePageHeader
        "Getting started"
        """A brief overview of Elm Bootstrap, how to use it and some examples."""
    , Util.pageContent
        (quickStart
            ++ embedding
            ++ conventions
            ++ example
        )
    ]


quickStart : List (Html msg)
quickStart =
    [ h2 [] [ text "Quick start" ]
    , p [] [ text """The easiest way to get started is to use the Bootstrap.CDN module to inline the Bootstrap CSS.
                  This way you can quickly get up and running using elm-reactor.""" ]
    , h4 [] [ text "Start a new project" ]
    , Util.code setupCode
    , h4 [] [ text "Module code" ]
    , p [] [ text "Create a Main.elm file with the following content" ]
    , Util.code quickStartCode
    , h4 [] [ text "Running the example" ]
    , Util.code runQuickStartCode
    , p [] [ text "Navigate to http://localhost:8000/Main.elm" ]
    , Util.calloutWarning
        [ p [] [ text """Don't use this method when you want to deploy your app for real life usage.
                         It's not very efficient, the payload for your page will be pretty big and you want get the benefits of caching the CSS.""" ]
        ]
    ]


setupCode : Html msg
setupCode =
    Util.toMarkdown """
```bash

mkdir bootstrap-example
cd bootstrap-example
elm install rundis/elm-bootstrap

```
"""


quickStartCode : Html msg
quickStartCode =
    Util.toMarkdownElm """
module Main exposing (main)

import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid


main =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col []
                [ text "Some content for my view here..."]
            ]

        ]
"""


runQuickStartCode : Html msg
runQuickStartCode =
    Util.toMarkdown """
```bash

elm reactor

```
"""


embedding : List (Html msg)
embedding =
    [ h2 [] [ text "Embedding" ]
    , p [] [ text """For any serious web application you will be embedding your Elm application in an Html page.
                  When you do, just remember to add the CSS, either as a server asset or just use a CDN.""" ]
    , Util.code embeddingCode
    ]


embeddingCode : Html msg
embeddingCode =
    Util.toMarkdown """
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      </head>
      <body>
        <h1>Hello, world!</h1>

        <!-- Your Elm application  -->
        <script src="elm.js"></script>
      </body>
    </html>
"""


conventions : List (Html msg)
conventions =
    [ h2 [] [ text "Conventions" ]
    , p [] [ text """Just a small note of conventions promoted when using Elm Bootstrap and a quick overview of common conventions used by Elm Bootstrap itself.""" ]
    , h3 [] [ text "Alias imports" ]
    , Util.code aliasCode
    , Util.calloutInfo
        [ text """By aliasing your Bootstrap related imports, it will usually be easier to read your code and understand where different functions are coming from.
                  You also reduce the chance of naming conflicts with other libraries.
                  The API for Elm Bootstrap has been designed with aliasing in mind and you will see aliases used throughout in all the examples.
               """
        ]
    , h3 [] [ text "Options and attributes" ]
    , p [] [ text """Most Html element creating functions in Elm bootstrap take two list arguments. The first is a list of options, the second is a list of child items or a list of child elements.
                  It's probably easier to illustrate with an annotated Code example first to explain further.""" ]
    , Util.code optionsCode
    , Util.calloutInfo
        [ ul []
            [ textLi "You create/specify options, by calling functions on the relevant module."
            , textLi "<module>.attrs is an escape hatch offered to allow you to provide further customizations when the exposed options are not sufficient for your use case."
            , textLi "Options are passed in as list, if you specify the same option more than once, the last one will be the one that is applied."
            , li []
                [ text "When you specify options that address the same area, the same logic applies"
                , ul []
                    [ textLi "If you specify an option that says that for the smallest screensize you should center vertically."
                    , textLi "Then you add another option saying that for the smallest screensize you should center content top, the last one of these will be the one applied."
                    ]
                ]
            , textLi "Many elements have default options, which you can override by specifying options in the options list argument."
            ]
        ]
    ]


aliasCode : Html msg
aliasCode =
    Util.toMarkdownElm """

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Row as Row
import Bootstrap.Grid.Col as Col


myViewFn =
    Grid.row [ Row.centerXs ]
        [ Grid.col [ Col.xs2 ]
            [ text "Col 1" ]
        , Grid.col [ Col.xs4 ]
            [ text "Col 2" ]
        ]

"""


optionsCode : Html msg
optionsCode =
    Util.toMarkdownElm """
Grid.row
    [ Row.centerXs ] -- Row.centerXs creates a Row.Option

    -- The second argument to row is a list of Grid.Column items
    [ Grid.col
        [ Col.xs12
        , Col.attrs [ class "custom-class" ] -- <module>.attrs function, creates an option to specify a list of custom Elm Html attributes.
        ]
        [ text "Some full width column."]
    ]
"""


example : List (Html msg)
example =
    [ h2 [] [ text "Example page" ]
    , p [] [ text """In the example below we've made a super simple single page application.
                     It contains basic navigation and a couple of example pages. """ ]
    , h3 [] [ text "Elm code" ]
    , Util.code exampleElmCode
    , h3 [] [ text "Html Index Page" ]
    , Util.code exampleHtmlCode
    ]


exampleElmCode : Html msg
exampleElmCode =
    Util.toMarkdownElm """
module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser.Navigation as Navigation
import Browser exposing (UrlRequest)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, s, top)
import Bootstrap.Navbar as Navbar
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Card as Card
import Bootstrap.Card.Block as Block
import Bootstrap.Button as Button
import Bootstrap.ListGroup as Listgroup
import Bootstrap.Modal as Modal


type alias Flags =
    {}

type alias Model =
    { navKey : Navigation.Key
    , page : Page
    , navState : Navbar.State
    , modalVisibility : Modal.Visibility
    }

type Page
    = Home
    | GettingStarted
    | Modules
    | NotFound


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        }

init : Flags -> Url -> Navigation.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        ( navState, navCmd ) =
            Navbar.initialState NavMsg

        ( model, urlCmd ) =
            urlUpdate url { navKey = key, navState = navState, page = Home, modalVisibility= Modal.hidden }
    in
        ( model, Cmd.batch [ urlCmd, navCmd ] )




type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavMsg Navbar.State
    | CloseModal
    | ShowModal


subscriptions : Model -> Sub Msg
subscriptions model =
    Navbar.subscriptions model.navState NavMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink req ->
             case req of
                 Browser.Internal url ->
                     ( model, Navigation.pushUrl model.navKey <| Url.toString url )

                 Browser.External href ->
                     ( model, Navigation.load href )


        UrlChange url ->
            urlUpdate url model

        NavMsg state ->
            ( { model | navState = state }
            , Cmd.none
            )

        CloseModal ->
            ( { model | modalVisibility = Modal.hidden }
            , Cmd.none
            )

        ShowModal ->
            ( { model | modalVisibility = Modal.shown }
            , Cmd.none
            )



urlUpdate : Url -> Model -> ( Model, Cmd Msg )
urlUpdate url model =
    case decode url of
        Nothing ->
            ( { model | page = NotFound }, Cmd.none )

        Just route ->
            ( { model | page = route }, Cmd.none )


decode : Url -> Maybe Page
decode url =
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
    |> UrlParser.parse routeParser


routeParser : Parser (Page -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map GettingStarted (s "getting-started")
        , UrlParser.map Modules (s "modules")
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Elm Bootstrap"
    , body =
        [ div []
            [ menu model
            , mainContent model
            , modal model
            ]
        ]
    }



menu : Model -> Html Msg
menu model =
    Navbar.config NavMsg
        |> Navbar.withAnimation
        |> Navbar.container
        |> Navbar.brand [ href "#" ] [ text "Elm Bootstrap" ]
        |> Navbar.items
            [ Navbar.itemLink [ href "#getting-started" ] [ text "Getting started" ]
            , Navbar.itemLink [ href "#modules" ] [ text "Modules" ]
            ]
        |> Navbar.view model.navState


mainContent : Model -> Html Msg
mainContent model =
    Grid.container [] <|
        case model.page of
            Home ->
                pageHome model

            GettingStarted ->
                pageGettingStarted model

            Modules ->
                pageModules model

            NotFound ->
                pageNotFound


pageHome : Model -> List (Html Msg)
pageHome model =
    [ h1 [] [ text "Home" ]
    , Grid.row []
        [ Grid.col []
            [ Card.config [ Card.outlinePrimary ]
                |> Card.headerH4 [] [ text "Getting started" ]
                |> Card.block []
                    [ Block.text [] [ text "Getting started is real easy. Just click the start button." ]
                    , Block.custom <|
                        Button.linkButton
                            [ Button.primary, Button.attrs [ href "#getting-started" ] ]
                            [ text "Start" ]
                    ]
                |> Card.view
            ]
        , Grid.col []
            [ Card.config [ Card.outlineDanger ]
                |> Card.headerH4 [] [ text "Modules" ]
                |> Card.block []
                    [ Block.text [] [ text "Check out the modules overview" ]
                    , Block.custom <|
                        Button.linkButton
                            [ Button.primary, Button.attrs [ href "#modules" ] ]
                            [ text "Module" ]
                    ]
                |> Card.view
            ]
        ]
    ]


pageGettingStarted : Model -> List (Html Msg)
pageGettingStarted model =
    [ h2 [] [ text "Getting started" ]
    , Button.button
        [ Button.success
        , Button.large
        , Button.block
        , Button.attrs [ onClick ShowModal ]
        ]
        [ text "Click me" ]
    ]


pageModules : Model -> List (Html Msg)
pageModules model =
    [ h1 [] [ text "Modules" ]
    , Listgroup.ul
        [ Listgroup.li [] [ text "Alert" ]
        , Listgroup.li [] [ text "Badge" ]
        , Listgroup.li [] [ text "Card" ]
        ]
    ]


pageNotFound : List (Html Msg)
pageNotFound =
    [ h1 [] [ text "Not found" ]
    , text "SOrry couldn't find that page"
    ]


modal : Model -> Html Msg
modal model =
    Modal.config CloseModal
        |> Modal.small
        |> Modal.h4 [] [ text "Getting started ?" ]
        |> Modal.body []
            [ Grid.containerFluid []
                [ Grid.row []
                    [ Grid.col
                        [ Col.xs6 ]
                        [ text "Col 1" ]
                    , Grid.col
                        [ Col.xs6 ]
                        [ text "Col 2" ]
                    ]
                ]
            ]
        |> Modal.view model.modalVisibility

"""


exampleHtmlCode : Html msg
exampleHtmlCode =
    Util.toMarkdown """
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      </head>
      <body>
        <script>
            var app = Elm.Main.init({})
            // you can use ports and stuff here
        </script>
      </body>
    </html>
"""


textLi : String -> Html msg
textLi str =
    li [] [ text str ]
