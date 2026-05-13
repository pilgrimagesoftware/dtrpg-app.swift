## ADDED Requirements

### Requirement: Swift frontend integration MUST use Swift SDK-backed adapters for library workflows
The Swift frontend MUST replace baseline stub adapters with Swift SDK-backed adapters for library loading, refresh, and detail retrieval workflows.

#### Scenario: Loading library data in Swift integration mode
- **WHEN** a user requests library data in the Swift app after integration
- **THEN** the request is handled through Swift SDK-backed adapters instead of baseline stubs

### Requirement: Swift integration MUST remain AppKit-only
The Swift frontend integration implementation MUST continue using AppKit-native implementation patterns and MUST NOT use SwiftUI.

#### Scenario: Integrating backend communication into Swift library views
- **WHEN** maintainers wire SDK-backed data loading and error handling into frontend components
- **THEN** those components remain AppKit-based and contain no SwiftUI usage

### Requirement: Swift adapter integration MUST preserve shared backend recovery behavior
The Swift frontend MUST map Swift SDK and session-related failures into the shared recovery behavior defined by app meta specs.

#### Scenario: Swift SDK-backed request fails
- **WHEN** a backend or session-aware failure occurs in Swift integration mode
- **THEN** the Swift app presents shared recovery behavior while using Swift-specific adapter implementation details
