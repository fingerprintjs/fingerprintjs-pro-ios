// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintJS",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "FingerprintJS",
            targets: ["FingerprintJS"]
        ),
    ],
    targets: [
        .target(
            name: "FingerprintJS",
            dependencies: [],
            resources: [.process("Resources/fp.min.js")]
        ),
        .testTarget(
            name: "FingerprintJSTests",
            dependencies: ["FingerprintJS"]
        ),
    ]
)
