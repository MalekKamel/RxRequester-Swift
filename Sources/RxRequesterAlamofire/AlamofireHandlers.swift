//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

/// Set Alamofire error handlers
public class AlamofireHandlers {
    /// set handlers for status code errors
    public static var statusCodeHandlers: Array<AlamofireStatusCodeHandler> = []

    /// set handlers for underlying errors
    public static var underlyingErrorHandlers: Array<AlamofireUnderlyingErrorHandler> = []

    /// set handlers for errors
    public static var errorHandlers: Array<AlamofireErrorHandler> = []
}