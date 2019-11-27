//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Alamofire
import RxRequester

public protocol AlamofireStatusCodeHandler {
    var supportedErrorCodes: [Int] { get set }
    func canHandle(error: AFError) -> Bool
    func handle(error: AFError, presentable: Presentable?)
}

public extension AlamofireStatusCodeHandler {
    func canHandle(error: AFError) -> Bool {
        let supportedError = supportedErrorCodes.first(where: { $0 == error.responseCode })
        return supportedError != nil
    }
}