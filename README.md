<div align="center">

***`grammar`***

[![Tests](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml)
[![Documentation](https://github.com/tayloraswift/swift-grammar/actions/workflows/Documentation.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/Documentation.yml)

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
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/tayloraswift/swift-grammar", from: "0.4.0"),
    ],
    targets: [
        .target(name: "example",
            dependencies: [
                .product(name: "Grammar", package: "swift-grammar"),
                // other dependencies
            ]),
        // other targets
    ]
)
```


## Requirements

The swift-grammar library requires Swift 5.8 or later.

| Platform | Status |
| -------- | ------ |
| 🐧 Linux | [![Tests](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml) |
| 🍏 Darwin | [![Tests](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/Tests.yml) |
| 🍏 Darwin (iOS) | [![iOS](https://github.com/tayloraswift/swift-grammar/actions/workflows/iOS.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/iOS.yml) |
| 🍏 Darwin (tvOS) | [![tvOS](https://github.com/tayloraswift/swift-grammar/actions/workflows/tvOS.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/tvOS.yml) |
| 🍏 Darwin (visionOS) | [![visionOS](https://github.com/tayloraswift/swift-grammar/actions/workflows/visionOS.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/visionOS.yml) |
| 🍏 Darwin (watchOS) | [![watchOS](https://github.com/tayloraswift/swift-grammar/actions/workflows/watchOS.yml/badge.svg)](https://github.com/tayloraswift/swift-grammar/actions/workflows/watchOS.yml) |
