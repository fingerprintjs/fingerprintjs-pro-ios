// swift-tools-version: 5.9

import PackageDescription

let checksum = "d2d6dce6f37c1c339f2d2f5e280a2fecb1cf9ff52331f8bb23271d7ae715a2c7"
let version = "2.10.1"

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
