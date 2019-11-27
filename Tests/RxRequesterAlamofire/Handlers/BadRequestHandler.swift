//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import RxRequester
import RxRequesterAlamofire
import Alamofire

struct BadRequestHandler: AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] = [400]

    func handle(error: AFError, presentable: Presentable?) {
        presentable?.showError(error: "BadRequestHandler")
    }

}
