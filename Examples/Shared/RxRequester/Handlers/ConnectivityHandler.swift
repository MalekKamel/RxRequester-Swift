//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import RxRequester

struct ConnectivityHandler: NSErrorHandler {
    var supportedErrors: [Int] = [
        NSURLErrorNotConnectedToInternet,
        NSURLErrorCannotConnectToHost,
        NSURLErrorNetworkConnectionLost
    ]

    func handle(error: NSError, presentable: Presentable?) {
        presentable?.showError(error: error.localizedDescription)
    }
}
