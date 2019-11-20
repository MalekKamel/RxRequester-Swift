//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
import RxSwift

public typealias Request<T> = () -> Observable<T>

public class RxRequester {
    var presentable: Presentable?

    static let httpErrorHandlers: Array<ErrorCodeHandler> = []
    static let nsErrorHandlers: Array<NSErrorHandler> = []
    static let errorHandlers: Array<ErrorHandler> = []
    static let resumableHandlers: Array<ResumableHandler> = []

    public init(presentable: Presentable) {
        self.presentable = presentable
    }

    public func request<T>(
            options: RequestOptions = RequestOptions.defaultOptions(),
            request: @escaping Request<T>) -> Observable<T> {

        request()
                .subscribeOn(options.subscribeOn())
                .observeOn(options.observeOn())
                .handleResumable(requestToBeResumed: request, presentable: presentable)
                .do(onSubscribe: { [weak self] in
                    if options.showLoading { self?.presentable?.showLoading() }
                })
                .do(onError: { [weak self] error in
                    guard self != nil else { return }

                    if options.showLoading { self?.presentable?.hideLoading() }

                    if options.inlineHandling?(error) == true { return }

                    ErrorProcessor.shared.process(error: error, presentable: self?.presentable)
                })
                .do(onNext: { [weak self] element in
                    if options.showLoading { self?.presentable?.hideLoading() }
                })
    }
}