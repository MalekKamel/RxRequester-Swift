//
// Created by mac on 2019-03-26.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation
import RxSwift

/// Handles error that needs retrying
/// the same request after invoking another request
public protocol ResumableHandler {
    func canHandle(error: Swift.Error) -> Bool
    func handle(error: Swift.Error, presentable: Presentable?) -> Observable<Any>
}