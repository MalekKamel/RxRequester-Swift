//
// Created by mac on 11/20/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class PostsDataSource {
    private let api: MoyaProvider<PostsApi>!

    init(api: MoyaProvider<PostsApi>) {
        self.api = api
    }

    func all() -> Single<[PostResponse]> {
        let request: Single<Response> = api.rx.request(.posts)
        return request.map([PostResponse].self, failsOnEmptyData: false)
    }
}
