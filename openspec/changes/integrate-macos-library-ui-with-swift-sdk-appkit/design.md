## Context

Swift baseline behavior is defined and initially stubbed with AppKit UI composition. Integration phase replaces stubs with Swift SDK-backed communication while preserving shared request/recovery behavior.

## Goals / Non-Goals

**Goals:**
- Integrate Swift SDK-backed adapters for library workflows.
- Preserve shared backend request/recovery behavior.
- Keep AppKit-only frontend implementation and explicit adapter boundaries.

**Non-Goals:**
- Introduce SwiftUI.
- Redefine shared behavior in Swift child specs.
- Redefine Swift SDK contracts in app specs.

## Decisions

Use a Swift-specific adapter capability for integration details.
Rationale: SDK wiring and error mapping details are language-specific.

Retain AppKit-only implementation policy in integration phase.
Rationale: frontend policy applies through both baseline and integrated phases.
