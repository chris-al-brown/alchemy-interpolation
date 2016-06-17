<center> 
    <h1>AlchemyInterpolation</h1> 
</center>

<p align="center">
    <img src="https://img.shields.io/badge/platform-osx-lightgrey.svg" alt="Platform">
    <img src="https://img.shields.io/badge/language-swift-orange.svg" alt="Language">
    <img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License">
</p>

<p align="center">
    <a href="#requirements">Requirements</a>
    <a href="#installation">Installation</a>
    <a href="#usage">Usage</a>
    <a href="#references">References</a>
    <a href="#license">License</a>
</p>

AlchemyInterpolation is a Swift framework for interpolations

## Requirements

- Xcode
    - Version: **8.0 beta (8S128d)**
    - Language: **Swift 3.0**
- OS X
    - Compatible With: **OS X 10.11**
    - Deployment Target: **OS X 10.10**

<!--- iOS-->
<!--    - Compatible With:   **iOS 9.1**-->
<!--    - Deployment Target: **iOS 8.0**-->
<!--- watchOS-->
<!--    - Compatible With:   **watchOS 2.0**-->
<!--    - Deployment Target: **watchOS 2.0**-->
<!--- tvOS-->
<!--    - Compatible With:   **tvOS 9.0**-->
<!--    - Deployment Target: **tvOS 9.0**-->

## Installation

Install using the [Swift Package Manager](https://swift.org/package-manager/)

Add the project as a dependency to your Package.swift:

```swift
import PackageDescription

let package = Package(
    name: "MyProjectUsingAlchemyInterpolation",
    dependencies: [
        .Package(url: "https://github.com/chris-al-brown/alchemy-interpolation", majorVersion: 0, minorVersion: 1)
    ]
)
```

Then import `import AlchemyInterpolation`.

## Usage

Check out 'Demo.playground' for example usage.  

## References

1. [Robert Penner's Easing Functions](http://robertpenner.com/easing/)

2. [AHEasing](https://github.com/warrenm/AHEasing)

3. [Easing Functions Cheat Sheet](http://easings.net)

## License

AlchemyInterpolation is released under the [MIT License](LICENSE.md).
