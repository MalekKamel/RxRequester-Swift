//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Alamofire
import RxRequester
import RxRequesterAlamofire

class JsonSerializationFailedHandler: AlamofireErrorHandler {

    func canHandle(error: AFError) -> Bool {
        switch error {
        case .responseSerializationFailed(let reason):
            switch reason {
            case .jsonSerializationFailed(let error):
                return error is JsonSerializationFailedError
            default: return false
            }
        default: return false
        }
    }

    func handle(error: AFError, presentable: Presentable?) {
        presentable?.showError(error: "JsonSerializationFailedHandler")
    }
}
