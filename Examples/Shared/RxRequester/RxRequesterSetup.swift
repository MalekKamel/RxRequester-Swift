//
// Created by mac on 11/20/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import RxRequester
import RxRequesterMoya
import RxRequesterAlamofire

class RxRequesterSetup {

    static func setup() {
        RxRequester.nsErrorHandlers = [ConnectivityHandler(), TimeoutHandler()]
        RxRequester.errorHandlers = []
        RxRequester.resumableHandlers = [UnauthorizedHandler()]
    }
}
