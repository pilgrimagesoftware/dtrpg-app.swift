## Why

The app meta-repository now defines shared language-agnostic desktop baseline behavior. The Swift frontend needs a child implementation change to realize those requirements with macOS-native implementation details while remaining backend-stubbed in baseline phase.

This child change also explicitly enforces AppKit-only implementation for the Swift frontend.

## What Changes

- Implement shared baseline library layout/state behavior in the Swift frontend.
- Define Swift macOS implementation details using AppKit-only UI architecture.
- Keep backend communication stubbed in this phase.
- Explicitly prohibit SwiftUI in this implementation path.

## Capabilities

### New Capabilities
- `macos-library-ui-implementation`: Defines Swift macOS AppKit-only implementation of shared desktop library baseline behavior.

## Impact

- `dtrpg-app/swift`: Baseline Swift AppKit implementation details.
- Depends on `dtrpg-app/openspec/changes/define-shared-desktop-library-baseline`.
