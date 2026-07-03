## ADDED Requirements

### Requirement: macOS main window MUST provide a native title bar region
The Swift macOS app MUST implement a title bar region above the content area, separated by a
horizontal rule, showing the window title and an account button that opens a menu with user info,
a settings action, and a sign-out action.

#### Scenario: Rendering the macOS title bar
- **WHEN** the macOS app displays the main window
- **THEN** it shows the title bar with the window title, a horizontal separator, and the account
  button

#### Scenario: Signing out from the macOS title bar
- **WHEN** the user selects sign-out from the title bar account menu
- **THEN** the macOS app ends the current session and returns to the signed-out state

### Requirement: macOS sidebar MUST be collapsible with section counts
The Swift macOS app MUST implement a collapsible `NSSplitViewItem` sidebar with default navigation
sections showing item counts, a Collections section (count, search, add, collapse), and a
Publishers section (count, search, collapse).

#### Scenario: Collapsing the macOS sidebar
- **WHEN** the user collapses the sidebar
- **THEN** the content area gains the width previously occupied by the sidebar, and the state
  persists across navigation within the session

### Requirement: macOS main content area MUST use a native tab strip
The Swift macOS app MUST present a tab strip with a non-closable catalog tab first, an overflow
"more" menu for tabs exceeding available width, and closable expanded detail tabs.

#### Scenario: Opening the macOS tab overflow menu
- **WHEN** more tabs are open than fit the tab strip width
- **THEN** the macOS app shows a "more" menu listing the remaining tabs, and selecting one
  activates it

#### Scenario: Catalog tab cannot be closed
- **WHEN** the user views the catalog tab
- **THEN** the macOS app does not render a close control for it

### Requirement: macOS catalog items MUST distinguish popover and tab detail
The Swift macOS app MUST open an `NSPopover` detail view on single-click and a new closable
expanded detail tab on double-click, with the expanded tab showing a large thumbnail, item
attributes, and a file list for multi-item entries.

#### Scenario: Opening a macOS popover detail
- **WHEN** the user single-clicks a catalog item
- **THEN** the macOS app shows an anchored popover with item detail and does not modify the tab
  strip

#### Scenario: Opening a macOS expanded detail tab
- **WHEN** the user double-clicks a catalog item
- **THEN** the macOS app opens a new closable tab with a large thumbnail, item attributes, and a
  file list when the item bundles multiple files

### Requirement: macOS status bar MUST consolidate library, theme, activity, and notification indicators
The Swift macOS app MUST provide a status bar showing total library item count and size, the
active tab's summary, a theme picker, an activity indicator, and a notification indicator, each
exposing a hover tooltip summary and a click-through detail surface.

#### Scenario: Viewing the macOS status bar
- **WHEN** the macOS app displays the main window
- **THEN** the status bar shows library totals, the active tab summary, and the theme, activity,
  and notification indicators
