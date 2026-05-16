## Why

The Swift macOS app needs an AppKit-specific implementation plan for the shared main-window library layout now defined by the top-level and app-level OpenSpec changes. Without a child proposal, the macOS frontend can satisfy baseline library loading while missing the richer browsing, account, and sync affordances expected by the shared product contract.

## What Changes

- Define AppKit-native main-window layout behavior for the DriveThruRPG library browsing surface.
- Map the shared disclosable search/filter area to macOS controls without introducing SwiftUI.
- Define macOS account menu behavior for identity, token set/reset actions, and settings navigation.
- Define macOS library presentation state for list/tree and grid views using one shared filtered/sorted result set.
- Define non-blocking sync status and asynchronous thumbnail loading expectations for the macOS app.

## Capabilities

### New Capabilities

- `macos-main-window-library-layout`: Defines AppKit-specific main-window layout, browsing state, account menu, and sync-status behavior for the Swift macOS app.

## Impact

- `dtrpg-app/swift`: Adds macOS implementation planning for the shared main-window library layout.
- Depends on `dtrpg-app/openspec/changes/define-shared-main-window-library-layout`.
- Must remain compatible with `library-view-state` and `macos-auth-session-management`.
