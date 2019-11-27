//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Moya
import RxRequester
import RxRequesterMoya

class EncodableMappingErrorHandler: MoyaErrorHandler {
    func canHandle(error: MoyaError) -> Bool {
        switch error {
        case .encodableMapping(let error):
            return error is EncodableMappingError
        default: return false
        }
    }

    func handle(error: MoyaError, presentable: Presentable?) {
        presentable?.showError(error: "EncodableMappingErrorHandler")
    }

}
