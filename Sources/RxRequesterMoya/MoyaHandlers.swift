//
// Created by mac on 11/22/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

public class MoyaHandlers {
    public static var statusCodeHandlers: Array<MoyaStatusCodeHandler> = []
    public static var underlyingErrorHandlers: Array<MoyaUnderlyingErrorHandler> = []
    public static var errorHandlers: Array<MoyaErrorHandler> = []
}