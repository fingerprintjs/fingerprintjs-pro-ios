// swift-tools-version: 5.9

import PackageDescription

let checksum = "bc66d7912a0a162c1082381f0f0550e3afaa3d267d805e6a2159ccc0f8f247dd"
let version = "2.12.0"

let package = Package(
    name: "FingerprintPro",
    platforms: [
        .iOS(.v13),
        .tvOS(.v15),
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
