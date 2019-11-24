//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation

public protocol ErrorHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}
