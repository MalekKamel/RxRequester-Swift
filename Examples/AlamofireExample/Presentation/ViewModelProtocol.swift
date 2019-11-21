//
// Created by mac on 11/17/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import RxRequester

protocol ViewModelProtocol: Reportable, ActivityIndicatable {
    var rxRequester: RxRequester! { get set }
}

