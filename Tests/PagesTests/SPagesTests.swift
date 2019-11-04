import XCTest
import SwiftUI
@testable import Pages

@available(iOS 13.0, OSX 10.15, *)
final class PagesTests: XCTestCase {
    func testStaticPagesCount() {
        let sPages = Pages {
            Text("A")
            Text("B")
        }
        XCTAssertEqual(sPages.pages.count, 2)
    }
}
