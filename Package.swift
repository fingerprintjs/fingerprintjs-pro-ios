// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

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
            url: "https://fpjs-public.s3.amazonaws.com/ios/2.1.4/FingerprintPro-2.1.4-a1970ecc0ce58c1bfcc30968c0a97009f7b3731b2a652c13e4d6d989b32573a3.xcframework.zip",
            checksum: "a1970ecc0ce58c1bfcc30968c0a97009f7b3731b2a652c13e4d6d989b32573a3"
        ),
    ]
)
