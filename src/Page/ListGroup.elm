module Page.ListGroup exposing (view)

import Bootstrap.Badge as Badge
import Bootstrap.ListGroup as ListGroup
import Bootstrap.Utilities.Flex as Flex
import Bootstrap.Utilities.Size as Size
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Util


view : Util.PageContent msg
view =
    { title = "List group"
    , description =
        """List groups are a flexible and powerful component for displaying a series of content.
        List group items can be modified and extended to support just about any content within.
        They can also be used as navigation with the right modifier class."""
    , children =
        basic
            ++ active
            ++ disabledItems
            ++ actionable
            ++ contextual
            ++ badges
            ++ custom
    }


basic : List (Html msg)
basic =
    [ h2 [] [ text "Basic example" ]
    , p [] [ text "The most basic list group is an unordered list with list items." ]
    , Util.example
        [ ListGroup.ul
            [ ListGroup.li [] [ text "List item 1" ]
            , ListGroup.li [] [ text "List item 2" ]
            , ListGroup.li [] [ text "List item 3" ]
            ]
        ]
    , Util.code basicCode
    ]


basicCode : Html msg
basicCode =
    Util.toMarkdownElm """
ListGroup.ul
    [ ListGroup.li [] [ text "List item 1" ]
    , ListGroup.li [] [ text "List item 2" ]
    , ListGroup.li [] [ text "List item 3" ]
    ]
"""


active : List (Html msg)
active =
    [ h2 [] [ text "Active items" ]
    , p [] [ text "You can mark an item as active as follows" ]
    , Util.example
        [ ListGroup.ul
            [ ListGroup.li [ ListGroup.active ] [ text "List item 1" ]
            , ListGroup.li [] [ text "List item 2" ]
            , ListGroup.li [] [ text "List item 3" ]
            ]
        ]
    , Util.code activeCode
    ]


activeCode : Html msg
activeCode =
    Util.toMarkdownElm """
ListGroup.ul
    [ ListGroup.li [ ListGroup.active ] [ text "List item 1" ]
    , ListGroup.li [] [ text "List item 2" ]
    , ListGroup.li [] [ text "List item 3" ]
    ]

"""


disabledItems : List (Html msg)
disabledItems =
    [ h2 [] [ text "Disabled items" ]
    , p [] [ text "You can make regular list items appear disabled as follows" ]
    , Util.example
        [ ListGroup.ul
            [ ListGroup.li [ ListGroup.disabled ] [ text "List item 1 (I'm disabled hover over me)" ]
            , ListGroup.li [] [ text "List item 2" ]
            , ListGroup.li [] [ text "List item 3" ]
            ]
        ]
    , Util.code disabledCode
    ]


disabledCode : Html msg
disabledCode =
    Util.toMarkdownElm """
ListGroup.ul
    [ ListGroup.li [ ListGroup.disabled ] [ text "List item 1 (I'm disabled hover over me)" ]
    , ListGroup.li [] [ text "List item 2" ]
    , ListGroup.li [] [ text "List item 3" ]
    ]

"""


actionable : List (Html msg)
actionable =
    [ h2 [] [ text "Links and buttons" ]
    , p [] [ text "You can create an actionable list group containing links or buttons." ]
    , Util.example
        [ ListGroup.custom
            [ ListGroup.anchor [ ListGroup.active, ListGroup.attrs [ href "javascript:void();" ] ] [ text "List item 1" ]
            , ListGroup.anchor [ ListGroup.attrs [ href "javascript:void();" ] ] [ text "List item 2" ]
            , ListGroup.anchor [ ListGroup.disabled, ListGroup.attrs [ href "http://www.google.com" ] ] [ text "List item 3" ]
            ]
        ]
    , Util.code linksCode
    , Util.calloutWarning
        [ h4 [] [ text "Disabled links" ]
        , p []
            [ text """Sadly the disabled option doesn't prevent actions for anchor elements.
                   The good news is that we've handled this with a custom click handler attribute.""" ]
        ]
    , p [] [ text "Buttons however works without any such hacks." ]
    , Util.example
        [ ListGroup.custom
            [ ListGroup.button [ ListGroup.active ] [ text "List item 1" ]
            , ListGroup.button [] [ text "List item 2" ]
            , ListGroup.button [ ListGroup.disabled ] [ text "List item 3" ]
            ]
        ]
    , Util.code buttonsCode
    ]


linksCode : Html msg
linksCode =
    Util.toMarkdownElm """
ListGroup.custom
    [ ListGroup.anchor [ ListGroup.active, ListGroup.attrs [ href "javascript:void();" ] ] [ text "List item 1" ]
    , ListGroup.anchor [ ListGroup.attrs [ href "javascript:void();" ] ] [ text "List item 2" ]
    , ListGroup.anchor [ ListGroup.disabled, ListGroup.attrs [  href "http://www.google.com" ] ] [ text "List item 3" ]
    ]

"""


buttonsCode : Html msg
buttonsCode =
    Util.toMarkdownElm """
ListGroup.custom
    [ ListGroup.button [ ListGroup.active ] [ text "List item 1"]
    , ListGroup.button [] [ text "List item 2"]
    , ListGroup.button [ ListGroup.disabled ] [ text "List item 3"]
    ]

"""


contextual : List (Html msg)
contextual =
    [ h2 [] [ text "Contextual items" ]
    , p [] [ text "You can give your list items contextual colors." ]
    , Util.example
        [ ListGroup.ul
            (contextualOptions ListGroup.li)
        ]
    , Util.code contextualCode
    , p [] [ text "Contextual colors also work with actionable items. Note the addtion of the hover styles not present in the previous example." ]
    , Util.example
        [ ListGroup.custom
            (contextualOptions ListGroup.button)
        ]
    , Util.code contextualActionsCode
    ]


contextualCode : Html msg
contextualCode =
    Util.toMarkdownElm """
ListGroup.ul
    [ ListGroup.li [ ListGroup.primary ] [ text "Primary" ]
    , ListGroup.li [ ListGroup.secondary ] [ text "Secondary" ]
    , ListGroup.li [ ListGroup.success ] [ text "Success" ]
    , ListGroup.li [ ListGroup.info ] [ text "Info" ]
    , ListGroup.li [ ListGroup.warning ] [ text "Warning" ]
    , ListGroup.li [ ListGroup.danger ] [ text "Danger" ]
    , ListGroup.li [ ListGroup.light ] [ text "Light" ]
    , ListGroup.li [ ListGroup.dark ] [ text "Dark" ]
    ]
"""


contextualActionsCode : Html msg
contextualActionsCode =
    Util.toMarkdownElm """
ListGroup.custom
    [ ListGroup.button [ ListGroup.primary ] [ text "Primary" ]
    , ListGroup.button [ ListGroup.secondary ] [ text "Secondary" ]
    , ListGroup.button [ ListGroup.success ] [ text "Success" ]
    , ListGroup.button [ ListGroup.info ] [ text "Info" ]
    , ListGroup.button [ ListGroup.warning ] [ text "Warning" ]
    , ListGroup.button [ ListGroup.danger ] [ text "Danger" ]
    , ListGroup.button [ ListGroup.light ] [ text "Light" ]
    , ListGroup.button [ ListGroup.dark ] [ text "Dark" ]
    ]
"""


contextualOptions :
    (List (ListGroup.ItemOption msg) -> List (Html msg) -> a)
    -> List a
contextualOptions fn =
    [ fn [ ListGroup.primary ] [ text "Primary" ]
    , fn [ ListGroup.secondary ] [ text "Secondary" ]
    , fn [ ListGroup.success ] [ text "Success" ]
    , fn [ ListGroup.info ] [ text "Info" ]
    , fn [ ListGroup.warning ] [ text "Warning" ]
    , fn [ ListGroup.danger ] [ text "Danger" ]
    , fn [ ListGroup.light ] [ text "Light" ]
    , fn [ ListGroup.dark ] [ text "Dark" ]
    ]


badges : List (Html msg)
badges =
    [ h2 [] [ text "With badges" ]
    , p [] [ text """Add badges to any list group item to show unread counts, activity, and more with the help of some utilities.
                    Note the justify-content-between utility class and the badge’s placement""" ]
    , Util.example
        [ ListGroup.ul
            [ ListGroup.li
                [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ] ]
                [ text "List item 1"
                , Badge.pillSuccess [] [ text "14" ]
                ]
            , ListGroup.li
                [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ] ]
                [ text "List item 2"
                , Badge.pillSuccess [] [ text "1" ]
                ]
            , ListGroup.li
                [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ]
                , ListGroup.success
                ]
                [ text "List item 3"
                , Badge.pillSuccess [] [ text "2" ]
                ]
            ]
        ]
    , Util.code badgesCode
    ]


badgesCode : Html msg
badgesCode =
    Util.toMarkdownElm """
ListGroup.ul
    [ ListGroup.li
        [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ] ]
        [ text "List item 1"
        , Badge.pill [] [ text "14" ]
        ]
    , ListGroup.li
        [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ] ]
        [ text "List item 2"
        , Badge.pill [] [ text "1" ]
        ]
    , ListGroup.li
        [ ListGroup.attrs [ Flex.block, Flex.justifyBetween, Flex.alignItemsCenter ]
        , ListGroup.success
        ]
        [ text "List item 3"
        , Badge.pillSuccess [] [ text "2" ]
        ]
    ]

"""


custom : List (Html msg)
custom =
    [ h2 [] [ text "Custom content" ]
    , p [] [ text "Add nearly any HTML within using flexbox utilities classes in Bootstrap" ]
    , Util.example
        [ ListGroup.custom
            [ ListGroup.anchor
                [ ListGroup.active
                , ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ]
                ]
                [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
                    [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
                    , small [] [ text "3 days ago" ]
                    ]
                , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
                , small [] [ text "Oh yea that's neat" ]
                ]
            , ListGroup.anchor
                [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
                [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
                    [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
                    , small [] [ text "3 days ago" ]
                    ]
                , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
                , small [] [ text "Oh yea that's neat" ]
                ]
            , ListGroup.anchor
                [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
                [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
                    [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
                    , small [] [ text "3 days ago" ]
                    ]
                , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
                , small [] [ text "Oh yea that's neat" ]
                ]
            ]
        , Util.code customCode
        ]
    ]


customCode : Html msg
customCode =
    Util.toMarkdownElm """
ListGroup.custom
    [ ListGroup.anchor
        [ ListGroup.active
        , ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ]
        ]
        [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
            [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
            , small [] [ text "3 days ago" ]
            ]
        , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
        , small [] [ text "Oh yea that's neat" ]
        ]
    , ListGroup.anchor
        [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
        [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
            [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
            , small [] [ text "3 days ago" ]
            ]
        , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
        , small [] [ text "Oh yea that's neat" ]
        ]
    , ListGroup.anchor
        [ ListGroup.attrs [ href "#", Flex.col, Flex.alignItemsStart ] ]
        [ div [ Flex.block, Flex.justifyBetween, Size.w100 ]
            [ h5 [ Spacing.mb1 ] [ text "List group heading" ]
            , small [] [ text "3 days ago" ]
            ]
        , p [ Spacing.mb1 ] [ text "Donec id elit non mi porta gravida at eget metus. Maecenas sed diam eget risus varius blandit." ]
        , small [] [ text "Oh yea that's neat" ]
        ]
    ]
"""
