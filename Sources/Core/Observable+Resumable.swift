//
// Created by mac on 11/16/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import RxSwift

extension Observable {

    func handleResumable(
            requestToBeResumed: @escaping Request<Element>,
            presentable: Presentable?) -> Observable<Element> {
        catchError { error in
            let handler: ResumableHandler? = RxRequester.resumableHandlers.first(where: {
                $0.canHandle(error: error)
            })
            guard handler != nil else { return Observable.error(error) }
            return handler!.handle(error: error, presentable: presentable)
                    .flatMap { _ in requestToBeResumed() }
        }
    }

}
