## Why

The app meta-repository defines shared, language-agnostic settings window presentation behavior in `dtrpg-app/openspec/changes/define-shared-settings-window-presentation`: settings open in a separate, non-modal window instead of an in-window overlay. The Swift frontend needs a child implementation change so that when its settings feature is built, it realizes that behavior using AppKit-native window mechanics (the Swift frontend is currently at scaffolding stage with no settings implementation yet — this establishes the contract before that work starts).

This child change also explicitly enforces AppKit-only implementation, consistent with the Swift frontend's baseline policy.

## What Changes

- Define AppKit implementation details for settings window presentation: a dedicated `NSWindowController`/`NSWindow` for settings, opened separately from the main library window.
- The settings window is non-modal: it MUST be opened as an ordinary window (`orderFront`/`makeKeyAndOrderFront`), never as a sheet, modal panel, or `NSApp.runModal` loop, so the main library window stays interactive.
- A single settings window instance is tracked and reused; repeat invocation of the Settings action brings the existing window to front instead of creating a duplicate.
- Closing the settings window (via its close button or Escape) hides/closes the window without terminating the app; reopening reuses the existing settings view model so in-progress edits persist for the session.
- Explicitly prohibit SwiftUI for this window's implementation.

## Capabilities

### New Capabilities
- `macos-settings-window-implementation`: Defines the AppKit-only implementation of the shared settings window presentation behavior — dedicated non-modal `NSWindowController`, single-instance reuse, state persistence across close/reopen — for the Swift frontend.

## Impact

- `dtrpg-app/swift`: New settings window controller and its integration with the app's menu/keyboard shortcut for opening settings (once a settings feature exists to host).
- Depends on `dtrpg-app/openspec/changes/define-shared-settings-window-presentation`.
- No changes to backend/SDK communication; this concerns window presentation only.
