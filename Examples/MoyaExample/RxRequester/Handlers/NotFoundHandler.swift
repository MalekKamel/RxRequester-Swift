//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Moya
import RxRequester
import RxRequesterMoya

struct NotFoundHandler: MoyaStatusCodeHandler {
    var supportedErrorCodes: [Int] = [404]

    func handle(error: MoyaError, presentable: Presentable?) {
        presentable?.showError(error: "Sorry, posts not found!")
    }
}
