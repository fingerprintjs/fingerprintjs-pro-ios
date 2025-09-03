// swift-tools-version: 5.9

import PackageDescription

let checksum = "e5e38cdf80c067bfc8a2889f59eacc3d27cd122e3162ae922c1f26fd27c76bad"
let version = "2.10.0"

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
