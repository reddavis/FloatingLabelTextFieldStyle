// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
    name: "FloatingLabelTextFieldStyle",
    platforms: [
        .iOS("15.0"),
        .macOS("12.0")
    ],
    products: [
        .library(
            name: "FloatingLabelTextFieldStyle",
            targets: ["FloatingLabelTextFieldStyle"]
        ),
    ],
    targets: [
        .target(
            name: "FloatingLabelTextFieldStyle",
            path: "FloatingLabelTextFieldStyle",
            exclude: ["Supporting Files/FloatingLabelTextFieldStyle.docc"]
        ),
        .testTarget(
            name: "FloatingLabelTextFieldStyleTests",
            dependencies: ["FloatingLabelTextFieldStyle"],
            path: "FloatingLabelTextFieldStyleTests"
        ),
    ]
)
