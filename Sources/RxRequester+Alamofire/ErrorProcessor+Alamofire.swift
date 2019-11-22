//
// Created by mac on 11/20/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxRequester
import Alamofire

extension ErrorProcessor: AlamofireErrorProcessor {
    public func handle(error: Error, presentable: Presentable?) -> Bool {
        guard let alamofireError = error as? AFError else { return false }

        if let underlyingError = alamofireError.underlyingError,
           handle(underlyingError: underlyingError, presentable: presentable) { return false }

        switch alamofireError {
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let _):
                return handle(statusCode: alamofireError, presentable: presentable)
            default: return handle(error: alamofireError, presentable: presentable)
            }
        default: return handle(error: alamofireError, presentable: presentable)
        }
    }

    private func handle(statusCode: AFError, presentable: Presentable?) -> Bool {
        let handler: AlamofireStatusCodeHandler? = AlamofireHandlers.statusCodeHandlers.first(where: {
            $0.canHandle(error: statusCode)
        })
        guard handler != nil else { return false }
        handler!.handle(error: statusCode, presentable: presentable)
        return true
    }

    private func handle(underlyingError: Swift.Error, presentable: Presentable?) -> Bool {
        let handler: AlamofireUnderlyingErrorHandler? = AlamofireHandlers.underlyingErrorHandlers.first(where: {
            $0.canHandle(error: underlyingError)
        })
        guard handler != nil else { return false }
        handler!.handle(error: underlyingError, presentable: presentable)
        return true
    }

//    private func handle(error: AFError, presentable: Presentable?) -> Bool {
//        let handler: AFErrorHandler? = AlamofireHandlers.errorHandlers.first(where: {
//            $0.canHandle(error: error)
//        })
//        guard handler != nil else { return false }
//        handler!.handle(error: error, presentable: presentable)
//        return true
//    }
}
