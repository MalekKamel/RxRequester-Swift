//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import Moya
import Data
import Core

public protocol ErrorCodeHandler {
    var supportedErrors: [Int] { get set }
    func canHandle(error: HTTPURLResponse) -> Bool
    func handle(error: HTTPURLResponse, presentable: Presentable?)
}

public extension ErrorCodeHandler {
    func canHandle(error: HTTPURLResponse) -> Bool {
       let handler = supportedErrors.first(where: {
             $0 == error.statusCode
        })
        return handler != nil
    }
}