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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.0.2/FingerprintPro-2.0.2-c2361af3e66764ab400d27cff300ed2134bd2e5fda1a64bcb28964937d661770.xcframework.zip",
            checksum: "c2361af3e66764ab400d27cff300ed2134bd2e5fda1a64bcb28964937d661770"
        ),
    ]
)
