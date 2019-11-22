//
// Created by mac on 11/20/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import RxRequester

class RxRequesterSetup {

    static func setup() {
        RxRequester.httpErrorHandlers = [BadRequestHandler()]
        RxRequester.nsErrorHandlers = [ConnectivityHandler(), TimeoutHandler()]
        RxRequester.errorHandlers = []
        RxRequester.resumableHandlers = [UnauthorizedHandler()]
    }
}
