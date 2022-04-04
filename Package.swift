// swift-tools-version:5.3
import PackageDescription

#if swift(>=5.6)
let future:[Package.Dependency] = 
[
    .package(url: "https://github.com/swift-biome/swift-documentation-extract", from: "0.1.1")
]
#else 
let future:[Package.Dependency] = []
#endif

let package:Package = .init(
    name: "swift-grammar",
    products: 
    [
        .library(name: "Grammar", targets: ["Grammar"]),
    ],
    dependencies: future,
    targets: 
    [
        .target(name: "Grammar", path: "sources/"),
    ]
)
