//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester
import Moya

public protocol MoyaUnderlyingErrorHandler {
    func canHandle(error: Swift.Error, response: Response?) -> Bool
    func handle(error: Swift.Error, response: Response?, presentable: Presentable?)
}
