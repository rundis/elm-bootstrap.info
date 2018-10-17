module Page.Badge exposing (view)

import Bootstrap.Badge as Badge
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Util


view : Util.PageContent msg
view =
    { title = "Badge"
    , description = "Small and adaptive tag for adding context to just about any content."
    , children =
        example ++ contextual ++ pills
    }


example : List (Html msg)
example =
    [ h2 [] [ text "Example" ]
    , p [] [ text "Badges scale to match the size of the immediate parent element by using relative font sizing and em units" ]
    , Util.example
        [ h1 [] [ text "Heading 1 ", Badge.badgeSecondary [] [ text "New" ] ]
        , h2 [] [ text "Heading 2 ", Badge.badgeSecondary [] [ text "New" ] ]
        , h3 [] [ text "Heading 3 ", Badge.badgeSecondary [] [ text "New" ] ]
        , h4 [] [ text "Heading 4 ", Badge.badgeSecondary [] [ text "New" ] ]
        , h5 [] [ text "Heading 5 ", Badge.badgeSecondary [] [ text "New" ] ]
        , h6 [] [ text "Heading 6 ", Badge.badgeSecondary [] [ text "New" ] ]
        ]
    , div [ class "highlight" ]
        [ exampleCode ]
    ]


exampleCode : Html msg
exampleCode =
    Util.toMarkdown """
```elm
div []
    [ h1 [] [ text "Heading 1 ", Badge.badgeSecondary [] [ text "New"] ]
    , h2 [] [ text "Heading 2 ", Badge.badgeSecondary [] [ text "New"] ]
    , h3 [] [ text "Heading 3 ", Badge.badgeSecondary [] [ text "New"] ]
    , h4 [] [ text "Heading 4 ", Badge.badgeSecondary [] [ text "New"] ]
    , h5 [] [ text "Heading 5 ", Badge.badgeSecondary [] [ text "New"] ]
    , h6 [] [ text "Heading 6 ", Badge.badgeSecondary [] [ text "New"] ]
    ]

```
"""


contextual : List (Html msg)
contextual =
    [ h2 [] [ text "Contextual variations" ]
    , p [] [ text "Use the following functions to change the appearance of a badge." ]
    , Util.example
        [ Badge.badgePrimary [] [ text "Primary" ]
        , Badge.badgeSecondary [ Spacing.ml1 ] [ text "Secondary" ]
        , Badge.badgeSuccess [ Spacing.ml1 ] [ text "Success" ]
        , Badge.badgeInfo [ Spacing.ml1 ] [ text "Info" ]
        , Badge.badgeWarning [ Spacing.ml1 ] [ text "Warning" ]
        , Badge.badgeDanger [ Spacing.ml1 ] [ text "Danger" ]
        , Badge.badgeLight [ Spacing.ml1 ] [ text "Light" ]
        , Badge.badgeDark [ Spacing.ml1 ] [ text "Dark" ]
        ]
    , div [ class "highlight" ]
        [ contextualCode ]
    ]


contextualCode : Html msg
contextualCode =
    Util.toMarkdown """
```elm
div []
    [ Badge.badgePrimary [ ] [ text "Primary" ]
    , Badge.badgeSecondary [ Spacing.ml1 ] [ text "Secondary" ]
    , Badge.badgeSuccess [ Spacing.ml1 ] [ text "Success" ]
    , Badge.badgeInfo [ Spacing.ml1 ] [ text "Info" ]
    , Badge.badgeWarning [ Spacing.ml1 ] [ text "Warning" ]
    , Badge.badgeDanger [ Spacing.ml1 ] [ text "Danger" ]
    , Badge.badgeLight [ Spacing.ml1 ] [ text "Light" ]
    , Badge.badgeDark [ Spacing.ml1 ] [ text "Dark" ]
    ]

```
"""


pills : List (Html msg)
pills =
    [ h2 [] [ text "Pill badges" ]
    , p [] [ text "To create more rounded badges use the pill* functions." ]
    , Util.example
        [ Badge.pillPrimary [] [ text "Primary" ]
        , Badge.pillSecondary [ Spacing.ml1 ] [ text "Secondary" ]
        , Badge.pillSuccess [ Spacing.ml1 ] [ text "Success" ]
        , Badge.pillInfo [ Spacing.ml1 ] [ text "Info" ]
        , Badge.pillWarning [ Spacing.ml1 ] [ text "Warning" ]
        , Badge.pillDanger [ Spacing.ml1 ] [ text "Danger" ]
        , Badge.pillLight [ Spacing.ml1 ] [ text "Light" ]
        , Badge.pillDark [ Spacing.ml1 ] [ text "Dark" ]
        ]
    , div [ class "highlight" ]
        [ pillsCode ]
    ]


pillsCode : Html msg
pillsCode =
    Util.toMarkdown """
```elm
div []
    [ Badge.pillPrimary [ ] [ text "Primary" ]
    , Badge.pillSecondary [ Spacing.ml1 ] [ text "Secondary" ]
    , Badge.pillSuccess [ Spacing.ml1 ] [ text "Success" ]
    , Badge.pillInfo [ Spacing.ml1 ] [ text "Info" ]
    , Badge.pillWarning [ Spacing.ml1 ] [ text "Warning" ]
    , Badge.pillDanger [ Spacing.ml1 ] [ text "Danger" ]
    , Badge.pillLight [ Spacing.ml1 ] [ text "Light" ]
    , Badge.pillDark [ Spacing.ml1 ] [ text "Dark" ]
    ]

```
"""
