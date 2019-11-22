//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester

public protocol AlamofireErrorHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?)
}
