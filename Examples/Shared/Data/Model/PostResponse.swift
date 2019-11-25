//
// Created by mac on 11/17/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation

public struct PostResponse: Decodable {
    let id: Int
    let title: String
    let body: String
}

struct PostMapper: Mapper {
    typealias I = PostResponse
    typealias O = Post

    func map(_ input: PostResponse) -> Post {
        Post(id: input.id, title: input.title, body: input.body)
    }
}
