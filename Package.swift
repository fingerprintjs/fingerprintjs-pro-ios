// swift-tools-version:5.5

import PackageDescription

let checksum = "4d43e8a8b3060e5d9f9970af18c367815a18329034740fe4d7d1c917109fb0eb"
let version = "2.1.5"

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
