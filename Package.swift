// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "MagicDealersKit",
                      platforms: [.iOS(.v16)],
                      products: [.library(name: "MDKit",
                                          type: nil,
                                          targets: ["MDKit"])],
                      targets: [.target(name: "MDKit"),
                                .testTarget(name: "MDKitTests",
                                            dependencies: ["MDKit"])])
