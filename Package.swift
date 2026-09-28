// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "NameThePaper",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "namethepaper", targets: ["NameThePaper"])
    ],
    targets: [
        .executableTarget(
            name: "NameThePaper",
            path: "Sources/NameThePaper"
        ),
        .testTarget(
            name: "NameThePaperTests",
            dependencies: ["NameThePaper"],
            path: "Tests/NameThePaperTests"
        )
    ]
)
