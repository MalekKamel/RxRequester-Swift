//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import RxRequester
import RxRequesterAlamofire
import Alamofire

struct NotFoundHandler: AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] = [404]

    func handle(error: AFError, presentable: Presentable?) {
        presentable?.showError(error: "Sorry, posts not found!")
    }

}
