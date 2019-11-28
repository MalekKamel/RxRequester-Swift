# RxRequester-Swift

A simple wrapper for RxSwift, Alamofire and Moya that abstracts repetitive code  helps you:
- [ ] Make clean RxSwift requests.
- [ ] Inline & Global error handling.
- [ ] Resume the current request after errors like token expired error.
- [ ] Easy control of loading indicators.

``` swift

```

## Usage
``` swift
extension ViewController: Presentable {
    public func showError(error: String) { show(error: error) }
    public func showLoading() { showLoading(show: true) }
    public func hideLoading() { showLoading(show: false) }
    public func onHandleErrorFailed(error: Error) { show(error: "Oops, something went wrong!") }
}
    // Set handlers
    RxRequester.nsErrorHandlers = [ConnectivityHandler()]
    RxRequester.errorHandlers = [MyErrorHandler()]
    RxRequester.resumableHandlers = [UnauthorizedHandler()]
      
    // Request
    RxRequester(presentable: self).request { loginApi.login() }
```
## Installation

### Swift Package Manager

To integrate using Apple's Swift package manager, add the following as a dependency to your `Package.swift`:

```swift
.package(url: "https://github.com/ShabanKamell/RxRequester-Swift.git", .upToNextMajor(from: "0.3.0"))
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
        .package(url: "https://github.com/ShabanKamell/RxRequester-Swift.git", .upToNextMajor(from: "0.3.0"))
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
pod 'RxRequester', '~> 0.3.0'

# or 

pod 'RxRequester/Alamofire', '~> 0.3.0'

# or

pod 'RxRequester/Moya', '~> 0.3.0'
```

Then run `pod install`.

In any file you'd like to use RxRequester in, don't forget to
import the framework with `import RxRequester`. for Alamofire, `import RxRequesterAlamofire`. For Moya, `import RxRequesterMoya`

### Carthage

Carthage users can point to this repository and use whichever
generated framework they'd like, `RxRequester`, `RxRequesterAlamofire`, or `RxRequesterMoya`.

Make the following entry in your Cartfile:

```
github "ShabanKamell/RxRequester" ~> 13.0
```

Then run `carthage update`.

If this is your first time using Carthage in the project, you'll need to go through some additional steps as explained [over at Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

> NOTE: At this time, Carthage does not provide a way to build only specific repository submodules. All submodules and their dependencies will be built with the above command. However, you don't need to copy frameworks you aren't using into your project. For instance, if you aren't using `RxRequesterAlamofire`, feel free to delete that framework along with `RxRequesterMoya` from the Carthage Build directory after `carthage update` completes.

### Error Handling
**RxRequester** shines when you need to handle error. Errors in RxRequesters can be handled by providing a handler for each error. For example, if you want to handle connectivity error `NSURLErrorNotConnectedToInternet`, you must provide a handler as the following

``` swift
import RxRequester

struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [NSURLErrorNotConnectedToInternet]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}

```

### Alamofire & Moya
RxReqeuster provides support for handling **Alamofire** and **Moya** errors. check handler types below.


### Error Handler Types

|     **Handler Type**     |                 **Description**               |
|--------------------------|-----------------------------------------------|
| **NSErrorHandler**       |   Handles NSError                             |
| **ResumableHandler**     |   provides a request to be invoked after <br> the error and before resuming <br>the main request.                                                                   |
| **ErrorHandler**         |     Handles any Swift.Error                   |


### Alamofire Handlers
|       **Handler Type**               |        **Description**            |
|--------------------------------------|-----------------------------------|
| **AlamofireStatusCodeHandler**       |   Handles HTTP status code        |
| **AlamofireUnderlyingErrorHandler**  |   Handles underlying error        |
| **AlamofireErrorHandler**            |   Handles any `AFError`           |

### Moya Handlers
|       **Handler Type**               |         **Description**           |
|--------------------------------------|-----------------------------------|
| **MoyaStatusCodeHandler**            |   Handles HTTP status code        |
| **MoyaUnderlyingErrorHandler**       |   Handles underlying error        |
| **MoyaErrorHandler**                 |   Handles any `MoyaError`         |

## Customizing Requests
RxRequester gives you the full controll over any request
- [ ] Inline error handling
- [ ] Enable/Disable loading indicators
- [ ] Invoke code on error.
- [ ] Set subscribeOn Scheduler
- [ ] Set observeOn Scheduler

``` swift
    let options = RequestOptions.Builder()
         .showLoading(true)
         .inlineErrorHandling { error in false }
         .doOnError { error in }
         .observeOnScheduler(MainScheduler.instance)
         .subscribeOnScheduler(ConcurrentDispatchQueueScheduler(qos: .background))
         .build()
     rxRequester.request(options: options) { .. }
```

#### Look at 'Examples' group for the full code.

### License

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
