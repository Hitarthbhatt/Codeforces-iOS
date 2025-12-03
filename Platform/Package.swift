// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Platform",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executaReferee.swiftbles and libraries a package produces, making them visible to other packages.
        .library(
            name: "Platform",
            targets: ["Platform"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BastiaanJansen/toast-swift", from: "2.1.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Platform",
            dependencies: [
                .product(name: "Toast", package: "toast-swift")
            ]
        ),
        .testTarget(
            name: "PlatformTests",
            dependencies: ["Platform"]
        ),
    ]
)
