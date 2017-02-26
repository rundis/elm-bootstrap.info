module Page.NotFound exposing (view)


import Html exposing (..)
import Html.Attributes exposing (..)


view : List (Html msg)
view =
    [ main_
        [ class "bd-masthead", id "content" ]
        [ div
            [ style [ ( "margin", "0 auto 2rem" ) ] ]
            [ img
                [ src "assets/images/elm-bootstrap.svg"
                , alt "elm-bootstrap"
                , style
                    [ ( "border", "1px solid white" )
                    , ( "width", "120px" )
                    , ( "border-radius", "15%" )
                    ]
                ]
                []
            ]
        , p [ class "lead" ]
            [ text "Oh dear, I couldn't find the page you were asking for." ]
        , p [ class "version" ]
            [ text "If you came from a link within this site, please report an "
            , a
                [ href "https://github.com/rundis/elm-bootstrap.info"
                , target "_blank"
                , style [("color", "#ffe484")]
                ]
                [ text "issue" ]
            , text "."
            ]
        ]
    ]
