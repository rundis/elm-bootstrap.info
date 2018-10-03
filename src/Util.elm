module Util exposing (PageContent, calloutInfo, calloutWarning, code, example, exampleAndRow, exampleRow, pageContent, simplePageHeader, toMarkdown, toMarkdownElm)

import Html exposing (..)
import Html.Attributes exposing (..)
import Markdown


type alias PageContent msg =
    { title : String
    , description : String
    , children : List (Html msg)
    }


simplePageHeader : String -> String -> Html msg
simplePageHeader title intro =
    div
        [ class "bd-pageheader" ]
        [ div
            [ class "container" ]
            [ h1 [] [ text title ]
            , p
                [ class "lead" ]
                [ text intro
                ]
            ]
        ]


pageContent : List (Html msg) -> Html msg
pageContent children =
    div [ class "container" ]
        [ div
            [ class "row" ]
            [ div
                [ class "col bd-content" ]
                children
            ]
        ]


example : List (Html msg) -> Html msg
example children =
    div [ class "bd-example" ]
        children


exampleRow : List (Html msg) -> Html msg
exampleRow children =
    div [ class "bd-example-row" ]
        children


exampleAndRow : List (Html msg) -> Html msg
exampleAndRow children =
    div [ class "bd-example bd-example-row" ]
        children


toMarkdown : String -> Html.Html msg
toMarkdown code_ =
    Markdown.toHtml
        []
        code_


toMarkdownElm : String -> Html.Html msg
toMarkdownElm code_ =
    Markdown.toHtml
        []
        ("```elm" ++ code_ ++ "```")


code : Html.Html msg -> Html.Html msg
code codeElem =
    div
        [ class "highlight" ]
        [ codeElem ]


calloutInfo : List (Html msg) -> Html msg
calloutInfo children =
    div [ class "bd-callout bd-callout-info" ] children


calloutWarning : List (Html msg) -> Html msg
calloutWarning children =
    div [ class "bd-callout bd-callout-warning" ] children
