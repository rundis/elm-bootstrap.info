module Route exposing (Route(..), clickTo, decode, encode)

import Html
import Html.Attributes as Attr
import Html.Events as Events exposing (preventDefaultOn)
import Json.Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, custom, fragment, s, top)


type Route
    = Home
    | GettingStarted
    | Grid
    | Table
    | Progress
    | Alert
    | Badge
    | ListGroup
    | Tab (Maybe String)
    | Card
    | Button
    | ButtonGroup
    | Dropdown
    | Accordion
    | Modal
    | Navbar
    | Form
    | InputGroup
    | Popover
    | Carousel
    | Spinner
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map GettingStarted (s "getting-started")
        , UrlParser.map Grid (s "grid")
        , UrlParser.map Table (s "table")
        , UrlParser.map Progress (s "progress")
        , UrlParser.map Alert (s "alert")
        , UrlParser.map Badge (s "badge")
        , UrlParser.map ListGroup (s "listgroup")
        , UrlParser.map Tab (s "tab" </> fragment identity)
        , UrlParser.map Card (s "card")
        , UrlParser.map Button (s "button")
        , UrlParser.map ButtonGroup (s "buttongroup")
        , UrlParser.map Dropdown (s "dropdown")
        , UrlParser.map Accordion (s "accordion")
        , UrlParser.map Modal (s "modal")
        , UrlParser.map Navbar (s "navbar")
        , UrlParser.map Form (s "form")
        , UrlParser.map InputGroup (s "inputgroup")
        , UrlParser.map Popover (s "popover")
        , UrlParser.map Carousel (s "carousel")
        , UrlParser.map Spinner (s "spinner")
        ]


decode : Url -> Maybe Route
decode url =
    UrlParser.parse routeParser url


encode : Route -> String
encode route =
    case route of
        Home ->
            "/"

        GettingStarted ->
            "/getting-started"

        Grid ->
            "/grid"

        Table ->
            "/table"

        Progress ->
            "/progress"

        Alert ->
            "/alert"

        Badge ->
            "/badge"

        ListGroup ->
            "/listgroup"

        Tab _ ->
            "/tab"

        Card ->
            "/card"

        Button ->
            "/button"

        ButtonGroup ->
            "/buttongroup"

        Dropdown ->
            "/dropdown"

        Accordion ->
            "/accordion"

        Modal ->
            "/modal"

        Navbar ->
            "/navbar"

        Form ->
            "/form"

        InputGroup ->
            "/inputgroup"

        Popover ->
            "/popover"

        Carousel ->
            "/carousel"

        Spinner ->
            "/spinner"

        NotFound ->
            "/notfound"


clickTo : Route -> List (Html.Attribute msg)
clickTo route =
    [ Attr.href (encode route) ]
