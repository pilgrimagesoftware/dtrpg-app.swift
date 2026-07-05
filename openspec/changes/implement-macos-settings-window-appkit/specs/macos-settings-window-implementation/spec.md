## ADDED Requirements

### Requirement: Settings window is owned by a dedicated NSWindowController
The Swift frontend SHALL present settings using a dedicated `NSWindowController` subclass with its own `NSWindow`, implemented with AppKit only (no SwiftUI), rather than a view composited inside the main library window.

#### Scenario: Opening settings from the main window
- **WHEN** the user triggers the settings action while no settings window controller is tracked as open
- **THEN** the app instantiates (or reuses) the settings `NSWindowController` and shows its window via `orderFront`/`makeKeyAndOrderFront`

### Requirement: Settings window MUST be non-modal
The Swift frontend SHALL show the settings window as an ordinary top-level window, never as a sheet, modal panel, or via `NSApp.runModal`.

#### Scenario: Main window stays interactive while settings is open
- **WHEN** the settings window is open
- **THEN** the user can click, scroll, and interact with the main library window without first closing the settings window

### Requirement: A single settings window controller instance is tracked and reused
The Swift frontend SHALL avoid creating duplicate settings windows.

#### Scenario: Triggering the settings action while already open
- **WHEN** the settings action fires and a settings window controller instance is already tracked and its window is visible
- **THEN** the app calls `makeKeyAndOrderFront` on the existing window instead of instantiating a new controller

### Requirement: Settings state persists across window close/reopen
The Swift frontend SHALL retain the settings window's backing view model and window instance (`isReleasedWhenClosed = false`) across close/reopen within a session.

#### Scenario: Reopening settings after close
- **WHEN** the user closes the settings window and then triggers the settings action again
- **THEN** the settings window reopens attached to the same view model state as before it was closed

#### Scenario: Closing settings does not quit the app
- **WHEN** the user closes the settings window
- **THEN** the application continues running and the main library window is unaffected
