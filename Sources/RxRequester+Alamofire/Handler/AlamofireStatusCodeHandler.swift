//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester

public protocol AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] { get set }
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}

public extension AlamofireStatusCodeHandler {
    func canHandle(error: Swift.Error) -> Bool {
//        let supportedError = supportedErrorCodes.first(where: { $0 == error.statusCode })
//        return supportedError != nil
        return false
    }
}