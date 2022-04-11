// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UISugar",
    products: [
        .library(name: "UISugar", targets: ["UISugar"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "UISugar",
            dependencies: []),
        .testTarget(
            name: "UISugarTests",
            dependencies: ["UISugar"]),
    ]
)
