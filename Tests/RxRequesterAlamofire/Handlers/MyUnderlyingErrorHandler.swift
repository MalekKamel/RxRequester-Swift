//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Alamofire
import RxRequester
import RxRequesterAlamofire

class MyUnderlyingErrorHandler: AlamofireUnderlyingErrorHandler {

    func canHandle(error: Swift.Error) -> Bool {
        error is MyUnderlyingError
    }

    func handle(error: Error, presentable: Presentable?) {
        presentable?.showError(error: "MyUnderlyingErrorHandler")
    }
}
