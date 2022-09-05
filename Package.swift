// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintPro",
    platforms: [
        .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(
            name: "FingerprintPro",
            targets: ["FingerprintPro"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "FingerprintPro",
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.1.1/FingerprintPro-2.1.1-a1ac572ee1f8196001248182129ab79c173bbdb81e4505e5cc2b1e6a5f935363.xcframework.zip",
            checksum: "a1ac572ee1f8196001248182129ab79c173bbdb81e4505e5cc2b1e6a5f935363"
        ),
    ]
)
