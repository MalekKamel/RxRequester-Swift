//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Moya
import RxRequester
import RxRequesterMoya

struct BadRequestHandler: MoyaStatusCodeHandler {
    var supportedErrorCodes: [Int] = [400]

    func handle(error: MoyaError, presentable: Presentable?) {
        presentable?.showError(error: "BadRequestHandler")
    }

}
