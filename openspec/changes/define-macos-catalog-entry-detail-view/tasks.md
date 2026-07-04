## 1. Data Model

- [ ] 1.1 Confirm the Swift SDK's generated `OrderProductFile` type and its field names (build the
      SDK and inspect generated output; do not assume parity with the Rust SDK's hand-written type)
- [ ] 1.2 Add a per-item file array to the macOS app's catalog entry model, mapped from the SDK type

## 2. Expanded Detail Tab

- [ ] 2.1 Confirm `add-macos-main-window-structure` task 4.4 has landed a tab content container;
      if not, stub a minimal container here rather than blocking
- [ ] 2.2 Implement the persistent item list (SwiftUI `List` or `Table`) for multi-item entries
- [ ] 2.3 Wire item list row selection to update an item metadata area in place, using view-local
      state (no persistence)
- [ ] 2.4 Implement the empty/prompt state for the item metadata area when no item is selected
- [ ] 2.5 Collapse item metadata inline into the entry tier for single-item entries (no item list)

## 3. Catalog Browsing Indicator

- [ ] 3.1 Add item-count badge rendering to catalog list rows for multi-item entries
- [ ] 3.2 Add item-count badge rendering to catalog grid tiles for multi-item entries

## 4. Popover Verification

- [ ] 4.1 Confirm the single-click `NSPopover` (task 4.3 of `add-macos-main-window-structure`)
      renders only entry-level summary information for multi-item entries, with no item list

## 5. Verification

- [ ] 5.1 Test single-item entry: detail tab shows entry and item metadata inline, no item list
- [ ] 5.2 Test multi-item entry: detail tab shows item list; selecting each item updates metadata
- [ ] 5.3 Test item-count badge appears only on multi-item entries in list and grid
- [ ] 5.4 Test reopening a multi-item entry's tab shows no pre-selected item
- [ ] 5.5 Test item list scrollability with an entry that has many items
