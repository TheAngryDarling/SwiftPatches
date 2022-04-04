// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPatches",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ResultPatches",
            targets: ["ResultPatches"]),
        .library(
            name: "ResultOperators",
            targets: ["ResultOperators"]),
        .library(
            name: "MoreResults",
            targets: ["MoreResults"]),
        .library(
            name: "HashablePatches",
            targets: ["HashablePatches"]),
        .library(
            name: "StringPatches",
            targets: ["StringPatches"]),
        .library(
            name: "CorePatches",
            targets: ["CorePatches"]),
        .library(
            name: "SequencePatches",
            targets: ["SequencePatches"]),
        .library(
            name: "NumericPatches",
            targets: ["NumericPatches"]),
        .library(
            name: "SpecialLiteralExpressionHelpers",
            targets: ["SpecialLiteralExpressionHelpers"]),
        .library(
            name: "SwiftPatches",
            targets: ["SwiftPatches"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/TheAngryDarling/SwiftUnitTestingHelper.git",
                 from: "1.0.3"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ResultPatches",
            dependencies: []),
        .target(
            name: "ResultOperators",
            dependencies: ["ResultPatches"]),
        .target(
            name: "MoreResults",
            dependencies: ["ResultPatches"]),
        .target(
            name: "HashablePatches",
            dependencies: []),
        .target(
            name: "StringPatches",
            dependencies: []),
        
        .target(
            name: "CorePatches",
            dependencies: ["ResultPatches",
                           "HashablePatches",
                           "StringPatches"]),
        
        .target(
            name: "SequencePatches",
            dependencies: []),
        .target(
            name: "NumericPatches",
            dependencies: []),
        .target(
            name: "SpecialLiteralExpressionHelpers",
            dependencies: []),
        .target(
            name: "SwiftPatches",
            dependencies: ["CorePatches",
                           "SequencePatches",
                           "NumericPatches",
                           "ResultOperators",
                           "MoreResults",
                           "SpecialLiteralExpressionHelpers"]),
        .testTarget(
            name: "SwiftPatchesTests",
            dependencies: ["SwiftPatches", "UnitTestingHelper"]),
    ]
)
