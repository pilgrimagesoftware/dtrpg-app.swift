## Context

The app layer owns what users experience when a session is restored, expires, or becomes invalid. The API owns token lifecycle meaning, and SDKs adapt those semantics for client libraries. The Swift macOS app needs a small, testable session-state model before UI screens can consistently react to auth changes.

## Goals / Non-Goals

**Goals:**
- Represent app-visible authentication state in Swift.
- Preserve API-defined auth state names and meanings.
- Make restoration, invalidation, sign-out, and reauthentication transitions explicit.
- Keep the implementation usable from future SwiftUI/AppKit flows.

**Non-Goals:**
- Implement HTTP login or refresh requests.
- Persist sessions in Keychain.
- Build the final macOS authentication UI.
- Redefine API token or error semantics.

## Decisions

Represent the current app auth state with a `SessionState` enum.
Rationale: the app needs to distinguish signed-out, restoring, authenticated, and reauthentication-required states before UI can react predictably.

Expose transitions from `DTRPGClient` methods.
Rationale: returning `SessionTransition` lets callers observe how a user flow should move after restore, auth response, invalidation, or sign-out.

Treat refresh token expiry as an app restoration gate.
Rationale: the app can reject expired stored sessions locally while preserving the API-owned meaning of `refresh_expired`.

## Risks / Trade-offs

- This is not yet a complete auth flow. Mitigation: keep networking, secure storage, and UI out of scope until their specs are ready.
- The Swift model may later need to align with generated SDK types. Mitigation: keep the fields and auth-state strings compatible with upstream API semantics.
