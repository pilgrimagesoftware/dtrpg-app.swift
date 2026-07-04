## Why

`dtrpg-app` now defines `shared-catalog-entry-detail-view`, specifying the entry-tier/item-tier
layout and persistent item list that must fill the expanded detail tab. `add-macos-main-window-structure`
already plans a double-click expanded detail tab "with a large thumbnail, item attributes, and a
file list for multi-item entries" (task 4.4) but leaves that file list unspecified. This change
defines the SwiftUI-specific implementation of the item-tier behavior inside that tab, so task 4.4
has a concrete contract to implement against rather than open-ended wording.

## What Changes

- Define a per-item file model in the macOS app's data layer, sourced from the Swift SDK's
  generated `OrderProductFile` type, exposing item name, format, size, and download state.
- Define the persistent item list panel (SwiftUI `List` or `Table`) rendered inside the expanded
  detail tab for multi-item entries, and the inline-collapse behavior for single-item entries.
- Define item-selection wiring so selecting a row updates an item metadata area in place within
  the same tab.
- Define the empty/prompt state for the item metadata area when no item is selected.
- Define the item-count badge for catalog list rows and grid tiles.
- Confirm the single-click `NSPopover` detail view (also planned in `add-macos-main-window-structure`,
  task 4.3) stays a lightweight entry-level summary and does not gain an item list.

## Capabilities

### New Capabilities

- `macos-catalog-entry-detail-view`: Defines the SwiftUI-specific data model, item list panel, and
  selection wiring implementing `shared-catalog-entry-detail-view` in the macOS app.

## Impact

- `dtrpg-app/swift/openspec`: Adds `macos-catalog-entry-detail-view`.
- Affected code: the macOS app's catalog data model and expanded detail tab view (exact file paths
  determined during implementation, since `add-macos-main-window-structure`'s tab and popover views
  are not yet built).
- Depends on `dtrpg-app/openspec/changes/define-shared-catalog-entry-detail-view`.
- Depends on `add-macos-main-window-structure` for the tab/popover shell this change fills.
- Depends on SDK coverage confirmed in `dtrpg/openspec/changes/multi-item-catalog-entry-detail`
  (Swift SDK generates `OrderProductFile` from `openapi.yaml` at build time).
