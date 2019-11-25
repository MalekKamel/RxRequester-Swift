//
// Created by mac on 2019-05-27.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import RxRequester

struct TimeoutHandler: NSErrorHandler {
    var supportedErrors: [Int] = [
         NSURLErrorTimedOut
    ]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }

}
