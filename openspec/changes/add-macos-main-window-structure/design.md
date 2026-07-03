## Context

`define-macos-main-window-library-layout` planned an AppKit main window with a disclosable
search/filter strip and a content-area account menu; implementation is early (2/11 tasks). Rather
than finishing that layout and reworking it immediately after, this change replaces the remaining
planned work with the title bar, sidebar, tabs, and status bar structure now required by
`shared-main-window-structure`.

## Goals / Non-Goals

**Goals:**

- Map `shared-main-window-structure` onto native AppKit/SwiftUI.
- Reuse `library-view-state` and `macos-auth-session-management` rather than redefining browsing
  state or auth/session handling.
- Define the tab strip, catalog tab header, and popover/tab detail interaction model for macOS.

**Non-Goals:**

- Define exact AppKit/SwiftUI view class names or file layout.
- Redefine authentication/session lifecycle.
- Specify pixel dimensions or animation timing.

## Decisions

Supersede the remaining incomplete portions of `define-macos-main-window-library-layout` rather
than completing it first.
Rationale: only 2 of 11 tasks are done; finishing the old search/filter strip design just to retire
it immediately would waste implementation effort.

Use `NSPopover` for single-click detail and a tab-based `NSTabView`/SwiftUI `TabView` for
double-click expanded detail.
Rationale: matches native macOS interaction idioms and keeps the popover lightweight relative to
the full tab-hosted detail view.

## Risks / Trade-offs

- **Risk: Superseding the in-progress layout change loses prior planning work** -> Mitigation:
  carry forward `library-view-state` and any completed account/session groundwork; only the
  container regions change.
- **Risk: AppKit tab overflow has no first-party "more" menu equivalent** -> Mitigation: implement
  the overflow menu as a custom `NSMenu` triggered by an overflow button when the tab strip
  exceeds available width.

## Migration Plan

1. Land `shared-main-window-structure` in `dtrpg-app` (already complete).
2. Mark the superseded search/filter and account-menu tasks in
   `define-macos-main-window-library-layout` as retired in favor of this change.
3. Implement the title bar, sidebar, tabs, and status bar in sequence, verifying against
   `library-view-state` and `macos-auth-session-management` compatibility at each step.
