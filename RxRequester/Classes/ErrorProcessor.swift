//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import Moya
import Data
import Core

let errorProcessor = ErrorProcessor()

class ErrorProcessor {
    static let shared = ErrorProcessor()

    func process(error: Error, presentable: Presentable?) {
        if error is HTTPURLResponse {
            handle(httpError: error, presentable: presentable)
            return
        }

        if handle(nsError: error as NSError, presentable: presentable) { return }

        if handle(error: error , presentable: presentable) { return }

        unknownError(error: error, presentable: presentable)
    }
}

private func handle(httpError: Error, presentable: Presentable?) {
    let handler: ErrorCodeHandler? = RxRequester.httpErrorHandlers.first(where: {
        $0.canHandle(error: httpError as! HTTPURLResponse)
    })
    guard handler != nil else {
        unknownError(error: httpError, presentable: presentable)
        return
    }
    handler!.handle(error: httpError as! HTTPURLResponse, presentable: presentable)
}

private func handle(error: Error, presentable: Presentable?) -> Bool {
    let handler: ErrorHandler? = RxRequester.errorHandlers.first(where: {
        $0.canHandle(error: error)
    })

    guard handler != nil else { return false }

    handler!.handle(error: error, presentable: presentable)
    return true
}

private func handle(nsError: NSError, presentable: Presentable?) -> Bool {
    if nsError.domain != NSURLErrorDomain {
        return false
    }

    let handler: NSErrorHandler? = RxRequester.nsErrorHandlers.first(where: {
        $0.canHandle(error: nsError)
    })

    guard handler != nil else { return false }

    handler!.handle(error: nsError, presentable: presentable)
    return true
}

func unknownError(error: Error, presentable: Presentable?) {
    presentable?.onHandleErrorFailed(error: error)
}




