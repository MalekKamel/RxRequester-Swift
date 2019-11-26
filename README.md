# RxRequester-Swift

A simple wrapper for RxSwift, Alamofire and Moya that helps you:
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

### Error Handling
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
