//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxSwift

public typealias Request<T> = () -> Observable<T>
public typealias SingleRequest<T> = () -> Single<T>
public typealias CompletableRequest = () -> Completable

public class RxRequester {
    var presentable: Presentable?

    /// Set NSError handlers
    public static var nsErrorHandlers: Array<NSErrorHandler> = []

    /// Set Resubalble handlers
    public static var resumableHandlers: Array<ResumableHandler> = []

    /// Set Error handlers
    public static var errorHandlers: Array<ErrorHandler> = []

    /// Set scheduler provider that provides default schedulers.
    /// Setting schedulers in RequestOptions will override this provider.
    public static var schedulerProvider: SchedulerProvider = DefSchedulerProvider.shared

    public init(presentable: Presentable) {
        self.presentable = presentable
    }

    /// invoke an Observable request
    public func request<T>(
            options: RequestOptions = RequestOptions.defaultOptions(),
            request: @escaping Request<T>) -> Observable<T> {

        request()
                .handleResumable(requestToBeResumed: request, presentable: presentable)
                .request(options: options, presentable: presentable)
    }

    /// invoke a Single request
    public func request<T>(
            options: RequestOptions = RequestOptions.defaultOptions(),
            singleRequest: @escaping SingleRequest<T>) -> Single<T> {
        singleRequest()
                .asObservable()
                .handleResumable(requestToBeResumed: { singleRequest().asObservable() }, presentable: presentable)
                .request(options: options, presentable: presentable)
                .asSingle()
    }

    /// invoke a Completable request
    public func request(
            options: RequestOptions = RequestOptions.defaultOptions(),
            completableRequest: @escaping CompletableRequest) -> Completable {
        let observable: Observable<Never> = completableRequest().asObservable()
                .handleResumable(requestToBeResumed: { completableRequest().asObservable() }, presentable: presentable)
                .request(options: options, presentable: presentable)
        return observable.ignoreElements()
    }

}

extension Observable {
    func request(
            options: RequestOptions = RequestOptions.defaultOptions(),
            presentable: Presentable?) -> Observable<Element> {
        subscribeOn(options.subscribeOn())
                .observeOn(options.observeOn())
                .do(onSubscribe: {
                    if options.showLoading { presentable?.showLoading() }
                })
                .do(onError: { [weak self] error in
                    guard self != nil else { return }

                    options.doOnError?(error)

                    if options.hideLoading { presentable?.hideLoading() }

                    if options.inlineHandling?(error) == true { return }

                    ErrorProcessor.shared.process(error: error, presentable: presentable)
                })
                .do(onNext: { _ in
                    if options.hideLoading { presentable?.hideLoading() }
                })
    }
}