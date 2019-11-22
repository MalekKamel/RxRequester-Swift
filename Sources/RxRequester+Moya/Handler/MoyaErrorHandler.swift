//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester
import Moya

public protocol MoyaErrorHandler {
    func canHandle(error: MoyaError) -> Bool
    func handle(error: MoyaError, presentable: Presentable?)
}
