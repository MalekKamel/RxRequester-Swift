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
        presentable?.showError(error: "UnauthorizedHandler")
        return Observable.just("")
    }

}
