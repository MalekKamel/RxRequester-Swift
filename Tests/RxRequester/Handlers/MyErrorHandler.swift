//
// Created by mac on 11/24/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester

class MyErrorHandler: ErrorHandler {

    func canHandle(error: Error) -> Bool { error is MyError }

    func handle(error: Error, presentable: Presentable?) {
        presentable?.showError(error: "MyErrorHandler")
    }
}
