//
//  HttpErrorProcessor.swift
//  RxRequester
//
//  Created by mac on 11/20/19.
//  Copyright © 2019 sha. All rights reserved.
//

import Foundation

public protocol MoyaErrorProcessor {
    func handle(httpError: Error) -> Bool
}
