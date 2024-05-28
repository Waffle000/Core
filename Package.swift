// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .macOS(.v14), .iOS(.v17)
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.7.1"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.9.1")
    ],
    targets: [
        .target(
            name: "Core", dependencies: ["Alamofire", "RxSwift", .product(name: "RxCocoa", package: "RxSwift")]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core"]),
    ]
)
