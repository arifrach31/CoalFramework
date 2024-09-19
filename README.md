# Coal Framework iOS

![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)
![SwiftUI Compatible](https://img.shields.io/badge/SwiftUI-compatible-green?style=flat-square)
![iOS Version](https://img.shields.io/badge/iOS-15.0-green?style=flat-square)

A Core App Library (Coal) that simplifies and enhances app development

## Getting Started
### Install and use Coal

#### Requirement

- iOS 15+
- XCode 13+
- Swift 5.6+

#### Using Swift Package Manager

To integrate Coal using SPM, specify it as a dependency in your Xcode project or `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://gitlab.playcourt.id/telkomdev/legion-coal-ios.git", branch: "master"),
],
```

### Import and use Coal

After the framework has been added you can import the module to use it, in the example you can using CoalFramework for configure:

```swift
import CoalFramework
```

and add `CoalConfig.shared.configure()` to your AppDelegate:

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  private let coalConfig = CoalConfig.shared
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    
    coalConfig.configure(window: window)
  }
}

```

## Module

- CoalCore
- CoalFramework
- CoalModel
- CoalNetwork
- CoalView
- CoalSplashScreen
- CoalLogin
- CoalRegister
- CoalHome

