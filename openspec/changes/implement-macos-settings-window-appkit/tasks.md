## 1. Settings window controller

- [ ] 1.1 Create a dedicated `NSWindowController` subclass for settings, backed by an AppKit view (no SwiftUI), following the frontend's AppKit-only policy.
- [ ] 1.2 Set `window.isReleasedWhenClosed = false` so the window and its view model persist across close/reopen.
- [ ] 1.3 Show the window via `orderFront`/`makeKeyAndOrderFront` only — never `beginSheet` or `runModal`.

## 2. Single-instance tracking

- [ ] 2.1 Add a tracked reference to the settings window controller (e.g. on the app delegate or a coordinator), set on first open.
- [ ] 2.2 Route the settings action/menu item to reuse the tracked controller if its window is already visible, calling `makeKeyAndOrderFront` instead of creating a new instance.

## 3. State persistence

- [ ] 3.1 Back the settings window with a view model that outlives window close (owned by the coordinator, not the window controller alone).
- [ ] 3.2 Verify draft/tab/scroll state in the settings view model survives a close/reopen cycle.

## 4. Manual verification

- [ ] 4.1 Once a settings feature exists to host: open settings, confirm it appears as a separate window and the main library window remains interactive.
- [ ] 4.2 Trigger the settings action again while open; confirm the existing window is brought to front rather than duplicated.
- [ ] 4.3 Close the settings window and confirm the app does not quit and the main window is unaffected.
- [ ] 4.4 Reopen settings and confirm prior state (draft values, active tab) persisted.
