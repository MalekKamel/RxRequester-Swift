//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester
import RxRequesterMoya

class RxRequesterSetup {

    static func setup() {
        // Core Handlers
        RxRequester.nsErrorHandlers = [ConnectivityHandler(), TimeoutHandler()]
        RxRequester.errorHandlers = [MyErrorHandler()]
        RxRequester.resumableHandlers = [UnauthorizedHandler()]

        // Moya Handlers
        MoyaHandlers.statusCodeHandlers = [NotFoundHandler()]
        MoyaHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
        MoyaHandlers.errorHandlers = [EncodableMappingErrorHandler()]
    }
}
