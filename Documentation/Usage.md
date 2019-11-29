# Usage

## Setup
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
      
  // Moya Handlers
  MoyaHandlers.statusCodeHandlers = [NotFoundHandler()]
  MoyaHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
  MoyaHandlers.errorHandlers = [EncodableMappingErrorHandler()]
  
  // Alamofire Handlers
  AlamofireHandlers.statusCodeHandlers = [NotFoundHandler()]
  AlamofireHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
  AlamofireHandlers.errorHandlers = [JsonSerializationFailedHandler()]
        
  // Request
  RxRequester(presentable: self).request { loginApi.login() }
```

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

### Error Handling
**RxRequester** shines when you need to handle errors. Errors in RxRequester can be handled by providing a handler for each error. For example, if you want to handle connectivity error `NSURLErrorNotConnectedToInternet`, you must provide a handler as the following

``` swift
import RxRequester

struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [NSURLErrorNotConnectedToInternet]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

### Alamofire & Moya Error Handling
RxReqeuster provides error handlers for the most common errors in **Alamofire** & **Moya**. check handler types below.


### Error Handler Types

#### Core Errors
|     **Handler Type**     |                 **Description**               |
|--------------------------|-----------------------------------------------|
| **NSErrorHandler**       |   Handles NSError                             |
| **ResumableHandler**     |   provides a request to be invoked after <br> the error and before resuming <br>the main request.                                                                   |
| **ErrorHandler**         |     Handles any Swift.Error                   |

To set core error handlers
``` swift
  RxRequester.nsErrorHandlers = [..]
  RxRequester.errorHandlers = [..]
  RxRequester.resumableHandlers = [..]
```

#### Alamofire Handlers
|       **Handler Type**               |        **Description**            |
|--------------------------------------|-----------------------------------|
| **AlamofireStatusCodeHandler**       |   Handles HTTP status code        |
| **AlamofireUnderlyingErrorHandler**  |   Handles underlying error        |
| **AlamofireErrorHandler**            |   Handles any `AFError`           |

To set Alamofire error handlers
``` swift
  AlamofireHandlers.statusCodeHandlers = [..]
  AlamofireHandlers.underlyingErrorHandlers = [..]
  AlamofireHandlers.errorHandlers = [..]
```

#### Moya Handlers
|       **Handler Type**               |         **Description**           |
|--------------------------------------|-----------------------------------|
| **MoyaStatusCodeHandler**            |   Handles HTTP status code        |
| **MoyaUnderlyingErrorHandler**       |   Handles underlying error        |
| **MoyaErrorHandler**                 |   Handles any `MoyaError`         |

To set Moya error handlers
``` swift
  MoyaHandlers.statusCodeHandlers = [..]
  MoyaHandlers.underlyingErrorHandlers = [..]
  MoyaHandlers.errorHandlers = [..]
```

## What is Resumable Handler?
There're cases where you want to handle the error and resume the current request as normal. Here's where ResumableHandler shines!
Imagine you received `401 token expired` error and you want to refresh the token then resume the original request. This can be done as easy as like this!
``` swift
struct UnauthorizedHandler: ResumableHandler {
    func canHandle(error: Swift.Error) -> Bool { error is UnauthorizedError }
    func handle(error: Error, presentable: Presentable?)  -> Observable<Any> {
        // put the API that refresh the token here
        Observable.just("")
    }
}
```

# Handlers structure

## NSErrorHandler
``` swift
public protocol NSErrorHandler {
    var supportedErrors: [Int] { get set }
    func canHandle(error: NSError) -> Bool
    func handle(error: NSError, presentable: Presentable?)
}
```
#### Example 
``` swift
struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [
        NSURLErrorNotConnectedToInternet,
        NSURLErrorCannotConnectToHost,
        NSURLErrorNetworkConnectionLost
    ]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

## ResumableHandler
``` swift
public protocol ResumableHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?) -> Observable<Any>
}
```
#### Example 
``` swift
struct UnauthorizedHandler: ResumableHandler {
    func canHandle(error: Swift.Error) -> Bool { error is UnauthorizedError }
    func handle(error: Error, presentable: Presentable?)  -> Observable<Any> {
        // put the API that refreshes the token here
        Observable.just("")
    }
}
```

## ErrorHandler
``` swift
public protocol ErrorHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}
```
#### Example 
``` swift
class MyErrorHandler: ErrorHandler {
    func canHandle(error: Error) -> Bool { error is MyError }
    func handle(error: Error, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

## AlamofireStatusCodeHandler
``` swift
public protocol AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] { get set }
    func canHandle(error: AFError) -> Bool
    func handle(error: AFError, presentable: Presentable?)
}
```
#### Example 
``` swift
struct NotFoundHandler: AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] = [404]

    func handle(error: AFError, presentable: Presentable?) {
        presentable?.showError(error: "Sorry, posts not found!")
    }
}
```

## AlamofireUnderlyingErrorHandler
``` swift
public protocol AlamofireUnderlyingErrorHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}
```
#### Example 
``` swift
class MyUnderlyingErrorHandler: AlamofireUnderlyingErrorHandler {
    func canHandle(error: Swift.Error) -> Bool {
        error is MyUnderlyingError
    }
    func handle(error: Error, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

## AlamofireErrorHandler
``` swift
public protocol AlamofireErrorHandler {
    func canHandle(error: AFError) -> Bool
    func handle(error: AFError, presentable: Presentable?)
}
```
#### Example 
``` swift
class JsonSerializationFailedHandler: AlamofireErrorHandler {

    func canHandle(error: AFError) -> Bool {
        switch error {
        case .responseSerializationFailed(let reason):
            switch reason {
            case .jsonSerializationFailed(let error):
                return error is JsonSerializationFailedError
            default: return false
            }
        default: return false
        }
    }

    func handle(error: AFError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

## MoyaStatusCodeHandler
``` swift
public protocol MoyaStatusCodeHandler {
    var supportedErrorCodes: [Int] { get set }
    func canHandle(error: MoyaError) -> Bool
    func handle(error: MoyaError, presentable: Presentable?)
}
```
#### Example 
``` swift
struct NotFoundHandler: MoyaStatusCodeHandler {
    var supportedErrorCodes: [Int] = [404]

    func handle(error: MoyaError, presentable: Presentable?) {
        presentable?.showError(error: "Sorry, posts not found!")
    }
}
```

## MoyaUnderlyingErrorHandler
``` swift
public protocol MoyaUnderlyingErrorHandler {
    func canHandle(error: Swift.Error, response: Response?) -> Bool
    func handle(error: Swift.Error, response: Response?, presentable: Presentable?)
}
```
#### Example 
``` swift
class MyUnderlyingErrorHandler: MoyaUnderlyingErrorHandler {
    func canHandle(error: Swift.Error, response: Response?) -> Bool {
        error is MyUnderlyingError
    }
    func handle(error: Error, response: Response?, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```

## MoyaErrorHandler
``` swift
public protocol MoyaErrorHandler {
    func canHandle(error: MoyaError) -> Bool
    func handle(error: MoyaError, presentable: Presentable?)
}
```
#### Example 
``` swift
class EncodableMappingErrorHandler: MoyaErrorHandler {
    func canHandle(error: MoyaError) -> Bool {
        switch error {
        case .encodableMapping(let error):
            return error is EncodableMappingError
        default: return false
        }
    }
    func handle(error: MoyaError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
```
