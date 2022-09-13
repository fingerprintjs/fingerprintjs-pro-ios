// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FingerprintPro",
    platforms: [
        .iOS(.v12), .tvOS(.v12)
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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.1.2/FingerprintPro-2.1.2-744c827b920ac90278e29446f2230f818df9791c493fb9615c8c9c70f6cc2f15.xcframework.zip",
            checksum: "744c827b920ac90278e29446f2230f818df9791c493fb9615c8c9c70f6cc2f15"
        ),
    ]
)
