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
      name: "CoalFramework",
      targets: ["CoalFramework"]),
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
      targets: ["CoalHome"]),
    .library(
      name: "CoalAccount",
      targets: ["CoalAccount"]),
    .library(
      name: "CoalVerificationMethod",
      targets: ["CoalVerificationMethod"]),
    .library(
      name: "CoalVerificationCode",
      targets: ["CoalVerificationCode"])
  ],
  dependencies: [
    .package(url: "ssh://git@gitlab.playcourt.id:31022/mobileteam/legion-ios.git", branch: "main")
  ],
  targets: [
    .target(
      name: "CoalCore",
      dependencies: [
        .product(name: "LegionUI", package: "legion-ios"),
        .product(name: "ThemeLGN", package: "legion-ios")
      ],
      path: "Sources/CoalCore",
      resources: [
        .copy("Resources/Assets.xcassets"),
        .process("Resources/Localized")
      ]
    ),
    .target(
      name: "CoalFramework",
      dependencies: ["CoalCore", 
                     "CoalSplashScreen",
                     "CoalLogin",
                     "CoalHome",
                     "CoalRegister",
                     "CoalAccount",
                     "CoalVerificationMethod",
                     "CoalVerificationCode"],
      path: "Sources/CoalFramework"
    ),
    .target(
      name: "CoalSplashScreen",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModule/SplashScreen"
    ),
    .target(
      name: "CoalLogin",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModule/Login"
    ),
    .target(
      name: "CoalRegister",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModule/Register"
    ),
    .target(
      name: "CoalHome",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModule/Home"
    ),
    .target(
      name: "CoalAccount",
      dependencies: ["CoalCore"],
      path: "Sources/CoalModule/Account"
    ),
    .target(
      name: "CoalVerificationMethod",
      dependencies: ["CoalCore", "CoalLogin"],
      path: "Sources/CoalModule/VerificationMethod"
    ),
    .target(
      name: "CoalVerificationCode",
      dependencies: ["CoalCore", "CoalLogin"],
      path: "Sources/CoalModule/VerificationCode"
    )
  ]
)
