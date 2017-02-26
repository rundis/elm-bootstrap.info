module Route exposing (decode, encode, clickTo, Route(..))


import UrlParser exposing (Parser, parseHash, s, top, (</>))
import Navigation exposing (Location)

import Html
import Html.Attributes as Attr
import Html.Events as Events exposing (defaultOptions)
import Json.Decode


type Route
    = Home
    | Grid
    | Table
    | Progress
    | Alert
    | Badge
    | ListGroup
    | Tab
    | Card
    | Button
    | Dropdown
    | Accordion
    | Modal
    | Navbar
    | Form
    | NotFound


routeParser : Parser (Route -> a) a
routeParser =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map Grid (s "grid")
        , UrlParser.map Table (s "table")
        , UrlParser.map Progress (s "progress")
        , UrlParser.map Alert (s "alert")
        , UrlParser.map Badge (s "badge")
        , UrlParser.map ListGroup (s "listgroup")
        , UrlParser.map Tab (s "tab")
        , UrlParser.map Card (s "card")
        , UrlParser.map Button (s "button")
        , UrlParser.map Dropdown (s "dropdown")
        , UrlParser.map Accordion (s "accordion")
        , UrlParser.map Modal (s "modal")
        , UrlParser.map Navbar (s "navbar")
        , UrlParser.map Form (s "form")
        ]

decode : Location -> Maybe Route
decode location =
    UrlParser.parsePath routeParser location


encode : Route -> String
encode route =
    case route of
        Home ->
            "/"

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

        Tab ->
            "/tab"

        Card ->
            "/card"

        Button ->
            "/button"

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

        NotFound ->
            "/notfound"




clickTo : Route -> (String -> msg) -> List (Html.Attribute msg)
clickTo route pageChengeMsg =
    [ Attr.href (encode route)
    , onPreventDefaultClick (encode route |> pageChengeMsg )
    ]


onPreventDefaultClick : msg -> Html.Attribute msg
onPreventDefaultClick message =
    Events.onWithOptions "click"
        { defaultOptions | preventDefault = True }
        ( preventDefault2
            |> Json.Decode.andThen (maybePreventDefault message)
        )


preventDefault2 : Json.Decode.Decoder Bool
preventDefault2 =
    Json.Decode.map2
        (invertedOr)
        (Json.Decode.field "ctrlKey" Json.Decode.bool)
        (Json.Decode.field "metaKey" Json.Decode.bool)


maybePreventDefault : msg -> Bool -> Json.Decode.Decoder msg
maybePreventDefault msg preventDefault =
    case preventDefault of
        True ->
            Json.Decode.succeed msg

        False ->
            Json.Decode.fail "Normal link"


invertedOr : Bool -> Bool -> Bool
invertedOr x y =
    not (x || y)
