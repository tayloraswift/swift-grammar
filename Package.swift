// swift-tools-version:5.8
import PackageDescription

let package:Package = .init(
    name: "swift-grammar",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "Grammar", targets: ["Grammar"]),
        .library(name: "TraceableErrors", targets: ["TraceableErrors"]),
    ],
    targets: [
        .target(name: "Grammar",
            dependencies: [
                .target(name: "TraceableErrors"),
            ]),

        .target(name: "TraceableErrors"),
    ]
)
