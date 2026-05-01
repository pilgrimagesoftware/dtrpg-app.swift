
import Foundation

public struct AuthTokenResponse: Equatable, Sendable {
    public let token: String
    public let refreshToken: String
    public let refreshTokenExpiresAt: Date

    public init(token: String, refreshToken: String, refreshTokenExpiresAt: Date) {
        self.token = token
        self.refreshToken = refreshToken
        self.refreshTokenExpiresAt = refreshTokenExpiresAt
    }
}

public enum AuthState: String, Equatable, Sendable {
    case unauthenticated
    case tokenInvalid = "token_invalid"
    case tokenExpired = "token_expired"
    case refreshExpired = "refresh_expired"
    case unauthorized
}

public struct AuthSessionError: Error, Equatable, Sendable {
    public let errorCode: String
    public let message: String
    public let authState: AuthState

    public init(errorCode: String, message: String, authState: AuthState) {
        self.errorCode = errorCode
        self.message = message
        self.authState = authState
    }
}

public struct AuthSession: Equatable, Sendable {
    public let token: String
    public let refreshToken: String
    public let refreshTokenExpiresAt: Date

    public init(token: String, refreshToken: String, refreshTokenExpiresAt: Date) {
        self.token = token
        self.refreshToken = refreshToken
        self.refreshTokenExpiresAt = refreshTokenExpiresAt
    }

    public init(response: AuthTokenResponse) {
        self.init(
            token: response.token,
            refreshToken: response.refreshToken,
            refreshTokenExpiresAt: response.refreshTokenExpiresAt
        )
    }

    public func isRefreshTokenExpired(at date: Date = Date()) -> Bool {
        date >= refreshTokenExpiresAt
    }
}

public enum SessionState: Equatable, Sendable {
    case signedOut
    case restoring
    case authenticated(AuthSession)
    case needsReauthentication(AuthSessionError?)
}

public struct SessionTransition: Equatable, Sendable {
    public let previousState: SessionState
    public let nextState: SessionState
    public let error: AuthSessionError?

    public init(previousState: SessionState, nextState: SessionState, error: AuthSessionError? = nil) {
        self.previousState = previousState
        self.nextState = nextState
        self.error = error
    }
}

public final class DTRPGClient {
    public private(set) var sessionState: SessionState

    public init(sessionState: SessionState = .signedOut) {
        self.sessionState = sessionState
    }

    @discardableResult
    public func beginRestoringSession() -> SessionTransition {
        transition(to: .restoring)
    }

    @discardableResult
    public func restoreSession(_ session: AuthSession, now: Date = Date()) -> SessionTransition {
        if session.isRefreshTokenExpired(at: now) {
            let error = AuthSessionError(
                errorCode: AuthState.refreshExpired.rawValue,
                message: "The stored refresh token has expired.",
                authState: .refreshExpired
            )
            return transition(to: .needsReauthentication(error), error: error)
        }

        return transition(to: .authenticated(session))
    }

    @discardableResult
    public func applyAuthResponse(_ response: AuthTokenResponse) -> SessionTransition {
        transition(to: .authenticated(AuthSession(response: response)))
    }

    @discardableResult
    public func invalidateSession(error: AuthSessionError) -> SessionTransition {
        transition(to: .needsReauthentication(error), error: error)
    }

    @discardableResult
    public func signOut() -> SessionTransition {
        transition(to: .signedOut)
    }

    public var activeSession: AuthSession? {
        guard case let .authenticated(session) = sessionState else {
            return nil
        }

        return session
    }

    private func transition(to nextState: SessionState, error: AuthSessionError? = nil) -> SessionTransition {
        let previousState = sessionState
        sessionState = nextState
        return SessionTransition(previousState: previousState, nextState: nextState, error: error)
    }
}
