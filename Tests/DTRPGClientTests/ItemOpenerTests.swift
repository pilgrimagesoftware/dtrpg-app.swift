import XCTest

@testable import DTRPGClient

final class ItemOpenerTests: XCTestCase {

    func testOpenItemThrowsFileNotFoundForMissingFile() {
        let url = URL(fileURLWithPath: "/tmp/dtrpg_item_opener_missing_file_stub.pdf")

        XCTAssertThrowsError(try openItem(at: url)) { error in
            XCTAssertEqual(error as? ItemOpenError, .fileNotFound(path: url.path))
        }
    }

    func testOpenItemDoesNotThrowFileNotFoundForExistingFile() throws {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("dtrpg_item_opener_test_file.txt")
        try "test content".write(to: url, atomically: true, encoding: .utf8)
        defer { try? FileManager.default.removeItem(at: url) }

        do {
            try openItem(at: url)
        } catch let error as ItemOpenError {
            XCTAssertNotEqual(error, .fileNotFound(path: url.path))
        }
    }

    func testItemOpenErrorDescriptionsAreNonEmpty() {
        XCTAssertFalse(ItemOpenError.fileNotFound(path: "x").errorDescription!.isEmpty)
        XCTAssertFalse(ItemOpenError.noDefaultApp.errorDescription!.isEmpty)
        XCTAssertFalse(ItemOpenError.osFailed.errorDescription!.isEmpty)
    }
}
