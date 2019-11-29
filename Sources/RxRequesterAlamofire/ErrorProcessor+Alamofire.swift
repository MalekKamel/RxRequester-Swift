//
// Created by mac on 11/20/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxRequester
import Alamofire

/// Extension for ErrorProcessor to support Alamofire
extension ErrorProcessor: PluggableErrorProcessor {
    
    public func handle(error: Error, presentable: Presentable?) -> Bool {
        guard let afError = error as? AFError else { return false }

        func defaultHandling() -> Bool { handle(afError: afError, presentable: presentable) }

        if let underlyingError = afError.underlyingError,
           handle(underlyingError: underlyingError, presentable: presentable) { return defaultHandling() }

        switch afError {
        
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(_):
                return handle(statusCode: afError, presentable: presentable) ? true : defaultHandling()
            default: return defaultHandling()
            }
            
        default: return defaultHandling()
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

    private func handle(afError: AFError, presentable: Presentable?) -> Bool {
        let handler: AlamofireErrorHandler? = AlamofireHandlers.errorHandlers.first(where: {
            $0.canHandle(error: afError)
        })
        guard handler != nil else { return false }
        handler!.handle(error: afError, presentable: presentable)
        return true
    }
}
