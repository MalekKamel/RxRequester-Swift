//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxSwift

protocol SchedulerProvider {
    var observeOn: ImmediateSchedulerType { get }
    var subscribeOn: ImmediateSchedulerType { get }
}

class DefSchedulerProvider: SchedulerProvider {
    static let shared = DefSchedulerProvider()

    var observeOn: ImmediateSchedulerType = MainScheduler.instance
    var subscribeOn: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
}

class TestSchedulerProvider: SchedulerProvider {
    static let shared = TestSchedulerProvider()

    var observeOn: ImmediateSchedulerType = MainScheduler.instance
    var subscribeOn: ImmediateSchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
}

func defaultSubscriber() -> SchedulerProvider {
      DefSchedulerProvider.shared
}