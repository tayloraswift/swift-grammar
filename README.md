<div align="center">

<strong><em><code>grammar</code></em></strong><br><small><code>0.3.3</code></small>

[![ci build status](https://github.com/tayloraswift/swift-grammar/actions/workflows/build.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/build.yml)
[![ci devices build status](https://github.com/tayloraswift/swift-grammar/actions/workflows/build-devices.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/build-devices.yml)
[![ci windows build status](https://github.com/tayloraswift/swift-grammar/actions/workflows/build-windows.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/build-windows.yml)

[![swift package index versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftayloraswift%2Fswift-grammar%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/tayloraswift/swift-grammar)
[![swift package index platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftayloraswift%2Fswift-grammar%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/tayloraswift/swift-grammar)

</div>

High-performance constructive parsing, in pure Swift. This module powers the [`swift-json`](https://github.com/tayloraswift/swift-json) library!

**Importing this module will expose the following top-level symbols**:

* `enum Pattern`
* `enum UnicodeDigit`
* `enum UnicodeEncoding`

* `protocol TraceableError`
* `protocol TraceableErrorRoot`
* `struct ParsingError<Index>`

* `struct ParsingInput<Diagnostics>`
* `struct NoDiagnostics<Source>`
* `struct DefaultDiagnostics<Source>`
* `protocol ParsingDiagnostics`

* `protocol ParsingRule`
* `protocol TerminalRule`
* `protocol LiteralRule`
* `protocol DigitRule`
* `protocol ASCIITerminal`
* `protocol UTF8Terminal`
* `protocol UTF16Terminal`
* `protocol UnicodeTerminal`
* `protocol CharacterTerminal`

## adding `swift-grammar` as a dependency

To use `swift-grammar` in a project, add the following to your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies:
    [
        // other dependencies
        .package(url: "https://github.com/tayloraswift/swift-grammar", from: "0.3.1"),
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

## toolchain requirement

`swift-grammar` requires Swift 5.7 or newer.
