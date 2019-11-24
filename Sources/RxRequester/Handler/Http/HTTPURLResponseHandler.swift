//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation

public protocol HTTPURLResponseHandler {
    var supportedErrors: [Int] { get set }
    func canHandle(error: HTTPURLResponse) -> Bool
    func handle(error: HTTPURLResponse, presentable: Presentable?)
}

public extension HTTPURLResponseHandler {
    func canHandle(error: HTTPURLResponse) -> Bool {
       let supportedError = supportedErrors.first(where: { $0 == error.statusCode })
        return supportedError != nil
    }
}