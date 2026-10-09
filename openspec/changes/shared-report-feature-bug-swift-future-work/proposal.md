# Proposal

## Why

The `shared-report-feature-bug` baseline (`dtrpg-app/openspec/changes/define-shared-report-feature-bug`) defines a language-agnostic "Report a Feature/Bug" menu item and dialog, already implemented for the Rust frontend (pilgrimagesoftware/dtrpg-app.rs#243). The parent proposal explicitly defers Swift parity rather than blocking the Rust baseline on it. This placeholder tracks that deferral so it isn't lost.

## What Changes

- Nothing yet. This is a future-work placeholder, not an active change.
- When picked up: implement the same Help-menu entry, account-menu entry, Bug/Feature Request dialog (subject, description, diagnostics), and browser-handoff submission to a pre-filled GitHub "new issue" URL, matching the Rust implementation's behavior.

## Tracking

- GitHub Issue: pilgrimagesoftware/dtrpg-app.swift#3
- Parent spec: `dtrpg-app/openspec/changes/define-shared-report-feature-bug`
- Reference implementation: `dtrpg-app/rust/openspec/changes/shared-report-feature-bug`
