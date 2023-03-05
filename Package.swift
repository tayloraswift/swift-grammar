// swift-tools-version:5.7
import PackageDescription

let package:Package = .init(
    name: "swift-grammar",
    products: 
    [
        .library(name: "Grammar", targets: ["Grammar"]),
        .library(name: "Testing", targets: ["Testing"]),
        .library(name: "TraceableErrors", targets: ["TraceableErrors"]),
    ],
    dependencies:
    [
        //  This dependency only used for the Testing module’s concurrency support.
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.0.3"),
    ],
    targets: 
    [
        .target(name: "Grammar", dependencies:
            [
                .target(name: "TraceableErrors"),
            ]),
        
        .target(name: "Testing", dependencies:
            [
                .product(name: "Atomics", package: "swift-atomics"),
            ]),
        
        .target(name: "TraceableErrors"),
    ]
)
