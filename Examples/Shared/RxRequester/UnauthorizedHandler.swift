//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import RxRequester
import RxSwift

struct UnauthorizedHandler: ResumableHandler {

    func handle(error: Error, presentable: Presentable?) -> Observable<Any> {
        Observable.just("")
    }

    func canHandle(error: Swift.Error) -> Bool {
        false
    }

    func handle(error: HTTPURLResponse, presentable: Presentable?)  -> Observable<Any> {
        // return an Observable that refreshes the token and updates the local refresh token
        Observable.just("")
    }

}
