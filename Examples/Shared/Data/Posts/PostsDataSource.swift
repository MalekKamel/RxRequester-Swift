//
// Created by mac on 11/20/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol PostsDataSource {
    func all() -> Single<[PostResponse]>
}
