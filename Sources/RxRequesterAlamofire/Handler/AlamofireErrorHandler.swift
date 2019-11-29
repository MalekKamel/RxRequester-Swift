//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Alamofire
import RxRequester

/// Handle Alamofire errors
public protocol AlamofireErrorHandler {
    func canHandle(error: AFError) -> Bool
    func handle(error: AFError, presentable: Presentable?)
}
