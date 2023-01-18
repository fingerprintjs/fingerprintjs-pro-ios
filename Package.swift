// swift-tools-version:5.5

import PackageDescription

let checksum = "fb845e35d253271df17435d8bdf6b1ba2088617f2ba23c0e2bb4433b014bf498"
let version = "2.1.6"

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
