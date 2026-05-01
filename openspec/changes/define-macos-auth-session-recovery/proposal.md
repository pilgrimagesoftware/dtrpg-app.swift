## Why

The Swift macOS app has specs for auth session management, but it does not yet have an implementation-level change that ties API-owned auth/session semantics to app-owned recovery behavior. Without that child change, the umbrella auth rollout is missing the application layer.

## What Changes

- Define the Swift macOS app as the child implementation owner for session expiry and recovery UX.
- Add app-level behavior for restoring stored sessions, accepting fresh auth responses, invalidating unusable sessions, and requiring reauthentication.
- Keep API token/error meaning upstream in `dtrpg-api` and SDK lifecycle adaptation upstream in `dtrpg-sdk`.
- Introduce a small SwiftPM foundation for session state transitions that future UI flows can observe.

## Capabilities

### Modified Capabilities
- `macos-auth-session-management`: Defines Swift macOS session restoration, expiry, invalidation, and reauthentication state transitions.

## Impact

- `dtrpg-app/swift`: Adds the child app-layer OpenSpec change and Swift session-state primitives.
- Depends on `dtrpg-api/openspec/changes/define-auth-session-contract` for token lifecycle and error meaning.
- Follows `dtrpg-sdk/rust/openspec/changes/define-rust-auth-session-behavior` as the current SDK lifecycle example without copying Rust-specific implementation details.
