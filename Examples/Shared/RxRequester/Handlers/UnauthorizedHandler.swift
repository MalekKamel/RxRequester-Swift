//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import RxRequester
import RxSwift

struct UnauthorizedHandler: ResumableHandler {

    func canHandle(error: Swift.Error) -> Bool { error is UnauthorizedError }

    func handle(error: Error, presentable: Presentable?)  -> Observable<Any> {
        // put the API that refresh the token here
        Observable.just("")
    }
}

/*
Just a fake error.
in production you can check if the error code is 401
*/
class UnauthorizedError {}