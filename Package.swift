// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintJSPro",
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "FingerprintJSPro",
            targets: ["FingerprintJSPro"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "FingerprintJSPro"
        ),
    ]
)
