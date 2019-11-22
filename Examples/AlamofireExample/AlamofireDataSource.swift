//
//  AlamofireDataSource.swift
//  
//
//  Created by mac on 11/22/19.
//

import RxSwift

class AlamofireDataSource: PostsDataSource {
//    private let api: MoyaProvider<PostsApi>!

//    init(api: MoyaProvider<PostsApi>) {
//        self.api = api
//    }

    func all() -> Single<[PostResponse]> {
        Single.just([PostResponse(id: 0, title: "", body: "")])
    }
}
