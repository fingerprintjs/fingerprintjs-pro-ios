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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.1.0/FingerprintPro-2.1.0-7827cdc299af8d4c23f056ae53331e9041e36f5760bd27eda8faca76d9997f25.xcframework.zip",
            checksum: "7827cdc299af8d4c23f056ae53331e9041e36f5760bd27eda8faca76d9997f25"
        ),
    ]
)
