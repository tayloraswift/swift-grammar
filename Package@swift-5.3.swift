// swift-tools-version:5.3
import PackageDescription

let plugins:[Package.Dependency] = []
let package:Package = .init(
    name: "swift-grammar",
    products: 
    [
        .library(name: "Grammar", targets: ["Grammar"]),
    ],
    dependencies: plugins,
    targets: 
    [
        .target(name: "Grammar", path: "sources/"),
    ]
)
