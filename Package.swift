// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "swift-grammar",
    products: 
    [
        .library    (name: "Grammar",       targets: ["Grammar"]),
    ],
    dependencies: 
    [
    ],
    targets: 
    [
        .target(name: "Grammar", 
            path: "sources/", 
            exclude: 
            [
            ]),
    ]
)
