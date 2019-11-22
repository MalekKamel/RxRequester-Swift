//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation

let errorProcessor = ErrorProcessor()

public class ErrorProcessor {
    static let shared = ErrorProcessor()

    func process(error: Swift.Error, presentable: Presentable?) {
        if let alamo = self as? AlamofireErrorProcessor,
              alamo.handle(error: error, presentable: presentable) { return }

        if let moya = self as? MoyaErrorProcessor,
              moya.handle(error: error, presentable: presentable) { return }

        if handle(nsError: error as NSError, presentable: presentable) { return }

        if handle(error: error , presentable: presentable) { return }

        unknownError(error: error, presentable: presentable)
    }
}

private func handle(httpError: Swift.Error, presentable: Presentable?) {
    let handler: HttpErrorHandler? = RxRequester.httpErrorHandlers.first(where: {
        $0.canHandle(error: httpError as! HTTPURLResponse)
    })
    guard handler != nil else {
        unknownError(error: httpError, presentable: presentable)
        return
    }
    handler!.handle(error: httpError as! HTTPURLResponse, presentable: presentable)
}

private func handle(error: Swift.Error, presentable: Presentable?) -> Bool {
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

public func unknownError(error: Swift.Error, presentable: Presentable?) {
    presentable?.onHandleErrorFailed(error: error)
}




