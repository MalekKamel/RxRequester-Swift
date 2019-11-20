//
// Created by mac on 11/17/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//


import Foundation
import Moya
import RxSwift

public class PostsRepository {
    private let api: MoyaProvider<Api>!

    init(api: MoyaProvider<Api>) {
        self.api = api
    }

    func all() -> Single<[PostResponse]> {
       let request: Single<Response> = api.rx.request(.posts)
       return request.map([PostResponse].self, failsOnEmptyData: false)
    }
}

