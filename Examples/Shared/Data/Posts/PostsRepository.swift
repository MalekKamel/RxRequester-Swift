//
// Created by mac on 11/17/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//


import Foundation
import Moya
import RxSwift

public class PostsRepository {
    private let dataSource: PostsDataSource!

    init(dataSource: PostsDataSource) {
        self.dataSource = dataSource
    }

    func all() -> Single<[PostResponse]> { dataSource.all() }
}

