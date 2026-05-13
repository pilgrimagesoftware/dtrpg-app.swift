## Context

Shared app-level specs define baseline desktop behavior across frontends. Swift implementation must realize this behavior using AppKit and stubbed service adapters in baseline phase.

## Goals / Non-Goals

**Goals:**
- Implement shared baseline layout/state behavior in the Swift frontend.
- Use AppKit-only UI implementation and architecture.
- Keep backend calls stubbed during baseline phase.

**Non-Goals:**
- Use SwiftUI for baseline implementation.
- Integrate real Swift SDK backend communication in this phase.
- Redefine shared behavior from app meta specs.

## Decisions

Require AppKit-only implementation.
Rationale: frontend policy requires Swift desktop implementation to avoid SwiftUI.

Use stub adapters behind service boundaries.
Rationale: creates a clean seam for follow-up Swift SDK integration.
