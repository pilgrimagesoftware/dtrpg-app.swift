## Context

`add-macos-main-window-structure` plans the title bar, sidebar, tabbed content area, and status
bar for the macOS app (2/17 tasks complete at time of writing); its task 4.4, "Implement
double-click expanded detail tab with thumbnail, attributes, and file list," is not yet started.
No detail view, popover, or per-item data model exists in the codebase yet — the Swift app's
`Sources/` currently contains only the generated SDK client scaffold. This change defines what
task 4.4's file list looks like before that implementation begins, so it is built directly against
`shared-catalog-entry-detail-view` rather than reinterpreted ad hoc.

## Goals / Non-Goals

**Goals:**

- Define a per-item file model sourced from the Swift SDK's generated `OrderProductFile` type.
- Define the item list panel and item metadata area inside the expanded detail tab.
- Define single-item inline collapse and multi-item persistent list behavior.
- Define the item-count badge for catalog rows/tiles.

**Non-Goals:**

- Building the title bar, sidebar, tab strip, or status bar — owned by
  `add-macos-main-window-structure`.
- Redesigning the popover beyond confirming it stays a lightweight summary.
- Specifying exact AppKit/SwiftUI view hierarchy file names, since no detail view code exists yet;
  naming is decided during implementation following this repo's existing SwiftUI conventions.

## Decisions

### 1. Item list uses a native SwiftUI `List`/`Table`, not a custom stack layout

The persistent item list is implemented with SwiftUI's `List` (or `Table` if column-style
name/type/size display is wanted) bound to the per-item file array, consistent with this
project's SwiftUI-first approach (see `docs/swift.md`: protocols + struct first, small pure
views).

**Rationale:** Native list/table components handle selection state, scrolling, and Dynamic Type
sizing without custom reimplementation, matching the project's stated preference for
straightforward SwiftUI primitives over custom layout code.

**Alternative considered:** A custom `ScrollView` of manually laid-out rows. Rejected — no reason
to hand-roll list behavior SwiftUI already provides, and it would diverge from the Rust app's
equivalent decision to use a native tabular component (`gpui-component::DataTable`).

### 2. Selected item state is local view state, not persisted

Following `shared-catalog-entry-detail-view`'s ephemeral-selection requirement, the selected item
is `@State` scoped to the detail tab's view, not written to any persistence layer or view model
that outlives the tab's lifetime.

**Rationale:** Matches the umbrella and shared spec's explicit ephemeral-selection requirement;
avoids adding state management complexity for a value with no cross-session meaning.

**Alternative considered:** Track selection in a `@StateObject` view model that outlives the tab.
Rejected — unnecessary for state that resets whenever the tab reopens.

### 3. Popover stays out of scope

The single-click `NSPopover` (task 4.3 of `add-macos-main-window-structure`) is referenced but not
modified by this change. It must not render an item list regardless of item count, matching the
`shared-main-window-structure` delta and `shared-catalog-entry-detail-view`.

**Rationale:** Keeps the popover/tab boundary consistent with the Rust app's equivalent decision
and the shared spec's explicit requirement.

## Risks / Trade-offs

- **Risk: `add-macos-main-window-structure`'s tab implementation (task 4.4) and this change land
  out of order, leaving a placeholder file list** → Mitigation: this change's tasks assume task
  4.4's tab shell exists first; if it doesn't, the first task here is to stub a minimal tab content
  container rather than block on the other change's full completion.
- **Risk: Swift SDK's generated `OrderProductFile` type name or field names differ from the Rust
  SDK's hand-written equivalent** → Mitigation: confirm the generated type's actual field names
  during implementation via `swift build` output; do not assume field-for-field parity with the
  Rust struct.

## Migration Plan

1. Confirm `add-macos-main-window-structure` task 4.4 has landed a tab content container (or land
   a minimal one here if not).
2. Add the per-item file model sourced from the generated SDK type.
3. Implement the item list panel and item metadata area.
4. Add the item-count badge to catalog rows/tiles.
5. Verify the popover renders no item list.

## Open Questions

- Should the item list panel appear beside the entry metadata (side-by-side) or below it, and does
  that depend on window width? (`shared-catalog-entry-detail-view`'s parent design.md leaves this
  breakpoint to child app proposals — to be decided alongside `add-macos-main-window-structure`'s
  tab layout work.)
