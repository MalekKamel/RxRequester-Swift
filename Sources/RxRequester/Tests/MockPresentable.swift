//
// Created by mac on 11/24/19.
// Copyright (c) 2019 sha. All rights reserved.
//

import Foundation
@testable import RxRequester

class MockPresentable: Presentable {
    var isShowErrorCalled = false
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var isOnHandleErrorFailedCalled = false
    var errorMessage = ""

    func showError(error: String) {
        errorMessage = error
        isShowErrorCalled = true
    }

    func showLoading() {
        isShowLoadingCalled = true
    }

    func hideLoading() {
        isHideLoadingCalled = true
    }

    func onHandleErrorFailed(error: Error) {
        isOnHandleErrorFailedCalled = true
    }

}
