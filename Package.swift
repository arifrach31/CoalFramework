// swift-tools-version:5.6
import PackageDescription

let package = Package(
  name: "Coal",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(
      name: "CoalCore",
      targets: ["CoalCore"]),
    .library(
      name: "CoalModel",
      targets: ["CoalModel"]),
    .library(
      name: "CoalFramework",
      targets: ["CoalFramework"]),
    .library(
      name: "CoalNetwork",
      targets: ["CoalNetwork"]),
    .library(
      name: "CoalView",
      targets: ["CoalView"]),
    .library(
      name: "CoalSplashScreen",
      targets: ["CoalSplashScreen"]),
    .library(
      name: "CoalLogin",
      targets: ["CoalLogin"]),
    .library(
      name: "CoalRegister",
      targets: ["CoalRegister"]),
    .library(
      name: "CoalHome",
      targets: ["CoalHome"])
  ],
  dependencies: [
    .package(url: "ssh://git@gitlab.playcourt.id:31022/mobileteam/legion-ios.git", branch: "main")
  ],
  targets: [
    .target(
      name: "CoalCore",
      path: "Sources/CoalCore",
      resources: [
        .copy("Resources/Assets.xcassets"),
        .process("Resources/Localized")
      ]
    ),
    .target(
      name: "CoalModel",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModel"
    ),
    .target(
      name: "CoalFramework",
      dependencies: ["CoalCore", "CoalModel", "CoalNetwork", "CoalSplashScreen", "CoalLogin", "CoalHome",  "CoalRegister"],
      path: "Sources/CoalFramework"
    ),
    .target(
      name: "CoalNetwork",
      dependencies: ["CoalModel"],
      path: "Sources/CoalNetwork"
    ),
    .target(
      name: "CoalView",
      dependencies: [
        "CoalCore",
        "CoalModel",
        .product(name: "LegionUI", package: "legion-ios"),
        .product(name: "ThemeLGN", package: "legion-ios")
      ],
      path: "Sources/CoalView"
    ),
    .target(
      name: "CoalSplashScreen",
      dependencies: ["CoalCore", "CoalView"],
      path: "Sources/CoalModule/SplashScreen"
    ),
    .target(
      name: "CoalLogin",
      dependencies: [
        "CoalView",
        "CoalCore",
        "CoalModel",
        .product(name: "LegionUI", package: "legion-ios"),
        .product(name: "ThemeLGN", package: "legion-ios")
      ],
      path: "Sources/CoalModule/Login"
    ),
    .target(
      name: "CoalRegister",
      dependencies: [
        "CoalView",
        "CoalCore",
        "CoalModel",
        .product(name: "LegionUI", package: "legion-ios"),
        .product(name: "ThemeLGN", package: "legion-ios")
      ],
      path: "Sources/CoalModule/Register"
    ),
    .target(
      name: "CoalHome",
      dependencies: ["CoalView"],
      path: "Sources/CoalModule/Home"
    )
  ]
)
