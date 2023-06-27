// swift-tools-version: 5.7

import PackageDescription

let checksum = "dd5172878f002876409906b391f37def52592580a90ece9b4142135577c982e0"
let version = "2.2.0"

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
