import XCTest
import SwiftUI
@testable import Pages

@available(iOS 13.0, OSX 10.15, *)
final class DPagesTests: XCTestCase {

    struct Car: Identifiable {
        var id = UUID()
        var model: String
    }

    let cars = [Car(model: "Ford"), Car(model: "Ferrari")]

    func testDynamicPagesCount() {
        let dPages = DPages(cars) { i, car in
            Text("Car model: \(car.model)")
        }
        XCTAssertEqual(dPages.items.count, cars.count)
    }
    
}
