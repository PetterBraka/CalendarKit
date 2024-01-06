// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalendarKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CalendarKit",
            targets: ["CalendarKit"]),
    ],
    targets: [
        .target(
            name: "CalendarKit",
            dependencies: ["MobileUI"]
        ),
        .target(
            name: "Engine"
        ),
        .target(
            name: "MobileUI",
            dependencies: ["Presenter"]
        ),
        .target(
            name: "Presenter",
            dependencies: ["Engine"]
        ),
        // MARK: - Tests
        .testTarget(
            name: "EngineTests",
            dependencies: ["Engine"]
        ),
        .testTarget(
            name: "MobileUITests",
            dependencies: ["MobileUI"]
        ),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter"]
        ),
    ]
)
