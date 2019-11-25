//
// Created by mac on 11/25/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxRequester
import RxRequesterAlamofire

class RxRequesterSetup {

    static func setup() {
        // Core Handlers
        RxRequester.nsErrorHandlers = [ConnectivityHandler(), TimeoutHandler()]
        RxRequester.errorHandlers = [MyErrorHandler()]
        RxRequester.resumableHandlers = [UnauthorizedHandler()]

        // Alamofire Handlers
        AlamofireHandlers.statusCodeHandlers = [NotFoundHandler()]
        AlamofireHandlers.underlyingErrorHandlers = [MyUnderlyingErrorHandler()]
        AlamofireHandlers.errorHandlers = [JsonSerializationFailedHandler()]
    }
}
