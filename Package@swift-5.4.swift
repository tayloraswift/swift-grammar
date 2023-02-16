// swift-tools-version:5.4
import PackageDescription

let plugins:[Package.Dependency] = []
let package:Package = .init(
    name: "swift-grammar",
    products: 
    [
        .library(name: "Grammar", targets: ["Grammar"]),
        .library(name: "TraceableErrors", targets: ["TraceableErrors"]),
    ],
    dependencies: plugins,
    targets: 
    [
        .target(name: "Grammar",
            dependencies:
            [
                .target(name: "TraceableErrors"),
            ]),
        
        .target(name: "TraceableErrors"),
    ]
)
