//
//  MoyaDataSource.swift
//  AlamofireExample
//
//  Created by mac on 11/22/19.
//  Copyright © 2019 sha. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class MoyaDataSource: PostsDataSource {
    private let api: MoyaProvider<PostsApi>!

    init(api: MoyaProvider<PostsApi>) {
        self.api = api
    }

    func all() -> Single<[PostResponse]> {
        let request: Single<Response> = api.rx.request(.posts)
        return request.map([PostResponse].self, failsOnEmptyData: false)
    }
}
