// swift-tools-version: 5.9

import PackageDescription

let checksum = "e6ef4cd4ebb1d4788f207043fe06ac493869ba4e6f101416fc8212c81bc5c950"
let version = "2.17.2"

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
