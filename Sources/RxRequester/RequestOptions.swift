//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxSwift

public class RequestOptions {

    ///  callback for handling the error at call site
    ///  @return true if the error is handled, false otherwise
    ///  If the error wasn't handled(by returning false), the provided
    ///  handlers will try to handle the error.
    ///  If all handlers failed, [Presentable#onHandleErrorFailed(Throwable]
    ///   will be called
    var inlineHandling: ((Error) -> Bool)? = nil

    /// Invoke error on error
    var doOnError: ((Error) -> Void)? = nil

    /// show loading indicator
    var showLoading: Bool = true

    /// subscribeOn scheduler
    var subscribeOnScheduler: ImmediateSchedulerType? = nil

    /// observeOn scheduler
    var observeOnScheduler: ImmediateSchedulerType? = nil

    func subscribeOn() -> ImmediateSchedulerType {
        subscribeOnScheduler ?? RxRequester.schedulerProvider.subscribeOn
    }

    func observeOn() -> ImmediateSchedulerType {
        observeOnScheduler ?? RxRequester.schedulerProvider.observeOn
    }

    public class Builder {
        private var options = RequestOptions()

        public init() {}

        /// Provide a callback to handle the error inline.
        /// Returning true means that the error has been handled inline
        /// Returning false means the error couldn't be handled inline, and in this case
        /// the error will be passed to global handlers to handle it.
        public func inlineErrorHandling(_ callback: ((Error) -> Bool)?) -> Builder {
            options.inlineHandling = callback
            return self
        }

        /// Provide a callback to be invoked when an error occurs.
        public func doOnError(_ callback: ((Error) -> Void)?) -> Builder {
            options.doOnError = callback
            return self
        }

        /// Show loading indicator. True by default
        public func showLoading(_ show: Bool) -> Builder {
            options.showLoading = show
            return self
        }
        /// Provide subscribeOn Scheduler
        public func subscribeOnScheduler(_ scheduler: ImmediateSchedulerType) -> Builder {
            options.subscribeOnScheduler = scheduler
            return self
        }

        /// Provide observeOn Scheduler
        public func observeOnScheduler(_ scheduler: ImmediateSchedulerType) -> Builder {
            options.observeOnScheduler = scheduler
            return self
        }

        /// Build the Object
        public func build() -> RequestOptions {
            options
        }
    }

    /// Default options
    public static func defaultOptions() -> RequestOptions {
        Builder().build()
    }

}