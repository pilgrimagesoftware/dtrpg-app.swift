import XCTest

@testable import DTRPGClient

final class DTRPGClientTests: XCTestCase {

    func testClientStartsSignedOut() {
        let client = DTRPGClient()

        XCTAssertEqual(client.sessionState, .signedOut)
        XCTAssertNil(client.activeSession)
    }

    func testApplyAuthResponseStoresAuthenticatedSession() {
        let expiry = Date(timeIntervalSince1970: 1_800_000_000)
        let response = AuthTokenResponse(
            token: "access-token",
            refreshToken: "refresh-token",
            refreshTokenExpiresAt: expiry
        )
        let client = DTRPGClient()

        let transition = client.applyAuthResponse(response)

        let expectedSession = AuthSession(response: response)
        XCTAssertEqual(transition.previousState, .signedOut)
        XCTAssertEqual(transition.nextState, .authenticated(expectedSession))
        XCTAssertEqual(client.sessionState, .authenticated(expectedSession))
        XCTAssertEqual(client.activeSession, expectedSession)
    }

    func testRestoreSessionRejectsExpiredRefreshToken() {
        let now = Date(timeIntervalSince1970: 1_800_000_000)
        let expiredSession = AuthSession(
            token: "access-token",
            refreshToken: "refresh-token",
            refreshTokenExpiresAt: now
        )
        let client = DTRPGClient(sessionState: .restoring)

        let transition = client.restoreSession(expiredSession, now: now)

        let expectedError = AuthSessionError(
            errorCode: AuthState.refreshExpired.rawValue,
            message: "The stored refresh token has expired.",
            authState: .refreshExpired
        )
        XCTAssertEqual(transition.previousState, .restoring)
        XCTAssertEqual(transition.nextState, .needsReauthentication(expectedError))
        XCTAssertEqual(transition.error, expectedError)
        XCTAssertEqual(client.sessionState, .needsReauthentication(expectedError))
        XCTAssertNil(client.activeSession)
    }

    func testRestoreSessionAcceptsUnexpiredRefreshToken() {
        let now = Date(timeIntervalSince1970: 1_800_000_000)
        let session = AuthSession(
            token: "access-token",
            refreshToken: "refresh-token",
            refreshTokenExpiresAt: now.addingTimeInterval(60)
        )
        let client = DTRPGClient(sessionState: .restoring)

        let transition = client.restoreSession(session, now: now)

        XCTAssertEqual(transition.previousState, .restoring)
        XCTAssertEqual(transition.nextState, .authenticated(session))
        XCTAssertEqual(client.activeSession, session)
    }

    func testInvalidateSessionMovesToReauthenticationState() {
        let session = AuthSession(
            token: "access-token",
            refreshToken: "refresh-token",
            refreshTokenExpiresAt: Date(timeIntervalSince1970: 1_800_000_000)
        )
        let error = AuthSessionError(
            errorCode: AuthState.tokenExpired.rawValue,
            message: "The access token has expired.",
            authState: .tokenExpired
        )
        let client = DTRPGClient(sessionState: .authenticated(session))

        let transition = client.invalidateSession(error: error)

        XCTAssertEqual(transition.previousState, .authenticated(session))
        XCTAssertEqual(transition.nextState, .needsReauthentication(error))
        XCTAssertEqual(transition.error, error)
        XCTAssertNil(client.activeSession)
    }

    func testSignOutClearsSessionState() {
        let session = AuthSession(
            token: "access-token",
            refreshToken: "refresh-token",
            refreshTokenExpiresAt: Date(timeIntervalSince1970: 1_800_000_000)
        )
        let client = DTRPGClient(sessionState: .authenticated(session))

        let transition = client.signOut()

        XCTAssertEqual(transition.previousState, .authenticated(session))
        XCTAssertEqual(transition.nextState, .signedOut)
        XCTAssertEqual(client.sessionState, .signedOut)
        XCTAssertNil(client.activeSession)
    }
}
