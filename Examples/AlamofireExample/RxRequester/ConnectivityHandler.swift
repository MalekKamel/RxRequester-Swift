//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import RxRequester

struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [
        NSURLErrorNotConnectedToInternet,
        NSURLErrorCannotConnectToHost,
        NSURLErrorNetworkConnectionLost
    ]

    func handle(error: NSError, presentable: Presentable?) {
//        rootViewController.showError(message: L10n.networkOffline)
    }


}
