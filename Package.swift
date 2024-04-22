// swift-tools-version:5.8
import PackageDescription

let package:Package = .init(
    name: "Swift Grammar",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "Grammar", targets: ["Grammar"]),
        .library(name: "Testing_", targets: ["Testing_"]),
        .library(name: "TraceableErrors", targets: ["TraceableErrors"]),
    ],
    dependencies: [
        //  This dependency only used for the Testing module’s concurrency support.
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.2.0"),
    ],
    targets: [
        .target(name: "Grammar",
            dependencies: [
                .target(name: "TraceableErrors"),
            ]),

        .target(name: "Testing_",
            dependencies: [
                .product(name: "Atomics", package: "swift-atomics"),
            ],
            path: "Sources/Testing"),

        .target(name: "TraceableErrors"),
    ]
)
