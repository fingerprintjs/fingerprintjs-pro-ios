@testable import fpjs_ios_wv
import XCTest

final class fpjs_ios_wvTests: XCTestCase {
    func testExample() {
        let expectation = XCTestExpectation(description: "FingerPrint Token")

        FingerPrintJS.shared.track(token: "kDIPlabQCHvWcgMHSyei", endpoint: "https://cdn.jsdelivr.net", region: "ru") {
            switch $0 {
            case let .success(value):
                print(value)
                XCTAssert(true)
            case let .failure(error):
                XCTAssert(false)
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 100)
    }
}
