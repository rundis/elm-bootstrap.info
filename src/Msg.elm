module Msg exposing (Msg(..))

import Bootstrap.Navbar as Navbar
import Bootstrap.Popover as Popover
import Page.Accordion as Accordion
import Page.Alert as Alert
import Page.ButtonGroup as ButtonGroup
import Page.Carousel as Carousel
import Page.Dropdown as Dropdown
import Page.Grid as Grid
import Page.InputGroup as InputGroup
import Page.Modal as Modal
import Page.Navbar as PageNav
import Page.Progress as Progress
import Page.Tab as Tab
import Page.Table as Table
import Url exposing (Url)
import Browser exposing (UrlRequest)


type Msg
    = UrlChange Url
    | ClickedLink UrlRequest
    | NavbarMsg Navbar.State
    | TableMsg Table.State
    | ProgressMsg Progress.State
    | GridMsg Grid.State
    | TabMsg Tab.Msg
    | DropdownMsg Dropdown.Msg
    | AccordionMsg Accordion.Msg
    | ModalMsg Modal.Msg
    | PageNavMsg PageNav.Msg
    | ButtonGroupMsg ButtonGroup.State
    | CarouselMsg Carousel.Msg
    | InputGroupMsg InputGroup.Msg
    | AlertMsg Alert.Msg
      -- Popover related
    | PopBasic Popover.State
    | PopTop Popover.State
    | PopBottom Popover.State
    | PopLeft Popover.State
    | PopRight Popover.State
