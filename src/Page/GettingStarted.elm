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
    [ Col.col
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
    , iframe
        [ src "https://ellie-app.com/embed/53W4KNyCZa1/0"
        , style "width" "100%"
        , style "height" "600px"
        , style "border" "0"
        , style "border-radius" "3px"
        , style "overflow" "hidden"
        , attribute "sandbox" "allow-modals allow-forms allow-popups allow-scripts allow-same-origin"
        ]
        []
    ]


textLi : String -> Html msg
textLi str =
    li [] [ text str ]
