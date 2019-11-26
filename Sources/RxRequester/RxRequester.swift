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

    public static var nsErrorHandlers: Array<NSErrorHandler> = []
    public static var resumableHandlers: Array<ResumableHandler> = []
    public static var errorHandlers: Array<ErrorHandler> = []

    public init(presentable: Presentable) {
        self.presentable = presentable
    }

    public func request<T>(
            options: RequestOptions = RequestOptions.defaultOptions(),
            request: @escaping Request<T>) -> Observable<T> {

        request()
                .handleResumable(requestToBeResumed: request, presentable: presentable)
                .request(options: options, presentable: presentable)
    }

    public func request<T>(
            options: RequestOptions = RequestOptions.defaultOptions(),
            singleRequest: @escaping SingleRequest<T>) -> Single<T> {
        singleRequest()
                .asObservable()
                .handleResumable(requestToBeResumed: { singleRequest().asObservable() }, presentable: presentable)
                .request(options: options, presentable: presentable)
                .asSingle()
    }

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

                    if options.showLoading { presentable?.hideLoading() }

                    if options.inlineHandling?(error) == true { return }

                    ErrorProcessor.shared.process(error: error, presentable: presentable)
                })
                .do(onNext: { _ in
                    if options.showLoading { presentable?.hideLoading() }
                })
    }
}