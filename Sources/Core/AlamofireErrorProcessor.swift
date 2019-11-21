//
// Created by mac on 11/21/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

protocol AlamofireErrorProcessor {
    func handle(httpError: Error) -> Bool
}
