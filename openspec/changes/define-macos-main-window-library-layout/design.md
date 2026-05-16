## Context

The Swift frontend is currently governed by AppKit-only library UI and SDK integration proposals. Existing specs define broad library view-state and auth-session behavior, but the app needs a concrete AppKit mapping for the full main-window layout contract.

## Goals / Non-Goals

**Goals:**

- Preserve the AppKit-only implementation policy.
- Define macOS controls for disclosable search/filter state, view mode, grouping, sorting, account menu, summary, and sync status.
- Define UI-facing state needed for browsing, account token status, and background sync progress.
- Require list/tree and grid views to share the same filtered/sorted library result set.
- Keep thumbnail loading asynchronous and metadata visible before thumbnails resolve.

**Non-Goals:**

- Introduce SwiftUI.
- Redefine SDK library response models.
- Define exact AppKit class names or storyboard/nib structure.
- Implement credential storage details beyond UI state and action routing.

## Decisions

Use AppKit-native controls for all main-window regions.
Rationale: existing Swift frontend policy explicitly avoids SwiftUI, and this change should extend that path rather than introduce a second UI framework.

Represent library browsing state separately from presentation widgets.
Rationale: a shared state object or equivalent controller state lets NSTableView/NSOutlineView and NSCollectionView render the same filtered/sorted result set.

Route account actions through an account-menu controller boundary.
Rationale: token set/reset and settings navigation need explicit action handling without exposing raw token values in passive menu content.

Represent sync status as observable UI state.
Rationale: progress, latency, and last-update details must update while the main window remains responsive.

## Risks / Trade-offs

- AppKit grid and outline/list implementations may require different adapters. Mitigation: keep shared browsing state independent of each view adapter.
- Sync progress updates can race with filtering changes. Mitigation: treat sync status as separate state from browsing result state.
- Token reset actions are sensitive. Mitigation: require confirmation or explicit edit flow in implementation and do not display raw tokens passively.
