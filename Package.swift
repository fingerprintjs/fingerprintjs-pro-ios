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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.1.3/FingerprintPro-2.1.3-2f3ab29b362c7e20470a7e844cf8e397aef5a678a6aef9feab6403f2d10efa98.xcframework.zip",
            checksum: "2f3ab29b362c7e20470a7e844cf8e397aef5a678a6aef9feab6403f2d10efa98"
        ),
    ]
)
