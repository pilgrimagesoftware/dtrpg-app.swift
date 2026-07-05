import Foundation
#if canImport(AppKit)
import AppKit
#endif

public enum ItemOpenError: Error, Equatable, LocalizedError {
    case fileNotFound(path: String)
    case noDefaultApp
    case osFailed

    public var errorDescription: String? {
        switch self {
        case .fileNotFound(let path):
            return "File not found: \(path)"
        case .noDefaultApp:
            return "No default application configured for this file type."
        case .osFailed:
            return "Failed to open file."
        }
    }
}

/// Opens a downloaded catalog item's file in the system's default application.
///
/// - Parameter url: The local file URL to open.
/// - Throws: `ItemOpenError.fileNotFound` if no file exists at `url`,
///   `ItemOpenError.osFailed` if `NSWorkspace` reports failure.
public func openItem(at url: URL) throws {
    guard FileManager.default.fileExists(atPath: url.path) else {
        throw ItemOpenError.fileNotFound(path: url.path)
    }

    #if canImport(AppKit)
    guard NSWorkspace.shared.open(url) else {
        throw ItemOpenError.osFailed
    }
    #endif
}
