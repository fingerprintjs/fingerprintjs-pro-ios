// swift-tools-version: 5.7

import PackageDescription

let checksum = "7e372d8b43e4102bde42a300afb86852d610e3d770c34c7059cc22aa10db3f0f"
let version = "2.1.8"

let package = Package(
    name: "FingerprintPro",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
    ],
    products: [
        .library(
            name: "FingerprintPro",
            targets: ["FingerprintPro"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "FingerprintPro",
            url: "https://fpjs-public.s3.amazonaws.com/ios/\(version)/FingerprintPro-\(version)-\(checksum).xcframework.zip",
            checksum: checksum
        )
    ]
)
