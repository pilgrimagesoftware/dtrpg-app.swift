## Why

After baseline Swift AppKit UI behavior is implemented with stubs, the Swift frontend needs a dedicated child change to replace stubs with real Swift SDK communication while preserving shared integration behavior.

This child change continues to enforce AppKit-only frontend implementation.

## What Changes

- Replace Swift baseline stubs with Swift SDK-backed adapters.
- Preserve shared desktop backend integration behavior and Swift app boundaries.
- Define Swift-specific adapter/error/session mapping concerns.
- Keep frontend implementation AppKit-only and prohibit SwiftUI.

## Capabilities

### New Capabilities
- `macos-library-sdk-adapter`: Defines Swift macOS AppKit frontend adapter behavior for integrating Swift SDK into library workflows.

## Impact

- `dtrpg-app/swift`: Swift-specific backend integration implementation.
- Depends on `dtrpg-app/openspec/changes/define-shared-desktop-library-sdk-integration`.
- Depends on `dtrpg-sdk/swift` backend capabilities.
