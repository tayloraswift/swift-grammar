// swift-tools-version:5.3
import PackageDescription

let package:Package = .init(
    name: "swift-grammar",
    products: 
    [
        .library(name: "Grammar", targets: ["Grammar"]),
    ],
    targets: 
    [
        .target(name: "Grammar", path: "sources/"),
    ]
)
