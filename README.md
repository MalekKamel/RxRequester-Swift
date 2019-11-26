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
      rxRequester.request { loginApi.login(credentials: credentials) }
    }
```
