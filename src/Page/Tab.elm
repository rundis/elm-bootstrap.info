module Page.Tab exposing (Msg, State, initialState, initialStateWithHash, subscriptions, update, view)

import Bootstrap.Form as Form
import Bootstrap.Form.Radio as Radio
import Bootstrap.Tab as Tab
import Bootstrap.Utilities.Spacing as Spacing
import Html exposing (..)
import Html.Attributes exposing (..)
import Util


type alias State =
    { tabState : Tab.State
    , pillState : Tab.State
    , animatedState : Tab.State
    , customizedState : Tab.State
    , layout : Layout
    }


type Layout
    = None
    | Justified
    | Fill
    | Center
    | Right


initialState : State
initialState =
    initialStateWithHash ""


initialStateWithHash : String -> State
initialStateWithHash hash =
    { tabState =
        if String.startsWith "tab" hash then
            Tab.customInitialState hash

        else
            Tab.initialState
    , pillState =
        if String.startsWith "pill" hash then
            Tab.customInitialState hash

        else
            Tab.initialState
    , animatedState =
        if String.startsWith "animated" hash then
            Tab.customInitialState hash

        else
            Tab.initialState
    , customizedState =
        if String.startsWith "customized" hash then
            Tab.customInitialState hash

        else
            Tab.initialState
    , layout = None
    }


type Msg
    = TabMsg Tab.State
    | PillMsg Tab.State
    | AnimatedMsg Tab.State
    | CustomizedMsg Tab.State
    | LayoutMsg Layout


subscriptions : State -> Sub Msg
subscriptions state =
    Tab.subscriptions state.animatedState AnimatedMsg


update : Msg -> State -> State
update msg state =
    case msg of
        TabMsg newState ->
            { state | tabState = newState }

        PillMsg newState ->
            { state | pillState = newState }

        AnimatedMsg newState ->
            { state | animatedState = newState }

        CustomizedMsg newState ->
            { state | customizedState = newState }

        LayoutMsg layout ->
            { state | layout = layout }


view : State -> Util.PageContent Msg
view state =
    { title = "Tab"
    , description =
        """Use the Tab module when you want to create a tabbed interface element with tabbable regions of content."""
    , children =
        tabs state
            ++ pills state
            ++ animated state
            ++ customized state
    }


tabs : State -> List (Html Msg)
tabs state =
    [ h2 [] [ text "Tabs" ]
    , p [] [ text """Create a classic tabbed control using the tabs function.
                    Since the Tabs require some internal view state, you will need to do a little bit of wiring to get it working.""" ]
    , Util.example
        [ Tab.config TabMsg
            |> Tab.items
                [ Tab.item
                    { id = "tabItem1"
                    , link = Tab.link [] [ text "Tab 1" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 1 Heading" ]
                            , p [] [ text "Contents of tab 1." ]
                            ]
                    }
                , Tab.item
                    { id = "tabItem2"
                    , link = Tab.link [] [ text "Tab 2" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 2 Heading" ]
                            , p [] [ text "This is something completely different." ]
                            ]
                    }
                ]
            |> Tab.view state.tabState
        ]
    , Util.code tabsCode
    ]


tabsCode : Html msg
tabsCode =
    Util.toMarkdownElm """

-- Tabs depends on view state to keep track of the active Tab, you'll need to store that in your model

type alias Model =
    { tabState : Tab.State }

-- Provide the initialState for the Tabs control

init : ( Model, Cmd Msg )
init =
    ( { tabState = Tab.initalState}, Cmd.none )


--  To step the state forward for the Tabs control we need to have a Message

type Msg
    = TabMsg Tab.State


-- In your update function you will need to handle the messages coming from the Tabs control

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        TabMsg state ->
            ( { model | tabState = state }
            , Cmd.none
            )


-- The view specifies how the tab should look and behave

view : Model -> Html msg
view model =
    Tab.config TabMsg
        |> Tab.items
            [ Tab.item
                { id = "tabItem1"
                , link = Tab.link [] [ text "Tab 1" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ h4 [] [ text "Tab 1 Heading" ]
                        , p [] [ text "Contents of tab 1." ]
                        ]
                }
            , Tab.item
                { id = "tabItem2"
                , link = Tab.link [] [ text "Tab 2" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ h4 [] [ text "Tab 2 Heading" ]
                        , p [] [ text "This is something completely different." ]
                        ]
                }
            ]
        |> Tab.view state.tabState
"""


pills : State -> List (Html Msg)
pills state =
    [ h2 [] [ text "Pills" ]
    , p [] [ text "Pills are just like tabs but gives a pill look to the tabs " ]
    , Util.example
        [ Tab.config PillMsg
            |> Tab.pills
            |> Tab.useHash True
            |> Tab.items
                [ Tab.item
                    { id = "pillItem1"
                    , link = Tab.link [] [ text "Tab 1" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 1 Heading" ]
                            , p [] [ text "Contents of tab 1." ]
                            ]
                    }
                , Tab.item
                    { id = "pillItem2"
                    , link = Tab.link [] [ text "Tab 2" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 2 Heading" ]
                            , p [] [ text "This is something completely different." ]
                            ]
                    }
                ]
            |> Tab.view state.pillState
        ]
    , Util.code pillsCode
    , Util.calloutInfo
        [ h4 [] [ text "Updating the hash when selecting tab items" ]
        , hashRef
        ]
    ]


hashRef : Html msg
hashRef =
    Util.toMarkdown """`Tab.useHash True`, will ensure that the URL is updated with a hash representing the given tab items id.
This is handy when you want to provide "deep-linking" support in your SPA.


When you click the pill items, you will see that the url is updated. If you try to refresh the browser with a (valid) pill hash in the URL you will see that the correct item is selected.

It's up to you to implement the route matching needed to support deep linking. Once you have the hash(id) for the tab item,
you may specify which tab item is active initially by calling `Tab.customInitialState <somehash>` (where `<somehash>` is the given id for the tab item).

[Check out the elm-bootstrap.info source for inpsiration, starting here](https://github.com/rundis/elm-bootstrap.info/blob/master/src/Main.elm#L65)"""


pillsCode : Html msg
pillsCode =
    Util.toMarkdownElm """
Tab.config TabMsg
    |> Tab.pills
    |> Tab.useHash True
    |> Tab.items
        [ Tab.item
            { id = "pillItem1"
            , link = Tab.link [] [ text "Tab 1" ]
            , pane =
                Tab.pane [ Spacing.mt3 ]
                    [ h4 [] [ text "Tab 1 Heading" ]
                    , p [] [ text "Contents of tab 1." ]
                    ]
            }
        , Tab.item
            { id = "pillItem2"
            , link = Tab.link [] [ text "Tab 2" ]
            , pane =
                Tab.pane [ Spacing.mt3 ]
                    [ h4 [] [ text "Tab 2 Heading" ]
                    , p [] [ text "This is something completely different." ]
                    ]
            }
        ]
    |> Tab.view state.tabState
"""


animated : State -> List (Html Msg)
animated state =
    [ h2 [] [ text "Adding an animation effect" ]
    , p [] [ text "You can add an fade in animation effect, by adding a little bit more of wiring." ]
    , Util.example
        [ Tab.config AnimatedMsg
            |> Tab.withAnimation
            |> Tab.items
                [ Tab.item
                    { id = "animatedTabItem1"
                    , link = Tab.link [] [ text "Tab 1" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 1 Heading" ]
                            , p [] [ text "Contents of tab 1." ]
                            ]
                    }
                , Tab.item
                    { id = "animatedTabItem2"
                    , link = Tab.link [] [ text "Tab 2" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 2 Heading" ]
                            , p [] [ text "This is something completely different." ]
                            ]
                    }
                ]
            |> Tab.view state.animatedState
        ]
    , Util.code animatedCode
    , Util.calloutWarning
        [ h4 [] [ text "Don't forget the subscription !" ]
        , p [] [ text """When you set withAnimation to True it's really important that you remember to also wire up the subscriptions function.
                         If you forget, changing tabs will not work.""" ]
        ]
    ]


animatedCode : Html msg
animatedCode =
    Util.toMarkdownElm """


-- For animations to work you need to wire up a subscription for the Tabs control

subscriptions : Model -> Sub Msg
    subscriptions model =
        Tab.subscriptions model.tabState TabMsg


view : Model -> Html msg
view model =
    Tab.config TabMsg
        |> Tab.withAnimation
        |> Tab.items
            [ Tab.item
                { id = "animatedTabItem1"
                , link = Tab.link [] [ text "Tab 1" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ h4 [] [ text "Tab 1 Heading" ]
                        , p [] [ text "Contents of tab 1." ]
                        ]
                }
            , Tab.item
                { id = "animatedTabItem2"
                , link = Tab.link [] [ text "Tab 2" ]
                , pane =
                    Tab.pane [ Spacing.mt3 ]
                        [ h4 [] [ text "Tab 2 Heading" ]
                        , p [] [ text "This is something completely different." ]
                        ]
                }
            ]
        |> Tab.view model.tabState
"""


customized : State -> List (Html Msg)
customized state =
    let
        radioAttrs layout =
            [ Radio.inline
            , Radio.onClick <| LayoutMsg layout
            , Radio.checked <| layout == state.layout
            ]

        tabLayout conf =
            case state.layout of
                None ->
                    conf

                Center ->
                    Tab.center conf

                Right ->
                    Tab.right conf

                Justified ->
                    Tab.justified conf

                Fill ->
                    Tab.fill conf
    in
    [ h2 [] [ text "Customizing with options" ]
    , p [] [ text "You can easily customize spacing and alignement of tabs using helper functions" ]
    , Util.example
        [ Form.form []
            [ h5 [] [ text "Tab layout options" ]
            , Form.group []
                [ Form.label [] [ text "Horizontal alignment" ]
                , div []
                    [ Radio.radio (radioAttrs None) "Default"
                    , Radio.radio (radioAttrs Center) "Tab.center"
                    , Radio.radio (radioAttrs Right) "Tab.right"
                    , Radio.radio (radioAttrs Justified) "Tab.justified"
                    , Radio.radio (radioAttrs Fill) "Tab.fill"
                    ]
                ]
            , hr [] []
            ]
        , Tab.config CustomizedMsg
            |> tabLayout
            |> Tab.items
                [ Tab.item
                    { id = "customizedTabItem1"
                    , link = Tab.link [] [ text "First tab" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ p [] [ text """Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo booth letterpress, commodo enim craft beer mlkshk aliquip jean shorts ullamco ad vinyl cillum PBR. Homo nostrud organic, assumenda labore aesthetic magna delectus mollit. Keytar helvetica VHS salvia yr, vero magna velit sapiente labore stumptown. Vegan fanny pack odio cillum wes anderson 8-bit, sustainable jean shorts beard ut DIY ethical culpa terry richardson biodiesel. Art party scenester stumptown, tumblr butcher vero sint qui sapiente accusamus tattooed echo park.""" ]
                            ]
                    }
                , Tab.item
                    { id = "customizedTabItem2"
                    , link = Tab.link [] [ text "Second tab" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 2 Heading" ]
                            , p [] [ text "This is something completely different." ]
                            ]
                    }
                , Tab.item
                    { id = "customizedTabItem3"
                    , link = Tab.link [] [ text "Yet another tab" ]
                    , pane =
                        Tab.pane [ Spacing.mt3 ]
                            [ h4 [] [ text "Tab 3 Heading" ]
                            , p [] [ text "Nothing to see here." ]
                            ]
                    }
                ]
            |> Tab.view state.customizedState
        ]
    ]
