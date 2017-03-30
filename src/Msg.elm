module Msg exposing (Msg (..))



import Navigation
import Bootstrap.Navbar as Navbar
import Page.Table as Table
import Page.Progress as Progress
import Page.Grid as Grid
import Page.Tab as Tab
import Page.Dropdown as Dropdown
import Page.Accordion as Accordion
import Page.Modal as Modal
import Page.Navbar as PageNav
import Page.ButtonGroup as ButtonGroup

import Bootstrap.Popover as Popover


type Msg
    = UrlChange Navigation.Location
    | PageChange String
    | NavbarMsg Navbar.State
    | TableMsg Table.State
    | ProgressMsg Progress.State
    | GridMsg Grid.State
    | TabMsg Tab.State
    | DropdownMsg Dropdown.State
    | AccordionMsg Accordion.State
    | ModalMsg Modal.State
    | PageNavMsg PageNav.State
    | ButtonGroupMsg ButtonGroup.State

    -- Popover related
    | PopBasic Popover.State
    | PopTop Popover.State
    | PopBottom Popover.State
    | PopLeft Popover.State
    | PopRight Popover.State
