import XCTest
import SwiftUI
@testable import Pages

@available(iOS 13.0, OSX 10.15, *)
final class ModelPagesTests: XCTestCase {

    struct Car: Identifiable {
        var id = UUID()
        var model: String
    }

    let cars = [Car(model: "Ford"), Car(model: "Ferrari")]

    func testDynamicPagesCount() {
        let modelPages = ModelPages(cars) { i, car in
            Text("Car model: \(car.model)")
        }
        XCTAssertEqual(modelPages.items.count, cars.count)
    }
    
}
