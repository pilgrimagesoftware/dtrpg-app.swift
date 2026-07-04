## ADDED Requirements

### Requirement: macOS catalog data model MUST expose a per-item file array

The macOS app's catalog entry model MUST expose an array of per-item file records, sourced from
the Swift SDK's generated `OrderProductFile` type, so the app can determine item count and
enumerate each item's name, format, size, and download state.

#### Scenario: Single-item entry has one file

- **WHEN** a catalog entry's file array contains exactly one entry
- **THEN** the macOS app treats it as a single-item entry

#### Scenario: Multi-item entry has more than one file

- **WHEN** a catalog entry's file array contains more than one entry
- **THEN** the macOS app treats it as a multi-item entry

### Requirement: macOS expanded detail tab MUST render a persistent item list for multi-item entries

The expanded detail tab MUST render a persistent, scrollable item list (SwiftUI `List` or `Table`)
when the entry's file array contains more than one entry. Each row MUST show item name and item
type.

#### Scenario: Rendering the item list

- **WHEN** the expanded detail tab is shown for a multi-item entry
- **THEN** the tab renders a persistent list showing all items, each with name and type

#### Scenario: Single-item entry renders no item list

- **WHEN** the expanded detail tab is shown for a single-item entry
- **THEN** no item list is rendered; item metadata is shown inline in the entry tier

### Requirement: macOS item list selection MUST update item metadata in place

Selecting a row in the item list MUST update a dedicated item metadata area within the same
expanded detail tab, using view-local (non-persisted) selection state.

#### Scenario: Selecting an item

- **WHEN** the user selects a row in the item list
- **THEN** the item metadata area shows that item's name, type, format, file size, and download
  state

#### Scenario: No item selected

- **WHEN** the expanded detail tab for a multi-item entry is first shown
- **THEN** the item metadata area shows a prompt indicating an item should be selected

#### Scenario: Reopening the tab does not preserve selection

- **WHEN** the user closes and reopens the expanded detail tab for a multi-item entry
- **THEN** no item is pre-selected and the item metadata area shows its default prompt state

### Requirement: macOS catalog list and grid MUST show an item-count badge for multi-item entries

The macOS catalog browsing surface MUST render a visible item-count indicator on list rows and
grid tiles for entries with more than one file, and MUST NOT render it for single-item entries.

#### Scenario: Multi-item entry in the catalog list or grid

- **WHEN** a catalog entry has more than one file
- **THEN** its list row or grid tile shows a visible item-count indicator

#### Scenario: Single-item entry in the catalog list or grid

- **WHEN** a catalog entry has exactly one file
- **THEN** no item-count indicator is shown

### Requirement: macOS popover detail view SHALL NOT gain an item list

The single-click `NSPopover` detail view SHALL remain a lightweight entry-level summary and SHALL
NOT render an item list or item-selection control, regardless of item count.

#### Scenario: Single-clicking a multi-item entry

- **WHEN** the user single-clicks a catalog entry with more than one file
- **THEN** the popover shows entry-level summary information only, without an item list
