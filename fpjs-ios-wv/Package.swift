// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "fpjs-ios-wv",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(
            name: "fpjs-ios-wv",
            targets: ["fpjs-ios-wv"]
        ),
    ],
    targets: [
        .target(
            name: "fpjs-ios-wv",
            dependencies: [],
            resources: [.process("Resources/fp.min.js")]
        ),
        .testTarget(
            name: "fpjs-ios-wvTests",
            dependencies: ["fpjs-ios-wv"]
        ),
    ]
)
