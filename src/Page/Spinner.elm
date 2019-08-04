module Page.Spinner exposing (view)

import Bootstrap.Button as Button
import Bootstrap.Spinner as Spinner
import Bootstrap.Text as Text
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Util


view : Util.PageContent msg
view =
    { title = "Spinner"
    , description = "Indicate the loading state of a component or page with Bootstrap spinners."
    , children = borderSpinner ++ growingSpinner ++ coloredSpinners ++ spinnerSize ++ buttonSpinner
    }


borderSpinner : List (Html msg)
borderSpinner =
    [ h2 [] [ text "Border spinner" ]
    , p [] [ text "Use the border spinners for lightweight loading indicator." ]
    , Util.example [ Spinner.spinner [] [] ]
    , div [ class "highlight" ] [ borderSpinnerCode ]
    ]


borderSpinnerCode : Html msg
borderSpinnerCode =
    Util.toMarkdown """
```elm
Spinner.spinner [] []
```
"""


growingSpinner : List (Html msg)
growingSpinner =
    [ h2 [] [ text "Growing spinner" ]
    , p [] [ text "If you don’t fancy a border spinner, switch to the grow spinner. While it doesn’t technically spin, it does repeatedly grow!" ]
    , Util.example [ Spinner.spinner [ Spinner.grow ] [] ]
    , div [ class "highlight" ] [ growingSpinnerCode ]
    ]


growingSpinnerCode : Html msg
growingSpinnerCode =
    Util.toMarkdown """
```elm
Spinner.spinner [ Spinner.grow ] []
```
"""


coloredSpinners : List (Html msg)
coloredSpinners =
    let
        colors =
            [ Text.primary
            , Text.secondary
            , Text.success
            , Text.danger
            , Text.warning
            , Text.info
            , Text.light
            , Text.dark
            ]
    in
    [ h2 [] [ text "Colors" ]
    , p [] [ text "Spice up your spinners with colors. You can use the predefined role colors in the Text module!" ]
    , Util.example <|
        List.map
            (\color -> Spinner.spinner [ Spinner.color color, Spinner.attrs [ Spacing.ml2 ] ] [])
            colors
    , div [ class "highlight" ] [ coloredSpinnersCode ]
    , p [] [ text "Same applies for growing spinners" ]
    , Util.example <|
        List.map
            (\color ->
                Spinner.spinner
                    [ Spinner.grow
                    , Spinner.color color
                    , Spinner.attrs [ Spacing.ml2 ]
                    ]
                    []
            )
            colors
    , div [ class "highlight" ] [ coloredSpinnersCode2 ]
    ]


coloredSpinnersCode : Html msg
coloredSpinnersCode =
    Util.toMarkdown """
```elm
let
    colors =
        [ Text.primary
        , Text.secondary
        , Text.success
        , Text.danger
        , Text.warning
        , Text.info
        , Text.light
        , Text.dark
        ]
in
List.map
    (\\color -> Spinner.spinner [ Spinner.color color, Spinner.attrs [ Spacing.ml2 ] ] [])
    colors

```
"""


coloredSpinnersCode2 : Html msg
coloredSpinnersCode2 =
    Util.toMarkdown """
```elm
-- see colors from previous example
List.map
    (\\color -> Spinner.spinner
        [ Spinner.grow
        , Spinner.color color
        , Spinner.attrs [ Spacing.ml2 ]
        ]
        []
    )
    colors

```
"""


spinnerSize : List (Html msg)
spinnerSize =
    let
        customStyles =
            [ style "width" "5rem"
            , style "height" "5rem"
            , style "border-width" "0.5rem"
            , style "color" "#FFC0CB"
            ]
    in
    [ h2 [] [ text "Size" ]
    , p [] [ text "Use the small option if you need a smaller spinner. Handy for usage within other components." ]
    , Util.example
        [ Spinner.spinner [ Spinner.small ] []
        , Spinner.spinner [ Spinner.grow, Spinner.small ] []
        ]
    , div [ class "highlight" ] [ spinnerSizeCode ]
    , p [] [ text "Need a larger spinner?" ]
    , Util.example
        [ Spinner.spinner [ Spinner.large ] []
        , Spinner.spinner [ Spinner.grow, Spinner.large ] []
        ]
    , div [ class "highlight" ] [ spinnerSizeCode2 ]
    , p [] [ text "Need custom size (or color even)? Just use styles (or custom css)." ]
    , Util.example
        [ Spinner.spinner [ Spinner.attrs customStyles ] []
        , Spinner.spinner [ Spinner.grow, Spinner.attrs customStyles ] []
        ]
    , div [ class "highlight" ] [ spinnerSizeCode3 ]
    ]


spinnerSizeCode : Html msg
spinnerSizeCode =
    Util.toMarkdown """
```elm
div []
    [ Spinner.spinner [ Spinner.small ] []
    , Spinner.spinner [ Spinner.grow, Spinner.small ] []
    ]
```
"""


spinnerSizeCode2 : Html msg
spinnerSizeCode2 =
    Util.toMarkdown """
```elm
div []
    [ Spinner.spinner [ Spinner.large ] []
    , Spinner.spinner [ Spinner.grow, Spinner.large ] []
    ]
```
"""


spinnerSizeCode3 : Html msg
spinnerSizeCode3 =
    Util.toMarkdown """
```elm
let
    customStyles =
        [ style "width" "5rem", style "height" "5rem", color "#FFC0CB" ]
in
div []
    [ Spinner.spinner [ Spinner.attrs customStyles ] []
    , Spinner.spinner [ Spinner.grow, Spinner.sttrs customStyles ] []
    ]
```
"""


buttonSpinner : List (Html msg)
buttonSpinner =
    [ h2 [] [ text "Buttons" ]
    , p [] [ text "Use spinners within buttons to indicate an action is currently processing or taking place." ]
    , Util.example
        [ Button.button [ Button.primary, Button.disabled True, Button.attrs [ Spacing.mr3 ] ]
            [ Spinner.spinner [ Spinner.small, Spinner.attrs [ Spacing.mr1 ] ] []
            , text "Saving..."
            ]
        , Button.button [ Button.primary, Button.disabled True ]
            [ Spinner.spinner [ Spinner.grow, Spinner.small, Spinner.attrs [ Spacing.mr1 ] ] []
            , text "Saving..."
            ]
        ]
    , div [ class "highlight" ] [ buttonSpinnerCode ]
    ]


buttonSpinnerCode : Html msg
buttonSpinnerCode =
    Util.toMarkdown """
```elm
div []
    [ Button.button
        [ Button.primary, Button.disabled True, Button.attrs [ Spacing.mr3 ] ]
        [ Spinner.spinner
            [ Spinner.small, Spinner.attrs [ Spacing.mr1 ] ] []
        , text "Saving..."
        ]
    , Button.button
        [ Button.primary, Button.disabled True ]
        [ Spinner.spinner
            [ Spinner.grow, Spinner.small, Spinner.attrs [ Spacing.mr1 ] ] []
        , text "Saving..."
        ]
    ]
```
"""
