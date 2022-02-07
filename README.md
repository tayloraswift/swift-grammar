<p align="center">
  <strong><em><code>grammar</code></em></strong><br><small><code>0.1.0</code></small>
</p>

High-performance constructive parsing, in pure Swift. This module powers the [`swift-json`](https://github.com/kelvin13/swift-json) library!

**Importing this module will expose the following top-level symbols**:

* `enum Grammar`
* `protocol TraceableError`
* `protocol TraceableErrorRoot`
* `struct ParsingError<Index>`
* `struct ParsingInput<Diagnostics>`
* `protocol ParsingRule`
* `protocol ParsingDiagnostics`

## adding `swift-grammar` as a dependency 

To use `swift-grammar` in a project, add the following to your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: 
    [
        // other dependencies
        .package(url: "https://github.com/kelvin13/swift-grammar", from: "0.1.0"),
    ],
    targets: 
    [
        .target(name: "example", 
            dependencies: 
            [
                .product(name: "Grammar", package: "swift-grammar"),
                // other dependencies
            ]),
        // other targets
    ]
)
```
