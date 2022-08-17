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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.0.0/FingerprintPro-2.0.0-20c757c7649f381b7528f3b6a2f52dd0a04f517866649774d16706dd770f2927.xcframework.zip",
            checksum: "20c757c7649f381b7528f3b6a2f52dd0a04f517866649774d16706dd770f2927"
        ),
    ]
)
