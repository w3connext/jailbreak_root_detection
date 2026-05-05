// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "jailbreak_root_detection",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "jailbreak-root-detection", targets: ["jailbreak_root_detection"]),
    ],
    dependencies: [
        .package(url: "https://github.com/securing/IOSSecuritySuite", from: "1.9.10"),
    ],
    targets: [
        .target(
            name: "jailbreak_root_detection",
            dependencies: [
                .product(name: "IOSSecuritySuite", package: "IOSSecuritySuite"),
            ],
        ),
    ]
)
