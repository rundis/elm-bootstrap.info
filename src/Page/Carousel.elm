module Page.Carousel exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Util
import Bootstrap.Carousel as Carousel exposing (defaultStateOptions)
import Bootstrap.Carousel.Slide as Slide
import Bootstrap.Card as Card
import Bootstrap.Text as Text


type alias State =
    { carousel : Carousel.State
    , controls : Carousel.State
    , captions : Carousel.State
    , stateOptions : Carousel.State
    , custom : Carousel.State
    }


initialState : State
initialState =
    { carousel = Carousel.initialState
    , controls = Carousel.initialState
    , captions = Carousel.initialState
    , stateOptions =
        Carousel.initialStateWithOptions
            { defaultStateOptions
                | interval = Just 2000
                , pauseOnHover = False
            }
    , custom = Carousel.initialState
    }


type Msg
    = CarouselMsg Carousel.Msg
    | ControlsMsg Carousel.Msg
    | CaptionsMsg Carousel.Msg
    | OptionsMsg Carousel.Msg
    | CustomMsg Carousel.Msg


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.batch
        [ Carousel.subscriptions state.carousel CarouselMsg
        , Carousel.subscriptions state.controls ControlsMsg
        , Carousel.subscriptions state.captions CaptionsMsg
        , Carousel.subscriptions state.stateOptions OptionsMsg
        , Carousel.subscriptions state.custom CustomMsg
        ]


update : Msg -> State -> State
update msg state =
    case msg of
        CarouselMsg subMsg ->
            { state | carousel = Carousel.update subMsg state.carousel }

        ControlsMsg subMsg ->
            { state | controls = Carousel.update subMsg state.controls }

        CaptionsMsg subMsg ->
            { state | captions = Carousel.update subMsg state.captions }

        OptionsMsg subMsg ->
            { state | stateOptions = Carousel.update subMsg state.stateOptions }

        CustomMsg subMsg ->
            { state | custom = Carousel.update subMsg state.custom }


view : State -> Util.PageContent Msg
view state =
    { title = "Carousel"
    , description =
        """The carousel is a slideshow for cycling through a series of content, built with CSS 3D transforms and a bit of Elm.
        It works with a series of images, text, or custom markup. It also includes support for previous/next controls and indicators.
        """
    , children =
        (basic state
            ++ controlsAndIndicators state
            ++ captions state
            ++ stateOptions state
            ++ custom state
        )
    }


basic : State -> List (Html Msg)
basic state =
    [ h2 [] [ text "Example" ]
    , p [] [ text """Creating an slideshow with the default options is quite easy. It does however require a little bit of wiring, because of the slide animations.""" ]
    , slideExample
        (Carousel.config CarouselMsg []
            |> Carousel.slides
                [ Slide.config [] (Slide.image [] img1)
                , Slide.config [] (Slide.image [] img2)
                , Slide.config [] (Slide.image [] img3)
                ]
            |> Carousel.view state.carousel
        )
    , Util.code basicCode
    , Util.calloutInfo
        [ p [] [ text "By default the carousel will start immediately and change slide every 5 seconds. When it reaches the end, it will restart from the beginning." ]
        ]
    ]


basicCode : Html msg
basicCode =
    Util.toMarkdownElm """
import Bootstrap.Carousel as Carousel
import Bootstrap.Carousel.Slide as Slide

-- We need to keep track of the carousel state in our model

type alias Model =
    { carouselState : Carousel.State }


-- Provide the initial state for the carousel

init: (Model, Cmd Msg)
init =
    ( { carouselState = Carousel.initialState}, Cmd.none )

-- To be able to handle content change/slide changes in the Carousel, we need to handle Carousel messages

type Msg
    = CarouselMsg Carousel.Msg


-- You'll need to wire up the Carousel subscriptions to handle the slide transitions

subscriptions : Model -> Sub Msg
subscriptions model =
    Carousel.subscriptions model.carouselState CarouselMsg


-- Handle carousel messages in your update function

update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        CarouselMsg subMsg ->
            { model | carouselState = Carousel.update subMsg model.carouselState }


-- Display the carousel in your view function

view : Model -> Html Msg
view model =
    Carousel.config CarouselMsg []
        |> Carousel.slides
            [ Slide.config [] (Slide.image [] "assets/img1.jpg")
            , Slide.config [] (Slide.image [] "assets/img2.jpg")
            , Slide.config [] (Slide.image [] "assets/img3.jpg")
            ]
        |> Carousel.view model.carouselState

"""


controlsAndIndicators : State -> List (Html Msg)
controlsAndIndicators state =
    [ h2 [] [ text "Controls and indicators" ]
    , p [] [ text """You may add controls to allow users to go forward/back manually and you can add indicators to show progress.""" ]
    , slideExample
        (Carousel.config ControlsMsg []
            |> Carousel.withControls
            |> Carousel.withIndicators
            |> Carousel.slides
                [ Slide.config [] (Slide.image [] img1)
                , Slide.config [] (Slide.image [] img2)
                , Slide.config [] (Slide.image [] img3)
                ]
            |> Carousel.view state.controls
        )
    , Util.code controlsCode
    ]


controlsCode : Html msg
controlsCode =
    Util.toMarkdownElm """
Carousel.config CarouselMsg []
    |> Carousel.withControls
    |> Carousel.withIndicators
    |> Carousel.slides
        [ Slide.config [] (Slide.image [] img1)
        , Slide.config [] (Slide.image [] img2)
        , Slide.config [] (Slide.image [] img3)
        ]
    |> Carousel.view model.carouselState
"""


captions : State -> List (Html Msg)
captions state =
    [ h2 [] [ text "Adding captions" ]
    , p [] [ text """You can also add captions to your slide. These are by default hidden at the extra small screen size threshold.""" ]
    , slideExample
        (Carousel.config ControlsMsg []
            |> Carousel.withControls
            |> Carousel.withIndicators
            |> Carousel.slides
                [ Slide.config [] (Slide.image [] img1)
                    |> Slide.caption []
                        [ h4 [] [ text "Slide 1 label" ]
                        , p [] [ text "Subtitle for slide 1" ]
                        ]
                , Slide.config [] (Slide.image [] img2)
                    |> Slide.caption []
                        [ h4 [] [ text "Slide 2 label" ]
                        , p [] [ text "Subtitle for slide 2" ]
                        ]
                , Slide.config [] (Slide.image [] img3)
                    |> Slide.caption []
                        [ h4 [] [ text "Slide 3 label" ]
                        , p [] [ text "Subtitle for slide 3" ]
                        ]
                ]
            |> Carousel.view state.controls
        )
    , Util.code captionsCode
    ]


captionsCode : Html msg
captionsCode =
    Util.toMarkdownElm """
Carousel.config CarouselMsg []
    |> Carousel.withControls
    |> Carousel.withIndicators
    |> Carousel.slides
        [ Slide.config [] (Slide.image [] img1)
            |> Slide.caption []
                [ h4 [] [ text "Slide 1 label"]
                , p [] [ text "Subtitle for slide 1"]
                ]
        , Slide.config [] (Slide.image [] img2)
            |> Slide.caption []
                [ h4 [] [ text "Slide 2 label"]
                , p [] [ text "Subtitle for slide 2"]
                ]
        , Slide.config [] (Slide.image [] img3)
            |> Slide.caption []
                [ h4 [] [ text "Slide 3 label"]
                , p [] [ text "Subtitle for slide 3"]
                ]
        ]
    |> Carousel.view model.carouselState
"""


stateOptions : State -> List (Html Msg)
stateOptions state =
    [ h2 [] [ text "Customizing transition behavior" ]
    , p [] [ text """You can change the transition behavior by customizing the initial state for the carousel.""" ]
    , slideExample
        (Carousel.config OptionsMsg []
            |> Carousel.slides
                [ Slide.config [] (Slide.image [] img1)
                , Slide.config [] (Slide.image [] img2)
                , Slide.config [] (Slide.image [] img3)
                ]
            |> Carousel.view state.stateOptions
        )
    , Util.code stateOptionsCode
    ]


stateOptionsCode : Html msg
stateOptionsCode =
    Util.toMarkdownElm """

-- Expose defaultStateOptions explicitly

import Bootstrap.Carousel as Carousel exposing (defaultStateOptions)


-- Change init function to modify default initial state
init: (Model, Cmd Msg)
init =
    ( Carousel.initialStateWithOptions
        { defaultStateOptions
            | interval = Just 2000 -- Change slide every 2 seconds
            , pauseOnHover = False -- Prevent the default behavior to pause the transitions on mouse hover
        }
    , Cmd.none
    )
"""


custom : State -> List (Html Msg)
custom state =
    [ h2 [] [ text "Custom slide content" ]
    , p [] [ text """You can create slides with customized content. Making it look nice, is up to you though !""" ]
    , slideExample
        (Carousel.config CustomMsg []
            |> Carousel.withControls
            |> Carousel.slides
                [ cardSlide "Custom Slide 1"
                , cardSlide "Custom Slide 2"
                , cardSlide "Custom Slide 3"
                ]
            |> Carousel.view state.custom
        )
    , Util.code customCode
    ]


cardSlide : String -> Slide.Config msg
cardSlide title =
    Slide.config []
        (Slide.customContent
            (Card.config
                [ Card.info
                , Card.attrs [ style [ ( "width", "800px" ) ] ]
                , Card.align Text.alignSmCenter
                ]
                |> Card.headerH4 [] [ text title ]
                |> Card.block [ Card.blockAlign Text.alignSmCenter ]
                    [ Card.titleH5 [] [ text "A card block title" ]
                    , Card.text [] [ text "Something something card" ]
                    ]
                |> Card.footer [] [ text "A footer" ]
                |> Card.view
            )
        )


customCode : Html msg
customCode =
    Util.toMarkdownElm """

import Bootstrap.Card as Card

view =
    Carousel.config CarouselMsg []
        |> Carousel.withControls
        |> Carousel.slides
            [ cardSlide "Custom Slide 1"
            , cardSlide "Custom Slide 2"
            , cardSlide "Custom Slide 3"
            ]
        |> Carousel.view model.carouselState

cardSlide title =
    Slide.config []
        (Slide.customContent
            (Card.config
                [ Card.info
                , Card.attrs [ style [ ( "width", "800px" ) ] ]
                , Card.align Text.alignSmCenter
                ]
                |> Card.headerH4 [] [ text title ]
                |> Card.block [ Card.blockAlign Text.alignSmCenter ]
                    [ Card.titleH5 [] [ text "A card block title" ]
                    , Card.text [] [ text "Something something card" ]
                    ]
                |> Card.footer [] [ text "A footer" ]
                |> Card.view
            )
        )
"""


slideExample : Html msg -> Html msg
slideExample carousel =
    Util.example
        [ div [ style [ ( "max-width", "800px" ) ] ] [ carousel ] ]


img1 =
    """data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22800%22%20height%3D%22400%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20800%20400%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15b8174244d%20text%20%7B%20fill%3A%23555%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A40pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15b8174244d%22%3E%3Crect%20width%3D%22800%22%20height%3D%22400%22%20fill%3D%22%23777%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22285.9296875%22%20y%3D%22217.7%22%3EFirst%20slide%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"""


img2 =
    """data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22800%22%20height%3D%22400%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20800%20400%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15b81742450%20text%20%7B%20fill%3A%23444%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A40pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15b81742450%22%3E%3Crect%20width%3D%22800%22%20height%3D%22400%22%20fill%3D%22%23666%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22247.3203125%22%20y%3D%22217.7%22%3ESecond%20slide%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"""


img3 =
    """data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22800%22%20height%3D%22400%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20800%20400%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_15b81742454%20text%20%7B%20fill%3A%23333%3Bfont-weight%3Anormal%3Bfont-family%3AHelvetica%2C%20monospace%3Bfont-size%3A40pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_15b81742454%22%3E%3Crect%20width%3D%22800%22%20height%3D%22400%22%20fill%3D%22%23555%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%22277.0078125%22%20y%3D%22217.7%22%3EThird%20slide%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E"""
