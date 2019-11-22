//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxSwift

public class RequestOptions {
    /**
     * callback for handling the error at call site
     * @return true if the error is handled, false otherwise
     * If the error wasn't handled(by returning false), the provided
     * handlers will try to handle the error.
     * If all handlers failed, [Presentable#onHandleErrorFailed(Throwable]
     * will be called
     */
    var inlineHandling: ((Error) -> Bool)? = nil
    /**
     * show loading indicator
     */
    var showLoading: Bool = true
    /**
     * subscribeOn scheduler
     */
    var subscribeOnScheduler: ImmediateSchedulerType? = nil
    /**
     * observeOn scheduler
     */
    var observeOnScheduler: ImmediateSchedulerType? = nil

    func subscribeOn() -> ImmediateSchedulerType {
         subscribeOnScheduler ?? defaultSubscriber().subscribeOn
    }

    func observeOn() -> ImmediateSchedulerType {
         observeOnScheduler ?? defaultSubscriber().observeOn
    }

    public class Builder {
        private var options = RequestOptions()

        public func inlineErrorHandling(callback: ((Error) -> Bool)?) -> Builder {
            options.inlineHandling = callback
            return self
        }

        public func showLoading(show: Bool) -> Builder {
            options.showLoading = show
            return self
        }

        public func subscribeOnScheduler(scheduler: ImmediateSchedulerType) -> Builder {
            options.subscribeOnScheduler = scheduler
            return self
        }

        public func observeOnScheduler(scheduler: ImmediateSchedulerType) -> Builder {
            options.observeOnScheduler = scheduler
            return self
        }

        public func build() -> RequestOptions {
            options
        }
    }

    public static func defaultOptions() -> RequestOptions {
        Builder().build()
    }

}