@testable import FingerprintJS
import XCTest

final class FingerprintJSTests: XCTestCase {
    func testVisitorId() {
        let expectation = XCTestExpectation(description: "Fingerprint visitorId")

        FingerprintJS.Factory
            .getInstance(token: "",
                         endpoint: URL(string: "https://cdn.jsdelivr.net"),
                         region: "ru")
            .getVisitorId {
                switch $0 {
                case let .success(value):
                    print(value)
                    XCTAssert(true)
                case let .failure(error):
                    dump(error)
                    XCTAssert(false)
                }
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 100)
    }
}
