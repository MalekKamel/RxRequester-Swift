//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import Data

public protocol ErrorHandler {
    var supportedErrors: [Swift.Error.Type] { get set }
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}

public extension ErrorHandler {
    func canHandle(error: Swift.Error) -> Bool {
        let errorType = type(of: error)

        let handler = supportedErrors.first(where: {
           $0 == errorType
        })

        return handler != nil
    }
}
