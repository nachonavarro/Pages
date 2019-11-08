//
//  File.swift
//  
//
//  Created by Nacho Navarro on 08/11/2019.
//

import XCTest
import SwiftUI
@testable import Pages

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
        XCTAssertEqual(modelPages.items.count, cars.count + 2)
    }

}
