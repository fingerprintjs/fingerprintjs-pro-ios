// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintJSPro",
    platforms: [
        .iOS(.v9),
    ],
    products: [
        .library(
            name: "FingerprintJSPro",
            targets: ["FingerprintJSPro"]
        ),
    ],
    targets: [
        .target(
            name: "FingerprintJSPro",
            dependencies: [],
            exclude: ["Resources/Info.plist"],
            resources: [.process("Resources/fp.min.js")]
        ),
        .testTarget(
            name: "FingerprintJSProTests",
            dependencies: ["FingerprintJSPro"]
        ),
    ]
)
