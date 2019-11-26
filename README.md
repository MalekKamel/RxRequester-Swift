# RxRequester-Swift

A simple wrapper for RxSwift & Alamofire & Moya that helps you:
- [ ] Make clean RxSwift requests.
- [ ] Inline & Global error handling.
- [ ] Resume the current request after errors like token expired error.
- [ ] Easy control of loading indicators.

``` swift

```

## Setup
``` swift
extension ViewController: Presentable {
    public func showError(error: String) { show(error: error) }
    public func showLoading() { showLoading(show: true) }
    public func hideLoading() { showLoading(show: false) }
    public func onHandleErrorFailed(error: Error) { show(error: "Oops, something went wrong!") }
    
}

class ViewModel {
    var presentable: Presentable!

    func setupRxRequester() {
      // initialize
      rxRequester = RxRequester(presentable: presentable)
    
      // set handlers
      RxRequester.nsErrorHandlers = [ConnectivityHandler()]
      RxRequester.errorHandlers = [MyErrorHandler()]
      RxRequester.resumableHandlers = [UnauthorizedHandler()]
    }

    func login(credentials: Credentials) -> Observable<User> {
      // request
      rxRequester.request { loginApi.login(credentials: credentials) }
    }
```

## Error Handling
**RxRequester** shines in error handling. Errors in RxRequesters can be handled by providing a handler for each error.
If you want to handle connectivity error `NSURLErrorNotConnectedToInternet`, for example, you must provide a handler as the following

``` swift
import RxRequester

struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [NSURLErrorNotConnectedToInternet]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}

```

## Error Handler Types
1- **NSErrorHandler**
2- **ResumableHandler**
3- **ErrorHandler**

|     **Handler Type**     |                 **Description**               |
|--------------------------|-----------------------------------------------|
| **NSErrorHandler**       |   Handles NSError                             |
| **ResumableHandler**     |   provides a request to be invoked after 
                               <br> the error and before resuming 
                               <br>the main request.                       |
| **ErrorHandler**         |     Handles any Swift.Error                   |

