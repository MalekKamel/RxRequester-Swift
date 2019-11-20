//
// Created by mac on 11/17/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation

public struct PostResponse: Decodable {
    let id: Int
    let title: String
    let body: String

    func toPost() -> Post {
         Post(
                id: id,
                title: title,
                body: body
        )
    }

}

public extension Array where Element == PostResponse {
    func toPresent() -> [Post] { self.map{ $0.toPost() } }
}
