//
// Created by mac on 11/20/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation

extension ErrorProcessor: HttpErrorProcessor {
    func handle(httpError: Error) -> Bool {
        false
    }
}