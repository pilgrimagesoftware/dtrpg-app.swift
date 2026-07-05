## Context

`dtrpg-app/openspec/changes/define-shared-settings-window-presentation` defines the language-agnostic behavior this change implements: settings open in a separate, non-modal window; a single instance is reused on repeat invocation; state persists across close/reopen; closing settings never quits the app. This document covers only the AppKit-specific mechanics for satisfying that behavior in the Swift frontend.

The Swift frontend is currently at scaffolding stage (`Package.swift` and a single `DTRPGClient.swift` source file) with no settings feature or main window controller implemented yet. This change establishes the window-presentation contract to follow once that work begins, rather than modifying existing window code.

## Goals / Non-Goals

**Goals:**
- Settings open in a dedicated `NSWindowController`-owned `NSWindow`, independently movable/closable/resizable from the main library window.
- The settings window is non-modal: opened via `orderFront`/`makeKeyAndOrderFront`, never `beginSheet` or `NSApp.runModal`, so the main library window stays interactive.
- A single tracked settings window controller instance is reused; invoking the settings action while it's open brings it to front instead of instantiating a second controller.
- Closing the settings window doesn't deallocate its view model — state persists for the app session.

**Non-Goals:**
- Define what settings contains (account, storage, file openers, advanced) — no such feature exists yet in Swift; this change only defines window presentation for whenever it's built.
- Use SwiftUI anywhere in this implementation.
- Integrate real backend/SDK communication for settings data.

## Decisions

Own the settings window via a dedicated `NSWindowController` subclass, held as a single optional reference (e.g. on the app delegate or a coordinator), rather than instantiating a new controller per invocation.
Rationale: AppKit's `NSWindowController` already owns the window lifecycle (load, show, close) as a single unit; keeping one instance around and calling `showWindow(_:)`/`window?.makeKeyAndOrderFront(_:)` on repeat invocation is the idiomatic way to get single-instance reuse without extra bookkeeping.

Use `window?.orderFront(nil)` / `makeKeyAndOrderFront(nil)` to show the window, never `NSApp.beginSheet` or `runModal`.
Rationale: sheets and modal loops block interaction with their parent window by design — the opposite of the non-modal requirement in the shared spec.

Back the settings window's content with a view model that survives window close.
Rationale: `NSWindowController.close()` hides/releases the window but the controller and its backing view model can remain alive (owned by the coordinator/app delegate) so reopening the window re-attaches to the same state instead of resetting it — mirroring the entity-reuse approach in the Rust child implementation.

## Risks / Trade-offs

- [Risk] `NSWindowController.window` returns `nil` after the underlying `NSWindow` is deallocated (e.g. if `isReleasedWhenClosed` is left at its default `true`), forcing a reload from nib/code on reopen and losing any window-level state (size/position). → Mitigation: set `window.isReleasedWhenClosed = false` on the settings window so the `NSWindow` instance — not just the view model — persists across close/reopen.
- [Risk] Without an existing settings feature to attach to, this change risks defining an implementation contract that drifts from whatever UI is eventually built. → Mitigation: keep this change strictly about window presentation mechanics (non-modal, single-instance, no-deallocate-on-close), which the shared parent spec already constrains at the requirements level; content-specific decisions are explicitly out of scope here.

## Migration Plan

- No migration: greenfield implementation to be done alongside (or ahead of) the Swift settings feature itself.
- No feature flag needed; this is scaffolding for a feature that doesn't ship until built.

## Open Questions

- Should the settings window persist its screen position/size across app restarts (`NSWindow.setFrameAutosaveName`)? Deferred to implementation; not required by the shared spec, so default to no persistence unless requested.
