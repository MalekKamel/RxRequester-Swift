//
// Created by mac on 11/21/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

/// Dynamic extension for ErrorProcessor
/// it's used to provide handlers for Alamofire & Moya
public protocol PluggableErrorProcessor {
    func handle(error: Error, presentable: Presentable?) -> Bool
}
