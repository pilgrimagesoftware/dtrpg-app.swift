## ADDED Requirements

### Requirement: macOS main window MUST provide AppKit-native layout regions
The Swift macOS app MUST implement the shared main-window library layout using AppKit-native controls and view/controller patterns.

#### Scenario: Rendering the macOS main library window
- **WHEN** the macOS app displays the library browsing window
- **THEN** it presents AppKit-native regions for search/filter controls, account menu access, library content, summary, and sync status

### Requirement: macOS search and filter controls MUST be disclosable
The Swift macOS app MUST provide a low-profile disclosable search/filter area with search input, view mode, grouping, and sort controls, plus a collapsed summary of active browsing state.

#### Scenario: Toggling macOS filter disclosure
- **WHEN** the user expands or collapses the search/filter area
- **THEN** the macOS app preserves active search, filter, view mode, grouping, and sort state

### Requirement: macOS library presentations MUST share browsing state
The Swift macOS app MUST use one UI-facing browsing state for list, tree, and grid presentations so mode changes preserve the current filtered and sorted result set.

#### Scenario: Switching between macOS list, tree, and grid views
- **WHEN** the user switches library presentation mode
- **THEN** the same matched items, grouping, and sort order are represented in the selected AppKit presentation

### Requirement: macOS account menu MUST expose account actions safely
The Swift macOS app MUST provide an account button menu that displays DriveThruRPG account identity or connection status, token set/reset actions, and settings navigation without passively showing raw access-token values.

#### Scenario: Opening the macOS account menu
- **WHEN** the user opens the account menu
- **THEN** the menu exposes account status, token management actions, and settings access without raw token disclosure

### Requirement: macOS sync and thumbnail loading MUST be non-blocking
The Swift macOS app MUST keep background library sync and thumbnail loading from blocking main-window interaction.

#### Scenario: Syncing or loading thumbnails on macOS
- **WHEN** the macOS app syncs library metadata or resolves grid thumbnails
- **THEN** the user can continue interacting with library controls and visible title/size metadata
