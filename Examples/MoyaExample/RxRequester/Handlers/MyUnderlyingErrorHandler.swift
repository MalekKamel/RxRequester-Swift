//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Moya
import RxRequester
import RxRequesterMoya

class MyUnderlyingErrorHandler: MoyaUnderlyingErrorHandler {

    func canHandle(error: Swift.Error, response: Response?) -> Bool {
        error is MyUnderlyingError
    }

    func handle(error: Error, response: Response?, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}

/// Just fake error
class MyUnderlyingError: Error {}
