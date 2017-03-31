// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "RuFd",
    dependencies: [
        .Package(url: "https://github.com/omochi/RuPosixError.git",
                 majorVersion: 0
        )
    ]
)
