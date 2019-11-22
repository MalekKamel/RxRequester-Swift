//
// Created by mac on 2019-05-27.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation

public protocol NSErrorHandler {
    var supportedErrors: [Int] { get set }
    func canHandle(error: NSError) -> Bool
    func handle(error: NSError, presentable: Presentable?)
}

public extension NSErrorHandler {
    func canHandle(error: NSError) -> Bool {
        let handler = supportedErrors.firstIndex(where: { $0 == error.code } )
        return handler != nil
    }
}
