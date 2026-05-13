## ADDED Requirements

### Requirement: Swift macOS baseline implementation MUST satisfy shared desktop library layout behavior
The Swift frontend MUST implement the shared desktop library baseline layout and interaction behavior defined by app meta specs.

#### Scenario: Rendering baseline library layout in Swift
- **WHEN** the Swift app renders the library screen in baseline mode
- **THEN** it presents the shared top-level layout regions and interactions defined by shared app specs

### Requirement: Swift baseline implementation MUST be AppKit-only
The Swift frontend baseline implementation MUST use AppKit-native implementation patterns and MUST NOT use SwiftUI.

#### Scenario: Building baseline Swift library UI components
- **WHEN** maintainers implement library screens and UI flow in baseline phase
- **THEN** those components are implemented with AppKit and contain no SwiftUI usage

### Requirement: Swift baseline implementation MUST use stubbed backend adapters
The Swift frontend baseline implementation MUST keep backend communication stubbed while exercising list/detail/filter/refresh flows.

#### Scenario: Loading library data in Swift baseline mode
- **WHEN** the Swift frontend loads or refreshes library content in baseline phase
- **THEN** it uses stubbed adapters and no live backend SDK calls
