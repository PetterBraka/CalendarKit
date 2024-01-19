// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalendarKit",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CalendarKit",
            targets: ["CalendarKit"]),
    ],
    targets: [
        .target(
            name: "CalendarKit",
            dependencies: ["PageView"]
        ),
        .target(
            name: "PageView"
        ),
        .target(
            name: "TestingHelpers"
        ),
        // MARK: - Tests
        .testTarget(
            name: "EngineTests",
            dependencies: ["CalendarKit", "TestingHelpers"]
        ),
        .testTarget(
            name: "CalendarKitTests",
            dependencies: ["CalendarKit", "TestingHelpers"]
        ),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["CalendarKit", "TestingHelpers"]
        ),
    ]
)
