## Why

`dtrpg-app` now defines `shared-main-window-structure`, replacing the disclosable search/filter
strip and content-area account menu that `macos-main-window-library-layout` planned for AppKit
with a title bar, a persistent sidebar, tabbed content, and a status bar. The Swift macOS app
needs a child change mapping that structure to native AppKit/SwiftUI, since implementation of the
prior layout is still early (2/11 tasks complete).

## What Changes

- Define a native title bar region above the content area with a horizontal separator, the window
  title, and an account button opening a menu with user info, a settings action, and a sign-out
  action, built on `NSToolbar` or an equivalent title-bar-adjacent AppKit surface.
- Define a collapsible `NSSplitViewItem`-based sidebar with default navigation section counts, a
  Collections section (count, search, add, collapse), and a Publishers section (count, search,
  collapse).
- Define a tabbed content area using `NSTabView` or a SwiftUI `TabView` equivalent, with a
  non-closable catalog tab first, an overflow "more" menu for tabs that exceed available width,
  and closable expanded detail tabs.
- Define catalog item interaction: single-click opens an `NSPopover` detail view without creating a
  tab; double-click opens a closable expanded detail tab with a large thumbnail, item attributes,
  and a file list for multi-item entries.
- Define a status bar region below the content area with total library item count and size, an
  active-tab summary, a theme picker, an activity indicator, and a notification indicator, each
  exposing a hover tooltip summary and a click-through detail surface.
- Retire the disclosable search/filter strip and content-area account menu planned in
  `define-macos-main-window-library-layout` in favor of the tab header, title bar, and status bar
  defined here.

## Capabilities

### New Capabilities

- `macos-main-window-structure`: Defines the AppKit-specific title bar, sidebar, tabbed content
  area, and status bar for the Swift macOS app.

## Impact

- `dtrpg-app/swift/openspec`: Adds `macos-main-window-structure`.
- Affected code: macOS main window scene, sidebar, catalog view, and status bar AppKit/SwiftUI
  modules (exact file paths determined during implementation planning).
- Depends on `dtrpg-app/openspec/changes/add-shared-main-window-structure`.
- Supersedes the still-in-progress search/filter and account-menu portions of
  `define-macos-main-window-library-layout`; must remain compatible with `library-view-state` and
  `macos-auth-session-management`.
