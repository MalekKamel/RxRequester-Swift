RxRequester-Swift
======================
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

A wrapper for **RxSwift** abstracts away all those nasty details you don't really care about in every Rx request and provides default configurations for schedulers, loading indicators, and error handling.

Using **RxRequester** you can:
- [ ] Make clean RxSwift requests.
- [ ] Inline & Global error handling.
- [ ] Toggle loading indicators easily.

### Before RxRequester
``` swift
respository.posts()
          .do(onNext: { _ in showLoading() })
          .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
          .observeOn(MainScheduler.instance)
          .do(onNext: { _ in hideLoading() })
          .subscribe(onSuccess: { response in },
                     onError: { error in
                           // handle error
                     })
```

### After RxRequester
``` swift
  rxRequester.request { repository.posts() }
```

## Usage
 **👉** See [Usage](https://github.com/ShabanKamell/RxRequester-Swift/blob/master/Documentation/Usage.md)

## Installation

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/ShabanKamell/RxRequester-Swift.git", .upToNextMajor(from: "0.4.0"))
```

and then specify `"RxRequester"` as a dependency of the Target in which you wish to use RxRequester.
If you want to use **Alamofire** or **Moya**, add also `"RxRequesterAlamofire"` or `"RxRequesterMoya"` as your Target dependency respectively.
Here's an example `PackageDescription`:

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MyPackage",
    products: [
        .library(
            name: "MyPackage",
            targets: ["MyPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ShabanKamell/RxRequester-Swift.git", .upToNextMajor(from: "0.4.0"))
    ],
    targets: [
        .target(
            name: "MyPackage",
            dependencies: ["RxRequesterAlamofire"])
    ]
)
```

### Accio

[Accio](https://github.com/JamitLabs/Accio) is a dependency manager based on SwiftPM which can build frameworks for iOS/macOS/tvOS/watchOS. Therefore the integration steps of RxRequester are exactly the same as described above. Once your `Package.swift` file is configured, run `accio update` instead of `swift package update`.

### CocoaPods

For RxRequester, use the following entry in your Podfile:

```rb
pod 'RxRequester', '~> 0.4.0'

# or 

pod 'RxRequester/Alamofire', '~> 0.4.0'

# or

pod 'RxRequester/Moya', '~> 0.4.0'
```

Then run `pod install`.

In any file you'd like to use RxRequester in, don't forget to
import the framework with `import RxRequester`.

### Carthage

Carthage users can point to this repository and use whichever
generated framework they'd like, `RxRequester`, `RxRequesterAlamofire`, or `RxRequesterMoya`.

Make the following entry in your Cartfile:

```
github "ShabanKamell/RxRequester-Swift" ~> 0.4.0
```

Then run `carthage update`.

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

> NOTE: At this time, Carthage does not provide a way to build only specific repository submodules. All submodules and their dependencies will be built with the above command. However, you don't need to copy frameworks you aren't using into your project. For instance, if you aren't using `RxRequesterAlamofire`, feel free to delete that framework along with `RxRequesterMoya` from the Carthage Build directory after `carthage update` completes.

#### Look at 'Examples' for the full exmples.

### License

<details>
    <summary>
        click to reveal License
    </summary>
    
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

</details>
