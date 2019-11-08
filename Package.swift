// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Pages",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Pages",
            targets: ["Pages"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Pages",
            dependencies: []),
        .testTarget(
            name: "PagesTests",
            dependencies: []
        )
    ]
)
