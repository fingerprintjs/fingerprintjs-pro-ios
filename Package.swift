// swift-tools-version:5.5

import PackageDescription

let checksum = "7ce695d59b193d2ad7fe2313a74eb795293763f44016eb2c4c5c5d6ac353fe5c"
let version = "2.1.7"

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
            url: "https://fpjs-public.s3.amazonaws.com/ios/\(version)/FingerprintPro-\(version)-\(checksum).xcframework.zip",
            checksum: checksum
        ),
    ]
)
